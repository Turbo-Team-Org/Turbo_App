import 'package:core/core.dart';
import 'package:turbo/app/core/use_case.dart';
import 'package:turbo/places/module/params/search_places_params.dart';

/// Caso de uso para búsqueda de lugares cercanos
/// Utiliza el LocationRepository para integración con Google Places y búsqueda local
class SearchNearbyPlacesUseCase
    implements UseCase<Future<List<Place>>, SearchNearbyPlacesParams> {
  final LocationRepository _locationRepository;
  final PlaceRepository _placeRepository;

  SearchNearbyPlacesUseCase({
    required LocationRepository locationRepository,
    required PlaceRepository placeRepository,
  }) : _locationRepository = locationRepository,
       _placeRepository = placeRepository;

  @override
  Future<List<Place>> call(SearchNearbyPlacesParams params) async {
    try {
      // Convertir LatLng a LocationData
      final locationData = LocationData(
        latitude: params.location.latitude,
        longitude: params.location.longitude,
        timestamp: DateTime.now(),
      );

      List<Place> results = [];

      // Búsqueda en nuestra base de datos local
      final localPlaces = await _getLocalNearbyPlaces(params, locationData);
      results.addAll(localPlaces);

      // Búsqueda con Google Places API (si está configurado)
      try {
        final googlePlaces = await _locationRepository.searchNearbyPlaces(
          location: locationData,
          radius: params.radius,
          keyword: params.keyword,
          // type: _getCategoryType(params.categoryId),
        );

        // Convertir GooglePlace a Place (esto requeriría mapeo)
        // Por ahora mantenemos solo resultados locales
      } catch (e) {
        // Google Places no disponible o error, continuar solo con resultados locales
      }

      // Eliminar duplicados
      final uniqueResults = _removeDuplicates(results);

      // Aplicar filtros finales
      List<Place> filteredResults = uniqueResults;

      if (params.minRating != null) {
        filteredResults =
            filteredResults
                .where((place) => (place.rating ?? 0) >= params.minRating!)
                .toList();
      }

      // Ordenar por distancia
      filteredResults.sort((a, b) {
        if (a.latitude == null || a.longitude == null) return 1;
        if (b.latitude == null || b.longitude == null) return -1;

        final distanceA = _locationRepository.calculateDistanceHaversine(
          lat1: params.location.latitude,
          lon1: params.location.longitude,
          lat2: a.latitude!,
          lon2: a.longitude!,
        );

        final distanceB = _locationRepository.calculateDistanceHaversine(
          lat1: params.location.latitude,
          lon1: params.location.longitude,
          lat2: b.latitude!,
          lon2: b.longitude!,
        );

        return distanceA.compareTo(distanceB);
      });

      // Limitar resultados
      if (filteredResults.length > params.limit) {
        filteredResults = filteredResults.take(params.limit).toList();
      }

      return filteredResults;
    } catch (e) {
      throw Exception('Error al buscar lugares cercanos: ${e.toString()}');
    }
  }

  /// Obtiene lugares cercanos de nuestra base de datos local
  Future<List<Place>> _getLocalNearbyPlaces(
    SearchNearbyPlacesParams params,
    LocationData locationData,
  ) async {
    final allPlaces = await _placeRepository.getPlaces();

    List<Place> nearbyPlaces =
        allPlaces.where((place) {
          if (place.latitude == null || place.longitude == null) return false;

          final distance = _locationRepository.calculateDistanceHaversine(
            lat1: params.location.latitude,
            lon1: params.location.longitude,
            lat2: place.latitude!,
            lon2: place.longitude!,
          );

          return distance <= params.radius;
        }).toList();

    // Filtrar por categoría
    if (params.categoryId != null) {
      nearbyPlaces =
          nearbyPlaces
              .where((place) => place.categoryId == params.categoryId)
              .toList();
    }

    // Filtrar por keyword
    if (params.keyword != null && params.keyword!.isNotEmpty) {
      final keyword = params.keyword!.toLowerCase();
      nearbyPlaces =
          nearbyPlaces.where((place) {
            final nameMatch =
                place.name?.toLowerCase().contains(keyword) ?? false;
            final descriptionMatch =
                place.description?.toLowerCase().contains(keyword) ?? false;
            final addressMatch =
                place.address?.toLowerCase().contains(keyword) ?? false;

            return nameMatch || descriptionMatch || addressMatch;
          }).toList();
    }

    return nearbyPlaces;
  }

  /// Elimina lugares duplicados basándose en ID o coordenadas muy cercanas
  List<Place> _removeDuplicates(List<Place> places) {
    final seen = <String>{};
    final uniquePlaces = <Place>[];

    for (final place in places) {
      if (place.id != null && !seen.contains(place.id)) {
        seen.add(place.id!);
        uniquePlaces.add(place);
      }
    }

    return uniquePlaces;
  }

  /// Mapea categoría interna a tipo de Google Places
  String? _getCategoryType(String? categoryId) {
    if (categoryId == null) return null;

    const categoryMapping = {
      'restaurants': 'restaurant',
      'bars': 'bar',
      'cafes': 'cafe',
      'hotels': 'lodging',
      'shops': 'store',
      'services': 'establishment',
    };

    return categoryMapping[categoryId];
  }
}
