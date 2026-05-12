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
      // TODO(core-sync): cuando Turbo_App apunte a un Core con los métodos
      // avanzados (`intelligentSearch`), delegar aquí y eliminar fallback.
      final _ = _placeRepository;
      return [];
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
      // TODO(core-sync): delegar en búsqueda por voz del Core cuando esté
      // disponible en la versión consumida por Turbo_App.
      final _ = _placeRepository;
      return [];
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
      // TODO(core-sync): delegar en búsqueda por ubicación del Core cuando
      // esté disponible en la versión consumida por Turbo_App.
      final _ = _placeRepository;
      return [];
    } catch (e) {
      throw Exception('Error al buscar lugares por ubicación: ${e.toString()}');
    }
  }
}
