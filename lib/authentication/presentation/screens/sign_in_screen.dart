import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:turbo/app/l10n/l10n.dart';
import 'package:turbo/app/routes/router/app_router.gr.dart';
import 'package:turbo_ui/turbo_ui.dart';
import 'package:turbo/authentication/presentation/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turbo/authentication/state_management/sign_in_cubit/cubit/sign_in_cubit.dart';

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
              builder: (_) => ErrorDialog(title: context.l10n.commonError, message: error),
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
                label: context.l10n.authEmail,
                textInputType: TextInputType.emailAddress,
                textController: email,
                hint: context.l10n.authEmail,
              ),
              const SizedBox(height: 12),
              CustomTextfield(
                label: context.l10n.authPassword,
                textInputType: TextInputType.visiblePassword,
                textController: password,
                hint: context.l10n.authPassword,
                //obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: TurboColors.primary,
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
                child: Text(
                  context.l10n.authSignIn,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(context.l10n.authOr, style: Theme.of(context).textTheme.titleMedium),
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
                label: Text(
                  context.l10n.authWithGoogle,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    context.l10n.authNoAccount,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  TextButton(
                    onPressed: () => context.replaceRoute(SignUpRoute()),
                    child: Text(context.l10n.authSignUp, style: Theme.of(context).textTheme.bodyMedium),
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
