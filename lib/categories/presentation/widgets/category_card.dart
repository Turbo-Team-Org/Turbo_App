import 'package:flutter/material.dart';
import 'package:turbo/categories/presentation/widgets/categories_widgets.dart';
import 'package:core/core.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  final VoidCallback onTap;

  const CategoryCard({super.key, required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red.shade400, Colors.red.shade600],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(51),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          children: [
            if (category.imageUrl != null)
              CategoryImage(imageUrl: category.imageUrl!),
            const CategoryGradient(),
            CategoryContent(
              name: category.name,
              placesCount: category.placesCount,
            ),
            if (category.isFeatured) const FeaturedBadge(),
          ],
        ),
      ),
    );
  }
}
