import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'category_image.dart';

class CategoryItem extends StatelessWidget {
  final Category category;

  const CategoryItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navegar a la pantalla de lugares filtrados por categoría
        // Navigator.of(context).pushNamed('/places/category/${category.id}');
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(26), // 0.1 * 255 ≈ 26
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              CategoryItemImage(
                imageUrl: category.imageUrl,
                primaryColor: Theme.of(context).primaryColor,
              ),
              const CategoryItemGradient(),
              CategoryItemContent(
                name: category.name,
                description: category.description,
                placesCount: category.placesCount,
              ),
              if (category.isFeatured) const CategoryItemFeaturedBadge(),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryItemImage extends StatelessWidget {
  final String? imageUrl;
  final Color primaryColor;

  const CategoryItemImage({
    super.key,
    this.imageUrl,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null) {
      return CachedNetworkImage(
        imageUrl: imageUrl!,
        fit: BoxFit.cover,
        placeholder: (context, url) => const ImagePlaceholder(),
        errorWidget: (context, url, error) => const ImageError(),
      );
    }
    return Container(
      color: primaryColor.withAlpha(77), // 0.3 * 255 ≈ 77
      child: Icon(Icons.category, size: 48, color: primaryColor),
    );
  }
}

class CategoryItemGradient extends StatelessWidget {
  const CategoryItemGradient({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Color.fromARGB(179, 0, 0, 0), // 0.7 * 255 ≈ 179
          ],
        ),
      ),
    );
  }
}

class CategoryItemContent extends StatelessWidget {
  final String name;
  final String? description;
  final int placesCount;

  const CategoryItemContent({
    super.key,
    required this.name,
    this.description,
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
          if (description != null) ...[
            const SizedBox(height: 4),
            Text(
              description!,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.place, color: Colors.white70, size: 14),
              const SizedBox(width: 4),
              Text(
                '$placesCount lugares',
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CategoryItemFeaturedBadge extends StatelessWidget {
  const CategoryItemFeaturedBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 8,
      right: 8,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Text(
          'Destacado',
          style: TextStyle(
            color: Color.fromARGB(221, 0, 0, 0), // 0.87 * 255 ≈ 221
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
