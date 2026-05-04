import 'package:flutter/material.dart';

/// Sistema de border radius de Turbo
/// 
/// Radios consistentes para un look moderno y cohesivo.
abstract final class TurboRadius {
  // ═══════════════════════════════════════════════════════════════
  // 📐 VALORES BASE
  // ═══════════════════════════════════════════════════════════════
  
  /// 0px - Sin radio (esquinas cuadradas)
  static const double none = 0.0;
  
  /// 4px - Radio mínimo
  static const double xs = 4.0;
  
  /// 8px - Radio pequeño
  static const double sm = 8.0;
  
  /// 12px - Radio medio
  static const double md = 12.0;
  
  /// 16px - Radio base/estándar
  static const double base = 16.0;
  
  /// 20px - Radio grande
  static const double lg = 20.0;
  
  /// 24px - Radio extra grande
  static const double xl = 24.0;
  
  /// 32px - Radio 2x extra grande
  static const double xxl = 32.0;
  
  /// Radio completo (circular)
  static const double full = 9999.0;
  
  // ═══════════════════════════════════════════════════════════════
  // 🔘 BORDER RADIUS PREDEFINIDOS
  // ═══════════════════════════════════════════════════════════════
  
  /// Sin radio
  static const BorderRadius noneRadius = BorderRadius.zero;
  
  /// Radio extra pequeño
  static const BorderRadius xsRadius = BorderRadius.all(Radius.circular(xs));
  
  /// Radio pequeño
  static const BorderRadius smRadius = BorderRadius.all(Radius.circular(sm));
  
  /// Radio medio
  static const BorderRadius mdRadius = BorderRadius.all(Radius.circular(md));
  
  /// Radio base/estándar
  static const BorderRadius baseRadius = BorderRadius.all(Radius.circular(base));
  
  /// Radio grande
  static const BorderRadius lgRadius = BorderRadius.all(Radius.circular(lg));
  
  /// Radio extra grande
  static const BorderRadius xlRadius = BorderRadius.all(Radius.circular(xl));
  
  /// Radio 2x extra grande
  static const BorderRadius xxlRadius = BorderRadius.all(Radius.circular(xxl));
  
  /// Radio circular completo
  static const BorderRadius fullRadius = BorderRadius.all(Radius.circular(full));
  
  // ═══════════════════════════════════════════════════════════════
  // 🎯 RADIOS ESPECÍFICOS POR COMPONENTE
  // ═══════════════════════════════════════════════════════════════
  
  /// Radio para botones
  static const BorderRadius button = BorderRadius.all(Radius.circular(md));
  
  /// Radio para botones pequeños
  static const BorderRadius buttonSm = BorderRadius.all(Radius.circular(sm));
  
  /// Radio para botones pill (redondeados)
  static const BorderRadius buttonPill = BorderRadius.all(Radius.circular(full));
  
  /// Radio para cards
  static const BorderRadius card = BorderRadius.all(Radius.circular(base));
  
  /// Radio para cards grandes
  static const BorderRadius cardLg = BorderRadius.all(Radius.circular(xl));
  
  /// Radio para inputs
  static const BorderRadius input = BorderRadius.all(Radius.circular(md));
  
  /// Radio para chips/badges
  static const BorderRadius chip = BorderRadius.all(Radius.circular(full));
  
  /// Radio para modals/dialogs
  static const BorderRadius modal = BorderRadius.all(Radius.circular(xl));
  
  /// Radio para bottom sheets
  static const BorderRadius bottomSheet = BorderRadius.only(
    topLeft: Radius.circular(xl),
    topRight: Radius.circular(xl),
  );
  
  /// Radio para imágenes
  static const BorderRadius image = BorderRadius.all(Radius.circular(md));
  
  /// Radio para avatares
  static const BorderRadius avatar = BorderRadius.all(Radius.circular(full));
  
  /// Radio para la parte superior de cards con imagen
  static const BorderRadius cardImageTop = BorderRadius.only(
    topLeft: Radius.circular(base),
    topRight: Radius.circular(base),
  );
}
