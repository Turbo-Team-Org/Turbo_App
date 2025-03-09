import 'package:auto_route/auto_route.dart';
import 'package:turbo/app/routes/router/app_router.gr.dart';
import 'package:turbo/authentication/state_managament/auth_cubit/cubit/auth_cubit_cubit.dart';

class AuthGuard extends AutoRouteGuard {
  final AuthCubit authCubit;

  AuthGuard(this.authCubit);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    authCubit.stream.first.then((state) {
      switch (state) {
        case Authenticated():
          resolver.next();
          break;
        default:
          router.replace(SignInRoute());
          break;
      }
    });
  }
}
