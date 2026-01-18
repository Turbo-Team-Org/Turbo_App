# 🏗️ Arquitectura - Turbo App

> **Visión general de la arquitectura del proyecto**

---

## 📐 Arquitectura General

```
┌─────────────────────────────────────────────────────────────────┐
│                        TURBO WORKSPACE                          │
├─────────────────┬─────────────────┬─────────────────────────────┤
│   Turbo_App     │  Turbo-Admin    │        Turbo_Core           │
│   (Mobile)      │  (Web Admin)    │     (Business Logic)        │
│                 │                 │                             │
│ • Flutter App   │ • Flutter Web   │ • Dart Package              │
│ • iOS/Android   │ • Business Mgmt │ • Repositories              │
│ • User Facing   │ • Analytics     │ • Models (Freezed)          │
│                 │                 │ • Services                  │
└────────┬────────┴────────┬────────┴──────────────┬──────────────┘
         │                 │                       │
         └─────────────────┼───────────────────────┘
                           │
              ┌────────────┴────────────┐
              │      Backend Layer       │
              ├─────────────────────────┤
              │  Firebase (Dev)          │
              │  Supabase (Staging/Prod) │
              └─────────────────────────┘
```

---

## 📁 Estructura del Proyecto (Turbo_App)

```
lib/
├── main.dart                    # Entry point
├── boostrap.dart                # Configuración inicial
├── firebase_options.dart        # Config Firebase
│
├── app/                         # Módulo principal de la app
│   ├── core/                    # Utilidades core
│   │   ├── theme/               # Temas y estilos
│   │   └── use_case.dart        # Base use case
│   │
│   ├── data/                    # Capa de datos local
│   │   └── database_helper.dart
│   │
│   ├── dependency_injection/    # GetIt setup
│   │   └── init_config.dart
│   │
│   ├── routes/                  # Navegación
│   │   ├── guards/              # Auth guards
│   │   └── router/              # auto_route config
│   │
│   ├── utils/                   # Utilidades
│   │   ├── app_preferences.dart
│   │   └── theme/
│   │
│   └── view/                    # Widgets globales
│       ├── screens/
│       │   └── app.dart         # MaterialApp
│       └── widgets/
│
├── authentication/              # Feature: Auth
│   ├── module/                  # Use cases
│   ├── presentation/            # UI
│   │   ├── screens/
│   │   └── widgets/
│   └── state_management/        # Cubits
│       ├── auth_cubit/
│       ├── sign_in_cubit/
│       ├── sign_out_cubit/
│       └── sign_up_cubit/
│
├── places/                      # Feature: Lugares
│   ├── module/                  # Use cases
│   ├── presentation/
│   │   ├── screens/
│   │   │   ├── feed_screen.dart
│   │   │   ├── business_detail.dart
│   │   │   └── places_search_screen.dart
│   │   └── widgets/
│   │       └── business_details/
│   └── state_management/
│       └── place_bloc/
│
├── categories/                  # Feature: Categorías
│   ├── module/
│   ├── presentation/
│   └── state_management/
│
├── events/                      # Feature: Eventos
│   ├── module/
│   ├── presentation/
│   └── state_management/
│
├── favorites/                   # Feature: Favoritos
│   ├── module/
│   ├── presentation/
│   └── state_management/
│
├── reservations/                # Feature: Reservaciones
│   ├── module/
│   ├── presentation/
│   │   ├── screens/
│   │   │   ├── booking_page.dart
│   │   │   ├── booking_form_page.dart
│   │   │   ├── my_reservations_page.dart
│   │   │   └── reservation_details_page.dart
│   │   └── widgets/
│   └── state_management/
│       └── booking_cubit/
│
├── reviews/                     # Feature: Reseñas
│   ├── module/
│   └── state_management/
│
├── location/                    # Feature: Ubicación
│   ├── module/
│   ├── presentation/
│   └── state_management/
│
├── users/                       # Feature: Usuario
│   └── presentation/            # (Pendiente)
│
└── mock_data/                   # Datos de prueba
    └── *.dart
```

