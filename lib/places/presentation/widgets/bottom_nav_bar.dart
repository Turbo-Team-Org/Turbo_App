import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        if (index == 2) {
          // Índice de favoritos
          final authState = context.read<AuthCubit>().state;
          if (authState is! Authenticated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Debes iniciar sesión para ver tus favoritos'),
                duration: Duration(seconds: 2),
              ),
            );
            return;
          }
        }
        onTap(index);
      },
      selectedItemColor: const Color.fromARGB(255, 243, 33, 61),
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, size: 32),
          activeIcon: Icon(Icons.home_filled, size: 32),
          label: "Inicio",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.grid_view, size: 32),
          activeIcon: Icon(Icons.grid_view_sharp, size: 32),
          label: "Explorar",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border, size: 32),
          activeIcon: Icon(Icons.favorite, size: 32),
          label: "Favoritos",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline, size: 32),
          activeIcon: Icon(Icons.person, size: 32),
          label: "Perfil",
        ),
      ],
    );
  }
}
