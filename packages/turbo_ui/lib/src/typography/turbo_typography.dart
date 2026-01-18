import 'package:flutter/material.dart';
import '../colors/turbo_colors.dart';

/// Sistema tipográfico de Turbo
/// 
/// Usa MuseoSans como fuente principal con fallback a system fonts.
/// Escalas basadas en Material Design 3 con ajustes premium.
abstract final class TurboTypography {
  // ═══════════════════════════════════════════════════════════════
  // 📝 CONFIGURACIÓN DE FUENTES
  // ═══════════════════════════════════════════════════════════════
  
  /// Fuente principal de la marca
  static const String fontFamily = 'MuseoSans';
  
  /// Fuente para display/títulos grandes (si se quiere diferente)
  static const String displayFontFamily = 'MuseoSans';
  
  /// Altura de línea base
  static const double baseLineHeight = 1.4;
  
  /// Espaciado de letras base
  static const double baseLetterSpacing = 0.0;
  
  // ═══════════════════════════════════════════════════════════════
  // 📐 ESCALAS DE TAMAÑO
  // ═══════════════════════════════════════════════════════════════
  
  // Display - Para headers grandes y hero sections
  static const double displayLarge = 57.0;
  static const double displayMedium = 45.0;
  static const double displaySmall = 36.0;
  
  // Headline - Para títulos de sección
  static const double headlineLarge = 32.0;
  static const double headlineMedium = 28.0;
  static const double headlineSmall = 24.0;
  
  // Title - Para títulos de componentes
  static const double titleLarge = 22.0;
  static const double titleMedium = 18.0;
  static const double titleSmall = 16.0;
  
  // Body - Para texto de contenido
  static const double bodyLarge = 16.0;
  static const double bodyMedium = 14.0;
  static const double bodySmall = 12.0;
  
  // Label - Para botones, badges, etc.
  static const double labelLarge = 14.0;
  static const double labelMedium = 12.0;
  static const double labelSmall = 11.0;
  
  // ═══════════════════════════════════════════════════════════════
  // 🎨 TEXT THEME - LIGHT
  // ═══════════════════════════════════════════════════════════════
  
  static TextTheme get lightTextTheme => TextTheme(
    // Display
    displayLarge: TextStyle(
      fontFamily: displayFontFamily,
      fontSize: TurboTypography.displayLarge,
      fontWeight: FontWeight.w700,
      letterSpacing: -1.5,
      height: 1.12,
      color: TurboColors.neutral900,
    ),
    displayMedium: TextStyle(
      fontFamily: displayFontFamily,
      fontSize: TurboTypography.displayMedium,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.5,
      height: 1.16,
      color: TurboColors.neutral900,
    ),
    displaySmall: TextStyle(
      fontFamily: displayFontFamily,
      fontSize: TurboTypography.displaySmall,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.0,
      height: 1.22,
      color: TurboColors.neutral900,
    ),
    
    // Headline
    headlineLarge: TextStyle(
      fontFamily: fontFamily,
      fontSize: TurboTypography.headlineLarge,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.25,
      height: 1.25,
      color: TurboColors.neutral900,
    ),
    headlineMedium: TextStyle(
      fontFamily: fontFamily,
      fontSize: TurboTypography.headlineMedium,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.0,
      height: 1.29,
      color: TurboColors.neutral900,
    ),
    headlineSmall: TextStyle(
      fontFamily: fontFamily,
      fontSize: TurboTypography.headlineSmall,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.0,
      height: 1.33,
      color: TurboColors.neutral900,
    ),
    
    // Title
    titleLarge: TextStyle(
      fontFamily: fontFamily,
      fontSize: TurboTypography.titleLarge,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.0,
      height: 1.27,
      color: TurboColors.neutral900,
    ),
    titleMedium: TextStyle(
      fontFamily: fontFamily,
      fontSize: TurboTypography.titleMedium,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.15,
      height: 1.33,
      color: TurboColors.neutral900,
    ),
    titleSmall: TextStyle(
      fontFamily: fontFamily,
      fontSize: TurboTypography.titleSmall,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      height: 1.38,
      color: TurboColors.neutral900,
    ),
    
    // Body
    bodyLarge: TextStyle(
      fontFamily: fontFamily,
      fontSize: TurboTypography.bodyLarge,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
      height: 1.5,
      color: TurboColors.neutral700,
    ),
    bodyMedium: TextStyle(
      fontFamily: fontFamily,
      fontSize: TurboTypography.bodyMedium,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      height: 1.43,
      color: TurboColors.neutral700,
    ),
    bodySmall: TextStyle(
      fontFamily: fontFamily,
      fontSize: TurboTypography.bodySmall,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      height: 1.33,
      color: TurboColors.neutral600,
    ),
    
    // Label
    labelLarge: TextStyle(
      fontFamily: fontFamily,
      fontSize: TurboTypography.labelLarge,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.1,
      height: 1.43,
      color: TurboColors.neutral900,
    ),
    labelMedium: TextStyle(
      fontFamily: fontFamily,
      fontSize: TurboTypography.labelMedium,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      height: 1.33,
      color: TurboColors.neutral700,
    ),
    labelSmall: TextStyle(
      fontFamily: fontFamily,
      fontSize: TurboTypography.labelSmall,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      height: 1.45,
      color: TurboColors.neutral600,
    ),
  );
  
