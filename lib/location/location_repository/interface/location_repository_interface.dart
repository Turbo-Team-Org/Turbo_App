import '../models/location_data.dart';

abstract class LocationRepositoryInterface {
  /// Obtiene la ubicación actual del usuario
  Future<LocationData> getCurrentLocation();

  /// Solicita permisos de localización
  Future<bool> requestLocationPermission();

  /// Verifica si los permisos de localización están concedidos
  Future<bool> checkLocationPermission();

  /// Inicia el seguimiento de ubicación en segundo plano
  Future<void> startLocationTracking();

  /// Detiene el seguimiento de ubicación en segundo plano
  Future<void> stopLocationTracking();

  /// Stream que emite actualizaciones de ubicación
  Stream<LocationData> get locationStream;
}
