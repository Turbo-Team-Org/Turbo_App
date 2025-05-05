import 'model/category.dart';
import 'service/category_service.dart';

class CategoryRepository {
  final CategoryService _categoryService;

  CategoryRepository({required CategoryService categoryService})
    : _categoryService = categoryService;

  Future<List<Category>> getAllCategories() async {
    try {
      return await _categoryService.getAllCategories();
    } catch (e) {
      throw Exception('Error al obtener categorías: ${e.toString()}');
    }
  }

  Future<Category?> getCategoryById(String id) async {
    try {
      return await _categoryService.getCategoryById(id);
    } catch (e) {
      throw Exception('Error al obtener categoría: ${e.toString()}');
    }
  }

  Future<bool> addCategory(Category category) async {
    try {
      await _categoryService.addCategory(category);
      return true;
    } catch (e) {
      throw Exception('Error al añadir categoría: ${e.toString()}');
    }
  }

  Future<bool> updateCategory(Category category) async {
    try {
      await _categoryService.updateCategory(category);
      return true;
    } catch (e) {
      throw Exception('Error al actualizar categoría: ${e.toString()}');
    }
  }

  Future<bool> deleteCategory(String id) async {
    try {
      await _categoryService.deleteCategory(id);
      return true;
    } catch (e) {
      throw Exception('Error al eliminar categoría: ${e.toString()}');
    }
  }
}
