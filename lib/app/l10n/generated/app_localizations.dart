import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// Nombre de la aplicación
  ///
  /// In es, this message translates to:
  /// **'Turbo'**
  String get appName;

  /// No description provided for @greetingMorning.
  ///
  /// In es, this message translates to:
  /// **'¡Buenos días!'**
  String get greetingMorning;

  /// No description provided for @greetingAfternoon.
  ///
  /// In es, this message translates to:
  /// **'¡Buenas tardes!'**
  String get greetingAfternoon;

  /// No description provided for @greetingEvening.
  ///
  /// In es, this message translates to:
  /// **'¡Buenas noches!'**
  String get greetingEvening;

  /// No description provided for @greetingDefault.
  ///
  /// In es, this message translates to:
  /// **'¡Hola!'**
  String get greetingDefault;

  /// No description provided for @welcomeSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Descubre los mejores lugares en Cuba'**
  String get welcomeSubtitle;

  /// No description provided for @defaultUserName.
  ///
  /// In es, this message translates to:
  /// **'Explorador'**
  String get defaultUserName;

  /// No description provided for @categoryPopular.
  ///
  /// In es, this message translates to:
  /// **'Popular'**
  String get categoryPopular;

  /// No description provided for @categoryFavorites.
  ///
  /// In es, this message translates to:
  /// **'Favoritos'**
  String get categoryFavorites;

  /// No description provided for @categoryTrending.
  ///
  /// In es, this message translates to:
  /// **'Trending'**
  String get categoryTrending;

  /// No description provided for @categoryEconomic.
  ///
  /// In es, this message translates to:
  /// **'Económico'**
  String get categoryEconomic;

  /// No description provided for @categoryTopRated.
  ///
  /// In es, this message translates to:
  /// **'Top Rated'**
  String get categoryTopRated;

  /// No description provided for @categoryFood.
  ///
  /// In es, this message translates to:
  /// **'Comida'**
  String get categoryFood;

  /// No description provided for @categoryDrinks.
  ///
  /// In es, this message translates to:
  /// **'Bebidas'**
  String get categoryDrinks;

  /// No description provided for @categoryOffers.
  ///
  /// In es, this message translates to:
  /// **'Ofertas'**
  String get categoryOffers;

  /// No description provided for @categoryNearby.
  ///
  /// In es, this message translates to:
  /// **'Cerca'**
  String get categoryNearby;

  /// No description provided for @categoryAll.
  ///
  /// In es, this message translates to:
  /// **'Todas las Categorías'**
  String get categoryAll;

  /// No description provided for @categoryRestaurants.
  ///
  /// In es, this message translates to:
  /// **'Restaurantes'**
  String get categoryRestaurants;

  /// No description provided for @categoryBars.
  ///
  /// In es, this message translates to:
  /// **'Bares'**
  String get categoryBars;

  /// No description provided for @categoryCafes.
  ///
  /// In es, this message translates to:
  /// **'Cafeterías'**
  String get categoryCafes;

  /// No description provided for @categoryHotels.
  ///
  /// In es, this message translates to:
  /// **'Hoteles'**
  String get categoryHotels;

  /// No description provided for @categoryTours.
  ///
  /// In es, this message translates to:
  /// **'Tours'**
  String get categoryTours;

  /// No description provided for @categoryBeaches.
  ///
  /// In es, this message translates to:
  /// **'Playas'**
  String get categoryBeaches;

  /// No description provided for @categoryNightlife.
  ///
  /// In es, this message translates to:
  /// **'Vida Nocturna'**
  String get categoryNightlife;

  /// No description provided for @categoryShopping.
  ///
  /// In es, this message translates to:
  /// **'Compras'**
  String get categoryShopping;

  /// No description provided for @categoryHealth.
  ///
  /// In es, this message translates to:
  /// **'Salud'**
  String get categoryHealth;

  /// No description provided for @categoryServices.
  ///
  /// In es, this message translates to:
  /// **'Servicios'**
  String get categoryServices;

  /// No description provided for @searchPlaceholder.
  ///
  /// In es, this message translates to:
  /// **'Buscar lugares...'**
  String get searchPlaceholder;

  /// No description provided for @searchTitle.
  ///
  /// In es, this message translates to:
  /// **'Buscar'**
  String get searchTitle;

  /// No description provided for @searchResults.
  ///
  /// In es, this message translates to:
  /// **'Resultados de búsqueda'**
  String get searchResults;

  /// No description provided for @searchNoResults.
  ///
  /// In es, this message translates to:
  /// **'No se encontraron resultados'**
  String get searchNoResults;

  /// No description provided for @searchHint.
  ///
  /// In es, this message translates to:
  /// **'¿Qué estás buscando?'**
  String get searchHint;

  /// No description provided for @searchRecent.
  ///
  /// In es, this message translates to:
  /// **'Búsquedas recientes'**
  String get searchRecent;

  /// No description provided for @searchSuggestions.
  ///
  /// In es, this message translates to:
  /// **'Sugerencias'**
  String get searchSuggestions;

  /// No description provided for @reservationsTitle.
  ///
  /// In es, this message translates to:
  /// **'Reservas'**
  String get reservationsTitle;

  /// No description provided for @reservationsSystem.
  ///
  /// In es, this message translates to:
  /// **'Sistema de reservas disponible'**
  String get reservationsSystem;

  /// No description provided for @reservationsViewAll.
  ///
  /// In es, this message translates to:
  /// **'Ver todas'**
  String get reservationsViewAll;

  /// No description provided for @reservationsNew.
  ///
  /// In es, this message translates to:
  /// **'Hacer Nueva Reserva'**
  String get reservationsNew;

  /// No description provided for @reservationsUpcoming.
  ///
  /// In es, this message translates to:
  /// **'Próximas Reservas'**
  String get reservationsUpcoming;

  /// No description provided for @reservationsPending.
  ///
  /// In es, this message translates to:
  /// **'{count, plural, =1{1 reserva pendiente} other{{count} reservas pendientes}}'**
  String reservationsPending(num count);

  /// No description provided for @reservationsMyReservations.
  ///
  /// In es, this message translates to:
  /// **'Mis Reservas'**
  String get reservationsMyReservations;

  /// No description provided for @reservationsNoReservations.
  ///
  /// In es, this message translates to:
  /// **'No tienes reservas'**
  String get reservationsNoReservations;

  /// No description provided for @reservationsNoUpcoming.
  ///
  /// In es, this message translates to:
  /// **'No tienes reservas próximas'**
  String get reservationsNoUpcoming;

  /// No description provided for @reservationsPast.
  ///
  /// In es, this message translates to:
  /// **'Reservas Pasadas'**
  String get reservationsPast;

  /// No description provided for @reservationsCancelled.
  ///
  /// In es, this message translates to:
  /// **'Reservas Canceladas'**
  String get reservationsCancelled;

  /// No description provided for @reservationsConfirmed.
  ///
  /// In es, this message translates to:
  /// **'Confirmada'**
  String get reservationsConfirmed;

  /// No description provided for @reservationsPendingStatus.
  ///
  /// In es, this message translates to:
  /// **'Pendiente'**
  String get reservationsPendingStatus;

  /// No description provided for @reservationsCancelledStatus.
  ///
  /// In es, this message translates to:
  /// **'Cancelada'**
  String get reservationsCancelledStatus;

  /// No description provided for @reservationsCompleted.
  ///
  /// In es, this message translates to:
  /// **'Completada'**
  String get reservationsCompleted;

  /// No description provided for @reservationDetails.
  ///
  /// In es, this message translates to:
  /// **'Detalles de la Reserva'**
  String get reservationDetails;

  /// No description provided for @reservationDate.
  ///
  /// In es, this message translates to:
  /// **'Fecha'**
  String get reservationDate;

  /// No description provided for @reservationTime.
  ///
  /// In es, this message translates to:
  /// **'Hora'**
  String get reservationTime;

  /// No description provided for @reservationGuests.
  ///
  /// In es, this message translates to:
  /// **'{count, plural, =1{1 persona} other{{count} personas}}'**
  String reservationGuests(num count);

  /// No description provided for @reservationSelectDate.
  ///
  /// In es, this message translates to:
  /// **'Seleccionar Fecha'**
  String get reservationSelectDate;

  /// No description provided for @reservationSelectTime.
  ///
  /// In es, this message translates to:
  /// **'Seleccionar Hora'**
  String get reservationSelectTime;

  /// No description provided for @reservationSelectGuests.
  ///
  /// In es, this message translates to:
  /// **'Número de Personas'**
  String get reservationSelectGuests;

  /// No description provided for @reservationNotes.
  ///
  /// In es, this message translates to:
  /// **'Notas adicionales'**
  String get reservationNotes;

  /// No description provided for @reservationNotesHint.
  ///
  /// In es, this message translates to:
  /// **'Alguna petición especial...'**
  String get reservationNotesHint;

  /// No description provided for @reservationConfirmTitle.
  ///
  /// In es, this message translates to:
  /// **'Confirmar Reserva'**
  String get reservationConfirmTitle;

  /// No description provided for @reservationConfirmMessage.
  ///
  /// In es, this message translates to:
  /// **'¿Estás seguro de realizar esta reserva?'**
  String get reservationConfirmMessage;

  /// No description provided for @reservationCancelTitle.
  ///
  /// In es, this message translates to:
  /// **'Cancelar Reserva'**
  String get reservationCancelTitle;

  /// No description provided for @reservationCancelMessage.
  ///
  /// In es, this message translates to:
  /// **'¿Estás seguro de cancelar esta reserva?'**
  String get reservationCancelMessage;

  /// No description provided for @reservationSuccess.
  ///
  /// In es, this message translates to:
  /// **'¡Reserva realizada con éxito!'**
  String get reservationSuccess;

  /// No description provided for @reservationCancelSuccess.
  ///
  /// In es, this message translates to:
  /// **'Reserva cancelada'**
  String get reservationCancelSuccess;

  /// No description provided for @reservationError.
  ///
  /// In es, this message translates to:
  /// **'Error al procesar la reserva'**
  String get reservationError;

  /// No description provided for @reservationNoSlots.
  ///
  /// In es, this message translates to:
  /// **'No hay horarios disponibles'**
  String get reservationNoSlots;

  /// No description provided for @reservationSelectSlot.
  ///
  /// In es, this message translates to:
  /// **'Selecciona un horario'**
  String get reservationSelectSlot;

  /// No description provided for @reservationAvailableSlots.
  ///
  /// In es, this message translates to:
  /// **'Horarios Disponibles'**
  String get reservationAvailableSlots;

  /// No description provided for @reservationContinue.
  ///
  /// In es, this message translates to:
  /// **'Continuar'**
  String get reservationContinue;

  /// No description provided for @reservationBack.
  ///
  /// In es, this message translates to:
  /// **'Volver'**
  String get reservationBack;

  /// No description provided for @reservationSummary.
  ///
  /// In es, this message translates to:
  /// **'Resumen de la Reserva'**
  String get reservationSummary;

  /// No description provided for @promoSpecial.
  ///
  /// In es, this message translates to:
  /// **'ESPECIAL'**
  String get promoSpecial;

  /// No description provided for @promoTitle.
  ///
  /// In es, this message translates to:
  /// **'¡Oferta especial!'**
  String get promoTitle;

  /// No description provided for @promoDescription.
  ///
  /// In es, this message translates to:
  /// **'Disfruta 20% de descuento en tours por La Habana'**
  String get promoDescription;

  /// No description provided for @promoButton.
  ///
  /// In es, this message translates to:
  /// **'Ver Oferta'**
  String get promoButton;

  /// No description provided for @placeOpen.
  ///
  /// In es, this message translates to:
  /// **'Abierto'**
  String get placeOpen;

  /// No description provided for @placeClosed.
  ///
  /// In es, this message translates to:
  /// **'Cerrado'**
  String get placeClosed;

  /// No description provided for @placeOpenNow.
  ///
  /// In es, this message translates to:
  /// **'Abierto ahora'**
  String get placeOpenNow;

  /// No description provided for @placeClosedNow.
  ///
  /// In es, this message translates to:
  /// **'Cerrado ahora'**
  String get placeClosedNow;

  /// No description provided for @placeDetails.
  ///
  /// In es, this message translates to:
  /// **'Detalles'**
  String get placeDetails;

  /// No description provided for @placeDescription.
  ///
  /// In es, this message translates to:
  /// **'Descripción'**
  String get placeDescription;

  /// No description provided for @placeLocation.
  ///
  /// In es, this message translates to:
  /// **'Ubicación'**
  String get placeLocation;

  /// No description provided for @placeContact.
  ///
  /// In es, this message translates to:
  /// **'Contacto'**
  String get placeContact;

  /// No description provided for @placeSchedule.
  ///
  /// In es, this message translates to:
  /// **'Horario'**
  String get placeSchedule;

  /// No description provided for @placeAmenities.
  ///
  /// In es, this message translates to:
  /// **'Servicios'**
  String get placeAmenities;

  /// No description provided for @placePhotos.
  ///
  /// In es, this message translates to:
  /// **'Fotos'**
  String get placePhotos;

  /// No description provided for @placeMoreInfo.
  ///
  /// In es, this message translates to:
  /// **'Más Información'**
  String get placeMoreInfo;

  /// No description provided for @placeSeeAll.
  ///
  /// In es, this message translates to:
  /// **'Ver todo'**
  String get placeSeeAll;

  /// No description provided for @placeNoDescription.
  ///
  /// In es, this message translates to:
  /// **'Sin descripción disponible'**
  String get placeNoDescription;

  /// No description provided for @placeCallNow.
  ///
  /// In es, this message translates to:
  /// **'Llamar'**
  String get placeCallNow;

  /// No description provided for @placeGetDirections.
  ///
  /// In es, this message translates to:
  /// **'Cómo llegar'**
  String get placeGetDirections;

  /// No description provided for @placeShare.
  ///
  /// In es, this message translates to:
  /// **'Compartir'**
  String get placeShare;

  /// No description provided for @placeWebsite.
  ///
  /// In es, this message translates to:
  /// **'Sitio Web'**
  String get placeWebsite;

  /// No description provided for @placeMenu.
  ///
  /// In es, this message translates to:
  /// **'Menú'**
  String get placeMenu;

  /// No description provided for @placeAveragePrice.
  ///
  /// In es, this message translates to:
  /// **'Precio promedio'**
  String get placeAveragePrice;

  /// No description provided for @placePriceRange.
  ///
  /// In es, this message translates to:
  /// **'Rango de precios'**
  String get placePriceRange;

  /// No description provided for @placeFromPrice.
  ///
  /// In es, this message translates to:
  /// **'Desde \${price}'**
  String placeFromPrice(String price);

  /// No description provided for @placeDistance.
  ///
  /// In es, this message translates to:
  /// **'{distance} km'**
  String placeDistance(Object distance);

  /// No description provided for @reviewsTitle.
  ///
  /// In es, this message translates to:
  /// **'Reseñas'**
  String get reviewsTitle;

  /// No description provided for @reviewsAll.
  ///
  /// In es, this message translates to:
  /// **'Todas las reseñas'**
  String get reviewsAll;

  /// No description provided for @reviewsWrite.
  ///
  /// In es, this message translates to:
  /// **'Escribir Reseña'**
  String get reviewsWrite;

  /// No description provided for @reviewsNoReviews.
  ///
  /// In es, this message translates to:
  /// **'Aún no hay reseñas'**
  String get reviewsNoReviews;

  /// No description provided for @reviewsBeFirst.
  ///
  /// In es, this message translates to:
  /// **'Sé el primero en opinar'**
  String get reviewsBeFirst;

  /// No description provided for @reviewsCount.
  ///
  /// In es, this message translates to:
  /// **'{count, plural, =1{1 reseña} other{{count} reseñas}}'**
  String reviewsCount(num count);

  /// No description provided for @reviewsRating.
  ///
  /// In es, this message translates to:
  /// **'Calificación'**
  String get reviewsRating;

  /// No description provided for @reviewsYourRating.
  ///
  /// In es, this message translates to:
  /// **'Tu calificación'**
  String get reviewsYourRating;

  /// No description provided for @reviewsComment.
  ///
  /// In es, this message translates to:
  /// **'Tu comentario'**
  String get reviewsComment;

  /// No description provided for @reviewsCommentHint.
  ///
  /// In es, this message translates to:
  /// **'Cuéntanos tu experiencia...'**
  String get reviewsCommentHint;

  /// No description provided for @reviewsSubmit.
  ///
  /// In es, this message translates to:
  /// **'Enviar Reseña'**
  String get reviewsSubmit;

  /// No description provided for @reviewsSuccess.
  ///
  /// In es, this message translates to:
  /// **'¡Reseña enviada!'**
  String get reviewsSuccess;

  /// No description provided for @reviewsError.
  ///
  /// In es, this message translates to:
  /// **'Error al enviar la reseña'**
  String get reviewsError;

  /// No description provided for @reviewsThankYou.
  ///
  /// In es, this message translates to:
  /// **'¡Gracias por tu opinión!'**
  String get reviewsThankYou;

  /// No description provided for @reviewsRatingRequired.
  ///
  /// In es, this message translates to:
  /// **'Por favor, selecciona una calificación'**
  String get reviewsRatingRequired;

  /// No description provided for @reviewsCommentRequired.
  ///
  /// In es, this message translates to:
  /// **'Por favor, escribe un comentario'**
  String get reviewsCommentRequired;

  /// No description provided for @reviewsRecent.
  ///
  /// In es, this message translates to:
  /// **'Más recientes'**
  String get reviewsRecent;

  /// No description provided for @reviewsBest.
  ///
  /// In es, this message translates to:
  /// **'Mejor valoradas'**
  String get reviewsBest;

  /// No description provided for @offersTitle.
  ///
  /// In es, this message translates to:
  /// **'Ofertas'**
  String get offersTitle;

  /// No description provided for @offersSpecial.
  ///
  /// In es, this message translates to:
  /// **'Ofertas Especiales'**
  String get offersSpecial;

  /// No description provided for @offersActive.
  ///
  /// In es, this message translates to:
  /// **'Ofertas Activas'**
  String get offersActive;

  /// No description provided for @offersExpired.
  ///
  /// In es, this message translates to:
  /// **'Expirada'**
  String get offersExpired;

  /// No description provided for @offersValidUntil.
  ///
  /// In es, this message translates to:
  /// **'Válido hasta {date}'**
  String offersValidUntil(Object date);

  /// No description provided for @offersDiscount.
  ///
  /// In es, this message translates to:
  /// **'{percent}% de descuento'**
  String offersDiscount(Object percent);

  /// No description provided for @offersNoOffers.
  ///
  /// In es, this message translates to:
  /// **'No hay ofertas disponibles'**
  String get offersNoOffers;

  /// No description provided for @loadingPlaces.
  ///
  /// In es, this message translates to:
  /// **'Cargando lugares...'**
  String get loadingPlaces;

  /// No description provided for @loadingData.
  ///
  /// In es, this message translates to:
  /// **'Cargando...'**
  String get loadingData;

  /// No description provided for @loadingMore.
  ///
  /// In es, this message translates to:
  /// **'Cargando más...'**
  String get loadingMore;

  /// No description provided for @noPlacesAvailable.
  ///
  /// In es, this message translates to:
  /// **'No hay lugares disponibles'**
  String get noPlacesAvailable;

  /// No description provided for @tryAnotherSearch.
  ///
  /// In es, this message translates to:
  /// **'Intenta con otra búsqueda'**
  String get tryAnotherSearch;

  /// No description provided for @errorOccurred.
  ///
  /// In es, this message translates to:
  /// **'Algo salió mal'**
  String get errorOccurred;

  /// No description provided for @errorGeneric.
  ///
  /// In es, this message translates to:
  /// **'Ha ocurrido un error'**
  String get errorGeneric;

  /// No description provided for @errorConnection.
  ///
  /// In es, this message translates to:
  /// **'Error de conexión'**
  String get errorConnection;

  /// No description provided for @errorTryAgain.
  ///
  /// In es, this message translates to:
  /// **'Por favor, intenta de nuevo'**
  String get errorTryAgain;

  /// No description provided for @retry.
  ///
  /// In es, this message translates to:
  /// **'Reintentar'**
  String get retry;

  /// No description provided for @refresh.
  ///
  /// In es, this message translates to:
  /// **'Actualizar'**
  String get refresh;

  /// No description provided for @notificationsTitle.
  ///
  /// In es, this message translates to:
  /// **'Notificaciones'**
  String get notificationsTitle;

  /// No description provided for @notificationsComingSoon.
  ///
  /// In es, this message translates to:
  /// **'Notificaciones próximamente'**
  String get notificationsComingSoon;

  /// No description provided for @notificationsEmpty.
  ///
  /// In es, this message translates to:
  /// **'No tienes notificaciones'**
  String get notificationsEmpty;

  /// No description provided for @notificationsMarkRead.
  ///
  /// In es, this message translates to:
  /// **'Marcar como leídas'**
  String get notificationsMarkRead;

  /// No description provided for @notificationsClearAll.
  ///
  /// In es, this message translates to:
  /// **'Limpiar todo'**
  String get notificationsClearAll;

  /// No description provided for @locationError.
  ///
  /// In es, this message translates to:
  /// **'Error de ubicación: {message}'**
  String locationError(Object message);

  /// No description provided for @locationNotAvailable.
  ///
  /// In es, this message translates to:
  /// **'Ubicación no disponible. Mostrando todos los lugares.'**
  String get locationNotAvailable;

  /// No description provided for @requestingLocation.
  ///
  /// In es, this message translates to:
  /// **'Solicitando tu ubicación para mostrar lugares cercanos...'**
  String get requestingLocation;

  /// No description provided for @locationPermissionTitle.
  ///
  /// In es, this message translates to:
  /// **'Permiso de ubicación'**
  String get locationPermissionTitle;

  /// No description provided for @locationPermissionMessage.
  ///
  /// In es, this message translates to:
  /// **'Necesitamos acceso a tu ubicación para mostrarte los lugares más cercanos'**
  String get locationPermissionMessage;

  /// No description provided for @locationPermissionAllow.
  ///
  /// In es, this message translates to:
  /// **'Permitir'**
  String get locationPermissionAllow;

  /// No description provided for @locationPermissionDeny.
  ///
  /// In es, this message translates to:
  /// **'Denegar'**
  String get locationPermissionDeny;

  /// No description provided for @locationPermissionSettings.
  ///
  /// In es, this message translates to:
  /// **'Ir a Configuración'**
  String get locationPermissionSettings;

  /// No description provided for @locationDenied.
  ///
  /// In es, this message translates to:
  /// **'Permiso de ubicación denegado'**
  String get locationDenied;

  /// No description provided for @locationDisabled.
  ///
  /// In es, this message translates to:
  /// **'Los servicios de ubicación están desactivados'**
  String get locationDisabled;

  /// No description provided for @themeSystem.
  ///
  /// In es, this message translates to:
  /// **'Sistema'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In es, this message translates to:
  /// **'Claro'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In es, this message translates to:
  /// **'Oscuro'**
  String get themeDark;

  /// No description provided for @themeSelectTitle.
  ///
  /// In es, this message translates to:
  /// **'Seleccionar Tema'**
  String get themeSelectTitle;

  /// No description provided for @themeTitle.
  ///
  /// In es, this message translates to:
  /// **'Tema'**
  String get themeTitle;

  /// No description provided for @themeAppearance.
  ///
  /// In es, this message translates to:
  /// **'Apariencia'**
  String get themeAppearance;

  /// No description provided for @navExplore.
  ///
  /// In es, this message translates to:
  /// **'Explorar'**
  String get navExplore;

  /// No description provided for @navCategories.
  ///
  /// In es, this message translates to:
  /// **'Categorías'**
  String get navCategories;

  /// No description provided for @navEvents.
  ///
  /// In es, this message translates to:
  /// **'Eventos'**
  String get navEvents;

  /// No description provided for @navFavorites.
  ///
  /// In es, this message translates to:
  /// **'Favoritos'**
  String get navFavorites;

  /// No description provided for @navProfile.
  ///
  /// In es, this message translates to:
  /// **'Perfil'**
  String get navProfile;

  /// No description provided for @navHome.
  ///
  /// In es, this message translates to:
  /// **'Inicio'**
  String get navHome;

  /// No description provided for @navSearch.
  ///
  /// In es, this message translates to:
  /// **'Buscar'**
  String get navSearch;

  /// No description provided for @navMap.
  ///
  /// In es, this message translates to:
  /// **'Mapa'**
  String get navMap;

  /// No description provided for @profileTitle.
  ///
  /// In es, this message translates to:
  /// **'Perfil'**
  String get profileTitle;

  /// No description provided for @profileEdit.
  ///
  /// In es, this message translates to:
  /// **'Editar Perfil'**
  String get profileEdit;

  /// No description provided for @profileMyReservations.
  ///
  /// In es, this message translates to:
  /// **'Mis Reservas'**
  String get profileMyReservations;

  /// No description provided for @profileMyReservationsDesc.
  ///
  /// In es, this message translates to:
  /// **'Ver y gestionar tus reservaciones'**
  String get profileMyReservationsDesc;

  /// No description provided for @profileNotifications.
  ///
  /// In es, this message translates to:
  /// **'Notificaciones'**
  String get profileNotifications;

  /// No description provided for @profileNotificationsDesc.
  ///
  /// In es, this message translates to:
  /// **'Configurar alertas y avisos'**
  String get profileNotificationsDesc;

  /// No description provided for @profileHelp.
  ///
  /// In es, this message translates to:
  /// **'Ayuda y Soporte'**
  String get profileHelp;

  /// No description provided for @profileHelpDesc.
  ///
  /// In es, this message translates to:
  /// **'Preguntas frecuentes y contacto'**
  String get profileHelpDesc;

  /// No description provided for @profileLogout.
  ///
  /// In es, this message translates to:
  /// **'Cerrar Sesión'**
  String get profileLogout;

  /// No description provided for @profileLogoutConfirm.
  ///
  /// In es, this message translates to:
  /// **'¿Estás seguro de que deseas cerrar sesión?'**
  String get profileLogoutConfirm;

  /// No description provided for @profileSettings.
  ///
  /// In es, this message translates to:
  /// **'Configuración'**
  String get profileSettings;

  /// No description provided for @profileLanguage.
  ///
  /// In es, this message translates to:
  /// **'Idioma'**
  String get profileLanguage;

  /// No description provided for @profilePrivacy.
  ///
  /// In es, this message translates to:
  /// **'Privacidad'**
  String get profilePrivacy;

  /// No description provided for @profileTerms.
  ///
  /// In es, this message translates to:
  /// **'Términos y Condiciones'**
  String get profileTerms;

  /// No description provided for @profileAbout.
  ///
  /// In es, this message translates to:
  /// **'Acerca de'**
  String get profileAbout;

  /// No description provided for @profileVersion.
  ///
  /// In es, this message translates to:
  /// **'Versión {version}'**
  String profileVersion(Object version);

  /// No description provided for @profileFavorites.
  ///
  /// In es, this message translates to:
  /// **'Mis Favoritos'**
  String get profileFavorites;

  /// No description provided for @profileFavoritesDesc.
  ///
  /// In es, this message translates to:
  /// **'Lugares que has guardado'**
  String get profileFavoritesDesc;

  /// No description provided for @profileAccount.
  ///
  /// In es, this message translates to:
  /// **'Mi Cuenta'**
  String get profileAccount;

  /// No description provided for @profileAccountDesc.
  ///
  /// In es, this message translates to:
  /// **'Información personal'**
  String get profileAccountDesc;

  /// No description provided for @profileWelcome.
  ///
  /// In es, this message translates to:
  /// **'¡Bienvenido!'**
  String get profileWelcome;

  /// No description provided for @profileGuest.
  ///
  /// In es, this message translates to:
  /// **'Invitado'**
  String get profileGuest;

  /// No description provided for @profileLoginPrompt.
  ///
  /// In es, this message translates to:
  /// **'Inicia sesión para acceder a todas las funciones'**
  String get profileLoginPrompt;

  /// No description provided for @favoritesTitle.
  ///
  /// In es, this message translates to:
  /// **'Favoritos'**
  String get favoritesTitle;

  /// No description provided for @favoritesEmpty.
  ///
  /// In es, this message translates to:
  /// **'No tienes favoritos'**
  String get favoritesEmpty;

  /// No description provided for @favoritesEmptyDesc.
  ///
  /// In es, this message translates to:
  /// **'Los lugares que guardes aparecerán aquí'**
  String get favoritesEmptyDesc;

  /// No description provided for @favoritesRemove.
  ///
  /// In es, this message translates to:
  /// **'Eliminar de favoritos'**
  String get favoritesRemove;

  /// No description provided for @favoritesAdd.
  ///
  /// In es, this message translates to:
  /// **'Agregar a favoritos'**
  String get favoritesAdd;

  /// No description provided for @favoritesAdded.
  ///
  /// In es, this message translates to:
  /// **'Agregado a favoritos'**
  String get favoritesAdded;

  /// No description provided for @favoritesRemoved.
  ///
  /// In es, this message translates to:
  /// **'Eliminado de favoritos'**
  String get favoritesRemoved;

  /// No description provided for @favoritesExplore.
  ///
  /// In es, this message translates to:
  /// **'Explorar lugares'**
  String get favoritesExplore;

  /// No description provided for @favoritesCount.
  ///
  /// In es, this message translates to:
  /// **'{count, plural, =1{1 favorito} other{{count} favoritos}}'**
  String favoritesCount(num count);

  /// No description provided for @eventsTitle.
  ///
  /// In es, this message translates to:
  /// **'Eventos'**
  String get eventsTitle;

  /// No description provided for @eventsUpcoming.
  ///
  /// In es, this message translates to:
  /// **'Próximos Eventos'**
  String get eventsUpcoming;

  /// No description provided for @eventsToday.
  ///
  /// In es, this message translates to:
  /// **'Hoy'**
  String get eventsToday;

  /// No description provided for @eventsThisWeek.
  ///
  /// In es, this message translates to:
  /// **'Esta Semana'**
  String get eventsThisWeek;

  /// No description provided for @eventsThisMonth.
  ///
  /// In es, this message translates to:
  /// **'Este Mes'**
  String get eventsThisMonth;

  /// No description provided for @eventsNoEvents.
  ///
  /// In es, this message translates to:
  /// **'No hay eventos disponibles'**
  String get eventsNoEvents;

  /// No description provided for @eventsNoUpcoming.
  ///
  /// In es, this message translates to:
  /// **'No hay eventos próximos'**
  String get eventsNoUpcoming;

  /// No description provided for @eventsDetails.
  ///
  /// In es, this message translates to:
  /// **'Detalles del Evento'**
  String get eventsDetails;

  /// No description provided for @eventsDate.
  ///
  /// In es, this message translates to:
  /// **'Fecha del evento'**
  String get eventsDate;

  /// No description provided for @eventsTime.
  ///
  /// In es, this message translates to:
  /// **'Hora'**
  String get eventsTime;

  /// No description provided for @eventsLocation.
  ///
  /// In es, this message translates to:
  /// **'Lugar'**
  String get eventsLocation;

  /// No description provided for @eventsPrice.
  ///
  /// In es, this message translates to:
  /// **'Precio'**
  String get eventsPrice;

  /// No description provided for @eventsFree.
  ///
  /// In es, this message translates to:
  /// **'Gratis'**
  String get eventsFree;

  /// No description provided for @eventsInterested.
  ///
  /// In es, this message translates to:
  /// **'Me interesa'**
  String get eventsInterested;

  /// No description provided for @eventsGoing.
  ///
  /// In es, this message translates to:
  /// **'Asistiré'**
  String get eventsGoing;

  /// No description provided for @eventsShare.
  ///
  /// In es, this message translates to:
  /// **'Compartir evento'**
  String get eventsShare;

  /// No description provided for @eventsWelcomeTitle.
  ///
  /// In es, this message translates to:
  /// **'¡Descubre los mejores eventos!'**
  String get eventsWelcomeTitle;

  /// No description provided for @eventsWelcomeSubtitle.
  ///
  /// In es, this message translates to:
  /// **'No te pierdas los eventos más destacados de Cuba'**
  String get eventsWelcomeSubtitle;

  /// No description provided for @eventsWelcomeButton.
  ///
  /// In es, this message translates to:
  /// **'Ver Eventos'**
  String get eventsWelcomeButton;

  /// No description provided for @eventsSeeAll.
  ///
  /// In es, this message translates to:
  /// **'Ver todos'**
  String get eventsSeeAll;

  /// No description provided for @authSignIn.
  ///
  /// In es, this message translates to:
  /// **'Iniciar Sesión'**
  String get authSignIn;

  /// No description provided for @authSignUp.
  ///
  /// In es, this message translates to:
  /// **'Registrarse'**
  String get authSignUp;

  /// No description provided for @authEmail.
  ///
  /// In es, this message translates to:
  /// **'Correo electrónico'**
  String get authEmail;

  /// No description provided for @authPassword.
  ///
  /// In es, this message translates to:
  /// **'Contraseña'**
  String get authPassword;

  /// No description provided for @authConfirmPassword.
  ///
  /// In es, this message translates to:
  /// **'Confirmar contraseña'**
  String get authConfirmPassword;

  /// No description provided for @authForgotPassword.
  ///
  /// In es, this message translates to:
  /// **'¿Olvidaste tu contraseña?'**
  String get authForgotPassword;

  /// No description provided for @authWithGoogle.
  ///
  /// In es, this message translates to:
  /// **'Continuar con Google'**
  String get authWithGoogle;

  /// No description provided for @authWithApple.
  ///
  /// In es, this message translates to:
  /// **'Continuar con Apple'**
  String get authWithApple;

  /// No description provided for @authWithFacebook.
  ///
  /// In es, this message translates to:
  /// **'Continuar con Facebook'**
  String get authWithFacebook;

  /// No description provided for @authOr.
  ///
  /// In es, this message translates to:
  /// **'o'**
  String get authOr;

  /// No description provided for @authNoAccount.
  ///
  /// In es, this message translates to:
  /// **'¿No tienes cuenta?'**
  String get authNoAccount;

  /// No description provided for @authHaveAccount.
  ///
  /// In es, this message translates to:
  /// **'¿Ya tienes cuenta?'**
  String get authHaveAccount;

  /// No description provided for @authCreateAccount.
  ///
  /// In es, this message translates to:
  /// **'Crear cuenta'**
  String get authCreateAccount;

  /// No description provided for @authWelcomeBack.
  ///
  /// In es, this message translates to:
  /// **'¡Bienvenido de nuevo!'**
  String get authWelcomeBack;

  /// No description provided for @authWelcome.
  ///
  /// In es, this message translates to:
  /// **'¡Bienvenido!'**
  String get authWelcome;

  /// No description provided for @authLoginSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Inicia sesión para continuar'**
  String get authLoginSubtitle;

  /// No description provided for @authSignUpSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Crea tu cuenta para empezar'**
  String get authSignUpSubtitle;

  /// No description provided for @authName.
  ///
  /// In es, this message translates to:
  /// **'Nombre completo'**
  String get authName;

  /// No description provided for @authPhone.
  ///
  /// In es, this message translates to:
  /// **'Teléfono'**
  String get authPhone;

  /// No description provided for @authTermsAgree.
  ///
  /// In es, this message translates to:
  /// **'Al continuar, aceptas nuestros'**
  String get authTermsAgree;

  /// No description provided for @authTermsLink.
  ///
  /// In es, this message translates to:
  /// **'Términos y Condiciones'**
  String get authTermsLink;

  /// No description provided for @authPrivacyLink.
  ///
  /// In es, this message translates to:
  /// **'Política de Privacidad'**
  String get authPrivacyLink;

  /// No description provided for @authAnd.
  ///
  /// In es, this message translates to:
  /// **'y'**
  String get authAnd;

  /// No description provided for @authInvalidEmail.
  ///
  /// In es, this message translates to:
  /// **'Correo electrónico inválido'**
  String get authInvalidEmail;

  /// No description provided for @authInvalidPassword.
  ///
  /// In es, this message translates to:
  /// **'La contraseña debe tener al menos 6 caracteres'**
  String get authInvalidPassword;

  /// No description provided for @authPasswordMismatch.
  ///
  /// In es, this message translates to:
  /// **'Las contraseñas no coinciden'**
  String get authPasswordMismatch;

  /// No description provided for @authLoginSuccess.
  ///
  /// In es, this message translates to:
  /// **'¡Sesión iniciada!'**
  String get authLoginSuccess;

  /// No description provided for @authLogoutSuccess.
  ///
  /// In es, this message translates to:
  /// **'Sesión cerrada'**
  String get authLogoutSuccess;

  /// No description provided for @authLoginError.
  ///
  /// In es, this message translates to:
  /// **'Error al iniciar sesión'**
  String get authLoginError;

  /// No description provided for @authSignUpError.
  ///
  /// In es, this message translates to:
  /// **'Error al registrarse'**
  String get authSignUpError;

  /// No description provided for @authResetPassword.
  ///
  /// In es, this message translates to:
  /// **'Restablecer contraseña'**
  String get authResetPassword;

  /// No description provided for @authResetPasswordSent.
  ///
  /// In es, this message translates to:
  /// **'Se ha enviado un correo para restablecer tu contraseña'**
  String get authResetPasswordSent;

  /// No description provided for @authContinueAsGuest.
  ///
  /// In es, this message translates to:
  /// **'Continuar como invitado'**
  String get authContinueAsGuest;

  /// No description provided for @bookingTitle.
  ///
  /// In es, this message translates to:
  /// **'Reservar'**
  String get bookingTitle;

  /// No description provided for @bookingSelectDate.
  ///
  /// In es, this message translates to:
  /// **'Selecciona una fecha'**
  String get bookingSelectDate;

  /// No description provided for @bookingSelectTime.
  ///
  /// In es, this message translates to:
  /// **'Selecciona un horario'**
  String get bookingSelectTime;

  /// No description provided for @bookingSelectGuests.
  ///
  /// In es, this message translates to:
  /// **'Número de personas'**
  String get bookingSelectGuests;

  /// No description provided for @bookingStep1.
  ///
  /// In es, this message translates to:
  /// **'Fecha y Hora'**
  String get bookingStep1;

  /// No description provided for @bookingStep2.
  ///
  /// In es, this message translates to:
  /// **'Detalles'**
  String get bookingStep2;

  /// No description provided for @bookingStep3.
  ///
  /// In es, this message translates to:
  /// **'Confirmación'**
  String get bookingStep3;

  /// No description provided for @bookingConfirm.
  ///
  /// In es, this message translates to:
  /// **'Confirmar Reserva'**
  String get bookingConfirm;

  /// No description provided for @bookingModify.
  ///
  /// In es, this message translates to:
  /// **'Modificar'**
  String get bookingModify;

  /// No description provided for @bookingCancel.
  ///
  /// In es, this message translates to:
  /// **'Cancelar Reserva'**
  String get bookingCancel;

  /// No description provided for @bookingSpecialRequests.
  ///
  /// In es, this message translates to:
  /// **'Peticiones especiales'**
  String get bookingSpecialRequests;

  /// No description provided for @bookingContactInfo.
  ///
  /// In es, this message translates to:
  /// **'Información de contacto'**
  String get bookingContactInfo;

  /// No description provided for @bookingPayment.
  ///
  /// In es, this message translates to:
  /// **'Método de pago'**
  String get bookingPayment;

  /// No description provided for @bookingTotal.
  ///
  /// In es, this message translates to:
  /// **'Total'**
  String get bookingTotal;

  /// No description provided for @bookingFree.
  ///
  /// In es, this message translates to:
  /// **'Sin costo'**
  String get bookingFree;

  /// No description provided for @bookingDeposit.
  ///
  /// In es, this message translates to:
  /// **'Depósito requerido'**
  String get bookingDeposit;

  /// No description provided for @bookingPolicy.
  ///
  /// In es, this message translates to:
  /// **'Política de cancelación'**
  String get bookingPolicy;

  /// No description provided for @bookingPolicyText.
  ///
  /// In es, this message translates to:
  /// **'Cancelación gratuita hasta 24 horas antes'**
  String get bookingPolicyText;

  /// No description provided for @mapTitle.
  ///
  /// In es, this message translates to:
  /// **'Mapa'**
  String get mapTitle;

  /// No description provided for @mapShowList.
  ///
  /// In es, this message translates to:
  /// **'Ver lista'**
  String get mapShowList;

  /// No description provided for @mapShowMap.
  ///
  /// In es, this message translates to:
  /// **'Ver mapa'**
  String get mapShowMap;

  /// No description provided for @mapMyLocation.
  ///
  /// In es, this message translates to:
  /// **'Mi ubicación'**
  String get mapMyLocation;

  /// No description provided for @mapNearby.
  ///
  /// In es, this message translates to:
  /// **'Lugares cercanos'**
  String get mapNearby;

  /// No description provided for @mapFilter.
  ///
  /// In es, this message translates to:
  /// **'Filtrar'**
  String get mapFilter;

  /// No description provided for @mapNoPlacesNearby.
  ///
  /// In es, this message translates to:
  /// **'No hay lugares cerca'**
  String get mapNoPlacesNearby;

  /// No description provided for @filterTitle.
  ///
  /// In es, this message translates to:
  /// **'Filtros'**
  String get filterTitle;

  /// No description provided for @filterApply.
  ///
  /// In es, this message translates to:
  /// **'Aplicar Filtros'**
  String get filterApply;

  /// No description provided for @filterClear.
  ///
  /// In es, this message translates to:
  /// **'Limpiar'**
  String get filterClear;

  /// No description provided for @filterReset.
  ///
  /// In es, this message translates to:
  /// **'Restablecer'**
  String get filterReset;

  /// No description provided for @filterPrice.
  ///
  /// In es, this message translates to:
  /// **'Precio'**
  String get filterPrice;

  /// No description provided for @filterRating.
  ///
  /// In es, this message translates to:
  /// **'Calificación'**
  String get filterRating;

  /// No description provided for @filterDistance.
  ///
  /// In es, this message translates to:
  /// **'Distancia'**
  String get filterDistance;

  /// No description provided for @filterCategory.
  ///
  /// In es, this message translates to:
  /// **'Categoría'**
  String get filterCategory;

  /// No description provided for @filterOpenNow.
  ///
  /// In es, this message translates to:
  /// **'Abierto ahora'**
  String get filterOpenNow;

  /// No description provided for @filterSortBy.
  ///
  /// In es, this message translates to:
  /// **'Ordenar por'**
  String get filterSortBy;

  /// No description provided for @filterRelevance.
  ///
  /// In es, this message translates to:
  /// **'Relevancia'**
  String get filterRelevance;

  /// No description provided for @filterNearest.
  ///
  /// In es, this message translates to:
  /// **'Más cercano'**
  String get filterNearest;

  /// No description provided for @filterHighestRated.
  ///
  /// In es, this message translates to:
  /// **'Mejor valorado'**
  String get filterHighestRated;

  /// No description provided for @filterLowestPrice.
  ///
  /// In es, this message translates to:
  /// **'Menor precio'**
  String get filterLowestPrice;

  /// No description provided for @filterHighestPrice.
  ///
  /// In es, this message translates to:
  /// **'Mayor precio'**
  String get filterHighestPrice;

  /// No description provided for @commonCancel.
  ///
  /// In es, this message translates to:
  /// **'Cancelar'**
  String get commonCancel;

  /// No description provided for @commonConfirm.
  ///
  /// In es, this message translates to:
  /// **'Confirmar'**
  String get commonConfirm;

  /// No description provided for @commonSave.
  ///
  /// In es, this message translates to:
  /// **'Guardar'**
  String get commonSave;

  /// No description provided for @commonDelete.
  ///
  /// In es, this message translates to:
  /// **'Eliminar'**
  String get commonDelete;

  /// No description provided for @commonEdit.
  ///
  /// In es, this message translates to:
  /// **'Editar'**
  String get commonEdit;

  /// No description provided for @commonClose.
  ///
  /// In es, this message translates to:
  /// **'Cerrar'**
  String get commonClose;

  /// No description provided for @commonAll.
  ///
  /// In es, this message translates to:
  /// **'Todos'**
  String get commonAll;

  /// No description provided for @commonDone.
  ///
  /// In es, this message translates to:
  /// **'Listo'**
  String get commonDone;

  /// No description provided for @commonNext.
  ///
  /// In es, this message translates to:
  /// **'Siguiente'**
  String get commonNext;

  /// No description provided for @commonBack.
  ///
  /// In es, this message translates to:
  /// **'Atrás'**
  String get commonBack;

  /// No description provided for @commonYes.
  ///
  /// In es, this message translates to:
  /// **'Sí'**
  String get commonYes;

  /// No description provided for @commonNo.
  ///
  /// In es, this message translates to:
  /// **'No'**
  String get commonNo;

  /// No description provided for @commonOk.
  ///
  /// In es, this message translates to:
  /// **'OK'**
  String get commonOk;

  /// No description provided for @commonContinue.
  ///
  /// In es, this message translates to:
  /// **'Continuar'**
  String get commonContinue;

  /// No description provided for @commonSkip.
  ///
  /// In es, this message translates to:
  /// **'Omitir'**
  String get commonSkip;

  /// No description provided for @commonSeeMore.
  ///
  /// In es, this message translates to:
  /// **'Ver más'**
  String get commonSeeMore;

  /// No description provided for @commonSeeLess.
  ///
  /// In es, this message translates to:
  /// **'Ver menos'**
  String get commonSeeLess;

  /// No description provided for @commonShare.
  ///
  /// In es, this message translates to:
  /// **'Compartir'**
  String get commonShare;

  /// No description provided for @commonCopy.
  ///
  /// In es, this message translates to:
  /// **'Copiar'**
  String get commonCopy;

  /// No description provided for @commonCopied.
  ///
  /// In es, this message translates to:
  /// **'Copiado'**
  String get commonCopied;

  /// No description provided for @commonSend.
  ///
  /// In es, this message translates to:
  /// **'Enviar'**
  String get commonSend;

  /// No description provided for @commonSubmit.
  ///
  /// In es, this message translates to:
  /// **'Enviar'**
  String get commonSubmit;

  /// No description provided for @commonApply.
  ///
  /// In es, this message translates to:
  /// **'Aplicar'**
  String get commonApply;

  /// No description provided for @commonSelect.
  ///
  /// In es, this message translates to:
  /// **'Seleccionar'**
  String get commonSelect;

  /// No description provided for @commonSelected.
  ///
  /// In es, this message translates to:
  /// **'Seleccionado'**
  String get commonSelected;

  /// No description provided for @commonRequired.
  ///
  /// In es, this message translates to:
  /// **'Requerido'**
  String get commonRequired;

  /// No description provided for @commonOptional.
  ///
  /// In es, this message translates to:
  /// **'Opcional'**
  String get commonOptional;

  /// No description provided for @commonLoading.
  ///
  /// In es, this message translates to:
  /// **'Cargando...'**
  String get commonLoading;

  /// No description provided for @commonSuccess.
  ///
  /// In es, this message translates to:
  /// **'¡Éxito!'**
  String get commonSuccess;

  /// No description provided for @commonError.
  ///
  /// In es, this message translates to:
  /// **'Error'**
  String get commonError;

  /// No description provided for @commonWarning.
  ///
  /// In es, this message translates to:
  /// **'Advertencia'**
  String get commonWarning;

  /// No description provided for @commonInfo.
  ///
  /// In es, this message translates to:
  /// **'Información'**
  String get commonInfo;

  /// No description provided for @commonToday.
  ///
  /// In es, this message translates to:
  /// **'Hoy'**
  String get commonToday;

  /// No description provided for @commonTomorrow.
  ///
  /// In es, this message translates to:
  /// **'Mañana'**
  String get commonTomorrow;

  /// No description provided for @commonYesterday.
  ///
  /// In es, this message translates to:
  /// **'Ayer'**
  String get commonYesterday;

  /// No description provided for @timeMinutes.
  ///
  /// In es, this message translates to:
  /// **'{count, plural, =1{1 minuto} other{{count} minutos}}'**
  String timeMinutes(num count);

  /// No description provided for @timeHours.
  ///
  /// In es, this message translates to:
  /// **'{count, plural, =1{1 hora} other{{count} horas}}'**
  String timeHours(num count);

  /// No description provided for @timeDays.
  ///
  /// In es, this message translates to:
  /// **'{count, plural, =1{1 día} other{{count} días}}'**
  String timeDays(num count);

  /// No description provided for @timeAgo.
  ///
  /// In es, this message translates to:
  /// **'hace {time}'**
  String timeAgo(Object time);

  /// No description provided for @errorNetwork.
  ///
  /// In es, this message translates to:
  /// **'Sin conexión a internet'**
  String get errorNetwork;

  /// No description provided for @errorServer.
  ///
  /// In es, this message translates to:
  /// **'Error del servidor'**
  String get errorServer;

  /// No description provided for @errorUnknown.
  ///
  /// In es, this message translates to:
  /// **'Error desconocido'**
  String get errorUnknown;

  /// No description provided for @errorTimeout.
  ///
  /// In es, this message translates to:
  /// **'Tiempo de espera agotado'**
  String get errorTimeout;

  /// No description provided for @errorNotFound.
  ///
  /// In es, this message translates to:
  /// **'No encontrado'**
  String get errorNotFound;

  /// No description provided for @errorUnauthorized.
  ///
  /// In es, this message translates to:
  /// **'No autorizado'**
  String get errorUnauthorized;

  /// No description provided for @errorForbidden.
  ///
  /// In es, this message translates to:
  /// **'Acceso denegado'**
  String get errorForbidden;

  /// No description provided for @successSaved.
  ///
  /// In es, this message translates to:
  /// **'Guardado correctamente'**
  String get successSaved;

  /// No description provided for @successDeleted.
  ///
  /// In es, this message translates to:
  /// **'Eliminado correctamente'**
  String get successDeleted;

  /// No description provided for @successUpdated.
  ///
  /// In es, this message translates to:
  /// **'Actualizado correctamente'**
  String get successUpdated;

  /// No description provided for @successSent.
  ///
  /// In es, this message translates to:
  /// **'Enviado correctamente'**
  String get successSent;

  /// No description provided for @dialogCloseConfirm.
  ///
  /// In es, this message translates to:
  /// **'¿Estás seguro de que deseas cerrar?'**
  String get dialogCloseConfirm;

  /// No description provided for @dialogDeleteConfirm.
  ///
  /// In es, this message translates to:
  /// **'¿Estás seguro de que deseas eliminar?'**
  String get dialogDeleteConfirm;

  /// No description provided for @dialogUnsavedChanges.
  ///
  /// In es, this message translates to:
  /// **'Tienes cambios sin guardar'**
  String get dialogUnsavedChanges;

  /// No description provided for @dialogDiscard.
  ///
  /// In es, this message translates to:
  /// **'Descartar'**
  String get dialogDiscard;

  /// No description provided for @dialogKeepEditing.
  ///
  /// In es, this message translates to:
  /// **'Seguir editando'**
  String get dialogKeepEditing;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
