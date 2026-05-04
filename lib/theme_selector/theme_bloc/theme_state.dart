import 'package:flutter/material.dart';

/// Estado del tema de la aplicación
///
/// Usa el enum [ThemeMode] de Flutter para mantener compatibilidad
/// con MaterialApp y facilitar la integración.
class ThemeState {
  /// Modo del tema actual (system, light, dark)
  final ThemeMode themeMode;

  const ThemeState({this.themeMode = ThemeMode.system});

  /// ¿Está usando el tema del sistema?
  bool get isSystem => themeMode == ThemeMode.system;

  /// ¿Está usando el tema claro?
  bool get isLight => themeMode == ThemeMode.light;

  /// ¿Está usando el tema oscuro?
  bool get isDark => themeMode == ThemeMode.dark;

  /// Nombre legible del modo actual
  String get modeName {
    switch (themeMode) {
      case ThemeMode.system:
        return 'Sistema';
      case ThemeMode.light:
        return 'Claro';
      case ThemeMode.dark:
        return 'Oscuro';
    }
  }

  /// Icono representativo del modo actual
  IconData get modeIcon {
    switch (themeMode) {
      case ThemeMode.system:
        return Icons.brightness_auto;
      case ThemeMode.light:
        return Icons.light_mode;
      case ThemeMode.dark:
        return Icons.dark_mode;
    }
  }

  /// Crea una copia con los campos modificados
  ThemeState copyWith({ThemeMode? themeMode}) {
    return ThemeState(themeMode: themeMode ?? this.themeMode);
  }

  /// Crea el estado desde un valor JSON (para HydratedBloc)
  factory ThemeState.fromJson(Map<String, dynamic> json) {
    final modeIndex = json['themeMode'] as int? ?? 0;
    return ThemeState(
      themeMode:
          ThemeMode.values[modeIndex.clamp(0, ThemeMode.values.length - 1)],
    );
  }

  /// Convierte el estado a JSON (para HydratedBloc)
  Map<String, dynamic> toJson() {
    return {'themeMode': themeMode.index};
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ThemeState && other.themeMode == themeMode;
  }

  @override
  int get hashCode => themeMode.hashCode;

  @override
  String toString() => 'ThemeState(themeMode: $themeMode)';
}
