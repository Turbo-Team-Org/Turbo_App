import 'package:flutter/material.dart';

import 'feed_widgets.dart';

class CategoriesSection extends StatelessWidget {
  final List<String> categories = [
    "Mountains",
    "Forest",
    "Ocean",
    "Desert",
    "Mountains",
    "Forest",
    "Ocean",
    "Desert",
    "Mountains",
    "Forest",
    "Ocean",
  ];

  final List<IconData> icons = [
    Icons.terrain,
    Icons.forest,
    Icons.waves,
    Icons.landscape,
    Icons.terrain,
    Icons.forest,
    Icons.waves,
    Icons.landscape,
    Icons.terrain,
    Icons.forest,
    Icons.waves,
  ];

  CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      blur: 100.0,
      opacity: 0.1,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Otras categorías de servicios",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Column(
                      children: [
                        GlassCircleAvatar(
                          child: Icon(icons[index], color: Colors.white),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          categories[index],
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
