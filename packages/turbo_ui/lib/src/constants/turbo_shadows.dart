import 'package:flutter/material.dart';
import '../colors/turbo_colors.dart';

/// Sistema de sombras de Turbo
/// 
/// Sombras elegantes para dar profundidad y jerarquía visual.
abstract final class TurboShadows {
  // ═══════════════════════════════════════════════════════════════
  // 🌫️ SOMBRAS LIGHT THEME
  // ═══════════════════════════════════════════════════════════════
  
  /// Sin sombra
  static const List<BoxShadow> none = [];
  
  /// Sombra extra pequeña - para elementos sutiles
  static const List<BoxShadow> xs = [
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 2,
      offset: Offset(0, 1),
    ),
  ];
  
  /// Sombra pequeña - para cards elevadas
  static const List<BoxShadow> sm = [
    BoxShadow(
      color: Color(0x0D000000),
      blurRadius: 4,
      offset: Offset(0, 2),
    ),
  ];
  
  /// Sombra media - para elementos interactivos
  static const List<BoxShadow> md = [
    BoxShadow(
      color: Color(0x0F000000),
      blurRadius: 8,
      offset: Offset(0, 4),
    ),
  ];
  
  /// Sombra grande - para modals y popovers
  static const List<BoxShadow> lg = [
    BoxShadow(
      color: Color(0x14000000),
      blurRadius: 16,
      offset: Offset(0, 8),
    ),
  ];
  
  /// Sombra extra grande - para elementos flotantes
  static const List<BoxShadow> xl = [
    BoxShadow(
      color: Color(0x1A000000),
      blurRadius: 24,
      offset: Offset(0, 12),
    ),
  ];
  
  /// Sombra 2x extra grande - para elementos destacados
  static const List<BoxShadow> xxl = [
    BoxShadow(
      color: Color(0x1F000000),
      blurRadius: 32,
      offset: Offset(0, 16),
    ),
  ];
  
  // ═══════════════════════════════════════════════════════════════
  // 🌙 SOMBRAS DARK THEME
  // ═══════════════════════════════════════════════════════════════
  
  /// Sombra pequeña para dark theme
  static const List<BoxShadow> darkSm = [
    BoxShadow(
      color: Color(0x40000000),
      blurRadius: 4,
      offset: Offset(0, 2),
    ),
  ];
  
  /// Sombra media para dark theme
  static const List<BoxShadow> darkMd = [
    BoxShadow(
      color: Color(0x50000000),
      blurRadius: 8,
      offset: Offset(0, 4),
    ),
  ];
  
  /// Sombra grande para dark theme
  static const List<BoxShadow> darkLg = [
    BoxShadow(
      color: Color(0x60000000),
      blurRadius: 16,
      offset: Offset(0, 8),
    ),
  ];
  
  // ═══════════════════════════════════════════════════════════════
  // 🔴 SOMBRAS CON COLOR (Glow)
  // ═══════════════════════════════════════════════════════════════
  
  /// Glow primario (rojo Turbo) pequeño
  static List<BoxShadow> primaryGlowSm = [
    BoxShadow(
      color: TurboColors.primary.withOpacity(0.2),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ];
  
  /// Glow primario (rojo Turbo) medio
  static List<BoxShadow> primaryGlowMd = [
    BoxShadow(
      color: TurboColors.primary.withOpacity(0.25),
      blurRadius: 16,
      offset: const Offset(0, 4),
    ),
  ];
  
  /// Glow primario (rojo Turbo) grande
  static List<BoxShadow> primaryGlowLg = [
    BoxShadow(
      color: TurboColors.primary.withOpacity(0.3),
      blurRadius: 24,
      offset: const Offset(0, 8),
    ),
  ];
  
  /// Glow de éxito
  static List<BoxShadow> successGlow = [
    BoxShadow(
      color: TurboColors.success.withOpacity(0.25),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ];
  
  /// Glow de error
  static List<BoxShadow> errorGlow = [
    BoxShadow(
      color: TurboColors.error.withOpacity(0.25),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ];
  
  // ═══════════════════════════════════════════════════════════════
  // 🎯 SOMBRAS ESPECÍFICAS POR COMPONENTE
  // ═══════════════════════════════════════════════════════════════
  
  /// Sombra para cards
  static const List<BoxShadow> card = sm;
  
  /// Sombra para cards elevadas (hover)
  static const List<BoxShadow> cardElevated = md;
  
  /// Sombra para botones elevados
  static const List<BoxShadow> button = sm;
  
  /// Sombra para botones elevados (pressed)
  static const List<BoxShadow> buttonPressed = xs;
  
  /// Sombra para FAB
  static const List<BoxShadow> fab = lg;
  
  /// Sombra para bottom navigation
  static const List<BoxShadow> bottomNav = [
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 8,
      offset: Offset(0, -2),
    ),
  ];
  
  /// Sombra para app bar cuando scrolled
  static const List<BoxShadow> appBar = sm;
  
  /// Sombra para modals
  static const List<BoxShadow> modal = xxl;
  
  /// Sombra para tooltips
  static const List<BoxShadow> tooltip = sm;
  
  /// Sombra para inputs focused
  static List<BoxShadow> inputFocused = [
    BoxShadow(
      color: TurboColors.primary.withOpacity(0.15),
      blurRadius: 4,
      spreadRadius: 1,
    ),
  ];
  
  // ═══════════════════════════════════════════════════════════════
  // 🛠️ UTILIDADES
  // ═══════════════════════════════════════════════════════════════
  
  /// Genera una sombra con color personalizado
  static List<BoxShadow> coloredShadow({
    required Color color,
    double opacity = 0.25,
    double blurRadius = 12,
    Offset offset = const Offset(0, 4),
  }) {
    return [
      BoxShadow(
        color: color.withOpacity(opacity),
        blurRadius: blurRadius,
        offset: offset,
      ),
    ];
  }
  
  /// Genera sombra interna (inset)
  static List<BoxShadow> inset({
    Color color = const Color(0x0A000000),
    double blurRadius = 4,
  }) {
    return [
      BoxShadow(
        color: color,
        blurRadius: blurRadius,
        spreadRadius: -1,
        offset: const Offset(0, 1),
      ),
    ];
  }
}
