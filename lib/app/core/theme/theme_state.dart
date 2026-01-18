abstract class ThemeState {
  const ThemeState();
}

class ThemeInitial extends ThemeState {
  const ThemeInitial();
}

class ThemeLoaded extends ThemeState {
  final bool isDarkMode;
  final bool isAutoTheme;

  const ThemeLoaded({required this.isDarkMode, required this.isAutoTheme});

  // Helper method to simulate freezed's maybeWhen
  T maybeWhen<T>({
    T Function(bool isDarkMode, bool isAutoTheme)? loaded,
    required T Function() orElse,
  }) {
    if (loaded != null) {
      return loaded(isDarkMode, isAutoTheme);
    }
    return orElse();
  }
}
