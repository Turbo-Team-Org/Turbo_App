import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turbo/app/core/theme/text_styles.dart';
import 'package:turbo/app/utils/app_preferences.dart';
import 'package:turbo/authentication/state_managament/auth_cubit/cubit/auth_cubit_cubit.dart';
import 'package:turbo/reviews/state_management/cubit/review_cubit.dart';
import 'package:turbo/reviews/review_repository/models/review.dart';
import 'package:animate_do/animate_do.dart';
import 'package:uuid/uuid.dart';
import 'package:turbo/app/image_management/presentation/cubit/image_management_cubit.dart';
import 'package:turbo/app/image_management/presentation/cubit/image_management_state.dart';
import 'package:turbo/app/image_management/domain/entities/image_compression_result.dart';
import 'package:turbo/app/image_management/data/services/storage_service.dart';

class AddReviewDialog extends StatefulWidget {
  final String placeId;

  const AddReviewDialog({super.key, required this.placeId});

  @override
  State<AddReviewDialog> createState() => _AddReviewDialogState();
}

class _AddReviewDialogState extends State<AddReviewDialog> {
  final _formKey = GlobalKey<FormState>();
  final _commentController = TextEditingController();
  final _storageService = StorageService();
  int _rating = 0;
  bool _isSubmitting = false;
  bool _isUploadingImages = false;
  List<ImageCompressionResult> _selectedImages = [];
  final preferences = AppPreferences();

  static const int maxImagesPerReview = 3;
  static const int maxImageSizeInMB = 5;

  @override
  void dispose() {
    _commentController.dispose();
    _cleanupImages();
    super.dispose();
  }

  void _cleanupImages() {
    // Eliminar archivos temporales
    for (var image in _selectedImages) {
      try {
        if (image.compressedFile.existsSync()) {
          image.compressedFile.deleteSync();
        }
      } catch (e) {
        debugPrint('Error al limpiar imagen temporal: $e');
      }
    }
    _selectedImages.clear();
  }

