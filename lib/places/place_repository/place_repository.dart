import 'package:turbo/places/place_repository/models/place/place.dart';
import 'package:turbo/places/place_repository/service/place_service.dart';

class PlaceRepository {
  final PlaceService placeService;
  PlaceRepository({required this.placeService});
  Future<List<Place>> getPlaces() async => await placeService.getPlaces();
}
