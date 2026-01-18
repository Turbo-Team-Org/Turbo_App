import 'package:flutter/material.dart';
import 'turbo_light_theme.dart';
import 'turbo_dark_theme.dart';

/// Punto de entrada principal para los temas de Turbo
///
/// Uso:
/// ```dart
/// MaterialApp(
///   theme: TurboTheme.light,
///   darkTheme: TurboTheme.dark,
///   themeMode: ThemeMode.system,
/// )
/// ```
abstract final class TurboTheme {
  /// Tema claro de Turbo
  static ThemeData get light => createTurboLightTheme();

  /// Tema oscuro de Turbo
  static ThemeData get dark => createTurboDarkTheme();

  /// Obtiene el tema basado en el brillo
  static ThemeData fromBrightness(Brightness brightness) {
    return brightness == Brightness.light ? light : dark;
  }
}

/// Extensión para acceder fácilmente a colores del tema
extension TurboThemeExtension on BuildContext {
  /// Acceso rápido al tema actual
  ThemeData get theme => Theme.of(this);

  /// Acceso rápido al ColorScheme
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Acceso rápido al TextTheme
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// ¿Está en modo oscuro?
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  /// Color primario del tema
  Color get primaryColor => colorScheme.primary;

  /// Color de superficie del tema
  Color get surfaceColor => colorScheme.surface;

  /// Color de fondo del scaffold
  Color get backgroundColor => theme.scaffoldBackgroundColor;

  /// Color de error del tema
  Color get errorColor => colorScheme.error;

  /// Color de texto primario
  Color get onSurfaceColor => colorScheme.onSurface;
}
