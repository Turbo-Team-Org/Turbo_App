import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

@RoutePage()
class SignUpScreen extends StatelessWidget {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController name = TextEditingController();
  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Column(
          children: [],
        )),
        body: SignUpBody(email: email, password: password, name: name));
  }
}
