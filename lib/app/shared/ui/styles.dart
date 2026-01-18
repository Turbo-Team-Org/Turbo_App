import 'package:flutter/material.dart';

/// Clase de estilos para la aplicación
class AppStyles {
  static const double hzScreenPadding = 18;

  // Estilos de texto base
  static final TextStyle baseTitle = TextStyle(
    fontSize: 11,
    fontFamily: 'DMSerifDisplay',
  );

  static final TextStyle baseBody = TextStyle(
    fontSize: 11,
    fontFamily: 'OpenSans',
  );

  // Estilos para encabezados de la aplicación
  static final TextStyle appHeader = baseTitle.copyWith(
    color: Color(0xFF0e0e0e),
    fontSize: 36,
    height: 1,
  );

  // Estilos para tarjetas
  static final TextStyle cardTitle = baseTitle.copyWith(
    height: 1,
    color: Color(0xFF1a1a1a),
    fontSize: 25,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle cardSubtitle = baseBody.copyWith(
    color: Color(0xFF666666),
    height: 1.5,
    fontSize: 12,
  );

  static final TextStyle cardAction = baseBody.copyWith(
    color: Color(0xFFa6998b),
    fontSize: 10,
    height: 1,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
  );

  // Estilos para lugares
  static final TextStyle placeTitle = baseBody.copyWith(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle placeDescription = baseBody.copyWith(
    color: Color(0xff4d4d4d),
    fontSize: 13,
  );

  static final TextStyle placeRating = baseBody.copyWith(
    color: Color(0xff0e0e0e),
    fontSize: 14,
  );

  static final TextStyle placeLocation = baseBody.copyWith(
    color: Colors.grey[700],
    fontSize: 12,
  );
}
