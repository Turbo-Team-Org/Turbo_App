// ═══════════════════════════════════════════════════════════════════════════
// 🎨 APP THEMES - Wrapper para TurboTheme
// ═══════════════════════════════════════════════════════════════════════════
//
// @deprecated Usar TurboTheme directamente desde turbo_ui
//
// Ejemplo en MaterialApp:
//   theme: TurboTheme.light,
//   darkTheme: TurboTheme.dark,
//
// ═══════════════════════════════════════════════════════════════════════════

import 'package:flutter/material.dart';
import 'package:turbo_ui/turbo_ui.dart';

/// @deprecated Use [TurboTheme] directamente
class AppThemes {
  /// Color primario de la marca
  static const Color primaryColor = TurboColors.primary;

  /// Color de acento
  static const Color accentColor = TurboColors.purple;

  /// Tema claro - Usa TurboTheme.light
  static ThemeData lightTheme() => TurboTheme.light;

  /// Tema oscuro - Usa TurboTheme.dark
  static ThemeData darkTheme() => TurboTheme.dark;
}
