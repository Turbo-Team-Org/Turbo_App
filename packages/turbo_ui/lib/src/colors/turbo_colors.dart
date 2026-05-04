import 'package:flutter/material.dart';

/// Paleta de colores oficial de Turbo
/// 
/// Basada en el logo de la marca con el rojo vibrante (#FF003D)
/// como color principal.
abstract final class TurboColors {
  // ═══════════════════════════════════════════════════════════════
  // 🔴 COLORES PRIMARIOS - Rojo Turbo
  // ═══════════════════════════════════════════════════════════════
  
  /// Rojo principal de la marca - Color del logo
  static const Color primary = Color(0xFFFF003D);
  
  /// Rojo oscuro para estados hover/pressed
  static const Color primaryDark = Color(0xFFD50033);
  
  /// Rojo más oscuro para énfasis
  static const Color primaryDarker = Color(0xFFAA0029);
  
  /// Rojo claro para fondos y estados sutiles
  static const Color primaryLight = Color(0xFFFF4D73);
  
  /// Rojo muy claro para backgrounds
  static const Color primaryLighter = Color(0xFFFFE5EB);
  
  /// Rojo con opacidad para overlays
  static const Color primaryOverlay = Color(0x1AFF003D); // 10% opacity
  
  // ═══════════════════════════════════════════════════════════════
  // ⚫ COLORES NEUTRALES - Escala de grises premium
  // ═══════════════════════════════════════════════════════════════
  
  /// Negro puro
  static const Color black = Color(0xFF000000);
  
  /// Negro suave para textos principales
  static const Color neutral900 = Color(0xFF0D0D0D);
  
  /// Gris muy oscuro
  static const Color neutral800 = Color(0xFF1A1A1A);
  
  /// Gris oscuro para textos secundarios
  static const Color neutral700 = Color(0xFF2D2D2D);
  
  /// Gris medio oscuro
  static const Color neutral600 = Color(0xFF4A4A4A);
  
  /// Gris medio
  static const Color neutral500 = Color(0xFF6B6B6B);
  
  /// Gris medio claro
  static const Color neutral400 = Color(0xFF8F8F8F);
  
  /// Gris claro para textos deshabilitados
  static const Color neutral300 = Color(0xFFB3B3B3);
  
  /// Gris muy claro para bordes
  static const Color neutral200 = Color(0xFFD9D9D9);
  
  /// Gris super claro para divisores
  static const Color neutral100 = Color(0xFFEBEBEB);
  
  /// Casi blanco para fondos
  static const Color neutral50 = Color(0xFFF5F5F7); // Del logo
  
  /// Blanco puro
  static const Color white = Color(0xFFFFFFFF);
  
  // ═══════════════════════════════════════════════════════════════
  // 🎨 COLORES DE ACENTO - Para variedad visual
  // ═══════════════════════════════════════════════════════════════
  
  /// Coral vibrante - Complemento cálido
  static const Color coral = Color(0xFFFF6B6B);
  
  /// Naranja energético
  static const Color orange = Color(0xFFFF8C42);
  
  /// Dorado premium
  static const Color gold = Color(0xFFFFD700);
  
  /// Ámbar para ratings
  static const Color amber = Color(0xFFFFC107);
  
  /// Turquesa fresco
  static const Color teal = Color(0xFF00D4AA);
  
  /// Azul moderno
  static const Color blue = Color(0xFF007AFF);
  
  /// Púrpura elegante
  static const Color purple = Color(0xFF8E2DE2);
  
  // ═══════════════════════════════════════════════════════════════
  // ✅ COLORES SEMÁNTICOS - Estados y feedback
  // ═══════════════════════════════════════════════════════════════
  
  /// Verde éxito
  static const Color success = Color(0xFF00C853);
  static const Color successLight = Color(0xFFE8F5E9);
  static const Color successDark = Color(0xFF00A844);
  
  /// Amarillo advertencia
  static const Color warning = Color(0xFFFFB300);
  static const Color warningLight = Color(0xFFFFF8E1);
  static const Color warningDark = Color(0xFFFF8F00);
  
  /// Rojo error (diferente al primario)
  static const Color error = Color(0xFFE53935);
  static const Color errorLight = Color(0xFFFFEBEE);
  static const Color errorDark = Color(0xFFC62828);
  
  /// Azul información
  static const Color info = Color(0xFF2196F3);
  static const Color infoLight = Color(0xFFE3F2FD);
  static const Color infoDark = Color(0xFF1976D2);
  
  // ═══════════════════════════════════════════════════════════════
  // 🌗 COLORES PARA TEMAS
  // ═══════════════════════════════════════════════════════════════
  
  // Light Theme
  static const Color lightBackground = Color(0xFFFAFAFA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceVariant = Color(0xFFF5F5F7);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightDivider = Color(0xFFE0E0E0);
  static const Color lightScaffold = Color(0xFFF8F9FA);
  
  // Dark Theme
  static const Color darkBackground = Color(0xFF0A0A0A);
  static const Color darkSurface = Color(0xFF141414);
  static const Color darkSurfaceVariant = Color(0xFF1E1E1E);
  static const Color darkCard = Color(0xFF1A1A1A);
  static const Color darkDivider = Color(0xFF2D2D2D);
  static const Color darkScaffold = Color(0xFF0D0D0D);
  
  // ═══════════════════════════════════════════════════════════════
  // 🌈 GRADIENTES
  // ═══════════════════════════════════════════════════════════════
  
  /// Gradiente principal de la marca
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, primaryDark],
  );
  
  /// Gradiente con coral para variedad
  static const LinearGradient warmGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, coral],
  );
  
  /// Gradiente sunset vibrante
  static const LinearGradient sunsetGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, orange],
  );
  
  /// Gradiente púrpura elegante
  static const LinearGradient purpleGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [purple, Color(0xFF4A00E0)],
  );
  
  /// Gradiente premium oscuro
  static const LinearGradient darkGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [neutral900, black],
  );
  
  /// Gradiente de fondo light
  static const LinearGradient lightBackgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [lightSurfaceVariant, lightBackground],
    stops: [0.0, 0.3],
  );
  
  /// Gradiente de fondo dark
  static const LinearGradient darkBackgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [darkSurfaceVariant, darkBackground],
    stops: [0.0, 0.3],
  );
  
  // ═══════════════════════════════════════════════════════════════
  // 🛠️ UTILIDADES
  // ═══════════════════════════════════════════════════════════════
  
  /// Color primario con opacidad personalizada
  static Color primaryWithOpacity(double opacity) => 
      primary.withOpacity(opacity);
  
  /// Obtiene el color de texto apropiado para un fondo
  static Color textOnColor(Color background) {
    return background.computeLuminance() > 0.5 ? neutral900 : white;
  }
  
  /// MaterialColor para el color primario
  static const MaterialColor primarySwatch = MaterialColor(
    0xFFFF003D,
    <int, Color>{
      50: Color(0xFFFFE5EB),
      100: Color(0xFFFFBFCC),
      200: Color(0xFFFF94AA),
      300: Color(0xFFFF6987),
      400: Color(0xFFFF496C),
      500: Color(0xFFFF003D), // primary
      600: Color(0xFFE60037),
      700: Color(0xFFCC002F),
      800: Color(0xFFB30028),
      900: Color(0xFF8A001E),
    },
  );
}
