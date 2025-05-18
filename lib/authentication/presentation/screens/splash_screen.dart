import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';
import 'package:turbo/app/routes/router/app_router.gr.dart';
import 'package:turbo/authentication/presentation/widgets/widgets.dart';
import 'package:turbo/authentication/state_management/auth_cubit/cubit/auth_cubit_cubit.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  bool _isNavigating = false;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Configurar animaciones
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();

    print("🔍 SplashScreen - initState - Iniciando");
    // Programamos la verificación para después de que se construya el widget
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAuthAndNavigate();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Método separado para verificar autenticación y navegar
  void _checkAuthAndNavigate() async {
    if (_isNavigating) return;
    _isNavigating = true;

    print(
      "🔍 SplashScreen - _checkAuthAndNavigate - Verificando autenticación",
    );

    // Verificación manual forzada (sin esperar cambios de estado)
    await Future.delayed(
      const Duration(seconds: 2),
    ); // Espera para mostrar la animación

    if (!mounted) return;

    final authState = context.read<AuthCubit>().state;
    print("🔍 SplashScreen - Estado actual: $authState");

    if (authState is Authenticated) {
      print("🔍 SplashScreen - Navegando a Home (autenticado)");
      context.router.replace(const BottomNavShellWidget());
    } else {
      print("🔍 SplashScreen - Verificando usuario con Firebase...");
      // Forzar verificación y esperar resultado
      await context.read<AuthCubit>().checkAuthStatus();

      if (!mounted) return;

      final newState = context.read<AuthCubit>().state;
      print(
        "🔍 SplashScreen - Nuevo estado después de verificación: $newState",
      );

      if (newState is Authenticated) {
        print("🔍 SplashScreen - Navegando a Home después de verificación");
        if (mounted) context.router.replace(const BottomNavShellWidget());
      } else {
        print("🔍 SplashScreen - Navegando a Login (no autenticado)");
        if (mounted) context.router.replace(SignInRoute());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF5F5F7), Colors.white],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              FadeIn(
                duration: const Duration(milliseconds: 1000),
                child: const LoginHeader(),
              ),
              const SizedBox(height: 40),
              SpinPerfect(
                infinite: true,
                duration: const Duration(milliseconds: 1500),
                spins: 2,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Color.fromARGB(255, 243, 33, 61),
                      strokeWidth: 3,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              FadeInUp(
                from: 30,
                delay: const Duration(milliseconds: 500),
                duration: const Duration(milliseconds: 1000),
                child: Text(
                  "Descubriendo Cuba",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade800,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              FadeInUp(
                from: 30,
                delay: const Duration(milliseconds: 700),
                duration: const Duration(milliseconds: 1000),
                child: Text(
                  "Los mejores lugares y servicios",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
              const Spacer(),
              FadeInUp(
                delay: const Duration(milliseconds: 1000),
                duration: const Duration(milliseconds: 800),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Text(
                    "© Turbo 2024",
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
