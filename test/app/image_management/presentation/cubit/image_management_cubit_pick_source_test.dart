import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:turbo/app/image_management/domain/entities/image_compression_result.dart';
import 'package:turbo/app/image_management/domain/repositories/image_management_repository.dart';
import 'package:turbo/app/image_management/presentation/cubit/image_management_cubit.dart';
import 'package:turbo/app/image_management/presentation/cubit/image_management_state.dart';

class MockImageManagementRepository extends Mock
    implements ImageManagementRepository {}

class MockImagePicker extends Mock implements ImagePicker {}

void main() {
  late MockImageManagementRepository repository;
  late MockImagePicker imagePicker;
  late String tempPath;

  setUpAll(() {
    registerFallbackValue(File('fallback.jpg'));
    registerFallbackValue(ImageSource.gallery);
  });

  setUp(() async {
    repository = MockImageManagementRepository();
    imagePicker = MockImagePicker();
    final dir = Directory.systemTemp.createTempSync('img_cubit_');
    tempPath = '${dir.path}/pick.jpg';
    await File(tempPath).writeAsBytes([1, 2, 3]);
  });

  blocTest<ImageManagementCubit, ImageManagementState>(
    'emite loading y compressed cuando galería devuelve imagen',
    build: () {
      when(
        () => imagePicker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 100,
        ),
      ).thenAnswer((_) async => XFile(tempPath));
      when(() => repository.compressImage(any())).thenAnswer((invocation) async {
        final file = invocation.positionalArguments.first as File;
        return ImageCompressionResult(
          compressedFile: file,
          originalSize: 10,
          compressedSize: 5,
          compressionRatio: 0.5,
        );
      });
      return ImageManagementCubit(
        repository: repository,
        imagePicker: imagePicker,
      );
    },
    act: (cubit) => cubit.pickAndCompressImage(ImageSource.gallery),
    expect: () => [
      const ImageManagementState.loading(),
      isA<Compressed>(),
    ],
    verify: (_) {
      verify(
        () => imagePicker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 100,
        ),
      ).called(1);
    },
  );

  blocTest<ImageManagementCubit, ImageManagementState>(
    'emite loading y compressed cuando cámara devuelve imagen',
    build: () {
      when(
        () => imagePicker.pickImage(
          source: ImageSource.camera,
          imageQuality: 100,
        ),
      ).thenAnswer((_) async => XFile(tempPath));
      when(() => repository.compressImage(any())).thenAnswer((invocation) async {
        final file = invocation.positionalArguments.first as File;
        return ImageCompressionResult(
          compressedFile: file,
          originalSize: 8,
          compressedSize: 4,
          compressionRatio: 0.5,
        );
      });
      return ImageManagementCubit(
        repository: repository,
        imagePicker: imagePicker,
      );
    },
    act: (cubit) => cubit.pickAndCompressImage(ImageSource.camera),
    expect: () => [
      const ImageManagementState.loading(),
      isA<Compressed>(),
    ],
    verify: (_) {
      verify(
        () => imagePicker.pickImage(
          source: ImageSource.camera,
          imageQuality: 100,
        ),
      ).called(1);
    },
  );

  blocTest<ImageManagementCubit, ImageManagementState>(
    'emite loading e initial si el usuario cancela la selección',
    build: () {
      when(
        () => imagePicker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 100,
        ),
      ).thenAnswer((_) async => null);
      return ImageManagementCubit(
        repository: repository,
        imagePicker: imagePicker,
      );
    },
    act: (cubit) => cubit.pickAndCompressImage(ImageSource.gallery),
    expect: () => [
      const ImageManagementState.loading(),
      const ImageManagementState.initial(),
    ],
    verify: (_) {
      verifyNever(() => repository.compressImage(any()));
    },
  );

  blocTest<ImageManagementCubit, ImageManagementState>(
    'emite loading y error si pickImage lanza',
    build: () {
      when(
        () => imagePicker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 100,
        ),
      ).thenThrow(Exception('permiso denegado'));
      return ImageManagementCubit(
        repository: repository,
        imagePicker: imagePicker,
      );
    },
    act: (cubit) => cubit.pickAndCompressImage(ImageSource.gallery),
    expect: () => [
      const ImageManagementState.loading(),
      isA<Error>(),
    ],
  );
}
