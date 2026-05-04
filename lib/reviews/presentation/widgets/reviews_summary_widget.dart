import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:turbo/app/l10n/l10n.dart';

import 'star_rating_widget.dart';

/// Shows average rating and review count for a place.
class ReviewsSummaryWidget extends StatelessWidget {
  const ReviewsSummaryWidget({
    super.key,
    required this.reviews,
    this.fallbackRating,
  });

  final List<Review> reviews;
  final double? fallbackRating;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final hasReviews = reviews.isNotEmpty;
    final average = hasReviews
        ? reviews.fold<double>(0, (a, r) => a + r.rating) / reviews.length
        : (fallbackRating ?? 0);

    final rounded = (average * 10).roundToDouble() / 10;
    final starDisplay = average <= 0 ? 0 : average.round().clamp(1, 5);

    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(
        alpha: 0.5,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.reviewsAverageLabel,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  average > 0 ? rounded.toStringAsFixed(1) : '—',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  StarRatingWidget(
                    value: starDisplay,
                    iconSize: 22,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    l10n.reviewsCount(hasReviews ? reviews.length : 0),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