  // ═══════════════════════════════════════════════════════════════
  // 🌙 TEXT THEME - DARK
  // ═══════════════════════════════════════════════════════════════
  
  static TextTheme get darkTextTheme => TextTheme(
    // Display
    displayLarge: TextStyle(
      fontFamily: displayFontFamily,
      fontSize: TurboTypography.displayLarge,
      fontWeight: FontWeight.w700,
      letterSpacing: -1.5,
      height: 1.12,
      color: TurboColors.white,
    ),
    displayMedium: TextStyle(
      fontFamily: displayFontFamily,
      fontSize: TurboTypography.displayMedium,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.5,
      height: 1.16,
      color: TurboColors.white,
    ),
    displaySmall: TextStyle(
      fontFamily: displayFontFamily,
      fontSize: TurboTypography.displaySmall,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.0,
      height: 1.22,
      color: TurboColors.white,
    ),
    
    // Headline
    headlineLarge: TextStyle(
      fontFamily: fontFamily,
      fontSize: TurboTypography.headlineLarge,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.25,
      height: 1.25,
      color: TurboColors.white,
    ),
    headlineMedium: TextStyle(
      fontFamily: fontFamily,
      fontSize: TurboTypography.headlineMedium,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.0,
      height: 1.29,
      color: TurboColors.white,
    ),
    headlineSmall: TextStyle(
      fontFamily: fontFamily,
      fontSize: TurboTypography.headlineSmall,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.0,
      height: 1.33,
      color: TurboColors.white,
    ),
    
    // Title
    titleLarge: TextStyle(
      fontFamily: fontFamily,
      fontSize: TurboTypography.titleLarge,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.0,
      height: 1.27,
      color: TurboColors.white,
    ),
    titleMedium: TextStyle(
      fontFamily: fontFamily,
      fontSize: TurboTypography.titleMedium,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.15,
      height: 1.33,
      color: TurboColors.white,
    ),
    titleSmall: TextStyle(
      fontFamily: fontFamily,
      fontSize: TurboTypography.titleSmall,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      height: 1.38,
      color: TurboColors.white,
    ),
    
    // Body
    bodyLarge: TextStyle(
      fontFamily: fontFamily,
      fontSize: TurboTypography.bodyLarge,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
      height: 1.5,
      color: TurboColors.neutral200,
    ),
    bodyMedium: TextStyle(
      fontFamily: fontFamily,
      fontSize: TurboTypography.bodyMedium,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      height: 1.43,
      color: TurboColors.neutral200,
    ),
    bodySmall: TextStyle(
      fontFamily: fontFamily,
      fontSize: TurboTypography.bodySmall,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      height: 1.33,
      color: TurboColors.neutral300,
    ),
    
    // Label
    labelLarge: TextStyle(
      fontFamily: fontFamily,
      fontSize: TurboTypography.labelLarge,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.1,
      height: 1.43,
      color: TurboColors.white,
    ),
    labelMedium: TextStyle(
      fontFamily: fontFamily,
      fontSize: TurboTypography.labelMedium,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      height: 1.33,
      color: TurboColors.neutral200,
    ),
    labelSmall: TextStyle(
      fontFamily: fontFamily,
      fontSize: TurboTypography.labelSmall,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      height: 1.45,
      color: TurboColors.neutral300,
    ),
  );
}
