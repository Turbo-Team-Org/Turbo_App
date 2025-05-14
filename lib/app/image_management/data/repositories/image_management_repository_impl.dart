import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;
import 'package:turbo/app/image_management/domain/entities/image_compression_result.dart';
import '../../domain/repositories/image_management_repository.dart';

class ImageManagementRepositoryImpl implements ImageManagementRepository {
  @override
  Future<ImageCompressionResult> compressImage(File imageFile) async {
    try {
      final bytes = await imageFile.readAsBytes();
      final originalSize = bytes.length;
      final image = img.decodeImage(bytes);

      if (image == null) {
        throw Exception('No se pudo decodificar la imagen');
      }

      // Calcular las nuevas dimensiones manteniendo la proporción
      int width = image.width;
      int height = image.height;

      // Si la imagen es muy grande, redimensionarla
      if (width > 1200 || height > 1200) {
        if (width > height) {
          height = (height * 1200 / width).round();
          width = 1200;
        } else {
          width = (width * 1200 / height).round();
          height = 1200;
        }
      }

      // Redimensionar la imagen
      final resizedImage = img.copyResize(
        image,
        width: width,
        height: height,
        interpolation: img.Interpolation.linear,
      );

      // Comprimir la imagen con calidad 85%
      final compressedBytes = img.encodeJpg(resizedImage, quality: 85);
      final compressedSize = compressedBytes.length;

      // Guardar la imagen comprimida en un archivo temporal
      final tempDir = await getTemporaryDirectory();
      final tempFile = File(
        '${tempDir.path}/compressed_${DateTime.now().millisecondsSinceEpoch}.jpg',
      );
      await tempFile.writeAsBytes(compressedBytes);

      return ImageCompressionResult(
        compressedFile: tempFile,
        originalSize: originalSize,
        compressedSize: compressedSize,
        compressionRatio: originalSize / compressedSize,
      );
    } catch (e) {
      throw Exception('Error al comprimir la imagen: $e');
    }
  }

  @override
  Future<List<ImageCompressionResult>> compressImages(
    List<File> imageFiles,
  ) async {
    final results = <ImageCompressionResult>[];
    for (final file in imageFiles) {
      results.add(await compressImage(file));
    }
    return results;
  }

  @override
  Future<String> uploadImage(File imageFile) async {
    // TODO: Implementar la lógica de subida a Firebase Storage
    throw UnimplementedError('Método no implementado');
  }

  @override
  Future<List<String>> uploadImages(List<File> imageFiles) async {
    // TODO: Implementar la lógica de subida múltiple a Firebase Storage
    throw UnimplementedError('Método no implementado');
  }
}
