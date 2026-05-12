import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:turbo/app/l10n/l10n.dart';
import 'package:turbo_ui/turbo_ui.dart';

/// Bottom sheet para elegir entre galería o cámara al actualizar la foto de perfil.
class ProfilePhotoSourceSheet extends StatelessWidget {
  const ProfilePhotoSourceSheet({super.key});

  static Future<ImageSource?> show(BuildContext context) {
    return showModalBottomSheet<ImageSource>(
      context: context,
      showDragHandle: true,
      useSafeArea: true,
      builder: (context) => const ProfilePhotoSourceSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: TurboSpacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: TurboSpacing.base,
              vertical: TurboSpacing.sm,
            ),
            child: Text(
              l10n.profileEditPhotoSourceTitle,
              style: theme.textTheme.titleMedium,
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.photo_library_outlined,
              color: theme.colorScheme.primary,
            ),
            title: Text(l10n.profileEditPhotoSourceGallery),
            onTap: () => Navigator.of(context).pop(ImageSource.gallery),
          ),
          ListTile(
            leading: Icon(
              Icons.photo_camera_outlined,
              color: theme.colorScheme.primary,
            ),
            title: Text(l10n.profileEditPhotoSourceCamera),
            onTap: () => Navigator.of(context).pop(ImageSource.camera),
          ),
        ],
      ),
    );
  }
}
