import 'package:core/core.dart';

import '../../app/core/use_case.dart';

class ToggleFavoriteUseCase implements UseCase<void, Favorite> {
  final FavoriteRepository favoriteRepository;

  ToggleFavoriteUseCase({required this.favoriteRepository});

  @override
  Future<void> call(Favorite favorite) async {
    await favoriteRepository.toggleFavorite(favorite);
  }
}
