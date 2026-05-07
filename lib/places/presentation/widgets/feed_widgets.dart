export 'bottom_nav_bar.dart';
export 'place_card_widget.dart';
export '../../../categories/presentation/widgets/categories_section.dart';
export 'profile_avatar_widget.dart';
export '../../../categories/presentation/widgets/category_tabs.dart';
export 'search_bar.dart';
export 'glass_circle_avatar.dart';
export 'glass_card.dart';
export 'offer_dialog.dart';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:turbo/app/core/theme/text_styles.dart';

/// Conjunto de widgets reutilizables para la sección de Feed

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {
        'name': 'Restaurantes',
        'icon': Icons.restaurant,
        'color': const Color(0xFFF44336),
      },
      {
        'name': 'Hoteles',
        'icon': Icons.hotel,
        'color': const Color(0xFF2196F3),
      },
      {
        'name': 'Bares',
        'icon': Icons.local_bar,
        'color': const Color(0xFF4CAF50),
      },
      {
        'name': 'Playas',
        'icon': Icons.beach_access,
        'color': const Color(0xFFFF9800),
      },
      {
        'name': 'Museos',
        'icon': Icons.museum,
        'color': const Color(0xFF9C27B0),
      },
      {'name': 'Tours', 'icon': Icons.tour, 'color': const Color(0xFF009688)},
    ];

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return FadeInUp(
          delay: Duration(milliseconds: 100 * index),
          duration: const Duration(milliseconds: 500),
          child: _buildCategoryItem(
            context,
            category['name'] as String,
            category['icon'] as IconData,
            category['color'] as Color,
          ),
        );
      },
    );
  }

  Widget _buildCategoryItem(
    BuildContext context,
    String name,
    IconData icon,
    Color color,
  ) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(15),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: AppTextStyles.bodyMedium(
                context,
              ).copyWith(fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
