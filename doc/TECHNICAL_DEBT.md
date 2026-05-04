# 🔧 Deuda Técnica - Turbo App

> **Última actualización:** Enero 2025

---

## 🔴 Deuda Crítica (Resolver antes de MVP)

### 1. Exceso de Print Statements

**Ubicación:** Todo el proyecto  
**Impacto:** Rendimiento, seguridad, logs ilegibles  
**Esfuerzo:** 2-4 horas

**Problema:**
```dart
// Ejemplo de feed_screen.dart
print("🔍 [DEBUG] Iniciando initState()");
print("🔍 [DEBUG] super.initState() completado");
print("🔍 [DEBUG] Inicializando TabController...");
// ... cientos más
```

**Solución propuesta:**
```dart
// lib/app/utils/logger.dart
import 'package:flutter/foundation.dart';

class AppLogger {
  static const String _tag = 'Turbo';
  
  static void d(String message, [String? tag]) {
    if (kDebugMode) {
      debugPrint('[$_tag${tag != null ? ':$tag' : ''}] $message');
    }
  }
  
  static void e(String message, [Object? error, StackTrace? stack]) {
    if (kDebugMode) {
      debugPrint('[ERROR] $message');
      if (error != null) debugPrint('Error: $error');
      if (stack != null) debugPrint('Stack: $stack');
    }
    // TODO: Enviar a Crashlytics en producción
  }
  
  static void w(String message) {
    if (kDebugMode) {
      debugPrint('[WARN] $message');
    }
  }
}

// Uso:
AppLogger.d('Iniciando feed', 'FeedScreen');
```

**Archivos afectados principales:**
- `lib/places/presentation/screens/feed_screen.dart`
- `lib/places/presentation/screens/business_detail.dart`
- `lib/authentication/presentation/screens/*.dart`
- `lib/location/state_management/*.dart`

---

### 2. Archivos Demasiado Grandes

**Impacto:** Mantenibilidad, testabilidad  
**Esfuerzo:** 8-12 horas

| Archivo | Líneas | Recomendación |
|---------|--------|---------------|
| `feed_screen.dart` | 1662 | Dividir en 5-6 widgets |
| `business_detail.dart` | 524 | Extraer BottomActionBar |

**Refactorización sugerida para feed_screen.dart:**
```
lib/places/presentation/
├── screens/
│   └── feed_screen.dart (~300 líneas)
└── widgets/
    └── feed/
        ├── feed_app_bar.dart
        ├── feed_welcome_section.dart
        ├── feed_category_tabs.dart
        ├── feed_promo_section.dart
        ├── feed_places_grid.dart
        └── feed_place_card.dart
```

---

### 3. Manejo de Estado Inconsistente

**Impacto:** UX, bugs  
**Esfuerzo:** 4-6 horas

**Problema:**
- Algunos cubits no manejan todos los estados
- Estados de carga no consistentes
- Errores no se propagan correctamente

**Ejemplo problemático:**
```dart
// Algunos estados no tienen loading indicator
case CategoryInitial():
  context.read<CategoryCubit>().loadCategories();
  return SizedBox(height: 48, ...); // No hay indicador de carga
```

**Solución:**
```dart
// Crear estados base consistentes
abstract class BaseState {}
class InitialState extends BaseState {}
class LoadingState extends BaseState {}
class LoadedState<T> extends BaseState { final T data; }
class ErrorState extends BaseState { final String message; }
```

---

### 4. Dependencias No Optimizadas

**Impacto:** Tamaño del app, tiempo de build  
**Esfuerzo:** 2-3 horas

**Dependencias a revisar:**
```yaml
# Posiblemente no usadas o redundantes
google_generative_ai: ^0.4.6  # ¿Se usa?
sembast: ^3.8.2               # ¿Se usa además de Firestore?
speech_to_text: ^6.6.0        # ¿Implementado?
crypto: ^3.0.3                # ¿Necesario?
```

**Acción:** 
1. Verificar uso real de cada dependencia
2. Remover las no usadas
3. Actualizar las desactualizadas

---

## 🟠 Deuda Importante (Resolver post-MVP)

### 5. Falta de Tests

**Impacto:** Estabilidad, confianza en deploys  
**Esfuerzo:** 20-40 horas (ongoing)

**Estado actual:**
- Tests unitarios: ~10% cobertura
- Tests de widgets: ~5% cobertura
- Tests de integración: 0%

