import 'package:flutter/material.dart';
import '../colors/turbo_colors.dart';
import '../constants/turbo_radius.dart';
import '../typography/turbo_typography.dart';

/// Estilos predefinidos para botones de Turbo
/// 
/// Proporciona estilos consistentes para diferentes tipos y tamaños de botones.
abstract final class TurboButtonStyles {
  // ═══════════════════════════════════════════════════════════════
  // 📏 TAMAÑOS
  // ═══════════════════════════════════════════════════════════════
  
  /// Altura de botones pequeños
  static const double heightSm = 36.0;
  
  /// Altura de botones medianos
  static const double heightMd = 48.0;
  
  /// Altura de botones grandes
  static const double heightLg = 56.0;
  
  // ═══════════════════════════════════════════════════════════════
  // 🔴 BOTÓN PRIMARIO (Filled)
  // ═══════════════════════════════════════════════════════════════
  
  /// Botón primario pequeño
  static ButtonStyle get primarySm => ElevatedButton.styleFrom(
    backgroundColor: TurboColors.primary,
    foregroundColor: TurboColors.white,
    minimumSize: const Size(64, heightSm),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    shape: RoundedRectangleBorder(borderRadius: TurboRadius.buttonSm),
    elevation: 0,
    textStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      fontFamily: TurboTypography.fontFamily,
    ),
  );
  
  /// Botón primario mediano (default)
  static ButtonStyle get primaryMd => ElevatedButton.styleFrom(
    backgroundColor: TurboColors.primary,
    foregroundColor: TurboColors.white,
    minimumSize: const Size(88, heightMd),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
    shape: RoundedRectangleBorder(borderRadius: TurboRadius.button),
    elevation: 0,
    textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      fontFamily: TurboTypography.fontFamily,
    ),
  );
  
  /// Botón primario grande
  static ButtonStyle get primaryLg => ElevatedButton.styleFrom(
    backgroundColor: TurboColors.primary,
    foregroundColor: TurboColors.white,
    minimumSize: const Size(120, heightLg),
    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
    shape: RoundedRectangleBorder(borderRadius: TurboRadius.button),
    elevation: 0,
    textStyle: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      fontFamily: TurboTypography.fontFamily,
    ),
  );
  
  /// Botón primario con glow (para CTAs importantes)
  static ButtonStyle get primaryGlow => primaryMd.copyWith(
    shadowColor: WidgetStateProperty.all(TurboColors.primary),
    elevation: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.pressed)) return 4;
      if (states.contains(WidgetState.hovered)) return 8;
      return 6;
    }),
  );
  
  // ═══════════════════════════════════════════════════════════════
  // ⚪ BOTÓN SECUNDARIO (Outlined)
  // ═══════════════════════════════════════════════════════════════
  
  /// Botón secundario pequeño
  static ButtonStyle get secondarySm => OutlinedButton.styleFrom(
    foregroundColor: TurboColors.primary,
    minimumSize: const Size(64, heightSm),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    side: const BorderSide(color: TurboColors.primary, width: 1.5),
    shape: RoundedRectangleBorder(borderRadius: TurboRadius.buttonSm),
    textStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      fontFamily: TurboTypography.fontFamily,
    ),
  );
  
  /// Botón secundario mediano
  static ButtonStyle get secondaryMd => OutlinedButton.styleFrom(
    foregroundColor: TurboColors.primary,
    minimumSize: const Size(88, heightMd),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
    side: const BorderSide(color: TurboColors.primary, width: 1.5),
    shape: RoundedRectangleBorder(borderRadius: TurboRadius.button),
    textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      fontFamily: TurboTypography.fontFamily,
    ),
  );
  
  /// Botón secundario grande
  static ButtonStyle get secondaryLg => OutlinedButton.styleFrom(
    foregroundColor: TurboColors.primary,
    minimumSize: const Size(120, heightLg),
    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
    side: const BorderSide(color: TurboColors.primary, width: 1.5),
    shape: RoundedRectangleBorder(borderRadius: TurboRadius.button),
    textStyle: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      fontFamily: TurboTypography.fontFamily,
    ),
  );
  
  // ═══════════════════════════════════════════════════════════════
  // 🔘 BOTÓN GHOST (Text Button)
  // ═══════════════════════════════════════════════════════════════
  
  /// Botón ghost pequeño
  static ButtonStyle get ghostSm => TextButton.styleFrom(
    foregroundColor: TurboColors.primary,
    minimumSize: const Size(48, heightSm),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    shape: RoundedRectangleBorder(borderRadius: TurboRadius.buttonSm),
    textStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      fontFamily: TurboTypography.fontFamily,
    ),
  );
  
  /// Botón ghost mediano
  static ButtonStyle get ghostMd => TextButton.styleFrom(
    foregroundColor: TurboColors.primary,
    minimumSize: const Size(64, heightMd),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    shape: RoundedRectangleBorder(borderRadius: TurboRadius.button),
    textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      fontFamily: TurboTypography.fontFamily,
    ),
  );
  
  // ═══════════════════════════════════════════════════════════════
  // 💊 BOTÓN PILL (Redondeado)
  // ═══════════════════════════════════════════════════════════════
  
  /// Botón pill primario
  static ButtonStyle get pillPrimary => primaryMd.copyWith(
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: TurboRadius.buttonPill),
    ),
  );
  
  /// Botón pill secundario
  static ButtonStyle get pillSecondary => secondaryMd.copyWith(
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: TurboRadius.buttonPill),
    ),
  );
  
  // ═══════════════════════════════════════════════════════════════
  // 🎨 VARIANTES DE COLOR
  // ═══════════════════════════════════════════════════════════════
  
  /// Botón de éxito
  static ButtonStyle get success => ElevatedButton.styleFrom(
    backgroundColor: TurboColors.success,
    foregroundColor: TurboColors.white,
    minimumSize: const Size(88, heightMd),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
    shape: RoundedRectangleBorder(borderRadius: TurboRadius.button),
    elevation: 0,
    textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      fontFamily: TurboTypography.fontFamily,
    ),
  );
  
  /// Botón de error/peligro
  static ButtonStyle get danger => ElevatedButton.styleFrom(
    backgroundColor: TurboColors.error,
    foregroundColor: TurboColors.white,
    minimumSize: const Size(88, heightMd),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
    shape: RoundedRectangleBorder(borderRadius: TurboRadius.button),
    elevation: 0,
    textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      fontFamily: TurboTypography.fontFamily,
    ),
  );
  
  /// Botón neutral/gris
  static ButtonStyle get neutral => ElevatedButton.styleFrom(
    backgroundColor: TurboColors.neutral200,
    foregroundColor: TurboColors.neutral700,
    minimumSize: const Size(88, heightMd),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
    shape: RoundedRectangleBorder(borderRadius: TurboRadius.button),
    elevation: 0,
    textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      fontFamily: TurboTypography.fontFamily,
    ),
  );
  
  /// Botón neutral para dark theme
  static ButtonStyle get neutralDark => ElevatedButton.styleFrom(
    backgroundColor: TurboColors.neutral700,
    foregroundColor: TurboColors.white,
    minimumSize: const Size(88, heightMd),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
    shape: RoundedRectangleBorder(borderRadius: TurboRadius.button),
    elevation: 0,
    textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      fontFamily: TurboTypography.fontFamily,
    ),
  );
  
  // ═══════════════════════════════════════════════════════════════
  // 🔲 ICON BUTTONS
  // ═══════════════════════════════════════════════════════════════
  
  /// Decoración para icon button circular
  static BoxDecoration iconButtonCircle({
    Color? backgroundColor,
    Color? borderColor,
  }) {
    return BoxDecoration(
      color: backgroundColor ?? TurboColors.lightSurfaceVariant,
      shape: BoxShape.circle,
      border: borderColor != null ? Border.all(color: borderColor) : null,
    );
  }
  
  /// Decoración para icon button cuadrado
  static BoxDecoration iconButtonSquare({
    Color? backgroundColor,
    Color? borderColor,
    double radius = 12,
  }) {
    return BoxDecoration(
      color: backgroundColor ?? TurboColors.lightSurfaceVariant,
      borderRadius: BorderRadius.circular(radius),
      border: borderColor != null ? Border.all(color: borderColor) : null,
    );
  }
  
  // ═══════════════════════════════════════════════════════════════
  // 📲 BOTÓN FULL WIDTH
  // ═══════════════════════════════════════════════════════════════
  
  /// Botón primario de ancho completo
  static ButtonStyle get fullWidthPrimary => primaryMd.copyWith(
    minimumSize: WidgetStateProperty.all(const Size(double.infinity, heightMd)),
  );
  
  /// Botón secundario de ancho completo
  static ButtonStyle get fullWidthSecondary => secondaryMd.copyWith(
    minimumSize: WidgetStateProperty.all(const Size(double.infinity, heightMd)),
  );
}
