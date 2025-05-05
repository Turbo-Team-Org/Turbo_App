import '../category_repository/category_repository.dart';
import '../category_repository/model/category.dart';

class GetCategoryByIdUseCase {
  final CategoryRepository _repository;

  GetCategoryByIdUseCase({required CategoryRepository repository})
    : _repository = repository;

  Future<Category?> call(String id) async {
    return await _repository.getCategoryById(id);
  }
}
