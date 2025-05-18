import 'package:core/core.dart';

class GetPlacesByCategoryUseCase {
  final CategoryRepository _categoryRepository;

  GetPlacesByCategoryUseCase({required CategoryRepository categoryRepository})
    : _categoryRepository = categoryRepository;

  Future<PlaceCategory> call(String categoryId) async {
    final places = await _categoryRepository.getPlacesByCategory(categoryId);
    final category = await _categoryRepository.getCategoryById(categoryId);
    return PlaceCategory(places: places, categories: category!);
  }
}
