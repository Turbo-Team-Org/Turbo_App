import 'dart:io';
import '../entities/image_compression_result.dart';

abstract class ImageManagementRepository {
  Future<ImageCompressionResult> compressImage(File imageFile);
  Future<List<ImageCompressionResult>> compressImages(List<File> imageFiles);
  Future<String> uploadImage(File imageFile);
  Future<List<String>> uploadImages(List<File> imageFiles);
}
