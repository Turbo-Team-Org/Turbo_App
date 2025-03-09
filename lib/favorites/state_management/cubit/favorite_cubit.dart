import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:async';

import '../../favorite_repository/models/favorite.dart';
import '../../module/get_favorites_use_case.dart';
import '../../module/toogle_favorite_use_case.dart';

part 'favorite_state.dart';
part 'favorite_cubit.freezed.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final GetFavoritesUseCase getFavoritesUseCase;
  final ToggleFavoriteUseCase toggleFavoriteUseCase;

  FavoriteCubit({
    required this.getFavoritesUseCase,
    required this.toggleFavoriteUseCase,
  }) : super(const FavoriteState.initial());

  Future<void> getFavorites(int userId) async {
    emit(const FavoriteState.loading());
    try {
      final favorites = await getFavoritesUseCase(userId);
      emit(FavoriteState.loaded(favorites));
    } catch (e) {
      emit(FavoriteState.error(e.toString()));
    }
  }

  Future<void> toggleFavorite(int placeId, int userId) async {
    try {
      final favorite = Favorite(userId: userId, placeId: placeId);
      await toggleFavoriteUseCase(favorite);
      final favorites = await getFavoritesUseCase(userId);
      // Actualizar el estado actual
      switch (state) {
        case FavoriteState.loaded:
          final updatedFavorites = List<Favorite>.from(favorites);
          if (updatedFavorites.any((fav) => fav.placeId == placeId)) {
            updatedFavorites.removeWhere(
              (fav) => fav.placeId == placeId,
            ); // Eliminar de favoritos
          } else {
            updatedFavorites.add(
              Favorite(userId: userId, placeId: placeId),
            ); // Añadir a favoritos
          }
          emit(FavoriteState.loaded(updatedFavorites));
          break;
        default:
          // Maneja otros casos si es necesario
          break;
      }
    } catch (e) {
      emit(const FavoriteState.error('Error al actualizar los favoritos'));
    }
  }

  // Verificar si un lugar es favorito
}
