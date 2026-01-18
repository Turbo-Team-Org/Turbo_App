import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turbo_ui/turbo_ui.dart';
import 'package:turbo/app/l10n/l10n.dart';
import 'package:turbo/app/routes/router/app_router.gr.dart';
import 'package:turbo/authentication/state_management/auth_cubit/cubit/auth_cubit_cubit.dart';
import 'package:turbo/authentication/state_management/sign_out_cubit/cubit/sign_out_cubit.dart';
import 'package:turbo/places/presentation/widgets/feed_widgets.dart';
import 'package:turbo/mock_data/data_loader_manager.dart';
import 'package:turbo/theme_selector/theme_selector.dart';

import '../../../app/view/widgets/global_widgets.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dataLoaderManager = DataLoaderManager();
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
              context.replaceRoute(SignInRoute());
            });
            break;
          case Error(:final error):
            showDialog(
              context: context,
              builder: (_) => ErrorDialog(title: context.l10n.commonError, message: error!),
            );
            break;
          default:
            break;
        }
      },
      child: BlocBuilder<AuthCubit, AuthCubitState>(
        builder: (context, state) {
          switch (state) {
            case Authenticated(:final user):
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
                    // Menú para gestionar datos de prueba (solo desarrollo)
                    PopupMenuButton<String>(
                      icon: Icon(
                        Icons.data_array,
                        color: colorScheme.primary,
                      ),
                      onSelected: (value) {
                        switch (value) {
                          case 'places':
                            _showLoadPlacesDialog(context, dataLoaderManager);
                            break;
                          case 'categories':
                            _showLoadCategoriesDialog(
                                context, dataLoaderManager);
                            break;
                          case 'additional':
                            dataLoaderManager.showDataLoaderOptions(context);
                            break;
                        }
                      },
                      itemBuilder: (BuildContext context) => [
                        const PopupMenuItem<String>(
                          value: 'places',
                          child: Text('Cargar lugares'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'categories',
                          child: Text('Cargar categorías'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'additional',
                          child: Text('Cargar datos adicionales'),
                        ),
                      ],
                    ),
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
                body: SingleChildScrollView(
                  padding: const EdgeInsets.all(TurboSpacing.base),
                  child: Column(
                    children: [
                      // Avatar del perfil
                      ProfileAvatar(),
                      const SizedBox(height: TurboSpacing.lg),

                      // Nombre del usuario
                      Text(
                        user.displayName ?? context.l10n.profileGuest,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: TurboSpacing.xs),

                      // Email
                      Text(
                        user.email,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: TurboSpacing.xl),

                      // Botón editar perfil
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
                            // TODO: Navegar a pantalla de edición
                          },
                        ),
                      ),
                      const SizedBox(height: TurboSpacing.xl),

                      // Sección de opciones
                      _buildOptionsSection(context, theme, colorScheme),
                    ],
                  ),
                ),
              );

            default:
              return const Center(child: CircularProgressIndicator.adaptive());
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
          // Mis Reservas
          _buildOptionTile(
            context: context,
            icon: Icons.calendar_today,
            iconColor: TurboColors.primary,
            title: context.l10n.profileMyReservations,
            subtitle: context.l10n.profileMyReservationsDesc,
            onTap: () => context.router.push(const MyReservationsRoute()),
          ),

          _buildDivider(),

          // Selector de Tema (usando nuestro nuevo ThemeSelectorTile)
          const ThemeSelectorTile(),

          _buildDivider(),

          // Notificaciones
          _buildOptionTile(
            context: context,
            icon: Icons.notifications_outlined,
            iconColor: TurboColors.amber,
            title: context.l10n.profileNotifications,
            subtitle: context.l10n.profileNotificationsDesc,
            onTap: () {
              // TODO: Navegar a configuración de notificaciones
            },
          ),

          _buildDivider(),

          // Ayuda
          _buildOptionTile(
            context: context,
            icon: Icons.help_outline,
            iconColor: TurboColors.blue,
            title: context.l10n.profileHelp,
            subtitle: context.l10n.profileHelpDesc,
            onTap: () {
              // TODO: Navegar a ayuda
            },
          ),

          _buildDivider(),

          // Cerrar Sesión
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
    return const Divider(height: 1, indent: TurboSpacing.base, endIndent: TurboSpacing.base);
  }

  void _showLoadPlacesDialog(
      BuildContext context, DataLoaderManager dataLoaderManager) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.loadingData),
        content: Text(context.l10n.commonConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(context.l10n.commonCancel),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              dataLoaderManager.loadPlaces();
            },
            child: Text(context.l10n.commonConfirm),
          ),
        ],
      ),
    );
  }

  void _showLoadCategoriesDialog(
      BuildContext context, DataLoaderManager dataLoaderManager) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.loadingData),
        content: Text(context.l10n.commonConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(context.l10n.commonCancel),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              dataLoaderManager.loadCategories();
            },
            child: Text(context.l10n.commonConfirm),
          ),
        ],
      ),
    );
  }
}
