import 'package:core/core.dart';
import 'package:turbo/app/core/use_case.dart';
import 'package:turbo/places/module/params/search_places_params.dart';

/// Caso de uso para búsqueda de lugares por texto
/// Utiliza tanto el PlaceRepository como el LocationRepository para búsquedas comprehensivas
class SearchPlacesUseCase
    implements UseCase<Future<List<Place>>, SearchPlacesParams> {
  final PlaceRepository _placeRepository;
  final LocationRepository _locationRepository;

  SearchPlacesUseCase({
    required PlaceRepository placeRepository,
    required LocationRepository locationRepository,
  }) : _placeRepository = placeRepository,
       _locationRepository = locationRepository;

  @override
  Future<List<Place>> call(SearchPlacesParams params) async {
    try {
      // Primero intentamos búsqueda por nombre en nuestra base de datos
      List<Place> localResults = [];

      try {
        final placeByName = await _placeRepository.getPlaceByName(params.query);
        localResults.add(placeByName);
      } catch (e) {
        // No se encontró lugar exacto por nombre, continuar con búsqueda general
      }

      // Obtener todos los lugares y filtrar por query
      final allPlaces = await _placeRepository.getPlaces();

      // Filtrar por texto (nombre, descripción, dirección)
      final filteredPlaces =
          allPlaces.where((place) {
            final searchText = params.query.toLowerCase();
            final nameMatch =
                place.name?.toLowerCase().contains(searchText) ?? false;
            final descriptionMatch =
                place.description?.toLowerCase().contains(searchText) ?? false;
            final addressMatch =
                place.address?.toLowerCase().contains(searchText) ?? false;

            return nameMatch || descriptionMatch || addressMatch;
          }).toList();

      // Combinar resultados y eliminar duplicados
      final Set<String> seenIds = {};
      final combinedResults = <Place>[];

      for (final place in [...localResults, ...filteredPlaces]) {
        if (!seenIds.contains(place.id)) {
          seenIds.add(place.id!);
          combinedResults.add(place);
        }
      }

      // Aplicar filtros adicionales
      List<Place> filteredResults = combinedResults;

      // Filtro por categoría
      if (params.categoryId != null) {
        filteredResults =
            filteredResults
                .where((place) => place.categoryId == params.categoryId)
                .toList();
      }

      // Filtro por rating
      if (params.minRating != null) {
        filteredResults =
            filteredResults
                .where((place) => (place.rating ?? 0) >= params.minRating!)
                .toList();
      }

      // Filtros por precio
      if (params.minPrice != null) {
        filteredResults =
            filteredResults
                .where((place) => (place.averagePrice ?? 0) >= params.minPrice!)
                .toList();
      }

      if (params.maxPrice != null) {
        filteredResults =
            filteredResults
                .where(
                  (place) =>
                      (place.averagePrice ?? double.infinity) <=
                      params.maxPrice!,
                )
                .toList();
      }

      // Filtro por distancia (si se proporciona ubicación)
      if (params.location != null && params.maxDistance != null) {
        filteredResults =
            filteredResults.where((place) {
              if (place.latitude == null || place.longitude == null)
                return false;

              final distance = _locationRepository.calculateDistanceHaversine(
                lat1: params.location!.latitude,
                lon1: params.location!.longitude,
                lat2: place.latitude!,
                lon2: place.longitude!,
              );

              return distance <= params.maxDistance!;
            }).toList();
      }

      // Ordenar por relevancia (por ahora por rating)
      filteredResults.sort((a, b) {
        // Si tenemos ubicación, ordenar por distancia
        if (params.location != null &&
            a.latitude != null &&
            a.longitude != null &&
            b.latitude != null &&
            b.longitude != null) {
          final distanceA = _locationRepository.calculateDistanceHaversine(
            lat1: params.location!.latitude,
            lon1: params.location!.longitude,
            lat2: a.latitude!,
            lon2: a.longitude!,
          );

          final distanceB = _locationRepository.calculateDistanceHaversine(
            lat1: params.location!.latitude,
            lon1: params.location!.longitude,
            lat2: b.latitude!,
            lon2: b.longitude!,
          );

          return distanceA.compareTo(distanceB);
        }

        // Sino, ordenar por rating
        return (b.rating ?? 0).compareTo(a.rating ?? 0);
      });

      return filteredResults;
    } catch (e) {
      throw Exception('Error al buscar lugares: ${e.toString()}');
    }
  }
}
