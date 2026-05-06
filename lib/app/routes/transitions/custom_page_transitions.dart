import 'package:flutter/material.dart';

/// Una transición personalizada para abrir la pantalla de detalles del lugar
/// con un efecto de expansión y zoom moderno.
class DetailPageTransition extends PageRouteBuilder {
  final Widget page;
  final Rect? originRect;

  DetailPageTransition({required this.page, this.originRect})
    : super(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionDuration: const Duration(milliseconds: 800),
        reverseTransitionDuration: const Duration(milliseconds: 600),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // Definimos varias animaciones para combinar
          var fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: animation,
              curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
            ),
          );

          var scaleAnimation = Tween<double>(
            begin: originRect != null ? 0.8 : 0.9,
            end: 1.0,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: const Interval(0.0, 0.9, curve: Curves.easeOutCubic),
            ),
          );

          // Combinamos las animaciones para un efecto complejo
          return FadeTransition(
            opacity: fadeAnimation,
            child: ScaleTransition(scale: scaleAnimation, child: child),
          );
        },
      );
}

/// Transición para salir de la pantalla de detalles con un efecto de desvanecimiento y contracción
class DetailPageReverseTransition extends PageRouteBuilder {
  final Widget page;

  DetailPageReverseTransition({required this.page})
    : super(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionDuration: const Duration(milliseconds: 600),
        reverseTransitionDuration: const Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // Animación de escalado y desvanecimiento
          return FadeTransition(
            opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOut),
            ),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.1),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
              ),
              child: child,
            ),
          );
        },
      );
}
