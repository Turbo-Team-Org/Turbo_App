import 'package:core/core.dart';

class UpdatePlaceCategoriesUseCase {
  final CategoryRepository _categoryRepository;

  UpdatePlaceCategoriesUseCase({required CategoryRepository categoryRepository})
    : _categoryRepository = categoryRepository;

  Future<bool> call(String placeId, List<String> categoryIds) async {
    return await _categoryRepository.updateCategoryAssociations(
      placeId,
      categoryIds,
    );
  }
}
