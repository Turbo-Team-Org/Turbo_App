/// Sistema de espaciado de Turbo
/// 
/// Escala de 4px base para consistencia en todo el diseño.
abstract final class TurboSpacing {
  // ═══════════════════════════════════════════════════════════════
  // 📏 ESCALA BASE (múltiplos de 4)
  // ═══════════════════════════════════════════════════════════════
  
  /// 0px - Sin espaciado
  static const double none = 0.0;
  
  /// 2px - Espaciado mínimo
  static const double xxs = 2.0;
  
  /// 4px - Espaciado extra pequeño
  static const double xs = 4.0;
  
  /// 8px - Espaciado pequeño
  static const double sm = 8.0;
  
  /// 12px - Espaciado medio-pequeño
  static const double md = 12.0;
  
  /// 16px - Espaciado base/medio
  static const double base = 16.0;
  
  /// 20px - Espaciado medio-grande
  static const double lg = 20.0;
  
  /// 24px - Espaciado grande
  static const double xl = 24.0;
  
  /// 32px - Espaciado extra grande
  static const double xxl = 32.0;
  
  /// 40px - Espaciado 2x extra grande
  static const double xxxl = 40.0;
  
  /// 48px - Espaciado enorme
  static const double huge = 48.0;
  
  /// 64px - Espaciado masivo
  static const double massive = 64.0;
  
  /// 80px - Espaciado gigante
  static const double giant = 80.0;
  
  // ═══════════════════════════════════════════════════════════════
  // 📱 PADDING DE PANTALLA
  // ═══════════════════════════════════════════════════════════════
  
  /// Padding horizontal estándar de pantalla
  static const double screenHorizontal = 16.0;
  
  /// Padding vertical estándar de pantalla
  static const double screenVertical = 24.0;
  
  /// Padding de pantalla para tablets
  static const double screenHorizontalTablet = 32.0;
  
  // ═══════════════════════════════════════════════════════════════
  // 🃏 PADDING DE CARDS
  // ═══════════════════════════════════════════════════════════════
  
  /// Padding interno de cards pequeñas
  static const double cardSm = 12.0;
  
  /// Padding interno de cards medianas
  static const double cardMd = 16.0;
  
  /// Padding interno de cards grandes
  static const double cardLg = 20.0;
  
  // ═══════════════════════════════════════════════════════════════
  // 🔘 PADDING DE BOTONES
  // ═══════════════════════════════════════════════════════════════
  
  /// Padding horizontal de botones pequeños
  static const double buttonHorizontalSm = 12.0;
  
  /// Padding horizontal de botones medianos
  static const double buttonHorizontalMd = 16.0;
  
  /// Padding horizontal de botones grandes
  static const double buttonHorizontalLg = 24.0;
  
  /// Padding vertical de botones pequeños
  static const double buttonVerticalSm = 8.0;
  
  /// Padding vertical de botones medianos
  static const double buttonVerticalMd = 12.0;
  
  /// Padding vertical de botones grandes
  static const double buttonVerticalLg = 16.0;
  
  // ═══════════════════════════════════════════════════════════════
  // 📋 GAPS ENTRE ELEMENTOS
  // ═══════════════════════════════════════════════════════════════
  
  /// Gap entre items de lista
  static const double listItemGap = 12.0;
  
  /// Gap entre cards en grid
  static const double gridGap = 16.0;
  
  /// Gap entre secciones
  static const double sectionGap = 32.0;
  
  /// Gap entre iconos y texto
  static const double iconTextGap = 8.0;
}