  Future<bool> _onWillPop() async {
    if (_isSubmitting || _isUploadingImages) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor espera a que termine la subida'),
          backgroundColor: Colors.orange,
        ),
      );
      return false;
    }
    return true;
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  Future<void> _validateImages() async {
    if (_selectedImages.length > maxImagesPerReview) {
      throw Exception('Máximo $maxImagesPerReview imágenes por reseña');
    }

    for (var image in _selectedImages) {
      final sizeInMB = image.compressedFile.lengthSync() / (1024 * 1024);
      if (sizeInMB > maxImageSizeInMB) {
        throw Exception('Las imágenes no deben superar ${maxImageSizeInMB}MB');
      }
    }
  }

  Future<List<String>> _uploadImages() async {
    if (_selectedImages.isEmpty) return [];

    setState(() => _isUploadingImages = true);
    try {
      await _validateImages();

      final files = _selectedImages.map((img) => img.compressedFile).toList();
      final urls = await _storageService.uploadMultipleImages(
        files,
        'reviews/${widget.placeId}',
      );
      return urls;
    } finally {
      setState(() => _isUploadingImages = false);
    }
  }

  Future<void> _submitReview() async {
    if (_formKey.currentState!.validate() && _rating > 0) {
      setState(() => _isSubmitting = true);

      try {
        final authState = context.read<AuthCubit>().state;
        if (authState is! Authenticated) {
          throw Exception('Debes iniciar sesión para publicar una reseña');
        }

        // Subir imágenes primero
        final imageUrls = await _uploadImages();

        final review = Review(
          id: const Uuid().v4(),
          userId: authState.user.uid,
          userName: preferences.getUserName() ?? 'Usuario',
          userAvatar: '',
          comment: _commentController.text,
          rating: _rating.toDouble(),
          date: DateTime.now(),
          imageUrls: imageUrls,
        );

        await context.read<ReviewCubit>().addReview(review, widget.placeId);
        if (mounted) {
          Navigator.of(context).pop();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error al añadir la reseña: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() => _isSubmitting = false);
        }
      }
    } else if (_rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, selecciona una calificación'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: BlocListener<ImageManagementCubit, ImageManagementState>(
        listener: (context, state) {
          switch (state) {
            case ImageManagementState.initial:
              break;
            case ImageManagementState.loading:
              break;
            case Compressed(result: final result):
              setState(() {
                if (_selectedImages.length < maxImagesPerReview) {
                  _selectedImages.add(result);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Máximo $maxImagesPerReview imágenes permitidas',
                      ),
                      backgroundColor: Colors.orange,
                    ),
                  );
                }
              });
              break;
            case MultipleCompressed(results: final results):
              setState(() {
                if (results.length > maxImagesPerReview) {
                  _selectedImages = results.sublist(0, maxImagesPerReview);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Se seleccionaron solo las primeras $maxImagesPerReview imágenes',
                      ),
                      backgroundColor: Colors.orange,
                    ),
                  );
                } else {
                  _selectedImages = results;
                }
              });
              break;
            case Error(message: final message):
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message), backgroundColor: Colors.red),
              );
              break;
            default:
              break;
          }
        },
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: FadeInDown(
            duration: const Duration(milliseconds: 300),
            child: Container(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Escribir Reseña',
                          style: AppTextStyles.titleLarge(
                            context,
                          ).copyWith(fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          onPressed:
                              _isSubmitting || _isUploadingImages
                                  ? null
                                  : () {
                                    _cleanupImages();
                                    Navigator.of(context).pop();
                                  },
                          icon: const Icon(Icons.close),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Calificación con estrellas
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          return GestureDetector(
                            onTap: () => setState(() => _rating = index + 1),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                              ),
                              child: Icon(
                                index < _rating
                                    ? Icons.star
                                    : Icons.star_border,
                                color: Theme.of(context).colorScheme.primary,
                                size: 32,
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Campo de comentario
                    TextFormField(
                      controller: _commentController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'Cuéntanos tu experiencia...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Theme.of(
                              context,
                            ).colorScheme.primary.withOpacity(0.5),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Theme.of(
                              context,
                            ).colorScheme.primary.withOpacity(0.3),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, escribe tu comentario';
                        }
                        if (value.length < 10) {
                          return 'El comentario debe tener al menos 10 caracteres';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    // Sección de imágenes
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Añadir fotos (máx. 3)',
                          style: AppTextStyles.bodyMedium(
                            context,
                          ).copyWith(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            // Botón para añadir imágenes
                            if (_selectedImages.length < 3)
                              GestureDetector(
                                onTap:
                                    () =>
                                        context
                                            .read<ImageManagementCubit>()
                                            .pickAndCompressImage(),
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary.withOpacity(0.3),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.add_photo_alternate_outlined,
                                        color:
                                            Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                        size: 24,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Añadir',
                                        style: TextStyle(
                                          color:
                                              Theme.of(
                                                context,
                                              ).colorScheme.primary,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            const SizedBox(width: 8),
                            // Imágenes seleccionadas
                            Expanded(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children:
                                      _selectedImages.asMap().entries.map((
                                        entry,
                                      ) {
                                        final index = entry.key;
                                        final image = entry.value;
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            right: 8,
                                          ),
                                          child: Stack(
                                            children: [
                                              Container(
                                                width: 80,
                                                height: 80,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  image: DecorationImage(
                                                    image: FileImage(
                                                      image.compressedFile,
                                                    ),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top: 4,
                                                right: 4,
                                                child: GestureDetector(
                                                  onTap:
                                                      () => _removeImage(index),
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(4),
                                                    decoration: BoxDecoration(
                                                      color: Colors.black
                                                          .withOpacity(0.5),
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: const Icon(
                                                      Icons.close,
                                                      color: Colors.white,
                                                      size: 16,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Botón de enviar
                    ElevatedButton(
                      onPressed:
                          (_isSubmitting || _isUploadingImages)
                              ? null
                              : _submitReview,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child:
                          (_isSubmitting || _isUploadingImages)
                              ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    _isUploadingImages
                                        ? 'Subiendo imágenes...'
                                        : 'Publicando reseña...',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              )
                              : const Text(
                                'Publicar Reseña',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
