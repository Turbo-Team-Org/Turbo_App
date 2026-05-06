import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';
import 'package:turbo/app/routes/router/app_router.gr.dart';
import 'package:turbo/authentication/presentation/widgets/widgets.dart';
import 'package:turbo/authentication/state_management/auth_cubit/cubit/auth_cubit_cubit.dart';
import 'package:turbo/app/cache/presentation/cubit/sync_cubit.dart';
import 'package:turbo/boostrap.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  bool _isNavigating = false;
  bool _syncCompleted = false;
  bool _authChecked = false;
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

    print("SplashScreen - initState - Iniciando con cache");
    // Iniciar sincronización después de que se construya el widget
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startSyncAndAuth();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Inicia la sincronización de cache y verificación de autenticación
  void _startSyncAndAuth() {
    if (_isNavigating) return;

    print("SplashScreen - Iniciando sincronización de cache");

    // Iniciar sincronización de cache
    context.read<SyncCubit>().startSync();

    // Verificar autenticación en paralelo
    _checkAuthentication();
  }

  /// Verifica el estado de autenticación
  void _checkAuthentication() async {
    print("SplashScreen - Verificando autenticación");

    // Esperar un mínimo para mostrar animaciones
    await Future.delayed(const Duration(milliseconds: 1000));

    if (!mounted) return;

    await context.read<AuthCubit>().checkAuthStatus();
    _authChecked = true;

    // Verificar si podemos navegar
    _checkIfCanNavigate();
  }

  /// Verifica si tanto sync como auth están completos para navegar
  void _checkIfCanNavigate() {
    if (_syncCompleted && _authChecked && !_isNavigating) {
      _navigateToNextScreen();
    }
  }

  /// Navega a la siguiente pantalla basada en el estado de autenticación
  void _navigateToNextScreen() async {
    if (_isNavigating) return;
    _isNavigating = true;

    print("SplashScreen - Navegando a siguiente pantalla");

    // Esperar un poco más para mostrar la completación
    await Future.delayed(const Duration(milliseconds: 800));

    if (!mounted) return;

    final authState = context.read<AuthCubit>().state;
    print("SplashScreen - Estado de auth: $authState");

    if (authState is Authenticated) {
      print("SplashScreen - Navegando a Home (autenticado)");
      context.router.replace(const BottomNavShellWidget());
    } else {
      print("SplashScreen - Navegando a Login (no autenticado)");
      context.router.replace(SignInRoute());
    }
  }

  /// Maneja errores de sincronización
  void _handleSyncError(String message) {
    print("SplashScreen - Error de sincronización: $message");

    // En caso de error, aún verificar si podemos continuar
    _syncCompleted = true;
    _checkIfCanNavigate();
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
          child: BlocListener<SyncCubit, SyncState>(
            listener: (context, syncState) {
              switch (syncState) {
                case SyncCompleted():
                  print("SplashScreen - Sincronización completada");
                  _syncCompleted = true;
                  _checkIfCanNavigate();
                  break;
                case SyncError():
                  _handleSyncError(syncState.message);
                  break;
                default:
                  break;
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                FadeIn(
                  duration: const Duration(milliseconds: 1000),
                  child: const LoginHeader(),
                ),
                const SizedBox(height: 40),
                _buildSyncIndicator(),
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
                      fontFamily: 'Roboto',
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                _buildSyncMessage(),
                const Spacer(),
                FadeInUp(
                  delay: const Duration(milliseconds: 1000),
                  duration: const Duration(milliseconds: 800),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: Text(
                      "© Turbo 2024",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Construye el indicador de sincronización con progreso
  Widget _buildSyncIndicator() {
    return BlocBuilder<SyncCubit, SyncState>(
      builder: (context, state) {
        return SpinPerfect(
          infinite: state is SyncSyncing,
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
            child: Center(child: _buildProgressIndicator(state)),
          ),
        );
      },
    );
  }

  /// Construye el indicador de progreso específico por estado
  Widget _buildProgressIndicator(SyncState state) {
    switch (state) {
      case SyncInitial():
        return const CircularProgressIndicator(
          color: Color.fromARGB(255, 243, 33, 61),
          strokeWidth: 3,
        );
      case SyncSyncing():
        return Stack(
          alignment: Alignment.center,
          children: [
            CircularProgressIndicator(
              value: state.progress,
              color: const Color.fromARGB(255, 243, 33, 61),
              strokeWidth: 3,
              backgroundColor: Colors.grey.shade300,
            ),
            Text(
              '${(state.progress * 100).toInt()}%',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        );
      case SyncCompleted():
        return Icon(Icons.check_circle, color: Colors.green.shade600, size: 40);
      case SyncError():
        return Icon(Icons.error, color: Colors.red.shade600, size: 40);
    }
  }

  /// Construye el mensaje de sincronización
  Widget _buildSyncMessage() {
    return BlocBuilder<SyncCubit, SyncState>(
      builder: (context, state) {
        String message = "Los mejores lugares y servicios";
        Color color = Colors.grey.shade600;

        switch (state) {
          case SyncInitial():
            message = "Los mejores lugares y servicios";
            color = Colors.grey.shade600;
            break;
          case SyncSyncing():
            message = state.message;
            color = const Color.fromARGB(255, 243, 33, 61);
            break;
          case SyncCompleted():
            message = "¡Todo listo! Preparando experiencia...";
            color = Colors.green;
            break;
          case SyncError():
            message = "Sin conexión - Usando datos locales";
            color = Colors.orange;
            break;
        }

        return FadeInUp(
          from: 30,
          delay: const Duration(milliseconds: 700),
          duration: const Duration(milliseconds: 1000),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Text(
              message,
              key: ValueKey(message),
              style: TextStyle(
                fontSize: 16,
                color: color,
                letterSpacing: 0.3,
                fontWeight:
                    state is SyncCompleted
                        ? FontWeight.w500
                        : FontWeight.normal,
                fontFamily: 'Roboto',
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}