**Plan de tests:**
```
test/
├── unit/
│   ├── cubits/
│   │   ├── auth_cubit_test.dart
│   │   ├── place_cubit_test.dart
│   │   └── booking_cubit_test.dart
│   └── repositories/
│       └── (cubiertos en Core)
├── widget/
│   ├── screens/
│   │   ├── feed_screen_test.dart
│   │   └── business_detail_test.dart
│   └── widgets/
│       └── place_card_test.dart
└── integration/
    ├── auth_flow_test.dart
    └── booking_flow_test.dart
```

---

### 6. Hardcoded Strings

**Impacto:** Mantenibilidad, i18n  
**Esfuerzo:** 8-12 horas

**Problema:**
```dart
// Strings hardcodeados en toda la app
Text('¡Hola, ${displayName.split(' ').first}!')
Text('Descubre los mejores lugares en Cuba')
Text('No hay horarios disponibles')
```

**Solución:**
```dart
// lib/l10n/app_strings.dart
class AppStrings {
  static String greeting(String name) => '¡Hola, $name!';
  static const String discoverPlaces = 'Descubre los mejores lugares en Cuba';
  static const String noSlotsAvailable = 'No hay horarios disponibles';
  // ...
}

// O usar flutter_localizations para i18n completo
```

---

### 7. Imágenes No Optimizadas

**Impacto:** Rendimiento, uso de datos  
**Esfuerzo:** 4-6 horas

**Problemas:**
- No hay placeholder mientras cargan
- No hay manejo de errores consistente
- Cache no optimizado

**Mejoras:**
```dart
// Usar cached_network_image consistentemente
CachedNetworkImage(
  imageUrl: url,
  placeholder: (context, url) => Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Container(color: Colors.white),
  ),
  errorWidget: (context, url, error) => PlaceholderImage(),
  memCacheWidth: 400, // Optimizar memoria
)
```

---

### 8. Navegación Compleja

**Impacto:** Mantenibilidad  
**Esfuerzo:** 4-6 horas

**Problema:**
- Mezcla de `context.router.push()` y `Navigator.of(context).push()`
- PageRouteBuilder custom no necesario

**Solución:**
- Usar solo auto_route para navegación
- Crear transiciones custom en el router

---

## 🟡 Deuda Menor (Backlog)

### 9. Comentarios TODO Pendientes

```bash
# Buscar TODOs
grep -r "TODO" lib/ --include="*.dart"
```

### 10. Código Duplicado

**Ubicaciones:**
- Estilos de botones repetidos
- Lógica de favoritos en múltiples lugares
- Manejo de imágenes duplicado

### 11. Nombres de Variables Inconsistentes

```dart
// Mezcla de español e inglés
final prefs = AppPreferences();
final _userName = "explorador";
bool _showAppBarBackground = false;
```

**Recomendación:** Usar inglés consistentemente

### 12. Magic Numbers

```dart
// Números mágicos sin contexto
_scrollController.offset > 180  // ¿Por qué 180?
Duration(milliseconds: 1500)    // ¿Por qué 1500?
place.rating >= 4               // ¿Por qué 4?
```

**Solución:**
```dart
class AppConstants {
  static const double headerCollapseThreshold = 180.0;
  static const Duration welcomeDialogDelay = Duration(milliseconds: 1500);
  static const double minimumHighRating = 4.0;
}
```

---

## 📊 Métricas de Calidad Actual

| Métrica | Valor | Objetivo |
|---------|-------|----------|
| Líneas de código | ~15,000 | - |
| Archivos Dart | ~200 | - |
| Cobertura de tests | ~10% | 60%+ |
| Complejidad promedio | Media | Baja |
| Dependencias | 45+ | <40 |
| Warnings de lint | ~50 | 0 |

---

## 🔄 Plan de Reducción de Deuda

### Corto Plazo (MVP)
1. ✅ Eliminar print statements
2. ✅ Refactorizar feed_screen.dart
3. ✅ Revisar dependencias

### Mediano Plazo (Post-MVP)
1. Implementar sistema de logging
2. Añadir tests críticos
3. Extraer strings a constantes

### Largo Plazo (v1.1+)
1. Internacionalización completa
2. 60%+ cobertura de tests
3. Refactorización completa de estilos

---

## 📝 Notas para Desarrolladores

### Al Agregar Nuevo Código

1. **No usar print()** - Usar AppLogger
2. **Extraer widgets** si > 100 líneas
3. **Escribir al menos 1 test** por feature
4. **Usar constantes** para valores mágicos
5. **Documentar** funciones públicas

### Antes de Cada PR

```bash
# Ejecutar análisis
flutter analyze

# Ejecutar tests
flutter test

# Verificar formato
dart format lib/
```

---

**Responsable de Deuda Técnica:** Equipo de desarrollo  
**Revisión:** Cada sprint
