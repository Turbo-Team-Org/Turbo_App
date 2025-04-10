import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turbo/app/routes/router/app_router.gr.dart';
import 'package:turbo/location/state_management/location_bloc/cubit/location_cubit.dart';

import '../../../boostrap.dart';

@RoutePage()
class BottomNavShellWidget extends StatelessWidget {
  const BottomNavShellWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<LocationCubit>(),
      child: AutoTabsScaffold(
        animationDuration: const Duration(milliseconds: 300),
        transitionBuilder: (context, child, animation) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          );
        },
        routes: const [FeedRoute(), FavoritesRoute(), ProfileRoute()],
        bottomNavigationBuilder: (context, tabsRouter) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 15,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: SafeArea(
                top: false,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(
                      context,
                      Icons.explore,
                      "Explorar",
                      0,
                      tabsRouter,
                    ),
                    _buildNavItem(
                      context,
                      Icons.favorite,
                      "Favoritos",
                      1,
                      tabsRouter,
                    ),
                    _buildNavItem(
                      context,
                      Icons.person,
                      "Perfil",
                      2,
                      tabsRouter,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    IconData icon,
    String label,
    int index,
    TabsRouter tabsRouter,
  ) {
    final isSelected = tabsRouter.activeIndex == index;

    return InkWell(
      onTap: () => tabsRouter.setActiveIndex(index),
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
        width: 70,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color:
                  isSelected
                      ? const Color.fromARGB(255, 243, 33, 61)
                      : Colors.grey,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color:
                    isSelected
                        ? const Color.fromARGB(255, 243, 33, 61)
                        : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
