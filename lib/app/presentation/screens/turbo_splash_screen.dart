import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:turbo/app/cache/presentation/cubit/sync_cubit.dart';
import 'package:turbo/app/core/theme/turbo_design_system.dart';
import 'package:turbo/app/routes/router/app_router.gr.dart';

@RoutePage()
class TurboSplashScreen extends StatefulWidget {
  const TurboSplashScreen({super.key});

  @override
  State<TurboSplashScreen> createState() => _TurboSplashScreenState();
}

class _TurboSplashScreenState extends State<TurboSplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _progressController;

  late Animation<double> _fadeAnimation;
  late Animation<double> _progressFadeAnimation;

  bool _logoAnimationComplete = false;
  bool _shouldNavigate = false;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _startAnimations();

    // Iniciar sync después de un breve delay
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        context.read<SyncCubit>().startSync();
      }
    });
  }

  void _setupAnimations() {
    // Controlador para fade in general
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // Controlador para progress
    _progressController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    // Animaciones
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeIn));

    _progressFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeIn),
    );
  }

  void _startAnimations() {
    _fadeController.forward().then((_) {
      setState(() {
        _logoAnimationComplete = true;
      });

      Future.delayed(const Duration(milliseconds: 400), () {
        if (mounted) {
          _progressController.forward();
        }
      });
    });
  }

  void _navigateToMain() {
    if (_shouldNavigate) return;
    _shouldNavigate = true;

    context.router.replace(const BottomNavShellWidget());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SyncCubit, SyncState>(
        listener: (context, state) {
          if (state is SyncCompleted && _logoAnimationComplete) {
            Future.delayed(const Duration(milliseconds: 1000), () {
              if (mounted) _navigateToMain();
            });
          } else if (state is SyncError && _logoAnimationComplete) {
            Future.delayed(const Duration(milliseconds: 1500), () {
              if (mounted) _navigateToMain();
            });
          }
        },
        child: Container(
          decoration: const BoxDecoration(
            color: TurboDesignSystem.primary, // Rojo sólido como ROCKY
          ),
          child: SafeArea(
            child: AnimatedBuilder(
              animation: _fadeAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: _fadeAnimation.value,
                  child: Column(
                    children: [
                      // Spacer superior grande
                      const Expanded(flex: 5, child: SizedBox()),

                      // Logo SVG "TURBO" en blanco - estilo ROCKY
                      SizedBox(
                        width: 200,
                        height: 50,
                        child: SvgPicture.asset(
                          'assets/images/Turbo Marca 7.svg',
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                          fit: BoxFit.contain,
                        ),
                      ),

                      // Spacer medio grande
                      const Expanded(flex: 3, child: SizedBox()),

                      // Descripción simple como ROCKY
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          'Turbo es una aplicación móvil que conecta a los usuarios con los mejores lugares, eventos y servicios de Cuba.',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withOpacity(0.85),
                            height: 1.4,
                            letterSpacing: 0.2,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      // Spacer inferior
                      const Expanded(flex: 2, child: SizedBox()),

                      // Progress bar minimalista como ROCKY
                      _buildCleanProgressBar(),

                      const SizedBox(height: 40),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCleanProgressBar() {
    return BlocBuilder<SyncCubit, SyncState>(
      builder: (context, state) {
        return AnimatedBuilder(
          animation: _progressFadeAnimation,
          builder: (context, child) {
            return Opacity(
              opacity: _progressFadeAnimation.value,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: Column(
                  children: [
                    // Progress bar estilo ROCKY - línea simple
                    Container(
                      height: 3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Colors.white.withOpacity(0.3),
                      ),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          double progress = 0.0;
                          if (state is SyncSyncing) {
                            progress = state.progress;
                          } else if (state is SyncCompleted) {
                            progress = 1.0;
                          }

                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: constraints.maxWidth * progress,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Status message minimalista
                    Text(
                      _getCleanStatusMessage(state),
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Colors.white.withOpacity(0.8),
                        letterSpacing: 0.3,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  String _getCleanStatusMessage(SyncState state) {
    switch (state.runtimeType) {
      case SyncInitial:
        return 'Iniciando...';
      case SyncSyncing:
        return 'Cargando contenido...';
      case SyncCompleted:
        return '¡Listo!';
      case SyncError:
        return 'Modo offline';
      default:
        return 'Preparando...';
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _progressController.dispose();
    super.dispose();
  }
}
