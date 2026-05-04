import 'package:flutter/material.dart';

/// Clase base sellada para eventos del tema
sealed class ThemeEvent {
  const ThemeEvent();

  /// Cambiar a un modo de tema específico
  const factory ThemeEvent.changeTheme(ThemeMode themeMode) = ChangeTheme;

  /// Alternar entre light y dark (ignora system)
  const factory ThemeEvent.toggleTheme() = ToggleTheme;

  /// Establecer tema del sistema
  const factory ThemeEvent.setSystemTheme() = SetSystemTheme;

  /// Establecer tema claro
  const factory ThemeEvent.setLightTheme() = SetLightTheme;

  /// Establecer tema oscuro
  const factory ThemeEvent.setDarkTheme() = SetDarkTheme;
}

final class ChangeTheme extends ThemeEvent {
  final ThemeMode themeMode;
  const ChangeTheme(this.themeMode);
}

final class ToggleTheme extends ThemeEvent {
  const ToggleTheme();
}

final class SetSystemTheme extends ThemeEvent {
  const SetSystemTheme();
}

final class SetLightTheme extends ThemeEvent {
  const SetLightTheme();
}

final class SetDarkTheme extends ThemeEvent {
  const SetDarkTheme();
}
