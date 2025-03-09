import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turbo/app/routes/router/app_router.gr.dart';
import 'package:turbo/authentication/presentation/widgets/widgets.dart';
import 'package:turbo/authentication/state_managament/auth_cubit/cubit/auth_cubit_cubit.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    //  context.read<AuthCubitCubit>().isAuthenticated();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthCubitState>(
      listener: (context, state) {
        switch (state) {
          case AuthCubitState.initial:
            // Acción para el estado "initial"
            break;
          case AuthCubitState.authenticated:
            context.router.replace(const FeedRoute());
            break;
          case AuthCubitState.unauthenticated:
            context.router.replace(SignInRoute());
            break;
          default:
            // Acción predeterminada si es necesario
            break;
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        body: const Column(children: [Center(child: LoginHeader())]),
      ),
    );
  }
}
