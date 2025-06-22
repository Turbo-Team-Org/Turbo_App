import 'package:core/core.dart';

class GetPlacesByCategoryUseCase {
  final PlaceCategoryRepository _placeCategoryRepository;

  GetPlacesByCategoryUseCase({
    required PlaceCategoryRepository placeCategoryRepository,
  }) : _placeCategoryRepository = placeCategoryRepository;

  Future<List<Place>> call(String categoryId) async {
    final places = await _placeCategoryRepository.getPlacesInCategory(
      categoryId,
    );

    return places;
  }
}
