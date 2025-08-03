import 'package:auto_route/auto_route.dart';
import 'package:turbo/app/routes/router/app_router.gr.dart';
import 'package:turbo/authentication/state_management/auth_cubit/cubit/auth_cubit_cubit.dart';

class AuthGuard extends AutoRouteGuard {
  final AuthCubit authCubit;

  AuthGuard(this.authCubit);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    print("🔐 AuthGuard - onNavigation - Verificando estado de autenticación");

    // Verificar el estado actual primero
    final currentState = authCubit.state;
    print("🔐 AuthGuard - Estado actual: $currentState");

    if (currentState is Authenticated) {
      print(
        "🔐 AuthGuard - Usuario ya autenticado, permitiendo navegación inmediata",
      );
      resolver.next();
      return;
    }

    if (currentState is Unauthenticated) {
      print(
        "🔐 AuthGuard - Usuario no autenticado, redirigiendo a login inmediatamente",
      );
      router.replace(SignInRoute());
      return;
    }

    // Solo esperar por el stream si el estado es Initial
    print(
      "🔐 AuthGuard - Estado inicial, esperando cambio de estado de autenticación...",
    );
    authCubit.stream.first.then((state) {
      print("🔐 AuthGuard - Nuevo estado recibido: $state");

      switch (state) {
        case Authenticated():
          print("🔐 AuthGuard - Usuario autenticado, permitiendo navegación");
          resolver.next();
          break;
        default:
          print("🔐 AuthGuard - Usuario no autenticado, redirigiendo a login");
          router.replace(SignInRoute());
          break;
      }
    });
  }
}
