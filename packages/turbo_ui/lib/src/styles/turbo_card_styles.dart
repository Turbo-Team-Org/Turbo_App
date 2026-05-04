import 'package:flutter/material.dart';
import '../colors/turbo_colors.dart';
import '../constants/turbo_radius.dart';
import '../constants/turbo_shadows.dart';
import '../constants/turbo_spacing.dart';

/// Estilos predefinidos para cards de Turbo
/// 
/// Proporciona decoraciones consistentes para diferentes tipos de cards.
abstract final class TurboCardStyles {
  // ═══════════════════════════════════════════════════════════════
  // 🃏 CARDS BÁSICAS - LIGHT THEME
  // ═══════════════════════════════════════════════════════════════
  
  /// Card básica sin elevación
  static BoxDecoration get flat => BoxDecoration(
    color: TurboColors.lightCard,
    borderRadius: TurboRadius.card,
    border: Border.all(color: TurboColors.neutral200, width: 1),
  );
  
  /// Card con elevación sutil
  static BoxDecoration get elevated => BoxDecoration(
    color: TurboColors.lightCard,
    borderRadius: TurboRadius.card,
    boxShadow: TurboShadows.sm,
  );
  
  /// Card con elevación media
  static BoxDecoration get elevatedMd => BoxDecoration(
    color: TurboColors.lightCard,
    borderRadius: TurboRadius.card,
    boxShadow: TurboShadows.md,
  );
  
  /// Card con elevación alta
  static BoxDecoration get elevatedLg => BoxDecoration(
    color: TurboColors.lightCard,
    borderRadius: TurboRadius.card,
    boxShadow: TurboShadows.lg,
  );
  
  // ═══════════════════════════════════════════════════════════════
  // 🌙 CARDS BÁSICAS - DARK THEME
  // ═══════════════════════════════════════════════════════════════
  
  /// Card básica dark sin elevación
  static BoxDecoration get flatDark => BoxDecoration(
    color: TurboColors.darkCard,
    borderRadius: TurboRadius.card,
    border: Border.all(color: TurboColors.neutral700, width: 1),
  );
  
  /// Card dark con elevación sutil
  static BoxDecoration get elevatedDark => BoxDecoration(
    color: TurboColors.darkCard,
    borderRadius: TurboRadius.card,
    boxShadow: TurboShadows.darkSm,
  );
  
  /// Card dark con elevación media
  static BoxDecoration get elevatedDarkMd => BoxDecoration(
    color: TurboColors.darkCard,
    borderRadius: TurboRadius.card,
    boxShadow: TurboShadows.darkMd,
  );
  
  // ═══════════════════════════════════════════════════════════════
  // ✨ CARDS ESPECIALES
  // ═══════════════════════════════════════════════════════════════
  
  /// Card destacada con borde primario
  static BoxDecoration get featured => BoxDecoration(
    color: TurboColors.lightCard,
    borderRadius: TurboRadius.card,
    border: Border.all(color: TurboColors.primary, width: 2),
    boxShadow: TurboShadows.primaryGlowSm,
  );
  
  /// Card destacada dark
  static BoxDecoration get featuredDark => BoxDecoration(
    color: TurboColors.darkCard,
    borderRadius: TurboRadius.card,
    border: Border.all(color: TurboColors.primary, width: 2),
    boxShadow: TurboShadows.primaryGlowSm,
  );
  
  /// Card con gradiente primario
  static BoxDecoration get gradientPrimary => BoxDecoration(
    gradient: TurboColors.primaryGradient,
    borderRadius: TurboRadius.card,
    boxShadow: TurboShadows.primaryGlowMd,
  );
  
  /// Card con gradiente sunset
  static BoxDecoration get gradientSunset => BoxDecoration(
    gradient: TurboColors.sunsetGradient,
    borderRadius: TurboRadius.card,
    boxShadow: TurboShadows.coloredShadow(
      color: TurboColors.orange,
      opacity: 0.25,
    ),
  );
  
  /// Card con gradiente purple
  static BoxDecoration get gradientPurple => BoxDecoration(
    gradient: TurboColors.purpleGradient,
    borderRadius: TurboRadius.card,
    boxShadow: TurboShadows.coloredShadow(
      color: TurboColors.purple,
      opacity: 0.25,
    ),
  );
  
