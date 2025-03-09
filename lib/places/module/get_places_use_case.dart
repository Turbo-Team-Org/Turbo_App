import 'package:turbo/app/core/no_params.dart';
import 'package:turbo/app/core/use_case.dart';
import 'package:turbo/places/place_repository/models/place/place.dart';
import 'package:turbo/places/place_repository/place_repository.dart';

class GetPlacesUseCase implements UseCase<Future<List<Place>>, NoParams> {
  final PlaceRepository placeRepository;
  GetPlacesUseCase({required this.placeRepository});
  @override
  Future<List<Place>> call(param) async => await placeRepository.getPlaces();
}
