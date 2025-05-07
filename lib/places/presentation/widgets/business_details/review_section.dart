import 'package:flutter/material.dart';
import 'package:turbo/app/core/theme/text_styles.dart';
import 'package:turbo/places/place_repository/models/place/place.dart';
import 'package:animate_do/animate_do.dart';
import 'package:turbo/places/presentation/widgets/business_details/review_card.dart';
import 'package:turbo/places/presentation/widgets/business_details/add_review_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turbo/reviews/state_management/cubit/review_cubit.dart';
import 'package:turbo/reviews/review_repository/models/review.dart';

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
    // Cargar las reseñas del lugar al iniciar
    context.read<ReviewCubit>().getReviewsFromAPlace(widget.place.id);
  }

  void _showAddReviewDialog() {
    showDialog(
      context: context,
      builder: (context) => AddReviewDialog(placeId: widget.place.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewCubit, ReviewState>(
      builder: (context, state) {
        switch (state) {
          case ReviewState.initial:
            return _buildReviewSection(widget.place.reviews);
          case ReviewState.loading:
            return const Center(child: CircularProgressIndicator.adaptive());
          case ReviewLoaded():
            final reviews = state.reviews;
            return _buildReviewSection(reviews);
          case ReviewError():
            final message = state.message;
            return _errorReviewWidget(message: message);
          default:
            return _buildReviewSection(widget.place.reviews);
        }
      },
    );
  }

  Widget _buildReviewSection(List<Review> reviews) {
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
              if (reviews.isNotEmpty)
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
                    'No hay reseñas aún',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                  ),
                ],
              ),
            )
          else
            ...reviews.map(
              (review) => FadeInLeft(
                delay: Duration(milliseconds: 100 * reviews.indexOf(review)),
                duration: const Duration(milliseconds: 400),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: ReviewCard(review: review),
                ),
              ),
            ),
          const SizedBox(height: 16),
          Center(
            child: TextButton.icon(
              onPressed: _showAddReviewDialog,
              icon: const Icon(Icons.add_comment_outlined),
              label: const Text('Escribir una reseña'),
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

Widget _errorReviewWidget({required String message}) {
  return Center(child: Column(children: [Text(message)]));
}
