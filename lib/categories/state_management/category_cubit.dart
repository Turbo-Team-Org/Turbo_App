import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:core/core.dart';
import 'package:turbo/categories/module/get_categories_use_case.dart';
import 'package:turbo/categories/module/get_category_by_id_use_case.dart';
import 'package:turbo/categories/module/get_places_by_category_use_case.dart';

part 'category_state.dart';
part 'category_cubit.freezed.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final GetCategoriesUseCase _getCategoriesUseCase;
  final GetCategoryByIdUseCase _getCategoryByIdUseCase;
  final GetPlacesByCategoryUseCase _getPlacesByCategoryUseCase;

  CategoryCubit({
    required GetCategoriesUseCase getCategoriesUseCase,
    required GetCategoryByIdUseCase getCategoryByIdUseCase,
    required GetPlacesByCategoryUseCase getPlacesByCategoryUseCase,
  }) : _getCategoriesUseCase = getCategoriesUseCase,
       _getCategoryByIdUseCase = getCategoryByIdUseCase,
       _getPlacesByCategoryUseCase = getPlacesByCategoryUseCase,
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

  Future<void> getPlacesByCategory({required String categoryId}) async {
    emit(CategoryState.loading());
    try {
      final places = await _getPlacesByCategoryUseCase.callLegacy(categoryId);
      emit(CategoryState.placesInCategory(places: places));
    } catch (e) {
      emit(CategoryState.error(e.toString()));
    }
  }
}
