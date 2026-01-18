import 'package:flutter/material.dart';

/// Modelo de datos para cada página del onboarding
class OnboardingPageData {
  final String titleKey;
  final String subtitleKey;
  final IconData icon;
  final List<Color> gradientColors;
  final String? lottieAsset;
  final IconData decorativeIcon;

  const OnboardingPageData({
    required this.titleKey,
    required this.subtitleKey,
    required this.icon,
    required this.gradientColors,
    this.lottieAsset,
    required this.decorativeIcon,
  });
}

/// Datos de las páginas del onboarding
class OnboardingData {
  static const List<OnboardingPageData> pages = [
    OnboardingPageData(
      titleKey: 'onboarding1Title',
      subtitleKey: 'onboarding1Subtitle',
      icon: Icons.explore_rounded,
      decorativeIcon: Icons.restaurant_rounded,
      gradientColors: [Color(0xFF667EEA), Color(0xFF764BA2)],
    ),
    OnboardingPageData(
      titleKey: 'onboarding2Title',
      subtitleKey: 'onboarding2Subtitle',
      icon: Icons.calendar_month_rounded,
      decorativeIcon: Icons.event_seat_rounded,
      gradientColors: [Color(0xFFE53935), Color(0xFFFF7043)],
    ),
    OnboardingPageData(
      titleKey: 'onboarding3Title',
      subtitleKey: 'onboarding3Subtitle',
      icon: Icons.celebration_rounded,
      decorativeIcon: Icons.music_note_rounded,
      gradientColors: [Color(0xFF11998E), Color(0xFF38EF7D)],
    ),
    OnboardingPageData(
      titleKey: 'onboarding4Title',
      subtitleKey: 'onboarding4Subtitle',
      icon: Icons.favorite_rounded,
      decorativeIcon: Icons.bookmark_rounded,
      gradientColors: [Color(0xFFFF416C), Color(0xFFFF4B2B)],
    ),
  ];
}
