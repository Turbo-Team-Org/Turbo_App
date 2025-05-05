import '../../places/place_repository/models/place/place.dart';
import '../module/place_category_association.dart';

class GetPlacesByCategoryUseCase {
  final PlaceCategoryAssociation _placeCategoryAssociation;

  GetPlacesByCategoryUseCase({
    required PlaceCategoryAssociation placeCategoryAssociation,
  }) : _placeCategoryAssociation = placeCategoryAssociation;

  Future<List<Place>> call(String categoryId) async {
    return await _placeCategoryAssociation.getPlacesInCategory(categoryId);
  }
}
