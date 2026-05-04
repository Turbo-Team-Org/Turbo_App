import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:animate_do/animate_do.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turbo/app/l10n/l10n.dart';
import 'package:turbo/app/routes/router/app_router.gr.dart';
import 'package:turbo/onboarding/data/onboarding_page_data.dart';
import 'package:turbo/onboarding/presentation/widgets/onboarding_page_indicator.dart';
import 'package:turbo/onboarding/presentation/widgets/onboarding_page_view.dart';

const String _onboardingCompletedKey = 'onboarding_completed';

@RoutePage()
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _buttonAnimationController;
  int _currentPage = 0;
  bool _showGetStarted = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _buttonAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    // Configurar la barra de estado para el onboarding
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _buttonAnimationController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
      _showGetStarted = page == OnboardingData.pages.length - 1;
    });

    if (_showGetStarted) {
      _buttonAnimationController.forward();
    } else {
      _buttonAnimationController.reverse();
    }

    HapticFeedback.selectionClick();
  }

  void _goToNextPage() {
    if (_currentPage < OnboardingData.pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutCubic,
      );
    }
  }

  void _goToPreviousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutCubic,
      );
    }
  }

  Future<void> _completeOnboarding() async {
    HapticFeedback.mediumImpact();

    // Guardar que el onboarding se completó
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingCompletedKey, true);

    if (mounted) {
      // Navegar a la pantalla de login
      context.router.replace(SignInRoute());
    }
  }

  Future<void> _skipOnboarding() async {
    HapticFeedback.lightImpact();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingCompletedKey, true);

    if (mounted) {
      context.router.replace(SignInRoute());
    }
  }

  /// Obtiene el título traducido para cada página
  String _getTitle(AppLocalizations l10n, int index) {
    switch (index) {
      case 0:
        return l10n.onboarding1Title;
      case 1:
        return l10n.onboarding2Title;
      case 2:
        return l10n.onboarding3Title;
      case 3:
        return l10n.onboarding4Title;
      default:
        return '';
    }
  }

  /// Obtiene el subtítulo traducido para cada página
  String _getSubtitle(AppLocalizations l10n, int index) {
    switch (index) {
      case 0:
        return l10n.onboarding1Subtitle;
      case 1:
        return l10n.onboarding2Subtitle;
      case 2:
        return l10n.onboarding3Subtitle;
      case 3:
        return l10n.onboarding4Subtitle;
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      body: Stack(
        children: [
          // PageView con las páginas del onboarding
          PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: OnboardingData.pages.length,
            itemBuilder: (context, index) {
              final pageData = OnboardingData.pages[index];
              return OnboardingPageView(
                data: pageData,
                title: _getTitle(l10n, index),
                subtitle: _getSubtitle(l10n, index),
                isActive: _currentPage == index,
              );
            },
          ),

          // Controles de navegación
          _buildNavigationControls(l10n),
        ],
      ),
    );
  }

  Widget _buildNavigationControls(AppLocalizations l10n) {
    return SafeArea(
      child: Column(
        children: [
          // Header con botón de Skip
          _buildHeader(l10n),

          const Spacer(),

          // Footer con indicadores y botones
          _buildFooter(l10n),
        ],
      ),
    );
  }

  Widget _buildHeader(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo o nombre de la app
          FadeInLeft(
            duration: const Duration(milliseconds: 600),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.local_fire_department_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  l10n.appName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),

          // Botón de Skip
          FadeInRight(
            duration: const Duration(milliseconds: 600),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: _showGetStarted ? 0.0 : 1.0,
              child: TextButton(
                onPressed: _showGetStarted ? null : _skipOnboarding,
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l10n.onboardingSkip,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 14,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
      child: Column(
        children: [
          // Indicadores de página
          OnboardingPageIndicator(
            currentPage: _currentPage,
            pageCount: OnboardingData.pages.length,
          ),

          const SizedBox(height: 40),

          // Botones de navegación
          _buildNavigationButtons(l10n),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons(AppLocalizations l10n) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.3),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            )),
            child: child,
          ),
        );
      },
      child: _showGetStarted
          ? _buildGetStartedButton(l10n)
          : _buildNextBackButtons(l10n),
    );
  }

  Widget _buildNextBackButtons(AppLocalizations l10n) {
    return Row(
      key: const ValueKey('next-back'),
      children: [
        // Botón Back
        AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: _currentPage > 0 ? 1.0 : 0.0,
          child: AnimatedScale(
            duration: const Duration(milliseconds: 200),
            scale: _currentPage > 0 ? 1.0 : 0.8,
            child: _buildCircularButton(
              icon: Icons.arrow_back_rounded,
              onPressed: _currentPage > 0 ? _goToPreviousPage : null,
            ),
          ),
        ),

        const Spacer(),

        // Botón Next
        _buildNextButton(l10n),
      ],
    );
  }

  Widget _buildCircularButton({
    required IconData icon,
    VoidCallback? onPressed,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(28),
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withValues(alpha: 0.2),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
        ),
      ),
    );
  }

  Widget _buildNextButton(AppLocalizations l10n) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: _goToNextPage,
        borderRadius: BorderRadius.circular(28),
        child: Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.onboardingNext,
                style: TextStyle(
                  color: OnboardingData.pages[_currentPage].gradientColors[0],
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.arrow_forward_rounded,
                color: OnboardingData.pages[_currentPage].gradientColors[0],
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGetStartedButton(AppLocalizations l10n) {
    return FadeInUp(
      key: const ValueKey('get-started'),
      duration: const Duration(milliseconds: 500),
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: _completeOnboarding,
            borderRadius: BorderRadius.circular(30),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 24,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    l10n.onboardingGetStarted,
                    style: TextStyle(
                      color: OnboardingData.pages.last.gradientColors[0],
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: OnboardingData.pages.last.gradientColors[0]
                          .withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.arrow_forward_rounded,
                      color: OnboardingData.pages.last.gradientColors[0],
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Verifica si el onboarding ya fue completado
Future<bool> isOnboardingCompleted() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool(_onboardingCompletedKey) ?? false;
}

/// Resetea el estado del onboarding (útil para testing)
Future<void> resetOnboarding() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove(_onboardingCompletedKey);
}
