import 'dart:io';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_compression_result.freezed.dart';

@freezed
sealed class ImageCompressionResult with _$ImageCompressionResult {
  const factory ImageCompressionResult({
    required File compressedFile,
    required int originalSize,
    required int compressedSize,
    required double compressionRatio,
  }) = _ImageCompressionResult;
}
