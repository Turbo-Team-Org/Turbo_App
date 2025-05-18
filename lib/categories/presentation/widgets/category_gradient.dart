import 'package:flutter/material.dart';

class CategoryGradient extends StatelessWidget {
  const CategoryGradient({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            Colors.black.withAlpha(179), // 0.7 * 255 ≈ 179
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}
