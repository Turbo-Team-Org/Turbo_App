import 'package:flutter/material.dart';
import '../colors/turbo_colors.dart';
import '../constants/turbo_radius.dart';
import '../typography/turbo_typography.dart';

/// Estilos predefinidos para inputs de Turbo
/// 
/// Proporciona InputDecoration consistentes para diferentes tipos de inputs.
abstract final class TurboInputStyles {
  // ═══════════════════════════════════════════════════════════════
  // 📝 INPUT DECORATIONS - LIGHT THEME
  // ═══════════════════════════════════════════════════════════════
  
  /// Input estándar con fondo
  static InputDecoration standard({
    String? labelText,
    String? hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
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
        fontFamily: TurboTypography.fontFamily,
      ),
      labelStyle: TextStyle(
        color: TurboColors.neutral600,
        fontSize: 16,
        fontFamily: TurboTypography.fontFamily,
      ),
      floatingLabelStyle: TextStyle(
        color: TurboColors.primary,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        fontFamily: TurboTypography.fontFamily,
      ),
    );
  }
  
  /// Input con solo borde inferior (underline)
  static InputDecoration underline({
    String? labelText,
    String? hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      filled: false,
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
      border: const UnderlineInputBorder(
        borderSide: BorderSide(color: TurboColors.neutral300),
      ),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: TurboColors.neutral300),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: TurboColors.primary, width: 2),
      ),
      errorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: TurboColors.error),
      ),
      focusedErrorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: TurboColors.error, width: 2),
      ),
      hintStyle: TextStyle(
        color: TurboColors.neutral400,
        fontSize: 16,
        fontFamily: TurboTypography.fontFamily,
      ),
      labelStyle: TextStyle(
        color: TurboColors.neutral600,
        fontSize: 16,
        fontFamily: TurboTypography.fontFamily,
      ),
    );
  }
  
  /// Input de búsqueda
  static InputDecoration search({
    String hintText = 'Buscar...',
    VoidCallback? onClear,
  }) {
    return InputDecoration(
      hintText: hintText,
      filled: true,
      fillColor: TurboColors.lightSurfaceVariant,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      prefixIcon: const Icon(
        Icons.search,
        color: TurboColors.neutral500,
        size: 22,
      ),
      suffixIcon: onClear != null
          ? IconButton(
              icon: const Icon(Icons.close, size: 20),
              onPressed: onClear,
              color: TurboColors.neutral500,
            )
          : null,
      border: OutlineInputBorder(
        borderRadius: TurboRadius.fullRadius,
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: TurboRadius.fullRadius,
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: TurboRadius.fullRadius,
        borderSide: const BorderSide(color: TurboColors.primary, width: 1.5),
      ),
      hintStyle: TextStyle(
        color: TurboColors.neutral400,
        fontSize: 16,
        fontFamily: TurboTypography.fontFamily,
      ),
    );
  }
  
  // ═══════════════════════════════════════════════════════════════
  // 🌙 INPUT DECORATIONS - DARK THEME
  // ═══════════════════════════════════════════════════════════════
  
  /// Input estándar dark
  static InputDecoration standardDark({
    String? labelText,
    String? hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
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
        fontFamily: TurboTypography.fontFamily,
      ),
      labelStyle: TextStyle(
        color: TurboColors.neutral400,
        fontSize: 16,
        fontFamily: TurboTypography.fontFamily,
      ),
      floatingLabelStyle: TextStyle(
        color: TurboColors.primary,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        fontFamily: TurboTypography.fontFamily,
      ),
    );
  }
  
  /// Input de búsqueda dark
  static InputDecoration searchDark({
    String hintText = 'Buscar...',
    VoidCallback? onClear,
  }) {
    return InputDecoration(
      hintText: hintText,
      filled: true,
      fillColor: TurboColors.darkSurfaceVariant,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      prefixIcon: const Icon(
        Icons.search,
        color: TurboColors.neutral400,
        size: 22,
      ),
      suffixIcon: onClear != null
          ? IconButton(
              icon: const Icon(Icons.close, size: 20),
              onPressed: onClear,
              color: TurboColors.neutral400,
            )
          : null,
      border: OutlineInputBorder(
        borderRadius: TurboRadius.fullRadius,
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: TurboRadius.fullRadius,
        borderSide: BorderSide(color: TurboColors.neutral700, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: TurboRadius.fullRadius,
        borderSide: const BorderSide(color: TurboColors.primary, width: 1.5),
      ),
      hintStyle: TextStyle(
        color: TurboColors.neutral500,
        fontSize: 16,
        fontFamily: TurboTypography.fontFamily,
      ),
    );
  }
  
  // ═══════════════════════════════════════════════════════════════
  // 🔒 INPUTS ESPECIALES
  // ═══════════════════════════════════════════════════════════════
  
  /// Input para contraseña
  static InputDecoration password({
    String labelText = 'Contraseña',
    bool isVisible = false,
    VoidCallback? onToggleVisibility,
    bool isDark = false,
  }) {
    final baseDecoration = isDark
        ? standardDark(labelText: labelText)
        : standard(labelText: labelText);
    
    return baseDecoration.copyWith(
      prefixIcon: const Icon(Icons.lock_outline),
      suffixIcon: IconButton(
        icon: Icon(isVisible ? Icons.visibility_off : Icons.visibility),
        onPressed: onToggleVisibility,
        color: isDark ? TurboColors.neutral400 : TurboColors.neutral500,
      ),
    );
  }
  
  /// Input para email
  static InputDecoration email({
    String labelText = 'Correo electrónico',
    String hintText = 'ejemplo@correo.com',
    bool isDark = false,
  }) {
    final baseDecoration = isDark
        ? standardDark(labelText: labelText, hintText: hintText)
        : standard(labelText: labelText, hintText: hintText);
    
    return baseDecoration.copyWith(
      prefixIcon: const Icon(Icons.email_outlined),
    );
  }
  
  /// Input para teléfono
  static InputDecoration phone({
    String labelText = 'Teléfono',
    String hintText = '+53 5555 5555',
    bool isDark = false,
  }) {
    final baseDecoration = isDark
        ? standardDark(labelText: labelText, hintText: hintText)
        : standard(labelText: labelText, hintText: hintText);
    
    return baseDecoration.copyWith(
      prefixIcon: const Icon(Icons.phone_outlined),
    );
  }
  
  // ═══════════════════════════════════════════════════════════════
  // 📝 TEXT AREA (Multiline)
  // ═══════════════════════════════════════════════════════════════
  
  /// Input multilinea
  static InputDecoration textArea({
    String? labelText,
    String? hintText,
    int maxLines = 4,
    bool isDark = false,
  }) {
    return isDark
        ? standardDark(labelText: labelText, hintText: hintText).copyWith(
            contentPadding: const EdgeInsets.all(16),
            alignLabelWithHint: true,
          )
        : standard(labelText: labelText, hintText: hintText).copyWith(
            contentPadding: const EdgeInsets.all(16),
            alignLabelWithHint: true,
          );
  }
}
