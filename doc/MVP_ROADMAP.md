# 🗺️ Roadmap MVP - Turbo App

> **Objetivo:** Lanzar MVP funcional en ~3-4 semanas

---

## 📅 Sprint 1: Funcionalidades Críticas (Semana 1-2)

### 🎯 Objetivos
- Completar flujos de usuario esenciales
- Mejorar experiencia de primer uso
- Estabilizar la aplicación

---

### Día 1-2: Pantalla de Perfil

**Archivos a crear:**
```
lib/users/
├── presentation/
│   ├── screens/
│   │   └── profile_screen.dart
│   └── widgets/
│       ├── profile_header.dart
│       ├── profile_stats_card.dart
│       └── settings_section.dart
├── state_management/
│   └── profile_cubit/
│       ├── profile_cubit.dart
│       └── profile_state.dart
└── module/
    └── profile_module.dart
```

**Funcionalidades:**
- [x] Header con foto y nombre
- [x] Estadísticas (favoritos, reservaciones, reseñas)
- [x] Sección de configuraciones
- [x] Botón cerrar sesión
- [x] Editar perfil básico

**Diseño sugerido:**
```
┌─────────────────────────────┐
│     [Avatar circular]       │
│       Juan Pérez            │
│    juan@example.com         │
├─────────────────────────────┤
│  ⭐ 12    ❤️ 25    📅 8     │
│  Reseñas  Favoritos Reserv. │
├─────────────────────────────┤
│  👤 Editar perfil      →    │
│  🔔 Notificaciones     →    │
│  🌙 Tema oscuro        [◯]  │
│  ❓ Ayuda              →    │
│  📋 Términos           →    │
├─────────────────────────────┤
│  🚪 Cerrar sesión           │
└─────────────────────────────┘
```

---

### Día 3-4: Onboarding

**Archivos a crear:**
```
lib/onboarding/
├── presentation/
│   ├── screens/
│   │   └── onboarding_screen.dart
│   └── widgets/
│       ├── onboarding_page.dart
│       └── page_indicator.dart
└── module/
    └── onboarding_module.dart
```

**Pantallas (3-4):**

1. **Bienvenida**
   - "Descubre Cuba como nunca antes"
   - Ilustración de mapa/lugares

2. **Lugares**
   - "Encuentra los mejores lugares"
   - Ilustración de restaurantes/bares

3. **Eventos**
   - "No te pierdas ningún evento"
   - Ilustración de eventos/festivales

4. **Reservaciones**
   - "Reserva con un solo tap"
   - Ilustración de calendario

**Lógica:**
```dart
// Verificar si es primera vez
final prefs = await SharedPreferences.getInstance();
final hasSeenOnboarding = prefs.getBool('has_seen_onboarding') ?? false;

if (!hasSeenOnboarding) {
  // Mostrar onboarding
  await prefs.setBool('has_seen_onboarding', true);
}
```

---

### Día 5-6: Limpieza de Código

**Tareas:**

1. **Eliminar prints de debug**
   ```bash
   # Buscar todos los prints
   grep -r "print(" lib/ --include="*.dart" | wc -l
   ```
   
   **Solución:**
   ```dart
   // Crear logger utility
   class AppLogger {
     static void debug(String message) {
       if (kDebugMode) {
         debugPrint('[DEBUG] $message');
       }
     }
     
     static void error(String message, [Object? error]) {
       if (kDebugMode) {
         debugPrint('[ERROR] $message: $error');
       }
       // En producción: enviar a Crashlytics
     }
   }
   ```

2. **Refactorizar archivos grandes**
   - `feed_screen.dart` (1662 líneas) → Dividir en widgets

3. **Revisar imports no usados**
   ```bash
   flutter analyze
   ```

---

### Día 7-8: Manejo de Errores

**Implementar:**

1. **Widget de error global**
   ```dart
   class ErrorView extends StatelessWidget {
     final String message;
     final VoidCallback? onRetry;
     
     // ...
   }
   ```

2. **Widget de sin conexión**
   ```dart
   class NoConnectionView extends StatelessWidget {
     final VoidCallback onRetry;
     
     // ...
   }
   ```

3. **Interceptor de errores**
   ```dart
   // En bootstrap.dart
   FlutterError.onError = (details) {
     // Log error
     // Mostrar snackbar amigable
   };
   ```

---

### Día 9-10: Recuperación de Contraseña

**Archivos a crear:**
```
lib/authentication/presentation/screens/
└── forgot_password_screen.dart
```

**Flujo:**
1. Usuario toca "¿Olvidaste tu contraseña?"
2. Ingresa email
3. Se envía link de recuperación
4. Mensaje de confirmación

---

## 📅 Sprint 2: Pulido (Semana 3)

### Día 11-12: Validaciones de Formularios

**Implementar en:**
- Login form
- Registro form
- Formulario de reservación
- Formulario de reseña

**Ejemplo:**
```dart
String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'El email es requerido';
  }
  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
    return 'Ingresa un email válido';
  }
  return null;
}
```

