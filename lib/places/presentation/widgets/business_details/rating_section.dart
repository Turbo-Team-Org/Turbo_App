import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:animate_do/animate_do.dart';
import 'package:turbo/app/core/theme/text_styles.dart';

class RatingSection extends StatelessWidget {
  final Place place;

  const RatingSection({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      delay: const Duration(milliseconds: 200),
      duration: const Duration(milliseconds: 400),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.secondaryBlue.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.star_rate_rounded,
                  color: AppColors.secondaryBlue,
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'Calificaciones y Reseñas',
                style: AppTextStyles.titleMedium(
                  context,
                ).copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FadeIn(
                duration: const Duration(milliseconds: 500),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          place.rating.toStringAsFixed(1),
                          style: AppTextStyles.titleLarge(context).copyWith(
                            fontSize: 32.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondaryBlue,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'de 5',
                          style: AppTextStyles.bodyMedium(context).copyWith(
                            color: Theme.of(
                              context,
                            ).colorScheme.onBackground.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < place.rating.floor()
                              ? Icons.star_rounded
                              : index < place.rating
                              ? Icons.star_half_rounded
                              : Icons.star_outline_rounded,
                          color: AppColors.secondaryBlue,
                          size: 18,
                        );
                      }),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${place.reviews.length} reseñas',
                      style: AppTextStyles.bodyMedium(context).copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.onBackground.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  children: List.generate(5, (index) {
                    final ratingLevel = 5 - index;
                    final reviewsWithRating =
                        place.reviews
                            .where((r) => r.rating == ratingLevel)
                            .length;
                    final percentage =
                        place.reviews.isEmpty
                            ? 0.0
                            : reviewsWithRating / place.reviews.length;

                    return SlideInRight(
                      delay: Duration(milliseconds: 100 * index),
                      duration: const Duration(milliseconds: 500),
                      from: 50,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            Text(
                              '$ratingLevel',
                              style: AppTextStyles.bodySmall(context),
                            ),
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.star,
                              size: 14,
                              color: AppColors.secondaryBlue,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: LinearProgressIndicator(
                                  value: percentage,
                                  backgroundColor: Theme.of(
                                    context,
                                  ).colorScheme.onBackground.withOpacity(0.1),
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                        AppColors.secondaryBlue,
                                      ),
                                  minHeight: 8,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${(percentage * 100).toInt()}%',
                              style: AppTextStyles.bodySmall(context),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
