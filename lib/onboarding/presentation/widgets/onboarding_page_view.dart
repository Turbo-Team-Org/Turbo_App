import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:turbo/onboarding/data/onboarding_page_data.dart';

/// Vista individual de una página del onboarding
class OnboardingPageView extends StatelessWidget {
  final OnboardingPageData data;
  final String title;
  final String subtitle;
  final bool isActive;

  const OnboardingPageView({
    super.key,
    required this.data,
    required this.title,
    required this.subtitle,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: data.gradientColors,
        ),
      ),
      child: SafeArea(
        child: Stack(
          children: [
            // Elementos decorativos de fondo
            _buildBackgroundDecorations(size),

            // Contenido principal
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  const Spacer(flex: 2),

                  // Icono principal con animación
                  _buildMainIcon(),

                  const SizedBox(height: 48),

                  // Título
                  _buildTitle(),

                  const SizedBox(height: 20),

                  // Subtítulo
                  _buildSubtitle(),

                  const Spacer(flex: 3),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundDecorations(Size size) {
    return Stack(
      children: [
        // Círculo superior izquierdo
        Positioned(
          top: -size.width * 0.3,
          left: -size.width * 0.3,
          child: Container(
            width: size.width * 0.8,
            height: size.width * 0.8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.05),
            ),
          ),
        ),

        // Círculo inferior derecho
        Positioned(
          bottom: -size.width * 0.4,
          right: -size.width * 0.3,
          child: Container(
            width: size.width * 0.9,
            height: size.width * 0.9,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.03),
            ),
          ),
        ),

        // Icono decorativo flotante superior
        Positioned(
          top: size.height * 0.12,
          right: 40,
          child: FadeInDown(
            delay: const Duration(milliseconds: 300),
            child: _buildFloatingIcon(Icons.star_rounded, 24),
          ),
        ),

        // Icono decorativo flotante izquierdo
        Positioned(
          top: size.height * 0.25,
          left: 30,
          child: FadeInLeft(
            delay: const Duration(milliseconds: 500),
            child: _buildFloatingIcon(data.decorativeIcon, 28),
          ),
        ),

        // Icono decorativo flotante derecho
        Positioned(
          top: size.height * 0.38,
          right: 50,
          child: FadeInRight(
            delay: const Duration(milliseconds: 700),
            child: _buildFloatingIcon(Icons.location_on_rounded, 20),
          ),
        ),

        // Patrón de puntos
        Positioned(
          bottom: size.height * 0.3,
          left: 20,
          child: FadeIn(
            delay: const Duration(milliseconds: 400),
            child: _buildDotPattern(),
          ),
        ),
      ],
    );
  }

  Widget _buildFloatingIcon(IconData icon, double size) {
    return Container(
      padding: EdgeInsets.all(size * 0.5),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Icon(
        icon,
        color: Colors.white.withValues(alpha: 0.6),
        size: size,
      ),
    );
  }

  Widget _buildDotPattern() {
    return Column(
      children: List.generate(
        3,
        (row) => Row(
          children: List.generate(
            3,
            (col) => Container(
              margin: const EdgeInsets.all(4),
              width: 4,
              height: 4,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.2),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMainIcon() {
    return FadeInUp(
      duration: const Duration(milliseconds: 600),
      child: Container(
        width: 160,
        height: 160,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withValues(alpha: 0.15),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.3),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 30,
              offset: const Offset(0, 15),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Anillo exterior animado
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
            ),
            // Icono principal
            Icon(
              data.icon,
              size: 72,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return FadeInUp(
      delay: const Duration(milliseconds: 200),
      duration: const Duration(milliseconds: 600),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: -0.5,
          height: 1.2,
        ),
      ),
    );
  }

  Widget _buildSubtitle() {
    return FadeInUp(
      delay: const Duration(milliseconds: 400),
      duration: const Duration(milliseconds: 600),
      child: Text(
        subtitle,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 17,
          color: Colors.white.withValues(alpha: 0.9),
          height: 1.5,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}
