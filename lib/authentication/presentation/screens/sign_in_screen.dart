import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:turbo/app/routes/router/app_router.gr.dart';
import 'package:turbo/app/utils/theme/style.dart';
import 'package:turbo/authentication/presentation/widgets/widgets.dart';
import '../../../app/utils/global/global_vars.dart';

@RoutePage()
class SignInScreen extends StatelessWidget {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const LoginHeader(),
            const SizedBox(height: 20),
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
            const SizedBox(height: 20),
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Styles.turboRed),
              ),
              onPressed: () {
                context.router.navigate(const FeedRoute());
              },
              child: const Text(
                'Sign In',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(noaccount, style: Styles.textTitleMedium),
            TextButton(
              onPressed: () {
                context.router.navigate(SignUpRoute());
              },
              child: const Text('Sign Up', style: Styles.textBodyMedium),
            ),
          ],
        ),
      ),
    );
  }
}
