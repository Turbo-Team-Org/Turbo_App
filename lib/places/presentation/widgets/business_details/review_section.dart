import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:turbo/app/core/theme/text_styles.dart';
import 'package:turbo/app/l10n/l10n.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turbo/reviews/presentation/widgets/review_card.dart';
import 'package:turbo/reviews/presentation/widgets/reviews_summary_widget.dart';
import 'package:turbo/reviews/state_management/cubit/review_cubit.dart';
import 'package:turbo/app/routes/router/app_router.gr.dart';

class ReviewSection extends StatefulWidget {
  final Place place;

  const ReviewSection({super.key, required this.place});

  @override
  State<ReviewSection> createState() => _ReviewSectionState();
}

class _ReviewSectionState extends State<ReviewSection> {
  @override
  void initState() {
    super.initState();
    context.read<ReviewCubit>().getReviewsFromAPlace(widget.place.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewCubit, ReviewState>(
      builder: (context, state) {
        return switch (state) {
          ReviewInitial() => const Center(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: CircularProgressIndicator.adaptive(),
            ),
          ),
          ReviewLoading() => const Center(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: CircularProgressIndicator.adaptive(),
            ),
          ),
          ReviewLoaded(:final reviews) => _buildSection(context, reviews),
          ReviewError(:final message) => _errorBlock(context, message),
        };
      },
    );
  }

  Widget _errorBlock(BuildContext context, String message) {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Text(l10n.reviewsLoadError, style: AppTextStyles.titleSmall(context)),
          const SizedBox(height: 8),
          Text(message, textAlign: TextAlign.center),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed:
                () => context.read<ReviewCubit>().getReviewsFromAPlace(
                  widget.place.id,
                ),
            icon: const Icon(Icons.refresh),
            label: Text(l10n.retry),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, List<Review> reviews) {
    final l10n = context.l10n;
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
                      ).colorScheme.primary.withValues(alpha: 0.1),
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
                    l10n.reviewsSectionTitle,
                    style: AppTextStyles.titleMedium(
                      context,
                    ).copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              if (reviews.isNotEmpty)
                TextButton(
                  onPressed:
                      () => context.router.push(
                        ReviewsListRoute(
                          placeId: widget.place.id,
                          placeName: widget.place.name,
                        ),
                      ),
                  child: Text(
                    l10n.reviewsSeeAll,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          ReviewsSummaryWidget(
            reviews: reviews,
            fallbackRating: widget.place.rating,
          ),
          const SizedBox(height: 16),
          if (reviews.isEmpty)
            Center(
              child: Column(
                children: [
                  Icon(
                    Icons.rate_review_outlined,
                    size: 48,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l10n.reviewsEmpty,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                  ),
                ],
              ),
            )
          else
            ...List.generate(
              reviews.length > 3 ? 3 : reviews.length,
              (i) {
                final review = reviews[i];
                return FadeInLeft(
                  delay: Duration(milliseconds: 100 * i),
                  duration: const Duration(milliseconds: 400),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: ReviewCard(review: review),
                  ),
                );
              },
            ),
          const SizedBox(height: 8),
          Center(
            child: TextButton.icon(
              onPressed:
                  () => context.router.push(
                    AddReviewRoute(
                      placeId: widget.place.id,
                      placeName: widget.place.name,
                    ),
                  ),
              icon: const Icon(Icons.add_comment_outlined),
              label: Text(l10n.reviewsWriteReview),
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.5),
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
