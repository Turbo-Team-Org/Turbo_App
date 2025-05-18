import 'package:flutter/material.dart';

class CategoryContent extends StatelessWidget {
  final String name;
  final int placesCount;

  const CategoryContent({
    super.key,
    required this.name,
    required this.placesCount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (placesCount > 0) ...[
            const SizedBox(height: 4),
            Text(
              '$placesCount lugares',
              style: const TextStyle(color: Colors.white70),
            ),
          ],
        ],
      ),
    );
  }
}
