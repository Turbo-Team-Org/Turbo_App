// ═══════════════════════════════════════════════════════════════════════════
// 📝 ESTILOS DE TEXTO - Integrado con TurboUI
// ═══════════════════════════════════════════════════════════════════════════
//
// Usar Theme.of(context).textTheme para acceder a los estilos del tema activo.
// TurboTheme ya define todos los estilos de texto necesarios.
//
// Ejemplo:
//   Theme.of(context).textTheme.headlineLarge  // Para títulos grandes
//   Theme.of(context).textTheme.bodyMedium     // Para texto normal
//
// ═══════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:turbo_ui/turbo_ui.dart';

/// Constantes de colores para la aplicación
/// @deprecated Use [TurboColors] directamente desde turbo_ui
class AppColors {
  // Colores principales - Mapeados a TurboColors
  static const Color primaryRed = TurboColors.primary;
  static const Color primaryDarkRed = TurboColors.primaryDark;
  static const Color secondaryBlue = TurboColors.blue;

  // Colores de fondo - Mapeados a TurboColors
  static const Color backgroundLight = TurboColors.lightSurfaceVariant;
  static const Color backgroundWhite = TurboColors.white;

  // Gradientes - Mapeados a TurboColors
  static const LinearGradient redGradient = TurboColors.primaryGradient;
  static const LinearGradient purpleGradient = TurboColors.purpleGradient;
}

/// Estilos de texto helpers
/// @deprecated Use Theme.of(context).textTheme directamente
class AppTextStyles {
  // Tamaños de texto base
  static const double fontSizeSm = 14.0;
  static const double fontSizeMd = 18.0;
  static const double fontSizeLg = 24.0;
  static const double fontSizeXl = 32.0;

  // Estilos para títulos - Usar theme.textTheme en su lugar
  static TextStyle titleLarge(BuildContext context) =>
      Theme.of(context).textTheme.headlineMedium ?? 
      TextStyle(
        fontSize: fontSizeXl,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.onSurface,
        letterSpacing: 0.5,
      );

  static TextStyle titleMedium(BuildContext context) =>
      Theme.of(context).textTheme.titleLarge ??
      TextStyle(
        fontSize: fontSizeLg,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.onSurface,
        letterSpacing: 0.25,
      );

  static TextStyle titleSmall(BuildContext context) =>
      Theme.of(context).textTheme.titleMedium ??
      TextStyle(
        fontSize: fontSizeMd,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.onSurface,
      );

  // Estilos para cuerpo de texto
  static TextStyle bodyLarge(BuildContext context) =>
      Theme.of(context).textTheme.bodyLarge ??
      TextStyle(
        fontSize: fontSizeMd,
        color: Theme.of(context).colorScheme.onSurface,
        height: 1.5,
      );

  static TextStyle bodyMedium(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium ??
      TextStyle(
        fontSize: fontSizeSm,
        color: Theme.of(context).colorScheme.onSurface,
        height: 1.4,
      );

  static TextStyle bodySmall(BuildContext context) =>
      Theme.of(context).textTheme.bodySmall ??
      TextStyle(
        fontSize: 12.0,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
        height: 1.3,
      );

  // Estilos especiales
  static TextStyle caption(BuildContext context) =>
      Theme.of(context).textTheme.labelSmall ??
      TextStyle(
        fontSize: 12.0,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
        letterSpacing: 0.4,
      );

  static TextStyle button(BuildContext context) =>
      Theme.of(context).textTheme.labelLarge ??
      TextStyle(
        fontSize: fontSizeSm,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).colorScheme.onPrimary,
        letterSpacing: 0.5,
      );

  static TextStyle highlighted(BuildContext context) => TextStyle(
        fontSize: fontSizeMd,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).colorScheme.primary,
      );
}
