part of 'favorite_cubit.dart';

@freezed
class FavoriteState with _$FavoriteState {
  const factory FavoriteState.initial() = FavoriteInitial;
  const factory FavoriteState.loading() = FavoriteLoading;
  const factory FavoriteState.loaded({required List<Favorite> favorites}) =
      FavoriteLoaded;
  const factory FavoriteState.error({required String message}) = FavoriteError;
}
