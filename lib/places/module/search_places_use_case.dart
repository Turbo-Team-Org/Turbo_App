import 'package:core/core.dart';
import 'package:turbo/app/core/use_case.dart';
import 'package:turbo/places/module/params/search_places_params.dart';

/// Caso de uso para búsqueda avanzada de lugares
/// Utiliza los nuevos métodos robustos del Core
class SearchPlacesUseCase
    implements UseCase<Future<List<Place>>, SearchPlacesParams> {
  final PlaceRepository _placeRepository;

  SearchPlacesUseCase({required PlaceRepository placeRepository})
    : _placeRepository = placeRepository;

  @override
  Future<List<Place>> call(SearchPlacesParams params) async {
    try {
      // Usar el nuevo método de búsqueda inteligente del Core
      return await _placeRepository.intelligentSearch(
        params.query,
        categoryId: params.categoryId,
        minRating: params.minRating,
        maxPrice: params.maxPrice,
        minPrice: params.minPrice,
        limit: 50,
      );
    } catch (e) {
      throw Exception('Error al buscar lugares: ${e.toString()}');
    }
  }
}

/// Caso de uso para búsqueda por voz
class SearchPlacesByVoiceUseCase
    implements UseCase<Future<List<Place>>, SearchPlacesParams> {
  final PlaceRepository _placeRepository;

  SearchPlacesByVoiceUseCase({required PlaceRepository placeRepository})
    : _placeRepository = placeRepository;

  @override
  Future<List<Place>> call(SearchPlacesParams params) async {
    try {
      // Usar el nuevo método de búsqueda por voz del Core
      return await _placeRepository.searchPlacesByVoice(
        params.query,
        categoryId: params.categoryId,
        minRating: params.minRating,
        maxPrice: params.maxPrice,
        minPrice: params.minPrice,
        limit: 50,
      );
    } catch (e) {
      throw Exception('Error al buscar lugares por voz: ${e.toString()}');
    }
  }
}

/// Caso de uso para búsqueda por ubicación
class SearchPlacesByLocationUseCase
    implements UseCase<Future<List<Place>>, SearchPlacesParams> {
  final PlaceRepository _placeRepository;

  SearchPlacesByLocationUseCase({required PlaceRepository placeRepository})
    : _placeRepository = placeRepository;

  @override
  Future<List<Place>> call(SearchPlacesParams params) async {
    try {
      if (params.location == null) {
        throw Exception('Ubicación requerida para búsqueda por ubicación');
      }

      // Usar el nuevo método de búsqueda por ubicación del Core
      return await _placeRepository.searchPlacesByLocation(
        latitude: params.location!.latitude,
        longitude: params.location!.longitude,
        radiusKm: (params.maxDistance ?? 5000) / 1000, // Convertir metros a km
        categoryId: params.categoryId,
        minRating: params.minRating,
        maxPrice: params.maxPrice,
        minPrice: params.minPrice,
        limit: 50,
      );
    } catch (e) {
      throw Exception('Error al buscar lugares por ubicación: ${e.toString()}');
    }
  }
}
