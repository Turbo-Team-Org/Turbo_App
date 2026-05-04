import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../colors/turbo_colors.dart';
import '../typography/turbo_typography.dart';
import '../constants/turbo_radius.dart';

/// Tema oscuro de Turbo - Elegante y sofisticado
/// 
/// Un tema oscuro con acentos rojos vibrantes que destacan
/// sobre fondos profundos para una experiencia premium nocturna.
ThemeData createTurboDarkTheme() {
  final colorScheme = ColorScheme.dark(
    // Primarios
    primary: TurboColors.primary,
    primaryContainer: TurboColors.primaryDarker,
    onPrimary: TurboColors.white,
    onPrimaryContainer: TurboColors.primaryLight,
    
    // Secundarios
    secondary: TurboColors.primary,
    secondaryContainer: TurboColors.primaryDarker,
    onSecondary: TurboColors.white,
    onSecondaryContainer: TurboColors.primaryLight,
    
    // Terciarios
    tertiary: TurboColors.coral,
    tertiaryContainer: const Color(0xFF5C1A1A),
    onTertiary: TurboColors.white,
    onTertiaryContainer: TurboColors.coral,
    
    // Superficies
    surface: TurboColors.darkSurface,
    surfaceContainerHighest: TurboColors.darkSurfaceVariant,
    onSurface: TurboColors.white,
    onSurfaceVariant: TurboColors.neutral300,
    
    // Outline
    outline: TurboColors.neutral600,
    outlineVariant: TurboColors.neutral700,
    
    // Error
    error: TurboColors.error,
    errorContainer: const Color(0xFF5C1A1A),
    onError: TurboColors.white,
    onErrorContainer: TurboColors.errorLight,
    
    // Inversas
    inverseSurface: TurboColors.neutral100,
    onInverseSurface: TurboColors.neutral900,
    inversePrimary: TurboColors.primaryDark,
    
    // Shadow y scrim
    shadow: TurboColors.black,
    scrim: TurboColors.black,
  );

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: colorScheme,
    
    // Scaffold
    scaffoldBackgroundColor: TurboColors.darkScaffold,
    
    // Typography
    fontFamily: TurboTypography.fontFamily,
    textTheme: TurboTypography.darkTextTheme,
    
    // AppBar
    appBarTheme: AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 1,
      backgroundColor: TurboColors.darkSurface,
      foregroundColor: TurboColors.white,
      surfaceTintColor: Colors.transparent,
      centerTitle: false,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      titleTextStyle: TurboTypography.darkTextTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w600,
      ),
      iconTheme: const IconThemeData(
        color: TurboColors.white,
        size: 24,
      ),
    ),
    
    // Bottom Navigation
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: TurboColors.darkSurface,
      selectedItemColor: TurboColors.primary,
      unselectedItemColor: TurboColors.neutral400,
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
      backgroundColor: TurboColors.darkSurface,
      indicatorColor: TurboColors.primary.withOpacity(0.2),
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      height: 80,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: TurboColors.primary, size: 24);
        }
        return const IconThemeData(color: TurboColors.neutral400, size: 24);
      }),
    ),
    
    // Cards
    cardTheme: CardThemeData(
      elevation: 0,
      color: TurboColors.darkCard,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: TurboRadius.card,
        side: BorderSide(
          color: TurboColors.neutral700,
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
        disabledBackgroundColor: TurboColors.neutral700,
        disabledForegroundColor: TurboColors.neutral500,
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
        disabledBackgroundColor: TurboColors.neutral700,
        disabledForegroundColor: TurboColors.neutral500,
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
        disabledForegroundColor: TurboColors.neutral500,
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
        disabledForegroundColor: TurboColors.neutral500,
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
      fillColor: TurboColors.darkSurfaceVariant,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: TurboRadius.input,
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: TurboRadius.input,
        borderSide: BorderSide(color: TurboColors.neutral700, width: 1),
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
        color: TurboColors.neutral500,
        fontSize: 16,
      ),
      labelStyle: TextStyle(
        color: TurboColors.neutral400,
        fontSize: 16,
      ),
      floatingLabelStyle: TextStyle(
        color: TurboColors.primary,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      prefixIconColor: TurboColors.neutral400,
      suffixIconColor: TurboColors.neutral400,
    ),
    
    // Chip
    chipTheme: ChipThemeData(
      backgroundColor: TurboColors.darkSurfaceVariant,
      selectedColor: TurboColors.primary.withOpacity(0.2),
      disabledColor: TurboColors.neutral800,
      labelStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: TurboColors.neutral200,
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
      backgroundColor: TurboColors.darkSurface,
      elevation: 8,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: TurboRadius.modal,
      ),
      titleTextStyle: TurboTypography.darkTextTheme.titleLarge,
      contentTextStyle: TurboTypography.darkTextTheme.bodyMedium,
    ),
    
    // Bottom Sheet
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: TurboColors.darkSurface,
      surfaceTintColor: Colors.transparent,
      elevation: 8,
      shape: const RoundedRectangleBorder(
        borderRadius: TurboRadius.bottomSheet,
      ),
      dragHandleColor: TurboColors.neutral600,
      dragHandleSize: const Size(40, 4),
    ),
    
    // Snackbar
    snackBarTheme: SnackBarThemeData(
      backgroundColor: TurboColors.neutral100,
      contentTextStyle: const TextStyle(
        color: TurboColors.neutral900,
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
      color: TurboColors.darkDivider,
      thickness: 1,
      space: 1,
    ),
    
    // Icon
    iconTheme: const IconThemeData(
      color: TurboColors.neutral200,
      size: 24,
    ),
    
    // Tab Bar
    tabBarTheme: TabBarThemeData(
      labelColor: TurboColors.primary,
      unselectedLabelColor: TurboColors.neutral400,
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
        return TurboColors.neutral500;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return TurboColors.primary;
        }
        return TurboColors.neutral700;
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
      side: const BorderSide(color: TurboColors.neutral500, width: 2),
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
        return TurboColors.neutral500;
      }),
    ),
    
    // Progress Indicator
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: TurboColors.primary,
      linearTrackColor: TurboColors.primary.withOpacity(0.2),
      circularTrackColor: TurboColors.primary.withOpacity(0.2),
    ),
    
    // Slider
    sliderTheme: SliderThemeData(
      activeTrackColor: TurboColors.primary,
      inactiveTrackColor: TurboColors.neutral700,
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
      selectedTileColor: TurboColors.primary.withOpacity(0.1),
      iconColor: TurboColors.neutral400,
      textColor: TurboColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: TurboRadius.smRadius,
      ),
    ),
    
    // Tooltip
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: TurboColors.neutral100,
        borderRadius: TurboRadius.smRadius,
      ),
      textStyle: const TextStyle(
        color: TurboColors.neutral900,
        fontSize: 12,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    ),
  );
}
