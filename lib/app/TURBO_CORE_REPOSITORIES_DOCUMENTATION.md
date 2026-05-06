# Turbo Core - Documentación de Repositorios y Servicios

Esta documentación incluye todos los repositorios, interfaces y servicios disponibles en **Turbo Core** para el desarrollo de aplicaciones móviles y paneles administrativos.

## 🏗️ Arquitectura General

Turbo Core sigue una arquitectura híbrida que soporta:

- **Firebase** (ambiente desarrollo)
- **Supabase** (ambientes staging y producción)

Cada repositorio expone métodos uniformes independientemente de la base de datos subyacente.

---

## 📑 Índice de Repositorios

1. [Authentication Repository](#authentication-repository)
2. [Admin Auth Repository](#admin-auth-repository)
3. [Place Repository](#place-repository)
4. [Category Repository](#category-repository)
5. [Place Category Repository](#place-category-repository)
6. [Review Repository](#review-repository)
7. [Event Repository](#event-repository)
8. [Favorite Repository](#favorite-repository)
9. [Location Repository](#location-repository)
10. [Analytics Repository](#analytics-repository)
11. [Reservation Repository](#reservation-repository)

---

## Authentication Repository

**Propósito:** Gestión de autenticación de usuarios finales de la aplicación móvil.

### Métodos Disponibles

#### 🔐 Operaciones de Autenticación

```dart
/// Inicia sesión con email y contraseña
Future<AuthUser?> signInWithEmail({
  required String email,
  required String password,
});

/// Registra un nuevo usuario con email y contraseña
Future<AuthUser?> signUpWithEmail({
  required String email,
  required String password,
  String? displayName,
});

/// Inicia sesión con Google
Future<AuthUser?> signInWithGoogle();

/// Cierra la sesión del usuario actual
Future<void> signOut();
```

#### 🔑 Operaciones de Contraseña

```dart
/// Cambia la contraseña del usuario autenticado
Future<void> changePassword({
  required String currentPassword,
  required String newPassword,
});

/// Envía email de recuperación de contraseña
Future<void> sendPasswordResetEmail({required String email});
```

#### 📡 Estado de Autenticación

```dart
/// Stream del estado de autenticación
Stream<AuthUser?> get authStateChanges;
```

**Casos de uso típicos:**

- Login/registro de usuarios en la app móvil
- Recuperación de contraseñas
- Autenticación con Google
- Monitoreo del estado de sesión

---

## Admin Auth Repository

**Propósito:** Sistema completo de autenticación y gestión de usuarios administrativos con roles y permisos.

### Métodos Disponibles

#### 🔐 Autenticación Administrativa

```dart
/// Stream del estado de autenticación admin
Stream<AdminUser?> get authStateChanges;

/// Obtiene el usuario admin actualmente autenticado
Future<AdminUser?> getCurrentAdminUser();

/// Inicia sesión con email y contraseña (admin)
Future<AdminUser> signInWithEmailAndPassword({
  required String email,
  required String password,
});

/// Login unificado que determina el tipo de usuario automáticamente
Future<AuthResult> signInUnified({
  required String email,
  required String password,
});

/// Registra un nuevo usuario administrativo
Future<AdminUser> signUpWithEmailAndPassword({
  required String email,
  required String password,
  required String displayName,
  required List<String> ownedPlaceIds,
  AdminRole role = AdminRole.placeOwner,
  String? createdByUid,
});

/// Cerrar sesión del usuario admin
Future<void> signOut();

/// Enviar email de recuperación para admins
Future<void> sendPasswordResetEmail(String email);
```

#### 🏢 Gestión de Permisos

```dart
/// Actualiza los lugares asignados a un usuario
Future<void> updateOwnedPlaces(
  String userId,
  List<String> placeIds, {
  String? updatedByUid,
});

/// Actualiza permisos específicos de un usuario
Future<void> updatePermissions(
  String userId,
  Map<String, List<Permission>> permissions, {
  String? updatedByUid,
});

/// Cambia el estado activo/inactivo de un usuario
Future<void> toggleUserStatus(
  String userId,
  bool isActive, {
  String? updatedByUid,
});
```

#### 📊 Consultas y Estadísticas

```dart
/// Obtiene administradores de un lugar específico
Future<List<AdminUser>> getAdminsByPlaceId(String placeId);

/// Obtiene todos los usuarios administrativos (solo superAdmin)
Future<List<AdminUser>> getAllAdmins({String? requestedByUid});

/// Obtiene estadísticas de usuarios administrativos
Future<AdminUsersStats> getAdminUsersStats({String? requestedByUid});

/// Busca usuarios administrativos por criterios
Future<List<AdminUser>> searchAdminUsers({
  String? email,
  String? displayName,
  AdminRole? role,
  bool? isActive,
  String? requestedByUid,
});
```

#### 🚀 Auto-Registro de Business Owners

```dart
/// Enviar solicitud de registro como business owner
Future<BusinessOwnerRequest> submitBusinessOwnerRequest({
  required String userId,
  required String displayName,
  required String businessName,
  required String businessDescription,
  required String businessAddress,
  String? phoneNumber,
  String? website,
  Map<String, dynamic>? businessMetadata,
  Map<String, dynamic>? contactInfo,
});

/// Aprobar solicitud de business owner
Future<AdminUser> approveBusinessOwnerRequest({
  required String requestId,
  required String approvedByUid,
  List<String>? initialPlaceIds,
  String? approvalNotes,
});

/// Rechazar solicitud de business owner
Future<void> rejectBusinessOwnerRequest({
  required String requestId,
  required String rejectedByUid,
  required String rejectionReason,
});

/// Obtener todas las solicitudes de business owners
Future<List<BusinessOwnerRequest>> getAllBusinessOwnerRequests({
  String? requestedByUid,
  BusinessOwnerRequestStatus? filterByStatus,
});

/// Registra usuario nuevo y envía solicitud en un solo flujo
Future<BusinessOwnerRegistrationResult> registerAndRequestBusinessOwner({
  required String email,
  required String password,
  required String displayName,
  required String businessName,
  required String businessDescription,
  required String businessAddress,
  String? phoneNumber,
  String? website,
  Map<String, dynamic>? businessMetadata,
  Map<String, dynamic>? contactInfo,
});
```

**Casos de uso típicos:**

- Panel administrativo con diferentes roles
- Gestión de business owners y sus lugares
- Sistema de solicitudes y aprobaciones
- Control de acceso granular

---

## Place Repository

**Propósito:** Gestión completa de lugares/negocios con analytics integrados.

### Métodos Disponibles

#### 📍 CRUD Básico de Lugares

```dart
/// Obtiene todos los lugares
Future<List<Place>> getPlaces();

/// Obtiene un lugar por ID
Future<Place> getPlaceById(String id);

/// Obtiene un lugar por nombre
Future<Place> getPlaceByName(String name);

/// Obtiene lugares por categoría
Future<List<Place>> getPlacesByCategory(String categoryId);

/// Añade un nuevo lugar
Future<void> addPlace(Place place);

/// Actualiza un lugar existente
Future<void> updatePlace(Place place);

/// Elimina un lugar
Future<void> deletePlace(String id);
```

#### 🏢 Operaciones Administrativas

```dart
/// Obtiene lugares propiedad de un admin específico
Future<List<Place>> getPlacesByOwnerId(String ownerId);

/// Obtiene lugares propiedad de múltiples admins
Future<List<Place>> getPlacesByOwnerIds(List<String> ownerIds);

/// Actualiza la propiedad de un lugar (solo super admin)
Future<Place> updatePlaceOwnership(String placeId, List<String> ownerIds);

/// Obtiene resumen de analytics para lugares de un admin
Future<PlaceOwnerAnalytics> getPlaceAnalyticsByOwnerId(String ownerId);

/// Añade un lugar con propietario específico
Future<void> addPlaceWithOwner(Place place, String ownerId);
```

**Casos de uso típicos:**

- Catálogo de lugares en la app móvil
- Gestión de lugares por business owners
- Búsqueda y filtrado por categorías
- Analytics de propietarios

---

## Category Repository

**Propósito:** Sistema de categorización de lugares con gestión de asociaciones.

### Métodos Disponibles

#### 📂 Gestión de Categorías

```dart
/// Obtiene todas las categorías
Future<List<Category>> getCategories();

/// Obtiene una categoría por ID
Future<Category> getCategoryById(String id);

/// Obtiene una categoría por nombre
Future<Category> getCategoryByName(String name);

/// Añade una nueva categoría
Future<void> addCategory(Category category);

/// Actualiza una categoría existente
Future<void> updateCategory(Category category);

/// Elimina una categoría
Future<void> deleteCategory(String id);
```

**Casos de uso típicos:**

- Sistema de filtros en la app
- Organización del catálogo de lugares
- Gestión administrativa de categorías

---

## Place Category Repository

**Propósito:** Gestión de relaciones muchos-a-muchos entre lugares y categorías.

### Métodos Disponibles

#### 🔗 Gestión de Asociaciones

```dart
/// Crea o actualiza una asociación lugar-categoría
Future<void> upsertPlaceCategory(PlaceCategory placeCategory);

/// Asigna una categoría a un lugar
Future<bool> assignCategoryToPlace(String placeId, String categoryId);

/// Remueve una categoría de un lugar
Future<bool> removeCategoryFromPlace(String placeId, String categoryId);

/// Actualiza todas las categorías de un lugar
Future<bool> updatePlaceCategories(String placeId, List<String> categoryIds);

/// Obtiene todos los lugares de una categoría
Future<List<Place>> getPlacesInCategory(String categoryId);

/// Obtiene todas las categorías de un lugar
Future<List<Category>> getCategoriesForPlace(String placeId);
```

**Casos de uso típicos:**

- Asignación múltiple de categorías a lugares
- Búsqueda por categorías específicas
- Gestión de taxonomías complejas

---

## Review Repository

**Propósito:** Sistema completo de reseñas con paginación, moderación y analytics.

### Métodos Disponibles

#### 📝 CRUD Básico

```dart
/// Obtiene todas las reseñas (método básico)
Future<List<Review>> getReviews();

/// Añade una nueva reseña a un lugar
Future<String> addReview(Review review, String placeId);

/// Actualiza una reseña existente
Future<void> updateReview(Review review);

/// Elimina una reseña por ID
Future<void> deleteReview(String id);

/// Obtiene reseñas de un lugar específico
Future<List<Review>> getReviewsFromAPlace(String placeId);
```

#### 📄 Operaciones con Paginación

```dart
/// Obtiene todas las reseñas con paginación
Future<PagedResult<Review>> getAllReviews({
  int page = 1,
  int limit = 20,
  ReviewStatus? status,
});

/// OPTIMIZADO: Paginación basada en cursor (recomendado)
Future<PaginatedReviews> getReviewsCursor({
  int limit = 20,
  ReviewStatus? status,
  String? placeId,
  String? userId,
  String? pageToken,
  bool includeTotalCount = false,
});

/// Obtiene reseñas paginadas con filtros
Future<PagedResult<Review>> getReviewsPaginated({
  int page = 1,
  int limit = 20,
  ReviewStatus? status,
  String? placeId,
  String? userId,
});

/// Reseñas paginadas por lugar
Future<PagedResult<Review>> getReviewsByPlaceId(String placeId, {
  int page = 1,
  int limit = 20,
  ReviewStatus? status,
});

/// Reseñas paginadas por usuario
Future<PagedResult<Review>> getReviewsByUserId(String userId, {
  int page = 1,
  int limit = 20,
  ReviewStatus? status,
});

/// Reseñas paginadas por estado
Future<PagedResult<Review>> getReviewsByStatus(ReviewStatus status, {
  int page = 1,
  int limit = 20,
});
```

#### 🛡️ Operaciones de Moderación

```dart
/// Aprueba una reseña
Future<void> approveReview(String reviewId, {
  String? moderatorId,
  String? moderationNote,
});

/// Rechaza una reseña
Future<void> rejectReview(String reviewId, {
  String? moderatorId,
  String? moderationNote,
});

/// Marca una reseña para revisión
Future<void> flagReview(String reviewId, {
  String? moderatorId,
  String? moderationNote,
});

/// Actualiza el estado de una reseña
Future<void> updateReviewStatus(String reviewId, ReviewStatus status, {
  String? moderatorId,
  String? moderationNote,
});
```

#### 📊 Analytics de Reseñas

```dart
/// Obtiene estadísticas de reseñas de un lugar
Future<Map<String, dynamic>> getReviewStats(String placeId);

/// Obtiene conteo de reseñas pendientes
Future<int> getPendingReviewsCount();

/// Obtiene conteo de reseñas marcadas
Future<int> getFlaggedReviewsCount();
```

**Casos de uso típicos:**

- Sistema de reseñas en la app móvil
- Panel de moderación para admins
- Analytics de satisfacción del cliente
- Gestión de contenido generado por usuarios

---

## Event Repository

**Propósito:** Gestión completa de eventos con analytics para business owners.

### Métodos Disponibles

#### 🎉 CRUD de Eventos

```dart
/// Obtiene todos los eventos
Future<List<Event>> getEvents();

/// Obtiene eventos del día actual
Future<List<Event>> getTodayEvents();

/// Obtiene eventos por tipo
Future<List<Event>> getEventsByType(EventType type);

/// Obtiene un evento por ID
Future<Event> getEventById(String id);

/// Obtiene eventos de un lugar específico
Future<List<Event>> getEventsByPlaceId(String placeId);

/// Obtiene eventos destacados
Future<List<Event>> getHighlightedEvents();

/// Añade un nuevo evento
Future<void> addEvent(Event event);

/// Actualiza un evento existente
Future<void> updateEvent(Event event);

/// Elimina un evento
Future<void> deleteEvent(String id);
```

#### 🏢 Operaciones Administrativas

```dart
/// Obtiene eventos de múltiples lugares (para admins)
Future<List<Event>> getEventsByPlaceIds(List<String> placeIds);

/// Obtiene eventos gestionados por un admin específico
Future<List<Event>> getEventsByAdminUser(String adminUserId);

/// Obtiene analytics de eventos para un admin
Future<EventAnalytics> getEventAnalyticsByAdminUser(
  String adminUserId, {
  DateTime? startDate,
  DateTime? endDate,
});

/// Busca eventos en lugares de un admin específico
Future<List<Event>> searchEventsByAdminUser(
  String query,
  String adminUserId, {
  EventType? eventType,
  DateTime? startDate,
  DateTime? endDate,
});

/// Añade evento con validación de propiedad
Future<void> addEventByAdmin(Event event, String adminUserId);

/// Actualiza evento con validación de propiedad
Future<void> updateEventByAdmin(Event event, String adminUserId);

/// Elimina evento con validación de propiedad
Future<void> deleteEventByAdmin(String eventId, String adminUserId);
```

**Casos de uso típicos:**

- Catálogo de eventos en la app
- Gestión de eventos por business owners
- Analytics de participación en eventos
- Sistema de permisos por propietario

---

## Favorite Repository

**Propósito:** Sistema de favoritos de usuarios para lugares.

### Métodos Disponibles

#### ❤️ Gestión de Favoritos

```dart
/// Obtiene los favoritos de un usuario
Future<List<Favorite>> getFavorites(String userId);

/// Verifica si un lugar es favorito
Future<bool> isFavorite(String userId, String placeId);

/// Añade un lugar a favoritos
Future<void> addFavorite(String userId, String placeId);

/// Alterna el estado de favorito
Future<void> toggleFavorite(Favorite favorite);

/// Remueve un lugar de favoritos
Future<void> removeFavorite(String userId, String placeId);
```

**Casos de uso típicos:**

- Lista de favoritos del usuario
- Botón de favorito en detalles del lugar
- Recomendaciones personalizadas
- Analytics de preferencias

---

## Location Repository

**Propósito:** Sistema completo de localización con integración de Google Places y geocoding.

### Métodos Disponibles

#### 📍 Seguimiento de Ubicación

```dart
/// Obtiene la ubicación actual
Future<LocationData> getCurrentLocation();

/// Inicia el seguimiento de ubicación
Future<void> startLocationTracking();

/// Detiene el seguimiento de ubicación
Future<void> stopLocationTracking();

/// Stream de actualizaciones de ubicación
Stream<LocationData> get locationStream;
```

#### 🗺️ Integración con Google Places

```dart
/// Busca lugares usando Google Places API
Future<List<GooglePlace>> searchPlaces({
  required String query,
  LocationData? location,
  double? radius,
  String? type,
  String? language,
});

/// Obtiene detalles de un lugar por Google Place ID
Future<GooglePlace?> getPlaceDetails(String placeId);

/// Busca lugares cercanos
Future<List<GooglePlace>> searchNearbyPlaces({
  required LocationData location,
  double radius = 5000,
  String? type,
  String? keyword,
});

/// Autocompletado de búsqueda de lugares
Future<List<GooglePlace>> autocompletePlaces({
  required String input,
  LocationData? location,
  double? radius,
});
```

#### 🏪 Gestión de Ubicaciones de Lugares

```dart
/// Guarda ubicación de lugar en base de datos
Future<void> savePlaceLocation(PlaceLocation placeLocation);

/// Obtiene ubicación de lugar por ID
Future<PlaceLocation?> getPlaceLocation(String placeId);

/// Actualiza ubicación de lugar
Future<void> updatePlaceLocation(PlaceLocation placeLocation);

/// Elimina ubicación de lugar
Future<void> deletePlaceLocation(String placeId);

/// Obtiene todas las ubicaciones de lugares
Future<List<PlaceLocation>> getAllPlaceLocations();
```

#### 📏 Distancia y Proximidad

```dart
/// Calcula distancia entre dos puntos
Future<DistanceResult> calculateDistance({
  required LocationData origin,
  required LocationData destination,
  String travelMode = 'driving',
});

/// Encuentra lugares dentro de un radio
Future<List<NearbySearchResult>> findPlacesWithinRadius({
  required LocationData center,
  required double radiusMeters,
  List<String>? categories,
  int limit = 20,
  String sortBy = 'distance',
});

/// Obtiene lugares ordenados por distancia
Future<List<NearbySearchResult>> getPlacesByDistance({
  required LocationData userLocation,
  List<String>? placeIds,
  ProximityFilter? filter,
});
```

#### 🌐 Geocoding

```dart
/// Convierte dirección a coordenadas
Future<LocationData?> geocodeAddress(String address);

/// Convierte coordenadas a dirección
Future<String?> reverseGeocode({
  required double latitude,
  required double longitude,
});

/// Obtiene dirección formateada de coordenadas
Future<PlaceLocation?> getFormattedAddress({
  required double latitude,
  required double longitude,
  String? placeId,
});
```

#### 🏢 Configuración de Ubicación de Negocios

```dart
/// Configura ubicación de negocio para panel admin
Future<PlaceLocation> setupBusinessLocation({
  required String placeId,
  required LocationData coordinates,
  String? googlePlaceId,
  String? userId,
});

/// Valida ubicación de negocio
Future<bool> validateBusinessLocation({
  required LocationData location,
  String? expectedAddress,
});

/// Obtiene sugerencias de ubicación para configuración
Future<List<GooglePlace>> getLocationSuggestions({
  required String businessName,
  String? address,
  LocationData? approximateLocation,
});
```

#### 🔧 Utilidades

```dart
/// Verifica si hay permisos de ubicación
Future<bool> hasLocationPermission();

/// Solicita permisos de ubicación
Future<bool> requestLocationPermission();

/// Verifica si los servicios de ubicación están habilitados
Future<bool> isLocationServiceEnabled();

/// Calcula distancia usando fórmula Haversine
double calculateDistanceHaversine({
  required double lat1,
  required double lon1,
  required double lat2,
  required double lon2,
});

/// Libera recursos
void dispose();
```

**Casos de uso típicos:**

- Búsqueda de lugares cercanos
- Navegación y direcciones
- Configuración de ubicación de negocios
- Filtros por proximidad

---

## Analytics Repository

**Propósito:** Sistema completo de analytics empresariales con dashboards y métricas avanzadas.

### Métodos Disponibles

#### 📊 Dashboard Principal

```dart
/// Obtiene datos completos del dashboard
Future<BusinessDashboard> getDashboardData(
  String placeId,
  DateRange dateRange,
);

/// Actualiza métricas en tiempo real
Future<void> updateRealTimeMetrics(String placeId);
```

#### 📈 Métricas Específicas

```dart
/// Métricas de tráfico por horas
Future<List<HourlyData>> getHourlyTraffic(
  String placeId,
  DateRange dateRange,
);

/// Métricas de tráfico por días
Future<List<DailyData>> getDailyTraffic(String placeId, DateRange dateRange);

/// Insights detallados de reseñas
Future<ReviewInsights> getReviewInsights(String placeId, DateRange dateRange);

/// Contenido y servicios más populares
Future<PopularContent> getPopularContent(String placeId, DateRange dateRange);
```

#### 🔄 Análisis Comparativo

```dart
/// Compara con período anterior
Future<List<ComparisonMetric>> compareWithPreviousPeriod(
  String placeId,
  DateRange currentRange,
);

/// Compara con promedios de industria
Future<List<ComparisonMetric>> compareWithIndustry(
  String placeId,
  DateRange dateRange,
  String categoryId,
);

/// Compara con competidores
Future<List<ComparisonMetric>> compareWithCompetitors(
  String placeId,
  DateRange dateRange,
  List<String> competitorIds,
);
```

#### 🔮 Análisis Predictivo

```dart
/// Predice métricas futuras
Future<Map<String, dynamic>> getPredictiveAnalytics(
  String placeId,
  int daysToPredict,
);

/// Detecta tendencias y patrones
Future<Map<String, dynamic>> getTrendAnalysis(
  String placeId,
  DateRange dateRange,
);

/// Identifica oportunidades de mejora
Future<List<String>> getImprovementOpportunities(
  String placeId,
  DateRange dateRange,
);
```

#### 📋 Eventos y Tracking

```dart
/// Registra una visita/interacción
Future<void> trackVisit(String placeId, Map<String, dynamic> metadata);

/// Registra una conversión
Future<void> trackConversion(
  String placeId,
  String conversionType,
  Map<String, dynamic> metadata,
);

/// Registra tiempo de sesión
Future<void> trackSessionDuration(
  String placeId,
  Duration sessionDuration,
  Map<String, dynamic> metadata,
);
```

#### 📄 Reportes Personalizados

```dart
/// Genera reporte personalizado
Future<Map<String, dynamic>> generateCustomReport(
  String placeId,
  DateRange dateRange,
  List<String> selectedMetrics,
  String reportFormat,
);

/// Exporta datos de analytics
Future<String> exportAnalyticsData(
  String placeId,
  DateRange dateRange,
  String format,
);
```

#### 🔔 Configuración y Alertas

```dart
/// Configura alertas automáticas
Future<void> setupMetricAlert(
  String placeId,
  String metricName,
  double threshold,
  String alertType,
);

/// Obtiene alertas existentes
Future<List<Map<String, dynamic>>> getMetricAlerts(String placeId);

/// Elimina una alerta específica
Future<void> removeMetricAlert(String placeId, String alertId);
```

#### 💭 Análisis de Sentimientos

```dart
/// Analiza sentimientos de reseñas
Future<SentimentAnalysis> analyzeSentiments(
  String placeId,
  DateRange dateRange,
);

/// Palabras clave más mencionadas
Future<List<String>> getTopKeywords(
  String placeId,
  DateRange dateRange, {
  int limit = 10,
});

/// Detecta problemas recurrentes
Future<List<String>> detectCommonIssues(String placeId, DateRange dateRange);
```

#### 🎯 Estadísticas Avanzadas

```dart
/// Calcula Customer Lifetime Value
Future<double> calculateCustomerLifetimeValue(String placeId);

/// Calcula tasa de retención
Future<double> calculateRetentionRate(String placeId, DateRange dateRange);

/// Métricas de engagement
Future<Map<String, double>> getUserEngagementMetrics(
  String placeId,
  DateRange dateRange,
);

/// Analiza customer journey
Future<Map<String, dynamic>> analyzeCustomerJourney(
  String placeId,
  DateRange dateRange,
);
```

#### ⚡ Métricas de Performance

```dart
/// Tiempo de carga promedio
Future<double> getAverageLoadTime(String placeId, DateRange dateRange);

/// Analiza dispositivos utilizados
Future<Map<String, int>> getDeviceAnalytics(
  String placeId,
  DateRange dateRange,
);

/// Datos de ubicación de visitantes
Future<Map<String, int>> getGeoAnalytics(String placeId, DateRange dateRange);
```

#### 🔧 Inicialización y Limpieza

```dart
/// Inicializa estructura de analytics para lugar nuevo
Future<void> initializeAnalyticsStructure(String placeId);

/// Limpia completamente analytics de un lugar
Future<void> cleanupAnalyticsStructure(String placeId);
```

**Casos de uso típicos:**

- Dashboards empresariales
- Reportes de performance
- Análisis de comportamiento de usuarios
- Optimización de negocios

---

## Reservation Repository

**Propósito:** Sistema completo de reservas con gestión de disponibilidad, analytics y notificaciones.

### Métodos Disponibles

#### 📅 Gestión de Reservas

```dart
/// Crear nueva reserva
Future<Reservation> createReservation(Reservation reservation);

/// Obtener reserva por ID
Future<Reservation?> getReservation(String reservationId);

/// Actualizar reserva existente
Future<void> updateReservation(Reservation reservation);

/// Cancelar reserva
Future<void> cancelReservation(String reservationId, {String? reason});

/// Confirmar reserva (admin)
Future<void> confirmReservation(
  String reservationId, {
  String? tableNumber,
  String? notes,
});

/// Rechazar reserva (admin)
Future<void> rejectReservation(String reservationId, {String? reason});

/// Check-in de cliente
Future<void> checkInReservation(String reservationId, {String? notes});

/// Completar reserva
Future<void> completeReservation(String reservationId, {String? notes});

/// Marcar como no-show
Future<void> markNoShow(String reservationId, {String? notes});
```

#### 🔍 Consultas de Reservas

```dart
/// Reservas por usuario
Future<List<Reservation>> getUserReservations(
  String userId, {
  ReservationStatus? status,
});

/// Reservas por lugar
Future<List<Reservation>> getPlaceReservations(
  String placeId, {
  ReservationStatus? status,
});

/// Reservas por fecha específica
Future<List<Reservation>> getReservationsByDate(
  String placeId,
  DateTime date,
);

/// Reservas entre fechas
Future<List<Reservation>> getReservationsBetweenDates(
  String placeId,
  DateTime startDate,
  DateTime endDate,
);

/// Reservas del día actual
Future<List<Reservation>> getTodayReservations(String placeId);

/// Reservas futuras de usuario
Future<List<Reservation>> getUserUpcomingReservations(String userId);

/// Stream de reservas en tiempo real
Stream<List<Reservation>> watchPlaceReservations(String placeId);
```

#### 🕐 Disponibilidad y Slots

```dart
/// Slots disponibles para una fecha
Future<List<ReservationTimeSlot>> getAvailableSlots(
  String placeId,
  DateTime date,
);

/// Verificar disponibilidad específica
Future<bool> isSlotAvailable(
  String placeId,
  DateTime startTime,
  DateTime endTime,
  int partySize,
);

/// Próximos slots disponibles
Future<List<ReservationTimeSlot>> getNextAvailableSlots(
  String placeId, {
  int days = 7,
});

/// Generar slots para un día
Future<List<ReservationTimeSlot>> generateDaySlots(
  String placeId,
  DateTime date,
);
```

#### ⚙️ Gestión de Disponibilidad

```dart
/// Obtener disponibilidad del negocio
Future<BusinessAvailability?> getBusinessAvailability(String placeId);

/// Crear/actualizar disponibilidad
Future<void> setBusinessAvailability(BusinessAvailability availability);

/// Actualizar horario semanal
Future<void> updateWeeklySchedule(
  String placeId,
  List<WeeklySchedule> schedule,
);

/// Agregar día especial
Future<void> addSpecialDay(String placeId, SpecialDay specialDay);

/// Agregar fecha bloqueada
Future<void> addBlackoutDate(String placeId, BlackoutDate blackoutDate);

/// Eliminar fecha bloqueada
Future<void> removeBlackoutDate(String placeId, String blackoutId);
```

#### 🎛️ Configuraciones

```dart
/// Obtener configuraciones de reserva
Future<ReservationSettings?> getReservationSettings(String placeId);

/// Actualizar configuraciones
Future<void> updateReservationSettings(ReservationSettings settings);

/// Crear configuraciones por defecto
Future<ReservationSettings> createDefaultSettings(
  String placeId, {
  String? createdBy,
});
```

#### 📊 Analytics y Estadísticas

```dart
/// Estadísticas de reservas
Future<ReservationStats> getReservationStats(
  String placeId, {
  DateTime? startDate,
  DateTime? endDate,
});

/// Tasa de ocupación
Future<double> getOccupancyRate(String placeId, DateTime date);

/// Horarios más populares
Future<List<PopularTimeSlot>> getPopularTimeSlots(
  String placeId, {
  int days = 30,
});

/// Tendencias de reservas
Future<List<ReservationTrend>> getReservationTrends(
  String placeId, {
  int days = 30,
});
```

#### 📧 Notificaciones

```dart
/// Enviar confirmación por email
Future<void> sendConfirmationEmail(String reservationId);

/// Enviar recordatorio por email
Future<void> sendReminderEmail(String reservationId);

/// Programar recordatorio automático
Future<void> scheduleReminder(String reservationId);
```

#### ✅ Validaciones

```dart
/// Validar datos de reserva
Future<ReservationValidationResult> validateReservation(
  Reservation reservation,
);

/// Verificar conflictos de horario
Future<List<Reservation>> checkTimeConflicts(
  String placeId,
  DateTime startTime,
  DateTime endTime,
);

/// Verificar capacidad disponible
Future<int> getAvailableCapacity(
  String placeId,
  DateTime startTime,
  DateTime endTime,
);
```

#### 🔧 Utilidades

```dart
/// Limpiar reservas antiguas
Future<void> cleanupOldReservations({int olderThanDays = 90});

/// Exportar reservas a CSV
Future<String> exportReservationsToCSV(
  String placeId,
  DateTime startDate,
  DateTime endDate,
);

/// Importar reservas desde CSV
Future<void> importReservationsFromCSV(String placeId, String csvData);

/// Liberar recursos
void dispose();
```

**Casos de uso típicos:**

- Sistema de reservas para restaurantes
- Gestión de citas y horarios
- Analytics de ocupación
- Notificaciones automáticas

---

## 🎯 Guía de Uso

### Inicialización

```dart
import 'package:core/core.dart';
import 'package:get_it/get_it.dart';

// Inicializar con ambiente específico
await initCoreDependencies(
  sl: GetIt.instance,
  environment: TurboEnvironment.staging, // o .dev, .prod
  enableDebugLogs: true,
);
```

### Uso de Repositorios

```dart
// Obtener instancia de repositorio
final authRepo = sl<AuthenticationRepository>();
final placesRepo = sl<PlaceRepository>();
final analyticsRepo = sl<AnalyticsRepository>();

// Usar métodos
final user = await authRepo.signInWithEmail(
  email: 'user@example.com',
  password: 'password123',
);

final places = await placesRepo.getPlaces();
final dashboard = await analyticsRepo.getDashboardData(
  placeId,
  DateRange.last30Days(),
);
```

### Ambientes Soportados

- **dev**: Firebase (desarrollo)
- **staging**: Supabase (pruebas)
- **prod**: Supabase (producción)

---

## 📝 Notas Importantes

1. **Rendimiento**: Usa métodos de paginación cursor-based para grandes conjuntos de datos
2. **Permisos**: Los métodos administrativos incluyen validación de permisos automática
3. **Analytics**: Se inicializan automáticamente al crear lugares
4. **Ambientes**: La configuración se maneja automáticamente según el ambiente
5. **Errores**: Todos los métodos lanzan excepciones descriptivas en caso de error

---

## 🔄 Actualizaciones

Esta documentación se actualiza automáticamente cuando se añaden nuevos métodos o funcionalidades al sistema.

**Última actualización**: Enero 2025  
**Versión de Turbo Core**: 1.0.0
