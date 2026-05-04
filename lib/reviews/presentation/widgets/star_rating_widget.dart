import 'package:flutter/material.dart';

/// Displays a 1–5 star rating. If [onChanged] is set, stars are tappable.
class StarRatingWidget extends StatelessWidget {
  const StarRatingWidget({
    super.key,
    required this.value,
    this.onChanged,
    this.iconSize = 28,
    this.activeColor,
    this.semanticsLabel,
  });

  final int value;
  final ValueChanged<int>? onChanged;
  final double iconSize;
  final Color? activeColor;
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) {
    final color = activeColor ?? Theme.of(context).colorScheme.primary;
    final stars = Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final starIndex = index + 1;
        final filled = starIndex <= value;
        final icon = Icon(
          filled ? Icons.star_rounded : Icons.star_border_rounded,
          color: filled ? color : color.withValues(alpha: 0.35),
          size: iconSize,
        );
        if (onChanged == null) {
          return icon;
        }
        return InkWell(
          onTap: () => onChanged!(starIndex),
          customBorder: const CircleBorder(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: icon,
          ),
        );
      }),
    );

    return Semantics(
      label: semanticsLabel,
      child: stars,
    );
  }
}
