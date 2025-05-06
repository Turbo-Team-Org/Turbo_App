import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:turbo/app/routes/router/app_router.gr.dart';
import 'package:turbo/app/utils/theme/style.dart';
import 'package:turbo/authentication/presentation/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turbo/authentication/state_managament/sign_in_cubit/cubit/sign_in_cubit.dart';

import '../../../app/view/widgets/global_widgets.dart';

@RoutePage()
class SignInScreen extends StatelessWidget {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInCubit, SignInState>(
      listener: (context, signinstate) {
        switch (signinstate) {
          case Success():
            {
              context.router.navigate(const FeedRoute());
            }

            break;

          case Error(:final error):
            showDialog(
              context: context,
              builder: (_) => ErrorDialog(title: "¡Error!", message: error),
            );
            break;

          case Loading():
            {
              CircularProgressIndicator.adaptive();
            }
          default:
            break;
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const LoginHeader(),
              const SizedBox(height: 30),
              CustomTextfield(
                label: 'Correo',
                textInputType: TextInputType.emailAddress,
                textController: email,
                hint: 'Escriba su correo',
              ),
              const SizedBox(height: 12),
              CustomTextfield(
                label: 'Contraseña',
                textInputType: TextInputType.visiblePassword,
                textController: password,
                hint: 'Escriba su contraseña',
                //obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Styles.turboRed,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  context.read<SignInCubit>().signInWithEmail(
                    email.text,
                    password.text,
                  );
                },
                child: const Text(
                  'Inicia Sesión',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text('O continua con', style: Styles.textTitleMedium),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  context.read<SignInCubit>().signInWithGoogle();
                },
                icon: Image.asset('assets/images/google_logo.png', height: 24),
                label: const Text(
                  'Inicia Sesión con Google',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "No tienes una cuenta ?",
                    style: Styles.textBodyMedium,
                  ),
                  TextButton(
                    onPressed: () => context.replaceRoute(SignUpRoute()),
                    child: const Text('Sign Up', style: Styles.textBodyMedium),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
