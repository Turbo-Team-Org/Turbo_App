import 'package:core/core.dart';

class GetCategoryByIdUseCase {
  final CategoryRepository _repository;

  GetCategoryByIdUseCase({required CategoryRepository repository})
    : _repository = repository;

  Future<Category?> call(String id) async {
    return await _repository.getCategoryById(id);
  }
}
