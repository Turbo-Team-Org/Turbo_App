import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';
import 'package:turbo_ui/turbo_ui.dart';
import 'package:turbo/authentication/state_management/auth_cubit/cubit/auth_cubit_cubit.dart';
import 'package:turbo/theme_selector/theme_bloc/theme_bloc.dart';

/// AppBar del Feed con animaciones y soporte de tema
/// 
/// Muestra el avatar del usuario, nombre de la app y controles de tema/notificaciones.
/// Cambia de apariencia cuando el usuario hace scroll (collapsed state).
class FeedAppBar extends StatelessWidget {
  final bool isCollapsed;
  final VoidCallback? onNotificationsTap;

  const FeedAppBar({
    super.key,
    required this.isCollapsed,
    this.onNotificationsTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SliverAppBar(
      expandedHeight: 70,
      floating: true,
      pinned: true,
      snap: false,
      elevation: isCollapsed ? 2 : 0,
      backgroundColor: isCollapsed ? colorScheme.surface : Colors.transparent,
      surfaceTintColor: Colors.transparent,
      centerTitle: false,
      leading: _buildUserAvatar(context),
      title: isCollapsed ? _buildCollapsedTitle(context) : null,
      actions: [
        _buildNotificationsButton(context),
        _buildThemeToggle(context),
        const SizedBox(width: 8),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: isCollapsed
            ? null
            : Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      colorScheme.primary,
                      colorScheme.primary.withValues(alpha: 0.8),
                    ],
                  ),
                ),
                height: 100,
              ),
      ),
    );
  }

  Widget _buildUserAvatar(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<AuthCubit, AuthCubitState>(
      builder: (context, state) {
        if (state is! Authenticated) return const SizedBox.shrink();

        final photoUrl = state.user.photoUrl ?? '';
        final displayName = state.user.displayName ?? '';
        final initial = displayName.isNotEmpty ? displayName[0].toUpperCase() : 'T';

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              // Navegar al perfil
            },
            child: CircleAvatar(
              backgroundColor: isCollapsed
                  ? colorScheme.primaryContainer
                  : Colors.white.withValues(alpha: 0.2),
              backgroundImage: photoUrl.isNotEmpty ? NetworkImage(photoUrl) : null,
              child: photoUrl.isEmpty
                  ? Text(
                      initial,
                      style: TextStyle(
                        color: isCollapsed
                            ? colorScheme.onPrimaryContainer
                            : Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : null,
            ),
          ),
        );
      },
    );
  }

  Widget _buildCollapsedTitle(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ElasticIn(
      duration: const Duration(milliseconds: 400),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.explore_rounded,
              color: colorScheme.primary,
              size: 20,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            'Turbo',
            style: TextStyle(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.bold,
              fontSize: TurboTypography.titleLarge,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationsButton(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return IconButton(
      icon: Icon(
        Icons.notifications_outlined,
        color: isCollapsed ? colorScheme.onSurfaceVariant : Colors.white,
        size: 24,
      ),
      onPressed: onNotificationsTap ?? () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Notificaciones próximamente'),
            backgroundColor: colorScheme.inverseSurface,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      },
    );
  }

  Widget _buildThemeToggle(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState.isDark ||
            (themeState.isSystem &&
                Theme.of(context).brightness == Brightness.dark);

        return IconButton(
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              return RotationTransition(
                turns: Tween(begin: 0.75, end: 1.0).animate(animation),
                child: FadeTransition(opacity: animation, child: child),
              );
            },
            child: Icon(
              isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
              key: ValueKey(isDarkMode),
              color: isCollapsed ? colorScheme.onSurfaceVariant : Colors.white,
              size: 24,
            ),
          ),
          onPressed: () {
            context.read<ThemeBloc>().add(const ThemeEvent.toggleTheme());
          },
        );
      },
    );
  }
}
