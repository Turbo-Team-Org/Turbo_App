import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:core/core.dart';
import 'package:turbo/favorites/module/toogle_favorite_use_case.dart';
import 'dart:async';

import '../../module/get_favorites_use_case.dart';

part 'favorite_state.dart';
part 'favorite_cubit.freezed.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final GetFavoritesUseCase getFavoritesUseCase;
  final ToggleFavoriteUseCase toggleFavoriteUseCase;
  final Map<String, bool> _favoritesMap = {};

  FavoriteCubit({
    required this.getFavoritesUseCase,
    required this.toggleFavoriteUseCase,
  }) : super(const FavoriteState.initial());

  Future<void> getFavorites(String userId) async {
    emit(const FavoriteState.loading());
    try {
      final favorites = await getFavoritesUseCase(userId);
      // Actualizar el mapa de favoritos
      _favoritesMap.clear();
      for (var favorite in favorites) {
        _favoritesMap[favorite.placeId] = true;
      }
      emit(FavoriteState.loaded(favorites: favorites));
    } catch (e) {
      emit(FavoriteState.error(message: e.toString()));
    }
  }

  Future<void> toggleFavorite({
    required String userId,
    required String placeId,
  }) async {
    try {
      // Optimistic update del mapa local
      _favoritesMap[placeId] = !(_favoritesMap[placeId] ?? false);

      final favorite = Favorite(
        id: '', // Se generará en el servicio
        placeId: placeId,
        userId: userId,
        date: DateTime.now(),
      );

      await toggleFavoriteUseCase(favorite);

      // Recargar la lista de favoritos después de togglear
      await getFavorites(userId);
    } catch (e) {
      // Revertir el cambio local si hay error
      _favoritesMap[placeId] = !(_favoritesMap[placeId] ?? false);
      emit(FavoriteState.error(message: e.toString()));
    }
  }

  // Verificar si un lugar es favorito
  bool isFavorite(String placeId) {
    return _favoritesMap[placeId] ?? false;
  }
}
