import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import '../models/location_data.dart';
import '../interface/location_repository_interface.dart';

class LocationService implements LocationRepositoryInterface {
  final _locationController = StreamController<LocationData>.broadcast();

  LocationService() {
    // Inicializar el servicio
    _checkPermission();
  }

  Future<void> _checkPermission() async {
    final hasPermission = await checkLocationPermission();
    if (hasPermission) {
      // Si ya tenemos permiso, obtener la ubicación inicial
      try {
        final position = await getCurrentLocation();
        _locationController.add(position);
      } catch (e) {
        // Ignorar errores de ubicación inicial
      }
    }
  }

  @override
  Future<LocationData> getCurrentLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      return LocationData(
        latitude: position.latitude,
        longitude: position.longitude,
        accuracy: position.accuracy,
        altitude: position.altitude,
        speed: position.speed,
        heading: position.heading,
        timestamp: position.timestamp,
      );
    } catch (e) {
      throw Exception('Error al obtener la ubicación: $e');
    }
  }

  @override
  Future<bool> requestLocationPermission() async {
    // Primero verificamos el estado actual
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      // Si está denegado, solicitamos permiso
      permission = await Geolocator.requestPermission();
    }

    // Solicitar permiso de ubicación usando el paquete permission_handler también
    // para mejor compatibilidad con iOS
    final status = await Permission.location.request();

    // Retornamos true si tenemos algún tipo de permiso
    return permission != LocationPermission.denied &&
        permission != LocationPermission.deniedForever &&
        (status.isGranted || status.isLimited);
  }

  @override
  Future<bool> checkLocationPermission() async {
    try {
      // Verificar si los servicios de ubicación están habilitados
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return false;
      }

      // Verificar el estado del permiso
      LocationPermission permission = await Geolocator.checkPermission();

      // Verificar también con permission_handler
      final status = await Permission.location.status;

      return (permission == LocationPermission.whileInUse ||
              permission == LocationPermission.always) &&
          (status.isGranted || status.isLimited);
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> startLocationTracking() async {
    // Verificar que tenemos permiso
    final hasPermission = await checkLocationPermission();
    if (!hasPermission) {
      throw Exception('No se tienen permisos para rastrear la ubicación');
    }

    // Iniciar la suscripción a las actualizaciones de ubicación
    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10, // actualiza cada 10 metros de movimiento
      ),
    ).listen((Position position) {
      // Convertir a nuestro modelo y emitir al stream
      final locationData = LocationData(
        latitude: position.latitude,
        longitude: position.longitude,
        accuracy: position.accuracy,
        altitude: position.altitude,
        speed: position.speed,
        heading: position.heading,
        timestamp: position.timestamp,
      );

      _locationController.add(locationData);
    });
  }

  @override
  Future<void> stopLocationTracking() async {
    // No necesitamos hacer nada específico para detener el rastreo
    // ya que el sistema de Flutter/Dart se encargará de limpiar los listeners
    // al destruir la instancia
  }

  @override
  Stream<LocationData> get locationStream => _locationController.stream;

  // Limpieza de recursos
  void dispose() {
    _locationController.close();
  }
}
