import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:turbo/app/core/no_params.dart';
import 'package:turbo/categories/module/get_places_by_category_use_case.dart';
import 'package:turbo/places/module/get_places_use_case.dart';
import 'package:core/core.dart';
part 'place_state.dart';
part 'place_cubit.freezed.dart';

class PlaceCubit extends Cubit<PlaceState> {
  final GetPlacesUseCase getPlacesUseCase;
  final GetPlacesByCategoryUseCase getPlacesByCategoryUseCase;

  PlaceCubit({
    required this.getPlacesUseCase,
    required this.getPlacesByCategoryUseCase,
  }) : super(const PlaceState.initial());

  Future<void> getPlaces() async {
    emit(const PlacesLoading());
    try {
      final places = await getPlacesUseCase.call(NoParams());
      emit(PlaceState.loaded(places: places));
    } catch (e) {
      emit(PlacesError(e.toString()));
    }
  }

  /*
  Future<void> getPlacesByCategory(String categoryId) async {
    emit(const PlacesLoading());
    try {
      final places = await getPlacesByCategoryUseCase.call(categoryId);
      emit(PlaceState.loaded(places: places));
    } catch (e) {
      emit(PlacesError(e.toString()));
    }
  }
  */
}
