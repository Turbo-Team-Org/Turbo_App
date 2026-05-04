import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../theme_bloc/theme_bloc.dart';
import 'theme_mode_selector.dart';

/// Tile compacto para mostrar en settings/profile
///
/// Muestra el tema actual y abre el selector al hacer tap.
class ThemeSelectorTile extends StatelessWidget {
  const ThemeSelectorTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return ListTile(
          leading: Icon(
            state.modeIcon,
            color: Theme.of(context).colorScheme.primary,
          ),
          title: const Text('Tema'),
          subtitle: Text(state.modeName),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _showThemeSelector(context),
        );
      },
    );
  }

  void _showThemeSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: context.read<ThemeBloc>(),
        child: const ThemeSelectorSheet(),
      ),
    );
  }
}

/// Bottom sheet con el selector de tema
class ThemeSelectorSheet extends StatelessWidget {
  const ThemeSelectorSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: colorScheme.onSurface.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Título
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Seleccionar Tema',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Selector
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ThemeModeSelector(),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