---

## 🔄 Flujo de Datos

```
┌──────────────┐     ┌──────────────┐     ┌──────────────┐
│     UI       │────▶│    Cubit     │────▶│   UseCase    │
│  (Screens)   │◀────│   (State)    │◀────│  (Domain)    │
└──────────────┘     └──────────────┘     └──────────────┘
                                                 │
                                                 ▼
                                          ┌──────────────┐
                                          │  Repository  │
                                          │    (Core)    │
                                          └──────────────┘
                                                 │
                                                 ▼
                                          ┌──────────────┐
                                          │   Service    │
                                          │  (Firebase/  │
                                          │   Supabase)  │
                                          └──────────────┘
```

---

## 🧩 Patrones Utilizados

### 1. Clean Architecture

```
Presentation Layer (UI)
       ↓
Domain Layer (Use Cases)
       ↓
Data Layer (Repositories, Services)
```

### 2. BLoC Pattern (Cubit)

```dart
// State
@freezed
class PlaceState with _$PlaceState {
  const factory PlaceState.initial() = PlacesInitial;
  const factory PlaceState.loading() = PlacesLoading;
  const factory PlaceState.loaded(List<Place> places) = PlacesLoaded;
  const factory PlaceState.error(String error) = PlacesError;
}

// Cubit
class PlaceCubit extends Cubit<PlaceState> {
  final GetPlacesUseCase _getPlacesUseCase;
  
  PlaceCubit(this._getPlacesUseCase) : super(const PlaceState.initial());
  
  Future<void> getPlaces() async {
    emit(const PlaceState.loading());
    try {
      final places = await _getPlacesUseCase();
      emit(PlaceState.loaded(places));
    } catch (e) {
      emit(PlaceState.error(e.toString()));
    }
  }
}
```

### 3. Dependency Injection (GetIt)

```dart
// init_config.dart
final sl = GetIt.instance;

Future<void> initDependencies() async {
  // Core
  await initCoreDependencies(sl: sl, environment: TurboEnvironment.dev);
  
  // Cubits
  sl.registerFactory(() => PlaceCubit(sl()));
  sl.registerFactory(() => AuthCubit(sl()));
  // ...
}
```

### 4. Feature-First Organization

```
feature/
├── module/              # Use cases y configuración
├── presentation/        # UI (screens, widgets)
└── state_management/    # Cubits/Blocs
```

---

## 🗺️ Navegación

### Router Configuration (auto_route)

```dart
@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    // Auth
    AutoRoute(page: TurboSplashRoute.page, path: '/'),
    AutoRoute(page: SignUpRoute.page, path: '/sign-up'),
    AutoRoute(page: SignInRoute.page, path: '/sign-in'),
    
    // Main (con guard de auth)
    AutoRoute(
      path: '/home',
      page: BottomNavShellWidget.page,
      guards: [authGuard],
      children: [
        AutoRoute(path: 'feed', page: FeedRoute.page, initial: true),
        AutoRoute(path: 'categories', page: CategoriesRoute.page),
        AutoRoute(path: 'events', page: EventsRoute.page),
        AutoRoute(path: 'favorites', page: FavoritesRoute.page),
        AutoRoute(path: 'profile', page: ProfileRoute.page),
      ],
    ),
    
    // Detalles
    AutoRoute(page: BusinessDetailsRoute.page, path: '/business-detail'),
    AutoRoute(page: BookingRoute.page, path: '/booking'),
    // ...
  ];
}
```

### Auth Guard

```dart
class AuthGuard extends AutoRouteGuard {
  final AuthenticationRepository _authRepo;
  
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final isAuthenticated = _authRepo.currentUser != null;
    if (isAuthenticated) {
      resolver.next();
    } else {
      router.push(const SignInRoute());
    }
  }
}
```

---

## 📦 Dependencias Principales

### UI & Styling
```yaml
flutter_bloc: ^9.1.0        # State management
auto_route: ^10.0.1         # Navigation
animate_do: ^4.2.0          # Animations
flutter_svg: ^2.0.14        # SVG support
cached_network_image: ^3.3.1 # Image caching
```

