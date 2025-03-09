import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:turbo/app/routes/router/app_router.gr.dart';

@RoutePage()
class BottomNavShellWidget extends StatelessWidget {
  const BottomNavShellWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      animationDuration: const Duration(milliseconds: 300),
      transitionBuilder:
          (context, child, animation) =>
              FadeTransition(opacity: animation, child: child),
      routes: const [FeedRoute(), FavoritesRoute(), ProfileRoute()],
      bottomNavigationBuilder: (context, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: (index) => tabsRouter.setActiveIndex(index),
          selectedItemColor: const Color.fromARGB(255, 243, 33, 61),
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 32),
              label: "Inicio",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border, size: 32),
              label: "Favoritos",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 32),
              label: "Perfil",
            ),
          ],
        );
      },
    );
  }
}
