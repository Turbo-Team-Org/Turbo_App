import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: const Color.fromARGB(255, 243, 33, 61),
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: false,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 32,
            ),
            label: ""),
        BottomNavigationBarItem(
            icon: Icon(Icons.grid_view, size: 32), label: ""),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border, size: 32), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.person, size: 32), label: ""),
      ],
    );
  }
}
