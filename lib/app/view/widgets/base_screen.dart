import 'package:flutter/material.dart';
import 'package:turbo/app/view/widgets/bottom_nav_shield.dart';

class BaseScreen extends StatelessWidget {
  final Widget body;
  final String title;

  const BaseScreen({super.key, required this.body, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      bottomNavigationBar: const BottomNavShellWidget(),
      body: body,
    );
  }
}
