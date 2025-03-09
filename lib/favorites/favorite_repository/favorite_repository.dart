import 'package:turbo/favorites/favorite_repository/service/favorite_service.dart';

import 'models/favorite.dart';

class FavoriteRepository {
  final FavoriteService favoriteService;

  FavoriteRepository({required this.favoriteService});

  Future<void> toggleFavorite(Favorite favorite) async {
    await favoriteService.toggleFavorite(favorite);
  }

  Future<List<Favorite>> getFavorites(int userId) async {
    return await favoriteService.getFavorites(userId);
  }
}
