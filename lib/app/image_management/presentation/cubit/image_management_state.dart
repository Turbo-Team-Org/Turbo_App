import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/image_compression_result.dart';

part 'image_management_state.freezed.dart';

@freezed
sealed class ImageManagementState with _$ImageManagementState {
  const factory ImageManagementState.initial() = Initial;
  const factory ImageManagementState.loading() = Loading;
  const factory ImageManagementState.compressed(ImageCompressionResult result) =
      Compressed;
  const factory ImageManagementState.multipleCompressed(
    List<ImageCompressionResult> results,
  ) = MultipleCompressed;
  const factory ImageManagementState.uploaded(String url) = Uploaded;
  const factory ImageManagementState.multipleUploaded(List<String> urls) =
      MultipleUploaded;
  const factory ImageManagementState.error(String message) = Error;
}
