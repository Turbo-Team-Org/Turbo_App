import 'dart:convert'; // Para decodificar payloads JSON
import 'dart:io' show Platform;

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/foundation.dart'; // Para kIsWeb
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'; // Para guardar token

// --- Manejador de mensajes en segundo plano (Nivel superior) ---
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Asegurarse que Firebase esté inicializado si se usa aquí
  await Firebase.initializeApp(); // Considera pasar options si es necesario
  print("Handling a background message: ${message.messageId}");
  // Aquí podrías hacer trabajo adicional, como mostrar una notificación local
  // si las automáticas de FCM no son suficientes o si quieres personalización.
  // NotificationService.showLocalNotification(message); // Ejemplo
}
// -----------------------------------------------------------

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final FirebaseFirestore _firestore; // Inyectar Firestore

  // Canal de notificación para Android (debe coincidir con main.dart y AndroidManifest)
  final AndroidNotificationChannel _androidChannel =
      const AndroidNotificationChannel(
        'high_importance_channel',
        'High Importance Notifications',
        description: 'Este canal se usa para notificaciones importantes.',
        importance: Importance.max, // Usar max para heads-up notifications
        playSound: true,
      );

  NotificationService({required FirebaseFirestore firestore})
    : _firestore = firestore;

  Future<void> initialize() async {
    print("Inicializando NotificationService..."); // Debug
    // --- 1. Inicializar Local Notifications ---
    await _initializeLocalNotifications();

    // --- 2. Configurar Manejadores de Mensajes FCM ---
    // Mensaje recibido mientras la app está en SEGUNDO PLANO/TERMINADA y el usuario TOCA la notificación
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);

    // Mensaje recibido mientras la app está en PRIMER PLANO
    FirebaseMessaging.onMessage.listen(_handleMessageInForeground);

    // Registrar manejador de mensajes en SEGUNDO PLANO (definido arriba)
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // --- 3. Obtener Token FCM Inicial (Opcional aquí, mejor después del login) ---
    // Podrías obtenerlo aquí, pero usualmente querrás el UID del usuario
    // final token = await getFcmToken();
    // print("FCM Token inicial: $token");

    print("NotificationService inicializado."); // Debug
  }

  // --- Configuración Inicial ---

  Future<void> _initializeLocalNotifications() async {
    // Crear canal Android
    await _localNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(_androidChannel);

    // Settings Android
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings(
          '@mipmap/ic_launcher',
        ); // Reemplaza con tu icono

    // Settings iOS
    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
          requestAlertPermission:
              false, // Solicitar permisos explícitamente más tarde
          requestBadgePermission: false,
          requestSoundPermission: false,
        );
    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _localNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
    );
  }

  // --- Solicitud de Permisos ---

  Future<bool> requestPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false, // Pide permiso definitivo, no provisional
      sound: true,
    );

    print(
      'Permisos de notificación otorgados: ${settings.authorizationStatus}',
    ); // Debug

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      return true;
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      // El usuario aceptó notificaciones provisionales (iOS)
      return true;
    } else {
      // El usuario denegó o no ha decidido
      // Podrías mostrar un diálogo explicando por qué necesitas permisos
      return false;
    }
  }

  // --- Obtención y Gestión de Tokens ---

  Future<String?> getFcmToken() async {
    try {
      // Para web, necesitas la vapidKey de la configuración de Firebase
      String? token = await _firebaseMessaging.getToken(
        // vapidKey: kIsWeb ? "TU_VAPID_KEY_DE_FIREBASE_MESSAGING" : null,
      );
      print("FCM Token: $token"); // Debug
      return token;
    } catch (e) {
      print("Error obteniendo FCM token: $e");
      return null;
    }
  }

  // Guardar token en Firestore asociado al usuario
  Future<void> saveTokenToDatabase(String userId) async {
    final token = await getFcmToken();
    if (token != null && userId.isNotEmpty) {
      try {
        final userRef = _firestore.collection('users').doc(userId);
        // Usar arrayUnion para añadir el token sin duplicar si ya existe
        await userRef.set(
          {
            'fcmTokens': FieldValue.arrayUnion([token]),
          },
          SetOptions(merge: true), // Merge para no sobrescribir otros campos
        );
        print("Token guardado para usuario $userId"); // Debug
      } catch (e) {
        print("Error guardando token en Firestore: $e");
      }
    }
  }

  // Eliminar token (por ejemplo, al cerrar sesión)
  Future<void> removeTokenFromDatabase(String userId, String? token) async {
    if (token != null && userId.isNotEmpty) {
      try {
        final userRef = _firestore.collection('users').doc(userId);
        await userRef.update({
          'fcmTokens': FieldValue.arrayRemove([token]),
        });
        print("Token eliminado para usuario $userId"); // Debug
        // Opcionalmente, invalidar el token actual para que no reciba más mensajes
        // await _firebaseMessaging.deleteToken();
      } catch (e) {
        print("Error eliminando token de Firestore: $e");
      }
    }
  }

  // --- Manejo de Mensajes Recibidos ---

  void _handleMessageOpenedApp(RemoteMessage message) {
    print(
      'Mensaje TOCADO (App abierta desde notificación): ${message.messageId}',
    );
    print('Data: ${message.data}');
    // TODO: Implementar navegación basada en message.data
    // Ejemplo: Si data contiene {'screen': 'placeDetails', 'placeId': 'xyz'}
    // Navegar a la pantalla de detalles del lugar con ID 'xyz'
    _handleNotificationNavigation(message.data);
  }

  void _handleMessageInForeground(RemoteMessage message) {
    print('Mensaje recibido en PRIMER PLANO: ${message.messageId}');
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    // Si el mensaje contiene una notificación y es Android, mostrarla manualmente
    // con flutter_local_notifications para que aparezca como heads-up.
    // FCM automáticamente muestra notificaciones en background/terminated.
    if (notification != null && !kIsWeb) {
      // No mostrar local si es web
      _showLocalNotification(notification, message.data);
    }
  }

  // Mostrar notificación local usando flutter_local_notifications
  Future<void> _showLocalNotification(
    RemoteNotification notification,
    Map<String, dynamic> payload,
  ) async {
    // Lógica para Android
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      _androidChannel.id,
      _androidChannel.name,
      channelDescription: _androidChannel.description,
      icon: '@mipmap/ic_launcher', // Usa el mismo icono que en initialize
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      // Puedes añadir más personalizaciones aquí
    );

    // Lógica para iOS
    DarwinNotificationDetails iOSDetails = const DarwinNotificationDetails(
      presentAlert: true, // Mostrar alerta
      presentBadge: true, // Actualizar badge
      presentSound: true, // Reproducir sonido
    );

    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidDetails,
      iOS: iOSDetails,
    );

    // Usar hashCode como ID de notificación (o generar uno único)
    await _localNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      platformChannelSpecifics,
      payload: jsonEncode(payload), // Codificar payload para pasarlo
    );
  }

  // --- Manejo de Interacciones con Notificaciones Locales ---

  // Callback para iOS < 10
  void _onDidReceiveLocalNotification(
    int id,
    String? title,
    String? body,
    String? payload,
  ) async {
    print('Recibida notificación local (iOS < 10): $title');
    // Mostrar un diálogo o manejar la data del payload si es necesario
    if (payload != null) {
      _handleNotificationNavigation(jsonDecode(payload));
    }
  }

  // Callback para Android e iOS >= 10 cuando se toca la notificación local
  void _onDidReceiveNotificationResponse(
    NotificationResponse notificationResponse,
  ) async {
    final String? payload = notificationResponse.payload;
    print('Notificación local TOCADA. Payload: $payload');
    if (payload != null) {
      try {
        _handleNotificationNavigation(jsonDecode(payload));
      } catch (e) {
        print("Error decodificando payload: $e");
      }
    }
    // Aquí puedes añadir lógica para marcar la notificación como leída si es necesario
  }

  // --- Lógica de Navegación (Centralizada) ---
  void _handleNotificationNavigation(Map<String, dynamic> data) {
    print("Intentando navegar con data: $data");
    // Extraer información relevante del payload (data)
    final String? screen =
        data['screen']; // Ejemplo: 'placeDetails', 'eventDetails'
    final String? id = data['id']; // Ejemplo: placeId, eventId

    // TODO: Implementar la lógica de navegación real usando AutoRoute u otro
    // Ejemplo simple:
    if (screen != null && id != null) {
      print("Navegando a pantalla: $screen con ID: $id");
      // if (screen == 'placeDetails') {
      //   // Asumiendo que tienes acceso al router global o a un navigatorKey
      //   // navigatorKey.currentState?.pushNamed('/business-details', arguments: id);
      //   // O con AutoRoute:
      //   // appRouter.push(BusinessDetailsRoute(id: id));
      // } else if (screen == 'eventDetails') {
      //    // appRouter.push(EventDetailsRoute(id: id));
      // }
    } else {
      print("Datos insuficientes en el payload para la navegación.");
    }
  }
}
