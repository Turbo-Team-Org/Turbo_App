import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turbo/app/l10n/l10n.dart';
import 'package:turbo/authentication/state_management/auth_cubit/cubit/auth_cubit_cubit.dart';
import 'package:turbo/boostrap.dart';
import 'package:turbo/reviews/presentation/widgets/review_card.dart';
import 'package:turbo/users/module/get_user_reviews_use_case.dart';

@RoutePage()
class MyReviewsScreen extends StatefulWidget {
  const MyReviewsScreen({super.key});

  @override
  State<MyReviewsScreen> createState() => _MyReviewsScreenState();
}

class _MyReviewsScreenState extends State<MyReviewsScreen> {
  Future<List<Review>>? _future;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  void _reload() {
    final authState = context.read<AuthCubit>().state;
    final userId = switch (authState) {
      Authenticated(:final user) => user.uid,
      _ => null,
    };
    if (userId == null) {
      _future = Future.value(const <Review>[]);
      return;
    }
    _future = sl<GetUserReviewsUseCase>().call(userId);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final authState = context.watch<AuthCubit>().state;
    final userId = switch (authState) {
      Authenticated(:final user) => user.uid,
      _ => null,
    };

    return Scaffold(
      appBar: AppBar(title: Text(l10n.profileMyReviews)),
      body: FutureBuilder<List<Review>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(l10n.reviewsLoadError),
                  const SizedBox(height: 12),
                  FilledButton.icon(
                    onPressed: () {
                      setState(_reload);
                    },
                    icon: const Icon(Icons.refresh),
                    label: Text(l10n.retry),
                  ),
                ],
              ),
            );
          }
          final reviews = snapshot.data ?? const <Review>[];
          if (reviews.isEmpty) {
            return Center(child: Text(l10n.reviewsEmpty));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              final review = reviews[index];
              return ReviewCard(
                review: review,
                currentUserId: userId,
              );
            },
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemCount: reviews.length,
          );
        },
      ),
    );
  }
}
