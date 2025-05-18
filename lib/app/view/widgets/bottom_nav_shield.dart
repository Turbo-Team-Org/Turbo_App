import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
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
          return FadeTransition(opacity: animation, child: child);
        },
        routes: const [
          FeedRoute(),
          CategoriesRoute(),
          EventsRoute(),
          FavoritesRoute(),
          ProfileRoute(),
        ],
        bottomNavigationBuilder: (context, tabsRouter) {
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor.withAlpha(26),
                  blurRadius: 15,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: SafeArea(
                top: false,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(
                      context,
                      Icons.explore_outlined,
                      Icons.explore,
                      "Explorar",
                      0,
                      tabsRouter,
                    ),
                    _buildNavItem(
                      context,
                      Icons.category_outlined,
                      Icons.category,
                      "Categorías",
                      1,
                      tabsRouter,
                    ),
                    _buildNavItem(
                      context,
                      Icons.celebration_outlined,
                      Icons.celebration,
                      "Eventos",
                      2,
                      tabsRouter,
                    ),
                    _buildNavItem(
                      context,
                      Icons.favorite_border,
                      Icons.favorite,
                      "Favoritos",
                      3,
                      tabsRouter,
                    ),
                    _buildNavItem(
                      context,
                      Icons.person_outline,
                      Icons.person,
                      "Perfil",
                      4,
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
    IconData activeIcon,
    String label,
    int index,
    TabsRouter tabsRouter,
  ) {
    final isSelected = tabsRouter.activeIndex == index;
    final color =
        isSelected
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).unselectedWidgetColor;

    return Expanded(
      child: InkResponse(
        onTap: () => tabsRouter.setActiveIndex(index),
        radius: 40,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(isSelected ? activeIcon : icon, color: color, size: 26),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: color,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
