import 'package:core/core.dart';

import '../../app/core/use_case.dart';

class GetFavoritesUseCase implements UseCase<Future<List<Favorite>>, String> {
  final FavoriteRepository favoriteRepository;

  GetFavoritesUseCase({required this.favoriteRepository});

  @override
  Future<List<Favorite>> call(String userId) async {
    return await favoriteRepository.getFavorites(userId);
  }
}
