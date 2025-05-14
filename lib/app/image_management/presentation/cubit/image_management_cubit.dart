import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:turbo/app/image_management/presentation/cubit/image_management_state.dart';
import '../../domain/repositories/image_management_repository.dart';

class ImageManagementCubit extends Cubit<ImageManagementState> {
  final ImageManagementRepository _repository;
  final ImagePicker _imagePicker;

  ImageManagementCubit({
    required ImageManagementRepository repository,
    ImagePicker? imagePicker,
  }) : _repository = repository,
       _imagePicker = imagePicker ?? ImagePicker(),
       super(const ImageManagementState.initial());

  Future<void> pickAndCompressImage() async {
    try {
      emit(const ImageManagementState.loading());

      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
      );

      if (image == null) {
        emit(const ImageManagementState.initial());
        return;
      }

      final File imageFile = File(image.path);
      final result = await _repository.compressImage(imageFile);

      emit(ImageManagementState.compressed(result));
    } catch (e) {
      emit(ImageManagementState.error(e.toString()));
    }
  }

  Future<void> pickAndCompressMultipleImages({int maxImages = 3}) async {
    try {
      emit(const ImageManagementState.loading());

      final List<XFile> images = await _imagePicker.pickMultiImage();

      if (images.isEmpty) {
        emit(const ImageManagementState.initial());
        return;
      }

      if (images.length > maxImages) {
        emit(
          ImageManagementState.error('Máximo $maxImages imágenes permitidas'),
        );
        return;
      }

      final List<File> imageFiles =
          images.map((xFile) => File(xFile.path)).toList();
      final results = await _repository.compressImages(imageFiles);

      emit(ImageManagementState.multipleCompressed(results));
    } catch (e) {
      emit(ImageManagementState.error(e.toString()));
    }
  }

  Future<void> uploadImage(File imageFile) async {
    try {
      emit(const ImageManagementState.loading());
      final url = await _repository.uploadImage(imageFile);
      emit(ImageManagementState.uploaded(url));
    } catch (e) {
      emit(ImageManagementState.error(e.toString()));
    }
  }

  Future<void> uploadImages(List<File> imageFiles) async {
    try {
      emit(const ImageManagementState.loading());
      final urls = await _repository.uploadImages(imageFiles);
      emit(ImageManagementState.multipleUploaded(urls));
    } catch (e) {
      emit(ImageManagementState.error(e.toString()));
    }
  }
}
