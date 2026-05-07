import 'package:core/core.dart';

class GetCategoriesUseCase {
  final CategoryRepository _repository;

  GetCategoriesUseCase({required CategoryRepository repository})
    : _repository = repository;

  Future<List<Category>> call() async {
    return await _repository.getAllCategories();
  }
}
