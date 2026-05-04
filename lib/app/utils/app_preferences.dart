import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static const String _authTokenKey = "auth_token";
  static const String _userIdKey = "user_id";
  static const String _userNameIdKey = "user_name";
  static const String _darkModeKey = "dark_mode";
  static const String _autoThemeKey = "auto_theme";

  static late SharedPreferences _preferences;

  // Inicializa las preferencias
  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  String? getUserId() {
    final userId = _preferences.getString(_userIdKey);
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
  Future<void> setUserId(String userId) async {
    await _preferences.setString(_userIdKey, userId);
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

  /// Obtiene el estado del modo oscuro
  bool isDarkMode() {
    return _preferences.getBool(_darkModeKey) ?? false;
  }

  /// Establece el estado del modo oscuro
  Future<void> setDarkMode(bool value) async {
    await _preferences.setBool(_darkModeKey, value);
  }

  /// Obtiene el estado del tema automático
  bool isAutoTheme() {
    return _preferences.getBool(_autoThemeKey) ?? true;
  }

  /// Establece el estado del tema automático
  Future<void> setAutoTheme(bool value) async {
    await _preferences.setBool(_autoThemeKey, value);
  }

  /// Determina si debe usar el modo oscuro basado en las preferencias y la hora
  bool shouldUseDarkMode() {
    // Si el tema automático está habilitado, comprueba la hora
    if (isAutoTheme()) {
      final now = DateTime.now();
      return now.hour >= 19 ||
          now.hour < 7; // Modo oscuro después de las 7pm y antes de las 7am
    }
    // Si no, usa la preferencia explícita
    return isDarkMode();
  }
}
