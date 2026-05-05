import 'package:flutter/material.dart';

import '../../domain/user_profile.dart';

class UserProfileAvatar extends StatelessWidget {
  const UserProfileAvatar({
    super.key,
    required this.profile,
    this.radius = 48,
  });

  final UserProfile profile;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final url = profile.photoUrl;
    if (url != null && url.isNotEmpty) {
      return CircleAvatar(
        radius: radius,
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        backgroundImage: NetworkImage(url),
      );
    }
    final name = profile.displayName?.trim() ?? '';
    final initial =
        name.isNotEmpty ? name.substring(0, 1).toUpperCase() : '?';
    return CircleAvatar(
      radius: radius,
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      child: Text(
        initial,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
