import 'package:core/core.dart';
import 'package:turbo/app/core/use_case.dart';
import 'package:turbo/places/module/params/search_places_params.dart';

class GetPlacesByCategoryUseCase
    implements UseCase<Future<List<Place>>, GetPlacesByCategoryParams> {
  final PlaceCategoryRepository _placeCategoryRepository;
  final LocationRepository? _locationRepository;

  GetPlacesByCategoryUseCase({
    required PlaceCategoryRepository placeCategoryRepository,
    LocationRepository? locationRepository,
  }) : _placeCategoryRepository = placeCategoryRepository,
       _locationRepository = locationRepository;

  @override
  Future<List<Place>> call(GetPlacesByCategoryParams params) async {
    try {
      // Obtener lugares de la categoría
      final places = await _placeCategoryRepository.getPlacesInCategory(
        params.categoryId,
      );

      List<Place> filteredPlaces = places;

      // Aplicar filtros de rating
      if (params.minRating != null) {
        filteredPlaces =
            filteredPlaces
                .where((place) => (place.rating ?? 0) >= params.minRating!)
                .toList();
      }

      // Aplicar filtros de precio
      if (params.minPrice != null) {
        filteredPlaces =
            filteredPlaces
                .where((place) => (place.averagePrice ?? 0) >= params.minPrice!)
                .toList();
      }

      if (params.maxPrice != null) {
        filteredPlaces =
            filteredPlaces
                .where(
                  (place) =>
                      (place.averagePrice ?? double.infinity) <=
                      params.maxPrice!,
                )
                .toList();
      }

      // Filtrar por distancia si se proporciona ubicación
      if (params.location != null &&
          params.maxDistance != null &&
          _locationRepository != null) {
        filteredPlaces =
            filteredPlaces.where((place) {
              if (place.latitude == null || place.longitude == null)
                return false;

              final distance = _locationRepository!.calculateDistanceHaversine(
                lat1: params.location!.latitude,
                lon1: params.location!.longitude,
                lat2: place.latitude!,
                lon2: place.longitude!,
              );

              return distance <= params.maxDistance!;
            }).toList();
      }

      // Ordenar según el criterio especificado
      filteredPlaces.sort((a, b) {
        switch (params.sortBy) {
          case 'distance':
            if (params.location != null &&
                a.latitude != null &&
                a.longitude != null &&
                b.latitude != null &&
                b.longitude != null &&
                _locationRepository != null) {
              final distanceA = _locationRepository!.calculateDistanceHaversine(
                lat1: params.location!.latitude,
                lon1: params.location!.longitude,
                lat2: a.latitude!,
                lon2: a.longitude!,
              );

              final distanceB = _locationRepository!.calculateDistanceHaversine(
                lat1: params.location!.latitude,
                lon1: params.location!.longitude,
                lat2: b.latitude!,
                lon2: b.longitude!,
              );

              return distanceA.compareTo(distanceB);
            }
            return 0;

          case 'rating':
            return (b.rating ?? 0).compareTo(a.rating ?? 0);

          case 'price':
            return (a.averagePrice ?? 0).compareTo(b.averagePrice ?? 0);

          default:
            return (b.rating ?? 0).compareTo(a.rating ?? 0);
        }
      });

      // Limitar resultados
      if (filteredPlaces.length > params.limit) {
        filteredPlaces = filteredPlaces.take(params.limit).toList();
      }

      return filteredPlaces;
    } catch (e) {
      throw Exception(
        'Error al obtener lugares por categoría: ${e.toString()}',
      );
    }
  }

  /// Método legacy para compatibilidad hacia atrás
  Future<List<Place>> callLegacy(String categoryId) async {
    return call(GetPlacesByCategoryParams(categoryId: categoryId));
  }
}
