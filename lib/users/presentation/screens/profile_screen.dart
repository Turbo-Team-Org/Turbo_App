import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turbo_ui/turbo_ui.dart';
import 'package:turbo/app/l10n/l10n.dart';
import 'package:turbo/app/routes/router/app_router.gr.dart';
import 'package:turbo/authentication/state_management/auth_cubit/cubit/auth_cubit_cubit.dart';
import 'package:turbo/authentication/state_management/sign_out_cubit/cubit/sign_out_cubit.dart';
import 'package:turbo/theme_selector/theme_selector.dart';
import 'package:turbo/users/presentation/widgets/profile_stats_widget.dart';
import 'package:turbo/users/presentation/widgets/user_profile_avatar.dart';
import 'package:turbo/users/state_management/profile_cubit/profile_cubit.dart';

import '../../../app/view/widgets/global_widgets.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<ProfileCubit>().loadProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocListener<SignOutCubit, SignOutState>(
      listener: (context, signoutstate) {
        switch (signoutstate) {
          case Success():
            showDialog(
              context: context,
              builder: (_) => SuccessDialog(
                title: context.l10n.authLogoutSuccess,
                message: context.l10n.authLogoutSuccess,
              ),
            );
            Future.delayed(const Duration(seconds: 2), () {
              if (!context.mounted) return;
              context.replaceRoute(SignInRoute());
            });
            break;
          case Error(:final error):
            showDialog(
              context: context,
              builder: (_) => ErrorDialog(
                title: context.l10n.commonError,
                message: error ?? '',
              ),
            );
            break;
          default:
            break;
        }
      },
      child: BlocBuilder<AuthCubit, AuthCubitState>(
        builder: (context, authState) {
          switch (authState) {
            case Authenticated():
              return BlocConsumer<ProfileCubit, ProfileState>(
                listener: (context, profileState) {
                  if (profileState is ProfileError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(profileState.message)),
                    );
                  }
                },
                builder: (context, profileState) {
                  Widget body;
                  if (profileState is ProfileInitial ||
                      profileState is ProfileLoading ||
                      profileState is ProfileUpdating) {
                    body = const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  } else if (profileState is ProfileError) {
                    body = Center(
                      child: Padding(
                        padding: const EdgeInsets.all(TurboSpacing.base),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(profileState.message),
                            const SizedBox(height: TurboSpacing.md),
                            FilledButton(
                              onPressed: () =>
                                  context.read<ProfileCubit>().loadProfile(),
                              child: Text(context.l10n.commonRetry),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else if (profileState is ProfileLoaded ||
                      profileState is ProfileUpdateSuccess) {
                    final profile = switch (profileState) {
                      ProfileLoaded(:final profile) => profile,
                      ProfileUpdateSuccess(:final profile) => profile,
                      _ => null,
                    };
                    body = profile == null
                        ? const Center(
                            child: CircularProgressIndicator.adaptive(),
                          )
                        : SingleChildScrollView(
                            padding: const EdgeInsets.all(TurboSpacing.base),
                            child: Column(
                              children: [
                                UserProfileAvatar(profile: profile),
                                const SizedBox(height: TurboSpacing.lg),
                                Text(
                                  profile.displayName ??
                                      context.l10n.profileGuest,
                                  style:
                                      theme.textTheme.headlineSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: TurboSpacing.xs),
                                Text(
                                  profile.email,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ),
                                ProfileStatsWidget(
                                  profile: profile,
                                  favoritesLabel:
                                      context.l10n.profileStatsFavorites,
                                  reservationsLabel:
                                      context.l10n.profileStatsReservations,
                                  reviewsLabel:
                                      context.l10n.profileStatsReviews,
                                ),
                                const SizedBox(height: TurboSpacing.xl),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: colorScheme.primary,
                                      foregroundColor: colorScheme.onPrimary,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: TurboSpacing.md,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: TurboRadius.button,
                                      ),
                                    ),
                                    icon: const Icon(Icons.edit),
                                    label: Text(context.l10n.profileEdit),
                                    onPressed: () {
                                      context.router.push(
                                        const EditProfileRoute(),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(height: TurboSpacing.xl),
                                _buildOptionsSection(
                                  context,
                                  theme,
                                  colorScheme,
                                ),
                              ],
                            ),
                          );
                  } else {
                    body = const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }

                  return Scaffold(
                    appBar: AppBar(
                      title: Text(
                        context.l10n.profileTitle,
                        style: theme.textTheme.titleLarge,
                      ),
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      centerTitle: true,
                      actions: [
                        IconButton(
                          icon: Icon(
                            Icons.logout,
                            color: colorScheme.onSurface,
                          ),
                          onPressed: () {
                            context.read<SignOutCubit>().signOut();
                          },
                        ),
                      ],
                    ),
                    body: body,
                  );
                },
              );
            default:
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
          }
        },
      ),
    );
  }

  Widget _buildOptionsSection(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: TurboRadius.card,
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.08),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildOptionTile(
            context: context,
            icon: Icons.calendar_today,
            iconColor: TurboColors.primary,
            title: context.l10n.profileMyReservations,
            subtitle: context.l10n.profileMyReservationsDesc,
            onTap: () => context.router.push(const MyReservationsRoute()),
          ),
          _buildDivider(),
          const ThemeSelectorTile(),
          _buildDivider(),
          _buildOptionTile(
            context: context,
            icon: Icons.rate_review_outlined,
            iconColor: TurboColors.primary,
            title: context.l10n.profileMyReviews,
            subtitle: context.l10n.profileMyReviewsDesc,
            onTap: () => context.router.push(const MyReviewsRoute()),
          ),
          _buildDivider(),
          _buildOptionTile(
            context: context,
            icon: Icons.notifications_outlined,
            iconColor: TurboColors.amber,
            title: context.l10n.profileNotifications,
            subtitle: context.l10n.profileNotificationsDesc,
            onTap: () {},
          ),
          _buildDivider(),
          _buildOptionTile(
            context: context,
            icon: Icons.help_outline,
            iconColor: TurboColors.blue,
            title: context.l10n.profileHelp,
            subtitle: context.l10n.profileHelpDesc,
            onTap: () {},
          ),
          _buildDivider(),
          _buildOptionTile(
            context: context,
            icon: Icons.logout,
            iconColor: TurboColors.error,
            title: context.l10n.profileLogout,
            titleColor: TurboColors.error,
            onTap: () => context.read<SignOutCubit>().signOut(),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionTile({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String title,
    String? subtitle,
    Color? titleColor,
    VoidCallback? onTap,
  }) {
    final theme = Theme.of(context);

    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(TurboSpacing.sm),
        decoration: BoxDecoration(
          color: iconColor.withValues(alpha: 0.1),
          borderRadius: TurboRadius.smRadius,
        ),
        child: Icon(
          icon,
          color: iconColor,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: theme.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w500,
          color: titleColor ?? theme.colorScheme.onSurface,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            )
          : null,
      trailing: subtitle != null
          ? Icon(
              Icons.arrow_forward_ios,
              color: theme.colorScheme.onSurfaceVariant,
              size: 16,
            )
          : null,
      onTap: onTap,
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      indent: TurboSpacing.base,
      endIndent: TurboSpacing.base,
    );
  }
}
