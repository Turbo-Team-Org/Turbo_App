import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';
import 'package:auto_route/auto_route.dart';
import 'package:turbo_ui/turbo_ui.dart';
import 'package:turbo/authentication/state_management/auth_cubit/cubit/auth_cubit_cubit.dart';
import 'package:turbo/app/routes/router/app_router.gr.dart';

/// Modelo de datos para categorías rápidas
class QuickCategory {
  final IconData icon;
  final String label;
  final String? searchQuery;
  final String? routePath;
  final Color? accentColor;

  const QuickCategory({
    required this.icon,
    required this.label,
    this.searchQuery,
    this.routePath,
    this.accentColor,
  });
}

/// Sección de bienvenida con saludo y categorías rápidas
/// 
/// Diseño moderno con gradiente sutil y chips de categorías.
class WelcomeSection extends StatelessWidget {
  final VoidCallback? onNearbyTap;

  const WelcomeSection({super.key, this.onNearbyTap});

  static final _quickCategories = [
    QuickCategory(
      icon: Icons.local_fire_department_rounded,
      label: 'Popular',
      searchQuery: 'popular',
      accentColor: TurboColors.orange,
    ),
    QuickCategory(
      icon: Icons.favorite_rounded,
      label: 'Favoritos',
      routePath: '/home/favorites',
      accentColor: TurboColors.coral,
    ),
    QuickCategory(
      icon: Icons.trending_up_rounded,
      label: 'Trending',
      searchQuery: 'trending',
      accentColor: TurboColors.blue,
    ),
    QuickCategory(
      icon: Icons.attach_money_rounded,
      label: 'Económico',
      searchQuery: 'precio',
      accentColor: TurboColors.success,
    ),
    QuickCategory(
      icon: Icons.star_rounded,
      label: 'Top Rated',
      searchQuery: 'rating',
      accentColor: TurboColors.gold,
    ),
    QuickCategory(
      icon: Icons.restaurant_rounded,
      label: 'Comida',
      searchQuery: 'restaurantes',
      accentColor: TurboColors.amber,
    ),
    QuickCategory(
      icon: Icons.local_bar_rounded,
      label: 'Bebidas',
      searchQuery: 'bares',
      accentColor: TurboColors.purple,
    ),
    QuickCategory(
      icon: Icons.local_offer_rounded,
      label: 'Ofertas',
      searchQuery: 'ofertas',
      accentColor: TurboColors.primary,
    ),
    QuickCategory(
      icon: Icons.near_me_rounded,
      label: 'Cerca',
      searchQuery: 'cerca',
      accentColor: TurboColors.info,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return FadeInDown(
      duration: const Duration(milliseconds: 600),
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [
                    colorScheme.surfaceContainerHighest,
                    colorScheme.surfaceContainerHigh,
                  ]
                : [
                    colorScheme.primary,
                    colorScheme.primary.withValues(alpha: 0.85),
                  ],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withValues(alpha: 0.3)
                  : colorScheme.primary.withValues(alpha: 0.25),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildGreeting(context, isDark),
            _buildCategoriesCarousel(context, isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildGreeting(BuildContext context, bool isDark) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BlocBuilder<AuthCubit, AuthCubitState>(
                builder: (context, state) {
                  String firstName = 'Explorador';
                  if (state is Authenticated) {
                    final name = state.user.displayName ?? '';
                    firstName = name.split(' ').first;
                    if (firstName.isEmpty) firstName = 'Explorador';
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getGreetingByTime(),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: isDark
                              ? theme.colorScheme.onSurfaceVariant
                              : Colors.white.withValues(alpha: 0.8),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        firstName,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: isDark
                              ? theme.colorScheme.onSurface
                              : Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                },
              ),
              // Indicador de scroll
              Pulse(
                infinite: true,
                duration: const Duration(milliseconds: 2000),
                child: Icon(
                  Icons.swipe_rounded,
                  color: isDark
                      ? theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5)
                      : Colors.white.withValues(alpha: 0.5),
                  size: 24,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Descubre los mejores lugares en Cuba',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: isDark
                  ? theme.colorScheme.onSurfaceVariant
                  : Colors.white.withValues(alpha: 0.85),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesCarousel(BuildContext context, bool isDark) {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        itemCount: _quickCategories.length,
        itemBuilder: (context, index) {
          final category = _quickCategories[index];
          return FadeInUp(
            duration: const Duration(milliseconds: 500),
            delay: Duration(milliseconds: 50 * index),
            child: _QuickCategoryChip(
              category: category,
              isDark: isDark,
              onTap: () => _onCategoryTap(context, category),
            ),
          );
        },
      ),
    );
  }

  void _onCategoryTap(BuildContext context, QuickCategory category) {
    HapticFeedback.lightImpact();

    if (category.routePath != null) {
      context.router.pushPath(category.routePath!);
    } else if (category.searchQuery == 'cerca') {
      onNearbyTap?.call();
    } else if (category.searchQuery != null) {
      context.router.push(PlacesSearchRoute(initialQuery: category.searchQuery));
    }
  }

  String _getGreetingByTime() {
    final hour = DateTime.now().hour;
    if (hour < 12) return '¡Buenos días!';
    if (hour < 18) return '¡Buenas tardes!';
    return '¡Buenas noches!';
  }
}

/// Chip individual de categoría rápida
class _QuickCategoryChip extends StatelessWidget {
  final QuickCategory category;
  final bool isDark;
  final VoidCallback onTap;

  const _QuickCategoryChip({
    required this.category,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final accentColor = category.accentColor ?? TurboColors.primary;

    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            width: 68,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.08)
                  : Colors.white.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.1)
                    : Colors.white.withValues(alpha: 0.25),
                width: 1,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: isDark ? 0.2 : 0.25),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    category.icon,
                    color: isDark ? accentColor : Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  category.label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isDark
                        ? Theme.of(context).colorScheme.onSurface
                        : Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.1,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
