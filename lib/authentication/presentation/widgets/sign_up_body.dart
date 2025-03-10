// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turbo/app/routes/router/app_router.gr.dart';
import 'package:turbo/app/utils/global/global_vars.dart';
import 'package:turbo/authentication/authentication_repository/models/auth_user.dart';
import 'package:turbo/authentication/state_managament/sign_up_cubit/cubit/sign_up_cubit.dart';

import '../../../app/utils/theme/style.dart';
import 'widgets.dart';

class SignUpBody extends StatelessWidget {
  const SignUpBody({
    super.key,
    required this.email,
    required this.password,
    required this.name,
  });

  final TextEditingController email;
  final TextEditingController password;
  final TextEditingController name;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        switch (state) {
          case Loading():
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const Center(child: CircularProgressIndicator()),
            );
            break;

          case Success():
            Navigator.of(context, rootNavigator: true).pop();
            context.replaceRoute(SignInRoute());

            break;

          case Error(:final error):
            Navigator.of(context, rootNavigator: true).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(error!), backgroundColor: Colors.red),
            );
            break;
          default:
            break;
        }
      },

      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const LoginHeader(),
            const SizedBox(height: 15),
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.white),
              ),
              onPressed: () {},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/images/google.jpeg', height: 20),
                  const SizedBox(width: 10),
                  const Text(googleSignInText, style: Styles.textTitleMedium),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Text('Or', style: Styles.textTitleMedium),
            const SizedBox(height: 10),
            const Padding(padding: EdgeInsets.all(4), child: Divider()),
            const SizedBox(height: 10),
            CustomTextfield(
              label: emailText,
              textInputType: TextInputType.text,
              textController: email,
              hint: emailHintFormText,
            ),
            const SizedBox(height: 10),
            CustomTextfield(
              label: passwordText,
              textInputType: TextInputType.visiblePassword,
              textController: password,
              hint: passwordHintText,
            ),
            const SizedBox(height: 10),
            CustomTextfield(
              label: nameText,
              textInputType: TextInputType.text,
              textController: name,
              hint: nameHintText,
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Styles.turboRed,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                final signUpCubit = context.read<SignUpCubit>();
                final String emailText = email.text.trim();
                final String passwordText = password.text.trim();

                if (emailText.isNotEmpty && passwordText.isNotEmpty) {
                  signUpCubit.signUpWithEmail(
                    emailText,
                    passwordText,
                    name.text,
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Email and password cannot be empty"),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const Text(
                'Sign Up',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(account, style: Styles.textTitleMedium),
            TextButton(
              onPressed: () {
                context.router.navigate(SignInRoute());
              },
              child: const Text('Login', style: Styles.textBodyMedium),
            ),
          ],
        ),
      ),
    );
  }
}
