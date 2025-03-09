import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static const String _authTokenKey = "auth_token";
  static const String _userIdKey = "user_id";
  static const String _userNameIdKey = "user_name";

  static late SharedPreferences _preferences;

  // Inicializa las preferencias
  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  int? getUserId() {
    final userId = _preferences.getInt(_userIdKey);
    return userId;
  }

  String? getUserName() {
    final result = _preferences.getString(_userNameIdKey);
    return result ?? '';
  }

  Future<void> setUserName(String userName) async {
    await _preferences.setString(_userNameIdKey, userName);
  }

  // Guarda el ID del usuario autenticado
  Future<void> setUserId(int userId) async {
    await _preferences.setInt(_userIdKey, userId);
  }

  // Limpia el ID del usuario
  Future<void> clearUserId() async {
    await _preferences.remove(_userIdKey);
  }

  /// Guarda el token de autenticación
  Future<void> setAuthToken(String token) async {
    await _preferences.setString(_authTokenKey, token);
  }

  /// Obtiene el token de autenticación
  String? getAuthToken() {
    return _preferences.getString(_authTokenKey);
  }

  /// Limpia el token de autenticación
  Future<void> clearAuthToken() async {
    await _preferences.remove(_authTokenKey);
  }

  /// Comprueba si el usuario está autenticado
  bool isAuthenticated() {
    final token = getAuthToken();
    return token != null && token.isNotEmpty;
  }
}
