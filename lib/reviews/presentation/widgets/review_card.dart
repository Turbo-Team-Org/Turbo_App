import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:intl/intl.dart';
import 'package:turbo/app/l10n/l10n.dart';

import 'star_rating_widget.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    super.key,
    required this.review,
    this.currentUserId,
    this.onEdit,
    this.onDelete,
  });

  final Review review;
  final String? currentUserId;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  bool get _isOwn =>
      currentUserId != null && currentUserId!.isNotEmpty && review.userId == currentUserId;

  bool get _canShowActions => _isOwn && (onEdit != null || onDelete != null);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final formatter = DateFormat.yMMMd(Localizations.localeOf(context).toString());
    final dateText = formatter.format(review.date);
    final avatarUrl = review.userAvatar.trim();
    final hasNetworkAvatar =
        avatarUrl.isNotEmpty &&
        (avatarUrl.startsWith('http://') || avatarUrl.startsWith('https://'));

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.primary.withValues(alpha: 0.2),
                  backgroundImage:
                      hasNetworkAvatar
                          ? CachedNetworkImageProvider(avatarUrl)
                          : null,
                  child:
                      hasNetworkAvatar
                          ? null
                          : Text(
                            review.userName.isNotEmpty
                                ? review.userName[0].toUpperCase()
                                : '?',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              review.userName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Text(
                            dateText,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      StarRatingWidget(
                        value: review.rating.round().clamp(0, 5),
                        iconSize: 16,
                      ),
                    ],
                  ),
                ),
                if (_canShowActions)
                  PopupMenuButton<String>(
                    onSelected: (v) {
                      if (v == 'edit') {
                        onEdit?.call();
                      } else if (v == 'delete') {
                        onDelete?.call();
                      }
                    },
                    itemBuilder:
                        (context) => [
                          if (onEdit != null)
                            PopupMenuItem(value: 'edit', child: Text(l10n.reviewsEdit)),
                          if (onDelete != null)
                            PopupMenuItem(
                              value: 'delete',
                              child: Text(l10n.reviewsDelete),
                            ),
                        ],
                  ),
              ],
            ),
            if (review.comment.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                review.comment,
                style: const TextStyle(fontSize: 14, height: 1.4),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
