import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:turbo/favorites/favorite_repository/models/favorite.dart';

import '../interface/favorite_interface.dart';

class FavoriteService implements IFavorite {
  final FirebaseFirestore firestore;

  FavoriteService({required this.firestore});

  @override
  Future<void> toggleFavorite(Favorite favorite) async {
    final userDoc = firestore
        .collection('users')
        .doc(favorite.userId.toString());
    final doc = await userDoc.get();

    if (doc.exists) {
      final favorites = List<int>.from(doc['favorites'] ?? []);
      if (favorites.contains(favorite.placeId)) {
        favorites.remove(favorite.placeId);
      } else {
        favorites.add(favorite.placeId);
      }
      await userDoc.update({'favorites': favorites});
    } else {
      await userDoc.set({
        'favorites': [favorite.placeId],
      });
    }
  }

  @override
  Future<List<Favorite>> getFavorites(int userId) async {
    final doc =
        await firestore.collection('users').doc(userId.toString()).get();

    if (!doc.exists) return [];

    // Obtener lista de IDs favoritos del usuario
    List<int> favoriteIds = List<int>.from(doc['favoritesId'] ?? []);

    if (favoriteIds.isEmpty) return [];

    // Buscar los favoritos en la colección 'favorites' cuyos IDs coincidan
    final querySnapshot =
        await firestore
            .collection('favorites')
            .where('id', whereIn: favoriteIds)
            .get();

    // Convertir los documentos en objetos Favorite
    return querySnapshot.docs
        .map((doc) => Favorite.fromJson(doc.data()))
        .toList();
  }
}
