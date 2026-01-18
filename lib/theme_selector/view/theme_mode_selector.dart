import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../theme_bloc/theme_bloc.dart';

/// Selector visual moderno de tema con tres opciones
///
/// Muestra tarjetas animadas para System, Light y Dark
/// con feedback visual del tema seleccionado.
class ThemeModeSelector extends StatelessWidget {
  const ThemeModeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: _ThemeOptionCard(
                mode: ThemeMode.system,
                icon: Icons.brightness_auto,
                label: 'Sistema',
                isSelected: state.isSystem,
                onTap: () => context.read<ThemeBloc>().add(
                      const ThemeEvent.setSystemTheme(),
                    ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _ThemeOptionCard(
                mode: ThemeMode.light,
                icon: Icons.light_mode,
                label: 'Claro',
                isSelected: state.isLight,
                onTap: () => context.read<ThemeBloc>().add(
                      const ThemeEvent.setLightTheme(),
                    ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _ThemeOptionCard(
                mode: ThemeMode.dark,
                icon: Icons.dark_mode,
                label: 'Oscuro',
                isSelected: state.isDark,
                onTap: () => context.read<ThemeBloc>().add(
                      const ThemeEvent.setDarkTheme(),
                    ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ThemeOptionCard extends StatelessWidget {
  final ThemeMode mode;
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThemeOptionCard({
    required this.mode,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? colorScheme.primaryContainer
              : colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? colorScheme.primary : Colors.transparent,
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: colorScheme.primary.withValues(alpha: 0.2),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Vista previa del tema
            _ThemePreview(
              mode: mode,
              isSelected: isSelected,
            ),
            const SizedBox(height: 12),

            // Icono
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected
                    ? colorScheme.primary
                    : colorScheme.surfaceContainerHighest,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 20,
                color: isSelected
                    ? colorScheme.onPrimary
                    : colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),

            // Label
            Text(
              label,
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color:
                    isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant,
              ),
            ),

            // Indicador de selección
            const SizedBox(height: 8),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: isSelected ? 24 : 0,
              height: 3,
              decoration: BoxDecoration(
                color: colorScheme.primary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Preview miniatura del tema
class _ThemePreview extends StatelessWidget {
  final ThemeMode mode;
  final bool isSelected;

  const _ThemePreview({
    required this.mode,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = mode == ThemeMode.dark;
    final isSystem = mode == ThemeMode.system;

    // Colores para la preview
    final bgColor = isDark ? const Color(0xFF1A1A2E) : Colors.white;
    final headerColor =
        isDark ? const Color(0xFF16213E) : const Color(0xFFF5F5F5);
    final accentColor =
        isDark ? const Color(0xFF0F3460) : const Color(0xFF2196F3);
    final textColor = isDark ? Colors.white70 : Colors.black54;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: isSystem
          ? _buildSystemPreview(context)
          : _buildThemePreview(bgColor, headerColor, accentColor, textColor),
    );
  }

  Widget _buildSystemPreview(BuildContext context) {
    // Preview dividida para mostrar ambos temas
    return Row(
      children: [
        // Mitad clara
        Expanded(
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  height: 12,
                  color: const Color(0xFFF5F5F5),
                ),
                const Spacer(),
                Container(
                  margin: const EdgeInsets.all(4),
                  height: 8,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2196F3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
        // Mitad oscura
        Expanded(
          child: Container(
            color: const Color(0xFF1A1A2E),
            child: Column(
              children: [
                Container(
                  height: 12,
                  color: const Color(0xFF16213E),
                ),
                const Spacer(),
                Container(
                  margin: const EdgeInsets.all(4),
                  height: 8,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F3460),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildThemePreview(
    Color bgColor,
    Color headerColor,
    Color accentColor,
    Color textColor,
  ) {
    return Container(
      color: bgColor,
      child: Column(
        children: [
          // Header
          Container(
            height: 14,
            color: headerColor,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              children: [
                Container(
                  width: 16,
                  height: 6,
                  decoration: BoxDecoration(
                    color: accentColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const Spacer(),
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: textColor.withValues(alpha: 0.5),
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 6,
                    width: 30,
                    decoration: BoxDecoration(
                      color: textColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    height: 4,
                    width: 45,
                    decoration: BoxDecoration(
                      color: textColor.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: 10,
                    decoration: BoxDecoration(
                      color: accentColor,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
