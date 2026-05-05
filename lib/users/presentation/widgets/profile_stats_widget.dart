import 'package:flutter/material.dart';
import 'package:turbo_ui/turbo_ui.dart';

import '../../domain/user_profile.dart';

/// Tres métricas visibles en perfil (valores preparados para métricas futuras).
class ProfileStatsWidget extends StatelessWidget {
  const ProfileStatsWidget({
    super.key,
    required this.profile,
    required this.favoritesLabel,
    required this.reservationsLabel,
    required this.reviewsLabel,
  });

  final UserProfile profile;
  final String favoritesLabel;
  final String reservationsLabel;
  final String reviewsLabel;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(top: TurboSpacing.lg),
      child: Row(
        children: [
          Expanded(
            child: _StatChip(
              icon: Icons.favorite_outline,
              label: favoritesLabel,
              value: '${profile.favoritesCount}',
              color: TurboColors.primary,
              scheme: scheme,
            ),
          ),
          Expanded(
            child: _StatChip(
              icon: Icons.calendar_today_outlined,
              label: reservationsLabel,
              value: '${profile.reservationsCount}',
              color: TurboColors.blue,
              scheme: scheme,
            ),
          ),
          Expanded(
            child: _StatChip(
              icon: Icons.rate_review_outlined,
              label: reviewsLabel,
              value: '${profile.reviewsCount}',
              color: TurboColors.amber,
              scheme: scheme,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    required this.scheme,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TurboSpacing.xs),
      child: Column(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: TurboSpacing.xs),
          Text(
            value,
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            label,
            style: textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
