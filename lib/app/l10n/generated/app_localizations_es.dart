// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'Turbo';

  @override
  String get greetingMorning => '¡Buenos días!';

  @override
  String get greetingAfternoon => '¡Buenas tardes!';

  @override
  String get greetingEvening => '¡Buenas noches!';

  @override
  String get greetingDefault => '¡Hola!';

  @override
  String get welcomeSubtitle => 'Descubre los mejores lugares en Cuba';

  @override
  String get defaultUserName => 'Explorador';

  @override
  String get categoryPopular => 'Popular';

  @override
  String get categoryFavorites => 'Favoritos';

  @override
  String get categoryTrending => 'Trending';

  @override
  String get categoryEconomic => 'Económico';

  @override
  String get categoryTopRated => 'Top Rated';

  @override
  String get categoryFood => 'Comida';

  @override
  String get categoryDrinks => 'Bebidas';

  @override
  String get categoryOffers => 'Ofertas';

  @override
  String get categoryNearby => 'Cerca';

  @override
  String get categoryAll => 'Todas las Categorías';

  @override
  String get categoryRestaurants => 'Restaurantes';

  @override
  String get categoryBars => 'Bares';

  @override
  String get categoryCafes => 'Cafeterías';

  @override
  String get categoryHotels => 'Hoteles';

  @override
  String get categoryTours => 'Tours';

  @override
  String get categoryBeaches => 'Playas';

  @override
  String get categoryNightlife => 'Vida Nocturna';

  @override
  String get categoryShopping => 'Compras';

  @override
  String get categoryHealth => 'Salud';

  @override
  String get categoryServices => 'Servicios';

  @override
  String get searchPlaceholder => 'Buscar lugares...';

  @override
  String get searchTitle => 'Buscar';

  @override
  String get searchResults => 'Resultados de búsqueda';

  @override
  String get searchNoResults => 'No se encontraron resultados';

  @override
  String get searchHint => '¿Qué estás buscando?';

  @override
  String get searchRecent => 'Búsquedas recientes';

  @override
  String get searchSuggestions => 'Sugerencias';

  @override
  String get reservationsTitle => 'Reservas';

  @override
  String get reservationsSystem => 'Sistema de reservas disponible';

  @override
  String get reservationsViewAll => 'Ver todas';

  @override
  String get reservationsNew => 'Hacer Nueva Reserva';

  @override
  String get reservationsUpcoming => 'Próximas Reservas';

  @override
  String reservationsPending(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count reservas pendientes',
      one: '1 reserva pendiente',
    );
    return '$_temp0';
  }

  @override
  String get reservationsMyReservations => 'Mis Reservas';

  @override
  String get reservationsNoReservations => 'No tienes reservas';

  @override
  String get reservationsNoUpcoming => 'No tienes reservas próximas';

  @override
  String get reservationsPast => 'Reservas Pasadas';

  @override
  String get reservationsCancelled => 'Reservas Canceladas';

  @override
  String get reservationsConfirmed => 'Confirmada';

  @override
  String get reservationsPendingStatus => 'Pendiente';

  @override
  String get reservationsCancelledStatus => 'Cancelada';

  @override
  String get reservationsCompleted => 'Completada';

  @override
  String get reservationDetails => 'Detalles de la Reserva';

  @override
  String get reservationDate => 'Fecha';

  @override
  String get reservationTime => 'Hora';

  @override
  String reservationGuests(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count personas',
      one: '1 persona',
    );
    return '$_temp0';
  }

  @override
  String get reservationSelectDate => 'Seleccionar Fecha';

  @override
  String get reservationSelectTime => 'Seleccionar Hora';

  @override
  String get reservationSelectGuests => 'Número de Personas';

  @override
  String get reservationNotes => 'Notas adicionales';

  @override
  String get reservationNotesHint => 'Alguna petición especial...';

  @override
  String get reservationConfirmTitle => 'Confirmar Reserva';

  @override
  String get reservationConfirmMessage =>
      '¿Estás seguro de realizar esta reserva?';

  @override
  String get reservationCancelTitle => 'Cancelar Reserva';

  @override
  String get reservationCancelMessage =>
      '¿Estás seguro de cancelar esta reserva?';

  @override
  String get reservationSuccess => '¡Reserva realizada con éxito!';

  @override
  String get reservationCancelSuccess => 'Reserva cancelada';

  @override
  String get reservationError => 'Error al procesar la reserva';

  @override
  String get reservationNoSlots => 'No hay horarios disponibles';

  @override
  String get reservationSelectSlot => 'Selecciona un horario';

  @override
  String get reservationAvailableSlots => 'Horarios Disponibles';

  @override
  String get reservationContinue => 'Continuar';

  @override
  String get reservationBack => 'Volver';

  @override
  String get reservationSummary => 'Resumen de la Reserva';

  @override
  String get promoSpecial => 'ESPECIAL';

  @override
  String get promoTitle => '¡Oferta especial!';

  @override
  String get promoDescription =>
      'Disfruta 20% de descuento en tours por La Habana';

  @override
  String get promoButton => 'Ver Oferta';

  @override
  String get placeOpen => 'Abierto';

  @override
  String get placeClosed => 'Cerrado';

  @override
  String get placeOpenNow => 'Abierto ahora';

  @override
  String get placeClosedNow => 'Cerrado ahora';

  @override
  String get placeDetails => 'Detalles';

  @override
  String get placeDescription => 'Descripción';

  @override
  String get placeLocation => 'Ubicación';

  @override
  String get placeContact => 'Contacto';

  @override
  String get placeSchedule => 'Horario';

  @override
  String get placeAmenities => 'Servicios';

  @override
  String get placePhotos => 'Fotos';

  @override
  String get placeMoreInfo => 'Más Información';

  @override
  String get placeSeeAll => 'Ver todo';

  @override
  String get placeNoDescription => 'Sin descripción disponible';

  @override
  String get placeCallNow => 'Llamar';

  @override
  String get placeGetDirections => 'Cómo llegar';

  @override
  String get placeShare => 'Compartir';

  @override
  String get placeWebsite => 'Sitio Web';

  @override
  String get placeMenu => 'Menú';

  @override
  String get placeAveragePrice => 'Precio promedio';

  @override
  String get placePriceRange => 'Rango de precios';

  @override
  String placeFromPrice(String price) {
    return 'Desde \$$price';
  }

  @override
  String placeDistance(Object distance) {
    return '$distance km';
  }

  @override
  String get reviewsTitle => 'Reseñas';

  @override
  String get reviewsAll => 'Todas las reseñas';

  @override
  String get reviewsWrite => 'Escribir Reseña';

  @override
  String get reviewsNoReviews => 'Aún no hay reseñas';

  @override
  String get reviewsBeFirst => 'Sé el primero en opinar';

  @override
  String reviewsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count reseñas',
      one: '1 reseña',
      zero: 'Sin reseñas',
    );
    return '$_temp0';
  }

  @override
  String get reviewsRating => 'Calificación';

  @override
  String get reviewsYourRating => 'Tu calificación';

  @override
  String get reviewsComment => 'Tu comentario';

  @override
  String get reviewsCommentHint => 'Cuéntanos tu experiencia';

  @override
  String get reviewsSubmit => 'Publicar';

  @override
  String get reviewsSuccess => '¡Reseña enviada!';

  @override
  String get reviewsError => 'Error al enviar la reseña';

  @override
  String get reviewsThankYou => '¡Gracias por tu opinión!';

  @override
  String get reviewsRatingRequired => 'Por favor, selecciona una calificación';

  @override
  String get reviewsCommentRequired => 'Por favor, escribe un comentario';

  @override
  String get reviewsRecent => 'Más recientes';

  @override
  String get reviewsBest => 'Mejor valoradas';

  @override
  String get offersTitle => 'Ofertas';

  @override
  String get offersSpecial => 'Ofertas Especiales';

  @override
  String get offersActive => 'Ofertas Activas';

  @override
  String get offersExpired => 'Expirada';

  @override
  String offersValidUntil(Object date) {
    return 'Válido hasta $date';
  }

  @override
  String offersDiscount(Object percent) {
    return '$percent% de descuento';
  }

  @override
  String get offersNoOffers => 'No hay ofertas disponibles';

  @override
  String get loadingPlaces => 'Cargando lugares...';

  @override
  String get loadingData => 'Cargando...';

  @override
  String get loadingMore => 'Cargando más...';

  @override
  String get noPlacesAvailable => 'No hay lugares disponibles';

  @override
  String get tryAnotherSearch => 'Intenta con otra búsqueda';

  @override
  String get errorOccurred => 'Algo salió mal';

  @override
  String get errorGeneric => 'Ha ocurrido un error';

  @override
  String get errorConnection => 'Error de conexión';

  @override
  String get errorTryAgain => 'Por favor, intenta de nuevo';

  @override
  String get retry => 'Reintentar';

  @override
  String get refresh => 'Actualizar';

  @override
  String get notificationsTitle => 'Notificaciones';

  @override
  String get notificationsComingSoon => 'Notificaciones próximamente';

  @override
  String get notificationsEmpty => 'No tienes notificaciones';

  @override
  String get notificationsMarkRead => 'Marcar como leídas';

  @override
  String get notificationsClearAll => 'Limpiar todo';

  @override
  String locationError(Object message) {
    return 'Error de ubicación: $message';
  }

  @override
  String get locationNotAvailable =>
      'Ubicación no disponible. Mostrando todos los lugares.';

  @override
  String get requestingLocation =>
      'Solicitando tu ubicación para mostrar lugares cercanos...';

  @override
  String get locationPermissionTitle => 'Permiso de ubicación';

  @override
  String get locationPermissionMessage =>
      'Necesitamos acceso a tu ubicación para mostrarte los lugares más cercanos';

  @override
  String get locationPermissionAllow => 'Permitir';

  @override
  String get locationPermissionDeny => 'Denegar';

  @override
  String get locationPermissionSettings => 'Ir a Configuración';

  @override
  String get locationDenied => 'Permiso de ubicación denegado';

  @override
  String get locationDisabled =>
      'Los servicios de ubicación están desactivados';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get themeSelectTitle => 'Seleccionar Tema';

  @override
  String get themeTitle => 'Tema';

  @override
  String get themeAppearance => 'Apariencia';

  @override
  String get navExplore => 'Explorar';

  @override
  String get navCategories => 'Categorías';

  @override
  String get navEvents => 'Eventos';

  @override
  String get navFavorites => 'Favoritos';

  @override
  String get navProfile => 'Perfil';

  @override
  String get navHome => 'Inicio';

  @override
  String get navSearch => 'Buscar';

  @override
  String get navMap => 'Mapa';

  @override
  String get profileTitle => 'Perfil';

  @override
  String get profileEdit => 'Editar Perfil';

  @override
  String get profileMyReservations => 'Mis Reservas';

  @override
  String get profileMyReservationsDesc => 'Ver y gestionar tus reservaciones';

  @override
  String get profileNotifications => 'Notificaciones';

  @override
  String get profileNotificationsDesc => 'Configurar alertas y avisos';

  @override
  String get profileHelp => 'Ayuda y Soporte';

  @override
  String get profileHelpDesc => 'Preguntas frecuentes y contacto';

  @override
  String get profileLogout => 'Cerrar Sesión';

  @override
  String get profileLogoutConfirm =>
      '¿Estás seguro de que deseas cerrar sesión?';

  @override
  String get profileSettings => 'Configuración';

  @override
  String get profileLanguage => 'Idioma';

  @override
  String get profilePrivacy => 'Privacidad';

  @override
  String get profileTerms => 'Términos y Condiciones';

  @override
  String get profileAbout => 'Acerca de';

  @override
  String profileVersion(Object version) {
    return 'Versión $version';
  }

  @override
  String get profileFavorites => 'Mis Favoritos';

  @override
  String get profileFavoritesDesc => 'Lugares que has guardado';

  @override
  String get profileAccount => 'Mi Cuenta';

  @override
  String get profileAccountDesc => 'Información personal';

  @override
  String get profileWelcome => '¡Bienvenido!';

  @override
  String get profileGuest => 'Invitado';

  @override
  String get profileLoginPrompt =>
      'Inicia sesión para acceder a todas las funciones';

  @override
  String get profileEditTitle => 'Editar perfil';

  @override
  String get profileEditNameLabel => 'Nombre visible';

  @override
  String get profileEditSave => 'Guardar';

  @override
  String get profileStatsFavorites => 'Favoritos';

  @override
  String get profileStatsReservations => 'Reservas';

  @override
  String get profileStatsReviews => 'Reseñas';

  @override
  String get profileUpdateSuccess => 'Perfil actualizado';

  @override
  String get profileNameMinLength =>
      'El nombre debe tener al menos 2 caracteres';

  @override
  String get profileMyReviews => 'Mis reseñas';

  @override
  String get profileMyReviewsDesc => 'Reseñas que escribiste';

  @override
  String get profileFeatureSoon => 'Próximamente';

  @override
  String get commonRetry => 'Reintentar';

  @override
  String get favoritesTitle => 'Favoritos';

  @override
  String get favoritesEmpty => 'No tienes favoritos';

  @override
  String get favoritesEmptyDesc => 'Los lugares que guardes aparecerán aquí';

  @override
  String get favoritesRemove => 'Eliminar de favoritos';

  @override
  String get favoritesAdd => 'Agregar a favoritos';

  @override
  String get favoritesAdded => 'Agregado a favoritos';

  @override
  String get favoritesRemoved => 'Eliminado de favoritos';

  @override
  String get favoritesExplore => 'Explorar lugares';

  @override
  String favoritesCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count favoritos',
      one: '1 favorito',
    );
    return '$_temp0';
  }

  @override
  String get eventsTitle => 'Eventos';

  @override
  String get eventsUpcoming => 'Próximos Eventos';

  @override
  String get eventsToday => 'Hoy';

  @override
  String get eventsThisWeek => 'Esta Semana';

  @override
  String get eventsThisMonth => 'Este Mes';

  @override
  String get eventsNoEvents => 'No hay eventos disponibles';

  @override
  String get eventsNoUpcoming => 'No hay eventos próximos';

  @override
  String get eventsDetails => 'Detalles del Evento';

  @override
  String get eventsDate => 'Fecha del evento';

  @override
  String get eventsTime => 'Hora';

  @override
  String get eventsLocation => 'Lugar';

  @override
  String get eventsPrice => 'Precio';

  @override
  String get eventsFree => 'Gratis';

  @override
  String get eventsInterested => 'Me interesa';

  @override
  String get eventsGoing => 'Asistiré';

  @override
  String get eventsShare => 'Compartir evento';

  @override
  String get eventsWelcomeTitle => '¡Descubre los mejores eventos!';

  @override
  String get eventsWelcomeSubtitle =>
      'No te pierdas los eventos más destacados de Cuba';

  @override
  String get eventsWelcomeButton => 'Ver Eventos';

  @override
  String get eventsSeeAll => 'Ver todos';

  @override
  String get authSignIn => 'Iniciar Sesión';

  @override
  String get authSignUp => 'Registrarse';

  @override
  String get authEmail => 'Correo electrónico';

  @override
  String get authPassword => 'Contraseña';

  @override
  String get authConfirmPassword => 'Confirmar contraseña';

  @override
  String get authForgotPassword => '¿Olvidaste tu contraseña?';

  @override
  String get authWithGoogle => 'Continuar con Google';

  @override
  String get authWithApple => 'Continuar con Apple';

  @override
  String get authWithFacebook => 'Continuar con Facebook';

  @override
  String get authOr => 'o';

  @override
  String get authNoAccount => '¿No tienes cuenta?';

  @override
  String get authHaveAccount => '¿Ya tienes cuenta?';

  @override
  String get authCreateAccount => 'Crear cuenta';

  @override
  String get authWelcomeBack => '¡Bienvenido de nuevo!';

  @override
  String get authWelcome => '¡Bienvenido!';

  @override
  String get authLoginSubtitle => 'Inicia sesión para continuar';

  @override
  String get authSignUpSubtitle => 'Crea tu cuenta para empezar';

  @override
  String get authName => 'Nombre completo';

  @override
  String get authPhone => 'Teléfono';

  @override
  String get authTermsAgree => 'Al continuar, aceptas nuestros';

  @override
  String get authTermsLink => 'Términos y Condiciones';

  @override
  String get authPrivacyLink => 'Política de Privacidad';

  @override
  String get authAnd => 'y';

  @override
  String get authInvalidEmail => 'Correo electrónico inválido';

  @override
  String get authInvalidPassword =>
      'La contraseña debe tener al menos 6 caracteres';

  @override
  String get authPasswordMismatch => 'Las contraseñas no coinciden';

  @override
  String get authLoginSuccess => '¡Sesión iniciada!';

  @override
  String get authLogoutSuccess => 'Sesión cerrada';

  @override
  String get authLoginError => 'Error al iniciar sesión';

  @override
  String get authSignUpError => 'Error al registrarse';

  @override
  String get authResetPassword => 'Restablecer contraseña';

  @override
  String get authResetPasswordSent =>
      'Se ha enviado un correo para restablecer tu contraseña';

  @override
  String get authContinueAsGuest => 'Continuar como invitado';

  @override
  String get bookingTitle => 'Reservar';

  @override
  String get bookingSelectDate => 'Selecciona una fecha';

  @override
  String get bookingSelectTime => 'Selecciona un horario';

  @override
  String get bookingSelectGuests => 'Número de personas';

  @override
  String get bookingStep1 => 'Fecha y Hora';

  @override
  String get bookingStep2 => 'Detalles';

  @override
  String get bookingStep3 => 'Confirmación';

  @override
  String get bookingConfirm => 'Confirmar Reserva';

  @override
  String get bookingModify => 'Modificar';

  @override
  String get bookingCancel => 'Cancelar Reserva';

  @override
  String get bookingSpecialRequests => 'Peticiones especiales';

  @override
  String get bookingContactInfo => 'Información de contacto';

  @override
  String get bookingPayment => 'Método de pago';

  @override
  String get bookingTotal => 'Total';

  @override
  String get bookingFree => 'Sin costo';

  @override
  String get bookingDeposit => 'Depósito requerido';

  @override
  String get bookingPolicy => 'Política de cancelación';

  @override
  String get bookingPolicyText => 'Cancelación gratuita hasta 24 horas antes';

  @override
  String get bookingFullName => 'Nombre completo';

  @override
  String get bookingNameRequired => 'El nombre es requerido';

  @override
  String get bookingEmail => 'Correo electrónico';

  @override
  String get bookingEmailRequired => 'El correo es requerido';

  @override
  String get bookingEmailInvalid => 'Correo inválido';

  @override
  String get bookingPhone => 'Número de teléfono';

  @override
  String get bookingPhoneRequired => 'El teléfono es requerido';

  @override
  String get bookingSpecialRequestsOptional =>
      'Solicitudes especiales (opcional)';

  @override
  String get bookingSpecialRequestsHint =>
      'Ej: Mesa cerca de la ventana, celebración especial...';

  @override
  String get bookingPartySize => '¿Para cuántas personas?';

  @override
  String get bookingPeopleCount => 'Número de personas:';

  @override
  String get bookingCancellationPolicy => 'Política de cancelación';

  @override
  String get bookingCancellationPolicyText =>
      'Puedes cancelar tu reserva hasta 2 horas antes del horario programado sin costo alguno.';

  @override
  String get bookingConfirming => 'Confirmando reserva...';

  @override
  String get bookingLoginRequired =>
      'Debes iniciar sesión para hacer una reserva';

  @override
  String get mapTitle => 'Mapa';

  @override
  String get mapShowList => 'Ver lista';

  @override
  String get mapShowMap => 'Ver mapa';

  @override
  String get mapMyLocation => 'Mi ubicación';

  @override
  String get mapNearby => 'Lugares cercanos';

  @override
  String get mapFilter => 'Filtrar';

  @override
  String get mapNoPlacesNearby => 'No hay lugares cerca';

  @override
  String get filterTitle => 'Filtros';

  @override
  String get filterApply => 'Aplicar Filtros';

  @override
  String get filterClear => 'Limpiar';

  @override
  String get filterReset => 'Restablecer';

  @override
  String get filterPrice => 'Precio';

  @override
  String get filterRating => 'Calificación';

  @override
  String get filterDistance => 'Distancia';

  @override
  String get filterCategory => 'Categoría';

  @override
  String get filterOpenNow => 'Abierto ahora';

  @override
  String get filterSortBy => 'Ordenar por';

  @override
  String get filterRelevance => 'Relevancia';

  @override
  String get filterNearest => 'Más cercano';

  @override
  String get filterHighestRated => 'Mejor valorado';

  @override
  String get filterLowestPrice => 'Menor precio';

  @override
  String get filterHighestPrice => 'Mayor precio';

  @override
  String get filterSearchTitle => 'Filtros de búsqueda';

  @override
  String get filterMinRating => 'Calificación mínima';

  @override
  String placesFoundCount(int count) {
    return '$count lugares';
  }

  @override
  String filterActiveRating(String rating) {
    return 'Calificación $rating+';
  }

  @override
  String filterSortChip(String sortBy) {
    return 'Orden: $sortBy';
  }

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonConfirm => 'Confirmar';

  @override
  String get commonSave => 'Guardar';

  @override
  String get commonDelete => 'Eliminar';

  @override
  String get commonEdit => 'Editar';

  @override
  String get commonClose => 'Cerrar';

  @override
  String get commonAll => 'Todos';

  @override
  String get commonDone => 'Listo';

  @override
  String get commonNext => 'Siguiente';

  @override
  String get commonBack => 'Atrás';

  @override
  String get commonYes => 'Sí';

  @override
  String get commonNo => 'No';

  @override
  String get commonOk => 'OK';

  @override
  String get commonContinue => 'Continuar';

  @override
  String get commonSkip => 'Omitir';

  @override
  String get commonSeeMore => 'Ver más';

  @override
  String get commonSeeLess => 'Ver menos';

  @override
  String get commonShare => 'Compartir';

  @override
  String get commonCopy => 'Copiar';

  @override
  String get commonCopied => 'Copiado';

  @override
  String get commonSend => 'Enviar';

  @override
  String get commonSubmit => 'Enviar';

  @override
  String get commonApply => 'Aplicar';

  @override
  String get commonSelect => 'Seleccionar';

  @override
  String get commonSelected => 'Seleccionado';

  @override
  String get commonRequired => 'Requerido';

  @override
  String get commonOptional => 'Opcional';

  @override
  String get commonLoading => 'Cargando...';

  @override
  String get commonSuccess => '¡Éxito!';

  @override
  String get commonError => 'Error';

  @override
  String get commonWarning => 'Advertencia';

  @override
  String get commonInfo => 'Información';

  @override
  String get commonToday => 'Hoy';

  @override
  String get commonTomorrow => 'Mañana';

  @override
  String get commonYesterday => 'Ayer';

  @override
  String timeMinutes(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minutos',
      one: '1 minuto',
    );
    return '$_temp0';
  }

  @override
  String timeHours(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count horas',
      one: '1 hora',
    );
    return '$_temp0';
  }

  @override
  String timeDays(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count días',
      one: '1 día',
    );
    return '$_temp0';
  }

  @override
  String timeAgo(Object time) {
    return 'hace $time';
  }

  @override
  String get errorNetwork => 'Sin conexión a internet';

  @override
  String get errorServer => 'Error del servidor';

  @override
  String get errorUnknown => 'Error desconocido';

  @override
  String get errorTimeout => 'Tiempo de espera agotado';

  @override
  String get errorNotFound => 'No encontrado';

  @override
  String get errorUnauthorized => 'No autorizado';

  @override
  String get errorForbidden => 'Acceso denegado';

  @override
  String get successSaved => 'Guardado correctamente';

  @override
  String get successDeleted => 'Eliminado correctamente';

  @override
  String get successUpdated => 'Actualizado correctamente';

  @override
  String get successSent => 'Enviado correctamente';

  @override
  String get dialogCloseConfirm => '¿Estás seguro de que deseas cerrar?';

  @override
  String get dialogDeleteConfirm => '¿Estás seguro de que deseas eliminar?';

  @override
  String get dialogUnsavedChanges => 'Tienes cambios sin guardar';

  @override
  String get dialogDiscard => 'Descartar';

  @override
  String get dialogKeepEditing => 'Seguir editando';

  @override
  String get onboardingSkip => 'Omitir';

  @override
  String get onboardingNext => 'Siguiente';

  @override
  String get onboardingGetStarted => 'Comenzar';

  @override
  String get onboardingBack => 'Atrás';

  @override
  String get onboarding1Title => 'Descubre Cuba';

  @override
  String get onboarding1Subtitle =>
      'Explora los mejores restaurantes, bares, hoteles y experiencias que Cuba tiene para ofrecer';

  @override
  String get onboarding2Title => 'Reserva Fácilmente';

  @override
  String get onboarding2Subtitle =>
      'Haz reservaciones en segundos. Sin llamadas, sin esperas. Tu mesa te espera con un solo toque';

  @override
  String get onboarding3Title => 'Eventos Únicos';

  @override
  String get onboarding3Subtitle =>
      'No te pierdas los eventos más exclusivos. Música en vivo, gastronomía, arte y cultura cubana';

  @override
  String get onboarding4Title => 'Guarda tus Favoritos';

  @override
  String get onboarding4Subtitle =>
      'Crea tu propia colección de lugares favoritos y accede a ellos cuando quieras';

  @override
  String get onboardingWelcome => 'Bienvenido a';

  @override
  String get onboardingReadyToExplore => '¿Listo para explorar?';

  @override
  String get reviewsSectionTitle => 'Reseñas de clientes';

  @override
  String get reviewsSeeAll => 'Ver todas';

  @override
  String get reviewsEmpty => 'Sé el primero en opinar';

  @override
  String get reviewsWriteReview => 'Escribir reseña';

  @override
  String get reviewsAddTitle => 'Nueva reseña';

  @override
  String get reviewsEditTitle => 'Editar reseña';

  @override
  String reviewsCommentMinLength(int count) {
    return 'Escribe al menos $count caracteres';
  }

  @override
  String get reviewsSelectRating => 'Selecciona una calificación';

  @override
  String get reviewsSave => 'Guardar';

  @override
  String get reviewsDelete => 'Eliminar';

  @override
  String get reviewsEdit => 'Editar';

  @override
  String get reviewsAverageLabel => 'Valoración media';

  @override
  String get reviewsLoadError => 'No se pudieron cargar las reseñas';

  @override
  String get reviewsAuthRequired => 'Inicia sesión para publicar una reseña';

  @override
  String get reviewsDeleteConfirmTitle => '¿Eliminar reseña?';

  @override
  String get reviewsDeleteConfirmMessage => 'Esta acción no se puede deshacer.';

  @override
  String get reviewsCancel => 'Cancelar';
}
