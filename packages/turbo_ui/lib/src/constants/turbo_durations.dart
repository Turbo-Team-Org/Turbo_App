/// Sistema de duraciones para animaciones de Turbo
/// 
/// Tiempos consistentes para transiciones fluidas y profesionales.
abstract final class TurboDurations {
  // ═══════════════════════════════════════════════════════════════
  // ⏱️ DURACIONES BASE
  // ═══════════════════════════════════════════════════════════════
  
  /// Instantáneo - 0ms
  static const Duration instant = Duration.zero;
  
  /// Ultra rápido - 50ms (micro-interacciones)
  static const Duration ultraFast = Duration(milliseconds: 50);
  
  /// Muy rápido - 100ms (feedback inmediato)
  static const Duration veryFast = Duration(milliseconds: 100);
  
  /// Rápido - 150ms (transiciones rápidas)
  static const Duration fast = Duration(milliseconds: 150);
  
  /// Normal - 200ms (transiciones estándar)
  static const Duration normal = Duration(milliseconds: 200);
  
  /// Medio - 300ms (transiciones suaves)
  static const Duration medium = Duration(milliseconds: 300);
  
  /// Lento - 400ms (transiciones elaboradas)
  static const Duration slow = Duration(milliseconds: 400);
  
  /// Muy lento - 500ms (animaciones grandes)
  static const Duration verySlow = Duration(milliseconds: 500);
  
  /// Extra lento - 700ms (animaciones dramáticas)
  static const Duration extraSlow = Duration(milliseconds: 700);
  
  /// Ultra lento - 1000ms (animaciones muy elaboradas)
  static const Duration ultraSlow = Duration(milliseconds: 1000);
  
  // ═══════════════════════════════════════════════════════════════
  // 🎯 DURACIONES POR CASO DE USO
  // ═══════════════════════════════════════════════════════════════
  
  /// Hover states
  static const Duration hover = fast;
  
  /// Press feedback
  static const Duration press = ultraFast;
  
  /// Fade in/out
  static const Duration fade = normal;
  
  /// Scale animaciones
  static const Duration scale = fast;
  
  /// Slide animaciones
  static const Duration slide = medium;
  
  /// Color transitions
  static const Duration color = normal;
  
  /// Modal/Dialog entrada
  static const Duration modalEnter = medium;
  
  /// Modal/Dialog salida
  static const Duration modalExit = fast;
  
  /// Page transitions
  static const Duration pageTransition = medium;
  
  /// Bottom sheet
  static const Duration bottomSheet = medium;
  
  /// Snackbar
  static const Duration snackbar = Duration(seconds: 3);
  
  /// Toast
  static const Duration toast = Duration(seconds: 2);
  
  /// Splash screen
  static const Duration splash = Duration(seconds: 2);
  
  /// Loading shimmer
  static const Duration shimmer = Duration(milliseconds: 1500);
  
  /// Hero animation
  static const Duration hero = Duration(milliseconds: 400);
  
  /// Tab switch
  static const Duration tabSwitch = normal;
  
  /// List item stagger
  static const Duration staggerDelay = Duration(milliseconds: 50);
  
  // ═══════════════════════════════════════════════════════════════
  // 🔄 DELAYS
  // ═══════════════════════════════════════════════════════════════
  
  /// Delay antes de mostrar tooltip
  static const Duration tooltipDelay = Duration(milliseconds: 500);
  
  /// Delay antes de auto-dismiss
  static const Duration autoDismiss = Duration(seconds: 4);
  
  /// Debounce para búsqueda
  static const Duration searchDebounce = Duration(milliseconds: 300);
  
  /// Throttle para scroll
  static const Duration scrollThrottle = Duration(milliseconds: 16);
}
