import 'package:flutter/material.dart';

/// Constantes de estilos de texto para la aplicación
/// Estos valores se pueden usar en toda la aplicación para mantener consistencia

class AppTextStyles {
  // Tamaños de texto base
  static const double fontSizeSm = 14.0;
  static const double fontSizeMd = 18.0;
  static const double fontSizeLg = 24.0;
  static const double fontSizeXl = 32.0;

  // Estilos para títulos
  static TextStyle titleLarge(BuildContext context) => TextStyle(
    fontSize: fontSizeXl,
    fontWeight: FontWeight.bold,
    color: Theme.of(context).colorScheme.onSurface,
    letterSpacing: 0.5,
  );

  static TextStyle titleMedium(BuildContext context) => TextStyle(
    fontSize: fontSizeLg,
    fontWeight: FontWeight.bold,
    color: Theme.of(context).colorScheme.onSurface,
    letterSpacing: 0.25,
  );

  static TextStyle titleSmall(BuildContext context) => TextStyle(
    fontSize: fontSizeMd,
    fontWeight: FontWeight.bold,
    color: Theme.of(context).colorScheme.onSurface,
  );

  // Estilos para cuerpo de texto
  static TextStyle bodyLarge(BuildContext context) => TextStyle(
    fontSize: fontSizeMd,
    color: Theme.of(context).colorScheme.onSurface,
    height: 1.5,
  );

  static TextStyle bodyMedium(BuildContext context) => TextStyle(
    fontSize: fontSizeSm,
    color: Theme.of(context).colorScheme.onSurface,
    height: 1.4,
  );

  static TextStyle bodySmall(BuildContext context) => TextStyle(
    fontSize: 12.0,
    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
    height: 1.3,
  );

  // Estilos especiales
  static TextStyle caption(BuildContext context) => TextStyle(
    fontSize: 12.0,
    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
    letterSpacing: 0.4,
  );

  static TextStyle button(BuildContext context) => TextStyle(
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

/// Constantes de colores para la aplicación
class AppColors {
  // Colores principales
  static const Color primaryRed = Color(0xFFF3213D);
  static const Color primaryDarkRed = Color(0xFFA1051D);
  static const Color secondaryBlue = Color(0xFF1976D2);

  // Colores de fondo
  static const Color backgroundLight = Color(0xFFF5F5F7);
  static const Color backgroundWhite = Colors.white;

  // Gradientes
  static const LinearGradient redGradient = LinearGradient(
    colors: [Color(0xFFF5515F), Color(0xFFA1051D)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient purpleGradient = LinearGradient(
    colors: [Color(0xFF4A00E0), Color(0xFF8E2DE2)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
