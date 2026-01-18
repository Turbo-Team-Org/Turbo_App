import 'dart:ui';

import 'package:flutter/material.dart';

class GlassCircleAvatar extends StatelessWidget {
  final Widget child;

  const GlassCircleAvatar({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 1.0,
            ),
          ),
          child: Center(child: child),
        ),
      ),
    );
  }
}
