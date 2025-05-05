import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:turbo/categories/category_repository/model/category.dart';
import 'package:turbo/categories/module/get_categories_use_case.dart';
import 'package:turbo/categories/module/get_category_by_id_use_case.dart';

part 'category_state.dart';
part 'category_cubit.freezed.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final GetCategoriesUseCase _getCategoriesUseCase;
  final GetCategoryByIdUseCase _getCategoryByIdUseCase;

  CategoryCubit({
    required GetCategoriesUseCase getCategoriesUseCase,
    required GetCategoryByIdUseCase getCategoryByIdUseCase,
  }) : _getCategoriesUseCase = getCategoriesUseCase,
       _getCategoryByIdUseCase = getCategoryByIdUseCase,
       super(const CategoryState.initial());
  Future<void> loadCategories() async {
    emit(const CategoryState.loading());

    try {
      final categories = await _getCategoriesUseCase();
      emit(CategoryState.loaded(categories: categories));
    } catch (e) {
      emit(CategoryState.error(e.toString()));
    }
  }

  Future<void> loadCategoryById(String id) async {
    emit(const CategoryState.loading());

    try {
      final category = await _getCategoryByIdUseCase(id);
      if (category != null) {
        emit(CategoryState.selectedCategory(category: category));
      } else {
        emit(const CategoryState.error('Categoría no encontrada'));
      }
    } catch (e) {
      emit(CategoryState.error(e.toString()));
    }
  }
}
