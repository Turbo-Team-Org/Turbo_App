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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LoginHeader(),
          SizedBox(height: 10),
          BlocListener<AuthCubit, AuthCubitState>(
            listener: (context, state) {
              Future.delayed(Duration(seconds: 1), () {
                switch (state) {
                  case Initial():
                    Center(child: CircularProgressIndicator.adaptive());
                    break;
                  case Authenticated():
                    context.router.replace(BottomNavShellWidget());

                  default:
                    break;
                }
              });
            },
            child: SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
