import '../module/place_category_association.dart';

class UpdatePlaceCategoriesUseCase {
  final PlaceCategoryAssociation _placeCategoryAssociation;

  UpdatePlaceCategoriesUseCase({
    required PlaceCategoryAssociation placeCategoryAssociation,
  }) : _placeCategoryAssociation = placeCategoryAssociation;

  Future<bool> call(String placeId, List<String> categoryIds) async {
    return await _placeCategoryAssociation.updatePlaceCategories(
      placeId,
      categoryIds,
    );
  }
}
