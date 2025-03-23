import 'package:flutter/material.dart';
import 'package:turbo/app/core/theme/text_styles.dart';
import 'package:turbo/places/place_repository/models/place/place.dart';
import 'package:animate_do/animate_do.dart';
import 'dart:math';
import 'package:turbo/places/presentation/widgets/business_details/review_card.dart';

class ReviewSection extends StatelessWidget {
  final Place place;

  const ReviewSection({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    if (place.reviews.isEmpty) {
      return const SizedBox();
    }

    return FadeInUp(
      delay: const Duration(milliseconds: 300),
      duration: const Duration(milliseconds: 400),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.rate_review_rounded,
                      color: Theme.of(context).colorScheme.primary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Reseñas de Clientes',
                    style: AppTextStyles.titleMedium(
                      context,
                    ).copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Ver todas',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...List.generate(
            min(3, place.reviews.length),
            (index) => FadeInLeft(
              delay: Duration(milliseconds: 100 * index),
              duration: const Duration(milliseconds: 400),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: ReviewCard(review: place.reviews[index]),
              ),
            ),
          ),
          Center(
            child: TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add_comment_outlined),
              label: const Text('Escribir una reseña'),
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withOpacity(0.5),
                    width: 1,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
