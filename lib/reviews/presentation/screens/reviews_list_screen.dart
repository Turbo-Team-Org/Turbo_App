import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/core.dart';
import 'package:turbo/app/l10n/l10n.dart';
import 'package:turbo/authentication/state_management/auth_cubit/cubit/auth_cubit_cubit.dart';
import 'package:turbo/reviews/state_management/cubit/review_cubit.dart';
import 'package:turbo/app/routes/router/app_router.gr.dart';

import '../widgets/review_card.dart';

@RoutePage()
class ReviewsListScreen extends StatefulWidget {
  const ReviewsListScreen({
    super.key,
    required this.placeId,
    this.placeName,
  });

  final String placeId;
  final String? placeName;

  @override
  State<ReviewsListScreen> createState() => _ReviewsListScreenState();
}

class _ReviewsListScreenState extends State<ReviewsListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<ReviewCubit>().getReviewsFromAPlace(widget.placeId);
    });
  }

  Future<void> _confirmDelete(Review review) async {
    final l10n = context.l10n;
    final ok = await showDialog<bool>(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: Text(l10n.reviewsDeleteConfirmTitle),
            content: Text(l10n.reviewsDeleteConfirmMessage),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: Text(l10n.reviewsCancel),
              ),
              FilledButton(
                onPressed: () => Navigator.of(ctx).pop(true),
                child: Text(l10n.reviewsDelete),
              ),
            ],
          ),
    );
    if (ok == true && mounted) {
      await context.read<ReviewCubit>().deleteReview(review.id, widget.placeId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final title = widget.placeName ?? l10n.reviewsTitle;

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.router.push(
            AddReviewRoute(placeId: widget.placeId, placeName: widget.placeName),
          );
        },
        icon: const Icon(Icons.rate_review_outlined),
        label: Text(l10n.reviewsWriteReview),
      ),
      body: BlocBuilder<ReviewCubit, ReviewState>(
        builder: (context, state) {
          return switch (state) {
            ReviewInitial() => const Center(child: SizedBox.shrink()),
            ReviewLoading() => const Center(child: CircularProgressIndicator.adaptive()),
            ReviewLoaded(:final reviews) => _buildList(context, reviews),
            ReviewError(:final message) => _ErrorBody(
              message: message,
              onRetry:
                  () => context.read<ReviewCubit>().getReviewsFromAPlace(
                    widget.placeId,
                  ),
            ),
          };
        },
      ),
    );
  }

  Widget _buildList(BuildContext context, List<Review> reviews) {
    final l10n = context.l10n;
    final auth = context.watch<AuthCubit>().state;
    final uid = auth is Authenticated ? auth.user.uid : null;

    if (reviews.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.rate_review_outlined, size: 56, color: Colors.grey.shade400),
              const SizedBox(height: 16),
              Text(
                l10n.reviewsEmpty,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade700, fontSize: 16),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        final review = reviews[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: ReviewCard(
            review: review,
            currentUserId: uid,
            onEdit:
                uid != null && review.userId == uid
                    ? () {
                      context.router.push(
                        AddReviewRoute(
                          placeId: widget.placeId,
                          placeName: widget.placeName,
                          editingReviewId: review.id,
                        ),
                      );
                    }
                    : null,
            onDelete:
                uid != null && review.userId == uid
                    ? () => _confirmDelete(review)
                    : null,
          ),
        );
      },
    );
  }
}

class _ErrorBody extends StatelessWidget {
  const _ErrorBody({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: Colors.red.shade300),
            const SizedBox(height: 12),
            Text(
              l10n.reviewsLoadError,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: Text(l10n.retry),
            ),
          ],
        ),
      ),
    );
  }
}