### Backend
```yaml
core:                        # Turbo Core package
  git:
    url: https://github.com/Turbo-Team-Org/Turbo_Core.git
cloud_firestore: ^5.6.5      # Firestore
firebase_auth: ^5.5.1        # Auth
firebase_messaging: ^15.2.5  # Push notifications
```

### Utilities
```yaml
get_it: ^8.0.3              # DI
shared_preferences: ^2.3.3   # Local storage
geolocator: ^14.0.0         # Location
permission_handler: ^11.4.0  # Permissions
url_launcher: ^6.3.1        # External links
```

### Code Generation
```yaml
freezed: ^3.0.3             # Immutable models
auto_route_generator: ^10.0.1 # Route generation
json_serializable: ^6.7.0    # JSON serialization
build_runner: ^2.0.0        # Build tool
```

---

## 🔐 Seguridad

### Autenticación
- Firebase Authentication para usuarios
- Tokens JWT manejados automáticamente
- Guards en rutas protegidas

### Datos
- Firestore Security Rules en Core
- Supabase RLS Policies
- No se almacenan datos sensibles localmente

---

## 🧪 Testing

### Estructura de Tests
```
test/
├── places/
│   └── place_cubit_test.dart
├── widget_test.dart
└── README.md (guías de testing)
```

### Ejecutar Tests
```bash
# Unit tests
flutter test

# Con coverage
flutter test --coverage

# Específico
flutter test test/places/
```

---

## 🚀 Build & Deploy

### Desarrollo
```bash
# Obtener dependencias
flutter pub get

# Generar código
flutter pub run build_runner build --delete-conflicting-outputs

# Ejecutar
flutter run
```

### Producción
```bash
# iOS
flutter build ios --release

# Android
flutter build apk --release
flutter build appbundle --release
```

---

## 📊 Diagramas Adicionales

### Flujo de Autenticación

```
┌─────────┐     ┌─────────┐     ┌─────────┐     ┌─────────┐
│ Splash  │────▶│ Check   │────▶│ Auth?   │────▶│  Feed   │
│ Screen  │     │  Auth   │     │  Yes    │     │ Screen  │
└─────────┘     └─────────┘     └────┬────┘     └─────────┘
                                     │ No
                                     ▼
                               ┌─────────┐
                               │  Login  │
                               │ Screen  │
                               └─────────┘
```

### Flujo de Reservación

```
┌─────────┐     ┌─────────┐     ┌─────────┐     ┌─────────┐
│ Place   │────▶│ Booking │────▶│ Booking │────▶│ Success │
│ Detail  │     │  Page   │     │  Form   │     │  Page   │
│ (Reservar)    │ (Fecha) │     │ (Datos) │     │         │
└─────────┘     └─────────┘     └─────────┘     └─────────┘
```

---

## 📝 Convenciones de Código

### Nombres
- **Archivos**: snake_case (`place_cubit.dart`)
- **Clases**: PascalCase (`PlaceCubit`)
- **Variables**: camelCase (`currentPlace`)
- **Constantes**: camelCase (`defaultTimeout`)

### Estructura de Widget

```dart
class MyWidget extends StatelessWidget {
  // 1. Propiedades
  final String title;
  
  // 2. Constructor
  const MyWidget({super.key, required this.title});
  
  // 3. Build method
  @override
  Widget build(BuildContext context) {
    return Container();
  }
  
  // 4. Métodos privados
  Widget _buildHeader() => Container();
}
```

### Estructura de Cubit

```dart
class MyCubit extends Cubit<MyState> {
  // 1. Dependencias
  final MyRepository _repository;
  
  // 2. Constructor
  MyCubit(this._repository) : super(const MyState.initial());
  
  // 3. Métodos públicos
  Future<void> loadData() async {
    // ...
  }
  
  // 4. Métodos privados
  void _handleError(Object error) {
    // ...
  }
}
```

---

**Última actualización:** Enero 2025  
**Mantenido por:** Turbo Team
