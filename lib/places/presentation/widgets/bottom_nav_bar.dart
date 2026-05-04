import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turbo/app/l10n/l10n.dart';
import 'package:turbo/authentication/state_management/auth_cubit/cubit/auth_cubit_cubit.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        if (index == 2) {
          // Índice de favoritos
          final authState = context.read<AuthCubit>().state;
          if (authState is! Authenticated) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(l10n.profileLoginPrompt),
                duration: const Duration(seconds: 2),
              ),
            );
            return;
          }
        }
        onTap(index);
      },
      selectedItemColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home, size: 32),
          activeIcon: const Icon(Icons.home_filled, size: 32),
          label: l10n.navHome,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.grid_view, size: 32),
          activeIcon: const Icon(Icons.grid_view_sharp, size: 32),
          label: l10n.navExplore,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.favorite_border, size: 32),
          activeIcon: const Icon(Icons.favorite, size: 32),
          label: l10n.navFavorites,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person_outline, size: 32),
          activeIcon: const Icon(Icons.person, size: 32),
          label: l10n.navProfile,
        ),
      ],
    );
  }
}
