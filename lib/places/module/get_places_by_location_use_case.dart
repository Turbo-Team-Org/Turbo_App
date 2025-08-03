import 'package:core/core.dart';
import 'package:turbo/app/core/use_case.dart';
import 'package:turbo/places/module/params/search_places_params.dart';

/// Caso de uso para obtener lugares por ubicación
/// Utiliza el LocationRepository para encontrar lugares dentro de un radio específico
class GetPlacesByLocationUseCase
    implements UseCase<Future<List<Place>>, GetPlacesByLocationParams> {
  final LocationRepository _locationRepository;
  final PlaceRepository _placeRepository;

  GetPlacesByLocationUseCase({
    required LocationRepository locationRepository,
    required PlaceRepository placeRepository,
  }) : _locationRepository = locationRepository,
       _placeRepository = placeRepository;

  @override
  Future<List<Place>> call(GetPlacesByLocationParams params) async {
    try {
      // Convertir LatLng a LocationData
      final locationData = LocationData(
        latitude: params.location.latitude,
        longitude: params.location.longitude,
        timestamp: DateTime.now(),
      );

      // Usar el método optimizado del LocationRepository si está disponible
      try {
        final nearbyResults = await _locationRepository.findPlacesWithinRadius(
          center: locationData,
          radiusMeters: params.radius,
          categories: params.categoryId != null ? [params.categoryId!] : null,
          limit: params.limit,
          sortBy: params.sortBy,
        );

        // Convertir NearbySearchResult a Place si es necesario
        // Por ahora, vamos a usar el método manual hasta que el core esté completamente implementado
      } catch (e) {
        // Fallback al método manual
      }

      // Método manual: obtener todos los lugares y filtrar por distancia
      final allPlaces = await _placeRepository.getPlaces();

      List<Place> filteredPlaces =
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

      // Aplicar filtros adicionales
      if (params.categoryId != null) {
        filteredPlaces =
            filteredPlaces
                .where((place) => place.categoryId == params.categoryId)
                .toList();
      }

      if (params.minRating != null) {
        filteredPlaces =
            filteredPlaces
                .where((place) => (place.rating ?? 0) >= params.minRating!)
                .toList();
      }

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

      // Ordenar según el criterio especificado
      filteredPlaces.sort((a, b) {
        switch (params.sortBy) {
          case 'distance':
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
        'Error al obtener lugares por ubicación: ${e.toString()}',
      );
    }
  }
}
