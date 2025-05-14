import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImage(File file, String folder) async {
    try {
      final fileName =
          '${DateTime.now().millisecondsSinceEpoch}${path.extension(file.path)}';
      final ref = _storage.ref().child('$folder/$fileName');

      final uploadTask = ref.putFile(file);
      final snapshot = await uploadTask;

      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      throw Exception('Error al subir la imagen: $e');
    }
  }

  Future<List<String>> uploadMultipleImages(
    List<File> files,
    String folder,
  ) async {
    try {
      final urls = await Future.wait(
        files.map((file) => uploadImage(file, folder)),
      );
      return urls;
    } catch (e) {
      throw Exception('Error al subir las imágenes: $e');
    }
  }

  Future<void> deleteImage(String url) async {
    try {
      final ref = _storage.refFromURL(url);
      await ref.delete();
    } catch (e) {
      throw Exception('Error al eliminar la imagen: $e');
    }
  }
}
