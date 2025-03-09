import 'package:turbo/favorites/favorite_repository/models/favorite.dart';

import '../../app/core/use_case.dart';
import '../favorite_repository/favorite_repository.dart';

class ToggleFavoriteUseCase implements UseCase<void, Favorite> {
  final FavoriteRepository favoriteRepository;

  ToggleFavoriteUseCase({required this.favoriteRepository});

  @override
  Future<void> call(Favorite favorite) async {
    await favoriteRepository.toggleFavorite(favorite);
  }
}
