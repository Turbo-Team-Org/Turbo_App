import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../colors/turbo_colors.dart';
import '../typography/turbo_typography.dart';
import '../constants/turbo_radius.dart';

/// Tema claro de Turbo - Premium y moderno
/// 
/// Un tema luminoso con acentos rojos vibrantes y una
/// estética limpia y profesional.
ThemeData createTurboLightTheme() {
  final colorScheme = ColorScheme.light(
    // Primarios
    primary: TurboColors.primary,
    primaryContainer: TurboColors.primaryLighter,
    onPrimary: TurboColors.white,
    onPrimaryContainer: TurboColors.primaryDark,
    
    // Secundarios (usando el mismo para consistencia)
    secondary: TurboColors.primary,
    secondaryContainer: TurboColors.primaryLighter,
    onSecondary: TurboColors.white,
    onSecondaryContainer: TurboColors.primaryDark,
    
    // Terciarios (coral para variedad)
    tertiary: TurboColors.coral,
    tertiaryContainer: const Color(0xFFFFE5E5),
    onTertiary: TurboColors.white,
    onTertiaryContainer: TurboColors.neutral900,
    
    // Superficies
    surface: TurboColors.lightSurface,
    surfaceContainerHighest: TurboColors.lightSurfaceVariant,
    onSurface: TurboColors.neutral900,
    onSurfaceVariant: TurboColors.neutral600,
    
    // Outline
    outline: TurboColors.neutral300,
    outlineVariant: TurboColors.neutral200,
    
    // Error
    error: TurboColors.error,
    errorContainer: TurboColors.errorLight,
    onError: TurboColors.white,
    onErrorContainer: TurboColors.errorDark,
    
    // Inversas
    inverseSurface: TurboColors.neutral900,
    onInverseSurface: TurboColors.white,
    inversePrimary: TurboColors.primaryLight,
    
    // Shadow y scrim
    shadow: TurboColors.black,
    scrim: TurboColors.black,
  );

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: colorScheme,
    
    // Scaffold
    scaffoldBackgroundColor: TurboColors.lightScaffold,
    
    // Typography
    fontFamily: TurboTypography.fontFamily,
    textTheme: TurboTypography.lightTextTheme,
    
    // AppBar
    appBarTheme: AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 1,
      backgroundColor: TurboColors.lightSurface,
      foregroundColor: TurboColors.neutral900,
      surfaceTintColor: Colors.transparent,
      centerTitle: false,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      titleTextStyle: TurboTypography.lightTextTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w600,
      ),
      iconTheme: const IconThemeData(
        color: TurboColors.neutral900,
        size: 24,
      ),
    ),
    
    // Bottom Navigation
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: TurboColors.lightSurface,
      selectedItemColor: TurboColors.primary,
      unselectedItemColor: TurboColors.neutral500,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      selectedLabelStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    ),
    
    // Navigation Bar (Material 3)
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: TurboColors.lightSurface,
      indicatorColor: TurboColors.primaryLighter,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      height: 80,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: TurboColors.primary, size: 24);
        }
        return const IconThemeData(color: TurboColors.neutral500, size: 24);
      }),
    ),
    
    // Cards
    cardTheme: CardThemeData(
      elevation: 0,
      color: TurboColors.lightCard,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: TurboRadius.card,
        side: BorderSide(
          color: TurboColors.neutral200,
          width: 1,
        ),
      ),
      margin: EdgeInsets.zero,
    ),
    
    // Elevated Button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: TurboColors.primary,
        foregroundColor: TurboColors.white,
        disabledBackgroundColor: TurboColors.neutral200,
        disabledForegroundColor: TurboColors.neutral400,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: TurboRadius.button,
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: TurboTypography.fontFamily,
        ),
      ),
    ),
    
    // Filled Button
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: TurboColors.primary,
        foregroundColor: TurboColors.white,
        disabledBackgroundColor: TurboColors.neutral200,
        disabledForegroundColor: TurboColors.neutral400,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: TurboRadius.button,
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: TurboTypography.fontFamily,
        ),
      ),
    ),
    
    // Outlined Button
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: TurboColors.primary,
        disabledForegroundColor: TurboColors.neutral400,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        side: const BorderSide(color: TurboColors.primary, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: TurboRadius.button,
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: TurboTypography.fontFamily,
        ),
      ),
    ),
    
    // Text Button
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: TurboColors.primary,
        disabledForegroundColor: TurboColors.neutral400,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: TurboRadius.button,
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: TurboTypography.fontFamily,
        ),
      ),
    ),
    
    // FAB
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: TurboColors.primary,
      foregroundColor: TurboColors.white,
      elevation: 4,
      highlightElevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: TurboRadius.baseRadius,
      ),
    ),
    
    // Input Decoration
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: TurboColors.lightSurfaceVariant,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: TurboRadius.input,
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: TurboRadius.input,
        borderSide: BorderSide(color: TurboColors.neutral200, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: TurboRadius.input,
        borderSide: const BorderSide(color: TurboColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: TurboRadius.input,
        borderSide: const BorderSide(color: TurboColors.error, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: TurboRadius.input,
        borderSide: const BorderSide(color: TurboColors.error, width: 2),
      ),
      hintStyle: TextStyle(
        color: TurboColors.neutral400,
        fontSize: 16,
      ),
      labelStyle: TextStyle(
        color: TurboColors.neutral600,
        fontSize: 16,
      ),
      floatingLabelStyle: TextStyle(
        color: TurboColors.primary,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      prefixIconColor: TurboColors.neutral500,
      suffixIconColor: TurboColors.neutral500,
    ),
    
    // Chip
    chipTheme: ChipThemeData(
      backgroundColor: TurboColors.lightSurfaceVariant,
      selectedColor: TurboColors.primaryLighter,
      disabledColor: TurboColors.neutral100,
      labelStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: TurboColors.neutral700,
      ),
      secondaryLabelStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: TurboColors.primary,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: TurboRadius.chip,
      ),
    ),
    
    // Dialog
    dialogTheme: DialogThemeData(
      backgroundColor: TurboColors.lightSurface,
      elevation: 8,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: TurboRadius.modal,
      ),
      titleTextStyle: TurboTypography.lightTextTheme.titleLarge,
      contentTextStyle: TurboTypography.lightTextTheme.bodyMedium,
    ),
    
    // Bottom Sheet
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: TurboColors.lightSurface,
      surfaceTintColor: Colors.transparent,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: TurboRadius.bottomSheet,
      ),
      dragHandleColor: TurboColors.neutral300,
      dragHandleSize: Size(40, 4),
    ),
    
    // Snackbar
    snackBarTheme: SnackBarThemeData(
      backgroundColor: TurboColors.neutral900,
      contentTextStyle: const TextStyle(
        color: TurboColors.white,
        fontSize: 14,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: TurboRadius.smRadius,
      ),
      behavior: SnackBarBehavior.floating,
      elevation: 4,
    ),
    
    // Divider
    dividerTheme: const DividerThemeData(
      color: TurboColors.lightDivider,
      thickness: 1,
      space: 1,
    ),
    
    // Icon
    iconTheme: const IconThemeData(
      color: TurboColors.neutral700,
      size: 24,
    ),
    
    // Tab Bar
    tabBarTheme: TabBarThemeData(
      labelColor: TurboColors.primary,
      unselectedLabelColor: TurboColors.neutral500,
      indicatorColor: TurboColors.primary,
      indicatorSize: TabBarIndicatorSize.tab,
      dividerColor: Colors.transparent,
      labelStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        fontFamily: TurboTypography.fontFamily,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontFamily: TurboTypography.fontFamily,
      ),
    ),
    
    // Switch
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return TurboColors.white;
        }
        return TurboColors.neutral400;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return TurboColors.primary;
        }
        return TurboColors.neutral200;
      }),
    ),
    
    // Checkbox
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return TurboColors.primary;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(TurboColors.white),
      side: const BorderSide(color: TurboColors.neutral400, width: 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    ),
    
    // Radio
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return TurboColors.primary;
        }
        return TurboColors.neutral400;
      }),
    ),
    
    // Progress Indicator
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: TurboColors.primary,
      linearTrackColor: TurboColors.primaryLighter,
      circularTrackColor: TurboColors.primaryLighter,
    ),
    
    // Slider
    sliderTheme: SliderThemeData(
      activeTrackColor: TurboColors.primary,
      inactiveTrackColor: TurboColors.neutral200,
      thumbColor: TurboColors.primary,
      overlayColor: TurboColors.primary.withOpacity(0.2),
      valueIndicatorColor: TurboColors.primary,
      valueIndicatorTextStyle: const TextStyle(
        color: TurboColors.white,
        fontWeight: FontWeight.w600,
      ),
    ),
    
    // ListTile
    listTileTheme: ListTileThemeData(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      tileColor: Colors.transparent,
      selectedTileColor: TurboColors.primaryLighter,
      iconColor: TurboColors.neutral600,
      textColor: TurboColors.neutral900,
      shape: RoundedRectangleBorder(
        borderRadius: TurboRadius.smRadius,
      ),
    ),
    
    // Tooltip
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: TurboColors.neutral900,
        borderRadius: TurboRadius.smRadius,
      ),
      textStyle: const TextStyle(
        color: TurboColors.white,
        fontSize: 12,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    ),
  );
}
