import 'package:turbo/favorites/favorite_repository/favorite_repository.dart';

import '../../app/core/use_case.dart';
import '../favorite_repository/models/favorite.dart';

class GetFavoritesUseCase implements UseCase<Future<List<Favorite>>, String> {
  final FavoriteRepository favoriteRepository;

  GetFavoritesUseCase({required this.favoriteRepository});

  @override
  Future<List<Favorite>> call(String userId) async {
    return await favoriteRepository.getFavorites(userId);
  }
}
