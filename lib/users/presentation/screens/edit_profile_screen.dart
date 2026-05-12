import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turbo_ui/turbo_ui.dart';
import 'package:turbo/app/l10n/l10n.dart';
import 'package:turbo/authentication/state_management/auth_cubit/cubit/auth_cubit_cubit.dart';
import 'package:turbo/app/image_management/presentation/cubit/image_management_cubit.dart';
import 'package:turbo/app/image_management/presentation/cubit/image_management_state.dart'
    as img;
import 'package:turbo/users/domain/user_profile.dart';
import 'package:turbo/users/module/update_user_profile_use_case.dart';
import 'package:turbo/users/presentation/widgets/profile_photo_source_sheet.dart';
import 'package:turbo/users/presentation/widgets/user_profile_avatar.dart';
import 'package:turbo/users/state_management/profile_cubit/profile_cubit.dart';

@RoutePage()
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  var _shouldPopOnSuccess = false;
  var _hasSyncedInitialNameFromState = false;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<ProfileCubit>().state;
    final profile = switch (cubit) {
      ProfileLoaded(:final profile) => profile,
      ProfileUpdateSuccess(:final profile) => profile,
      _ => null,
    };
    final auth = context.read<AuthCubit>().state;
    final authUser = switch (auth) {
      Authenticated(:final user) => user,
      _ => null,
    };
    final initialName =
        profile?.displayName ?? authUser?.displayName ?? '';
    _nameController = TextEditingController(text: initialName);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _onAvatarTap() async {
    final source = await ProfilePhotoSourceSheet.show(context);
    if (!context.mounted || source == null) {
      return;
    }
    await context.read<ImageManagementCubit>().pickAndCompressImage(source);
  }

  Future<void> _save() async {
    final valid = _formKey.currentState?.validate() ?? false;
    if (!valid) {
      return;
    }
    _shouldPopOnSuccess = true;
    await context.read<ProfileCubit>().updateProfile(
          UpdateUserProfileParams(displayName: _nameController.text.trim()),
        );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);

    return MultiBlocListener(
      listeners: [
        BlocListener<ImageManagementCubit, img.ImageManagementState>(
          listener: (context, state) {
            switch (state) {
              case img.Compressed(:final result):
                context.read<ImageManagementCubit>().uploadImage(
                      result.compressedFile,
                    );
              case img.Uploaded(:final url):
                context.read<ProfileCubit>().updateProfile(
                      UpdateUserProfileParams(photoUrl: url),
                    );
              default:
                break;
            }
          },
        ),
        BlocListener<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state case ProfileLoaded(:final profile) ||
                ProfileUpdateSuccess(:final profile)) {
              final currentText = _nameController.text.trim();
              final profileName = profile.displayName?.trim() ?? '';
              // Sync once when profile arrives asynchronously to avoid an empty
              // initial input while respecting user edits already made.
              if (!_hasSyncedInitialNameFromState &&
                  currentText.isEmpty &&
                  profileName.isNotEmpty) {
                _nameController.value = _nameController.value.copyWith(
                  text: profileName,
                  selection: TextSelection.collapsed(
                    offset: profileName.length,
                  ),
                );
                _hasSyncedInitialNameFromState = true;
              }
            }
            switch (state) {
              case ProfileUpdateSuccess():
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.profileUpdateSuccess)),
                );
                if (_shouldPopOnSuccess) {
                  _shouldPopOnSuccess = false;
                  context.router.maybePop();
                }
              case ProfileError(:final message):
                if (!context.mounted) return;
                _shouldPopOnSuccess = false;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(message)),
                );
              default:
                break;
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.profileEditTitle),
        ),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, profileState) {
            final profile = switch (profileState) {
              ProfileLoaded(:final profile) => profile,
              ProfileUpdateSuccess(:final profile) => profile,
              _ => null,
            };
            final authState = context.watch<AuthCubit>().state;
            final user = switch (authState) {
              Authenticated(:final user) => user,
              _ => null,
            };
            final displayProfile =
                profile ?? (user != null ? UserProfile.fromAuthUser(user) : null);
            if (displayProfile == null) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }

            final updating = profileState is ProfileUpdating;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(TurboSpacing.base),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: GestureDetector(
                        onTap: updating ? null : _onAvatarTap,
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            UserProfileAvatar(profile: displayProfile),
                            if (!updating)
                              CircleAvatar(
                                radius: 16,
                                backgroundColor: theme.colorScheme.primary,
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 18,
                                  color: theme.colorScheme.onPrimary,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: TurboSpacing.lg),
                    Text(
                      l10n.profileEditNameLabel,
                      style: theme.textTheme.titleSmall,
                    ),
                    const SizedBox(height: TurboSpacing.sm),
                    TextFormField(
                      controller: _nameController,
                      enabled: !updating,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: TurboRadius.smRadius,
                        ),
                      ),
                      validator: (value) {
                        final v = value?.trim() ?? '';
                        if (v.length < 2) {
                          return l10n.profileNameMinLength;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: TurboSpacing.xl),
                    FilledButton(
                      onPressed: updating ? null : _save,
                      child: updating
                          ? const SizedBox(
                              height: 22,
                              width: 22,
                              child: CircularProgressIndicator.adaptive(
                                strokeWidth: 2,
                              ),
                            )
                          : Text(l10n.profileEditSave),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