  // ═══════════════════════════════════════════════════════════════
  // 🔲 CARDS GLASSMORPHISM
  // ═══════════════════════════════════════════════════════════════
  
  /// Card con efecto glass (para overlays)
  static BoxDecoration get glass => BoxDecoration(
    color: TurboColors.white.withOpacity(0.8),
    borderRadius: TurboRadius.card,
    border: Border.all(
      color: TurboColors.white.withOpacity(0.2),
      width: 1,
    ),
  );
  
  /// Card con efecto glass dark
  static BoxDecoration get glassDark => BoxDecoration(
    color: TurboColors.black.withOpacity(0.6),
    borderRadius: TurboRadius.card,
    border: Border.all(
      color: TurboColors.white.withOpacity(0.1),
      width: 1,
    ),
  );
  
  // ═══════════════════════════════════════════════════════════════
  // 📱 CARDS INTERACTIVAS
  // ═══════════════════════════════════════════════════════════════
  
  /// Card interactiva (hover/press states)
  static BoxDecoration interactive({
    bool isPressed = false,
    bool isHovered = false,
    bool isDark = false,
  }) {
    if (isDark) {
      return BoxDecoration(
        color: isPressed
            ? TurboColors.darkSurfaceVariant
            : isHovered
                ? TurboColors.darkSurface
                : TurboColors.darkCard,
        borderRadius: TurboRadius.card,
        border: Border.all(
          color: isHovered ? TurboColors.primary : TurboColors.neutral700,
          width: isHovered ? 1.5 : 1,
        ),
        boxShadow: isHovered ? TurboShadows.darkMd : TurboShadows.darkSm,
      );
    }
    
    return BoxDecoration(
      color: isPressed
          ? TurboColors.neutral50
          : isHovered
              ? TurboColors.lightSurface
              : TurboColors.lightCard,
      borderRadius: TurboRadius.card,
      border: Border.all(
        color: isHovered ? TurboColors.primary : TurboColors.neutral200,
        width: isHovered ? 1.5 : 1,
      ),
      boxShadow: isHovered ? TurboShadows.md : TurboShadows.sm,
    );
  }
  
  // ═══════════════════════════════════════════════════════════════
  // 🏷️ CARDS DE CONTENIDO ESPECÍFICO
  // ═══════════════════════════════════════════════════════════════
  
  /// Card para lugares/negocios
  static BoxDecoration get placeCard => BoxDecoration(
    color: TurboColors.lightCard,
    borderRadius: TurboRadius.card,
    border: Border.all(
      color: TurboColors.primary.withOpacity(0.1),
      width: 1.5,
    ),
    boxShadow: TurboShadows.sm,
  );
  
  /// Card para lugares dark
  static BoxDecoration get placeCardDark => BoxDecoration(
    color: TurboColors.darkCard,
    borderRadius: TurboRadius.card,
    border: Border.all(
      color: TurboColors.primary.withOpacity(0.2),
      width: 1.5,
    ),
    boxShadow: TurboShadows.darkSm,
  );
  
  /// Card para ofertas
  static BoxDecoration get offerCard => BoxDecoration(
    gradient: TurboColors.warmGradient,
    borderRadius: TurboRadius.card,
    boxShadow: TurboShadows.primaryGlowSm,
  );
  
  /// Card para eventos
  static BoxDecoration get eventCard => BoxDecoration(
    gradient: TurboColors.purpleGradient,
    borderRadius: TurboRadius.card,
    boxShadow: TurboShadows.coloredShadow(
      color: TurboColors.purple,
      opacity: 0.3,
    ),
  );
  
  // ═══════════════════════════════════════════════════════════════
  // 📋 PADDING PREDEFINIDOS
  // ═══════════════════════════════════════════════════════════════
  
  /// Padding pequeño para cards
  static const EdgeInsets paddingSm = EdgeInsets.all(TurboSpacing.cardSm);
  
  /// Padding mediano para cards
  static const EdgeInsets paddingMd = EdgeInsets.all(TurboSpacing.cardMd);
  
  /// Padding grande para cards
  static const EdgeInsets paddingLg = EdgeInsets.all(TurboSpacing.cardLg);
}