---

### Día 13-14: Notificaciones Push

**Configuración:**
1. Verificar Firebase Messaging setup
2. Crear NotificationService
3. Manejar tokens
4. Implementar handlers

**Tipos de notificaciones:**
- 📅 Recordatorio de reservación (1h antes)
- 🎉 Nuevo evento cerca
- ⭐ Oferta especial
- 📣 Actualizaciones de la app

---

### Día 15: Fix de Bugs

**Lista de bugs conocidos a revisar:**
- [ ] Hero animation glitch en transiciones
- [ ] TabController length mismatch ocasional
- [ ] Ubicación no se actualiza correctamente
- [ ] Favoritos no se sincronizan inmediatamente

---

## 📅 Sprint 3: Testing y QA (Semana 4)

### Día 16-17: Tests Críticos

**Tests de flujos principales:**
```dart
// test/flows/
├── auth_flow_test.dart
├── booking_flow_test.dart
├── favorite_flow_test.dart
└── search_flow_test.dart
```

**Ejemplo de test de flujo:**
```dart
testWidgets('Usuario puede hacer login y ver feed', (tester) async {
  await tester.pumpWidget(MyApp());
  
  // Ingresar credenciales
  await tester.enterText(find.byKey(Key('email')), 'test@test.com');
  await tester.enterText(find.byKey(Key('password')), 'password123');
  
  // Tap login
  await tester.tap(find.text('Inicia Sesión'));
  await tester.pumpAndSettle();
  
  // Verificar que estamos en feed
  expect(find.text('¡Hola,'), findsOneWidget);
});
```

---

### Día 18-19: Testing en Dispositivos

**Dispositivos a probar:**
- [ ] iPhone 15 (iOS 17)
- [ ] iPhone SE (pantalla pequeña)
- [ ] iPad (tablet)
- [ ] Samsung Galaxy S23 (Android 14)
- [ ] Pixel 7 (Android puro)
- [ ] Dispositivo de gama baja

**Checklist por dispositivo:**
- [ ] Onboarding completo
- [ ] Login/Registro
- [ ] Navegación por tabs
- [ ] Ver detalle de lugar
- [ ] Hacer reservación
- [ ] Añadir favorito
- [ ] Ver eventos
- [ ] Cerrar sesión

---

### Día 20: QA Final y Preparación

**Tareas:**
- [ ] Revisar todos los textos (typos)
- [ ] Verificar traducciones
- [ ] Optimizar imágenes
- [ ] Verificar app icon
- [ ] Crear splash screen final
- [ ] Preparar release notes
- [ ] Configurar versión (1.0.0)

---

## 📋 Checklist Pre-Lanzamiento

### App Store / Play Store

**Assets necesarios:**
- [ ] App icon (1024x1024)
- [ ] Screenshots iPhone (6.5", 5.5")
- [ ] Screenshots iPad (12.9")
- [ ] Screenshots Android (phone, tablet)
- [ ] Feature graphic (Play Store)
- [ ] Descripción corta (30 chars)
- [ ] Descripción larga (4000 chars)
- [ ] Keywords/Tags
- [ ] Categoría
- [ ] Clasificación de contenido

**Documentos:**
- [ ] Política de privacidad URL
- [ ] Términos de servicio URL
- [ ] Información de contacto

### Configuración

**Firebase:**
- [ ] Configurar proyecto de producción
- [ ] Habilitar Authentication
- [ ] Configurar Firestore rules
- [ ] Habilitar Cloud Messaging
- [ ] Configurar Crashlytics

**Supabase (si aplica):**
- [ ] Configurar proyecto de producción
- [ ] Migrar datos de prueba
- [ ] Configurar RLS policies

---

## 🚀 Plan de Lanzamiento

### Semana de Lanzamiento

**Lunes:**
- Build final iOS y Android
- Upload a TestFlight y Play Console (Internal Testing)

**Martes-Miércoles:**
- Testing con equipo interno
- Fix de bugs críticos

**Jueves:**
- Submit para review (App Store)
- Publicar en beta abierta (Play Store)

**Viernes-Domingo:**
- Monitorear reviews
- Preparar hotfix si necesario

### Post-Lanzamiento (Semana 1)

- Monitorear Crashlytics
- Responder reviews
- Recopilar feedback
- Priorizar mejoras

---

## 📊 KPIs para MVP

### Métricas de Éxito (Primer Mes)

| Métrica | Objetivo |
|---------|----------|
| Descargas | 1,000+ |
| Usuarios activos diarios | 100+ |
| Reservaciones completadas | 50+ |
| Rating promedio | 4.0+ |
| Crash-free sessions | 99%+ |

### Métricas de Engagement

| Métrica | Objetivo |
|---------|----------|
| Sesiones por usuario | 3+/semana |
| Tiempo en app | 5+ min/sesión |
| Lugares favoritos por usuario | 5+ |
| Reseñas por usuario | 1+ |

---

**Nota:** Este roadmap es flexible y debe ajustarse según los recursos disponibles y el feedback del equipo.
