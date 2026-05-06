import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turbo/app/core/theme/theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  static const String _isDarkModeKey = 'is_dark_mode';
  static const String _isAutoThemeKey = 'is_auto_theme';

  Timer? _timer;

  ThemeCubit() : super(const ThemeInitial()) {
    _initTheme();
  }

  Future<void> _initTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool(_isDarkModeKey) ?? false;
    final isAutoTheme = prefs.getBool(_isAutoThemeKey) ?? true;

    emit(ThemeLoaded(isDarkMode: isDarkMode, isAutoTheme: isAutoTheme));

    if (isAutoTheme) {
      _setupAutoThemeTimer();
      _checkAndUpdateTheme();
    }
  }

  void _setupAutoThemeTimer() {
    _timer?.cancel();
    // Comprobar cada minuto si necesitamos cambiar el tema
    _timer = Timer.periodic(const Duration(minutes: 1), (_) {
      _checkAndUpdateTheme();
    });
  }

  void _checkAndUpdateTheme() async {
    final currentState = state;
    if (currentState is! ThemeLoaded || !currentState.isAutoTheme) return;

    final now = TimeOfDay.now();
    final hour = now.hour;

    // Activar modo oscuro después de las 19:00 (7 PM) y antes de las 7:00 AM
    final shouldBeDarkMode = hour >= 19 || hour < 7;

    if (shouldBeDarkMode != currentState.isDarkMode) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_isDarkModeKey, shouldBeDarkMode);

      emit(
        ThemeLoaded(
          isDarkMode: shouldBeDarkMode,
          isAutoTheme: currentState.isAutoTheme,
        ),
      );
    }
  }

  Future<void> toggleDarkMode() async {
    final currentState = state;
    if (currentState is! ThemeLoaded) return;

    final prefs = await SharedPreferences.getInstance();
    final newIsDarkMode = !currentState.isDarkMode;

    await prefs.setBool(_isDarkModeKey, newIsDarkMode);
    // Desactivar modo automático si el usuario cambia manualmente
    if (currentState.isAutoTheme) {
      await prefs.setBool(_isAutoThemeKey, false);
      _timer?.cancel();

      emit(ThemeLoaded(isDarkMode: newIsDarkMode, isAutoTheme: false));
    } else {
      emit(
        ThemeLoaded(
          isDarkMode: newIsDarkMode,
          isAutoTheme: currentState.isAutoTheme,
        ),
      );
    }
  }

  Future<void> setAutoTheme(bool isAutoTheme) async {
    final currentState = state;
    if (currentState is! ThemeLoaded) return;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isAutoThemeKey, isAutoTheme);

    if (isAutoTheme) {
      _setupAutoThemeTimer();
      _checkAndUpdateTheme();
    } else {
      _timer?.cancel();
    }

    emit(
      ThemeLoaded(
        isDarkMode: currentState.isDarkMode,
        isAutoTheme: isAutoTheme,
      ),
    );
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
