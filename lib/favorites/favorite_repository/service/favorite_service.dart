import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:turbo/favorites/favorite_repository/models/favorite.dart';
import 'package:turbo/places/place_repository/models/place/place.dart';
import 'package:uuid/uuid.dart';
import '../interface/favorite_interface.dart';

class FavoriteService implements IFavorite {
  final FirebaseFirestore _firestore;
  final _uuid = const Uuid();

  FavoriteService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<void> toggleFavorite(Favorite favorite) async {
    try {
      // Buscar si ya existe un favorito para este usuario y lugar
      final querySnapshot =
          await _firestore
              .collection('favorites')
              .where('userId', isEqualTo: favorite.userId)
              .where('placeId', isEqualTo: favorite.placeId)
              .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Si existe, eliminarlo
        await _firestore
            .collection('favorites')
            .doc(querySnapshot.docs.first.id)
            .delete();
      } else {
        // Si no existe, crearlo con un UUID único
        final String newId = _uuid.v4();
        await _firestore.collection('favorites').doc(newId).set({
          'id': newId,
          'placeId': favorite.placeId,
          'userId': favorite.userId,
          'date': FieldValue.serverTimestamp(),
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      throw Exception('Error al actualizar favorito: $e');
    }
  }

  @override
  Future<List<Favorite>> getFavorites(String userId) async {
    try {
      final favoritesSnapshot =
          await _firestore
              .collection('favorites')
              .where('userId', isEqualTo: userId)
              .get();

      print('Favoritos encontrados: ${favoritesSnapshot.docs.length}'); // Debug

      final favorites =
          favoritesSnapshot.docs.map((doc) {
            final data = doc.data();
            print('Documento favorito: $data'); // Debug
            return Favorite.fromFirestore(doc);
          }).toList();

      // Obtener los lugares para cada favorito
      final placesSnapshot = await Future.wait(
        favorites.map(
          (favorite) =>
              _firestore.collection('places').doc(favorite.placeId).get(),
        ),
      );

      // Combinar los favoritos con sus lugares
      final favoritesWithPlaces = List<Favorite>.from(favorites);
      for (var i = 0; i < favorites.length; i++) {
        final placeDoc = placesSnapshot[i];
        if (placeDoc.exists) {
          final place = Place.fromFirestore(placeDoc);
          favoritesWithPlaces[i] = favorites[i].copyWith(place: place);
        }
      }

      return favoritesWithPlaces;
    } catch (e) {
      print('Error al obtener favoritos: $e'); // Debug
      throw Exception('Error al obtener favoritos: $e');
    }
  }

  @override
  Future<bool> isFavorite(String userId, String placeId) async {
    try {
      final querySnapshot =
          await _firestore
              .collection('favorites')
              .where('userId', isEqualTo: userId)
              .where('placeId', isEqualTo: placeId)
              .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      throw Exception('Error al verificar favorito: $e');
    }
  }

  @override
  Future<void> addFavorite(String userId, String placeId) async {
    try {
      final newId = _uuid.v4();
      await _firestore.collection('favorites').doc(newId).set({
        'id': newId,
        'userId': userId,
        'placeId': placeId,
        'date': FieldValue.serverTimestamp(),
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Error al agregar favorito: $e');
    }
  }

  @override
  Future<void> removeFavorite(String userId, String placeId) async {
    try {
      final querySnapshot =
          await _firestore
              .collection('favorites')
              .where('userId', isEqualTo: userId)
              .where('placeId', isEqualTo: placeId)
              .get();

      if (querySnapshot.docs.isNotEmpty) {
        await _firestore
            .collection('favorites')
            .doc(querySnapshot.docs.first.id)
            .delete();
      }
    } catch (e) {
      throw Exception('Error al eliminar favorito: $e');
    }
  }
}
