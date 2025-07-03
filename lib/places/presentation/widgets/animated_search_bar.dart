import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:animate_do/animate_do.dart';
import 'package:turbo/app/core/theme/app_themes.dart';
import 'package:turbo/app/core/theme/text_styles.dart';
import 'package:turbo/app/routes/router/app_router.gr.dart';
import 'package:turbo/categories/state_management/category_cubit.dart';

class AnimatedSearchBar extends StatefulWidget {
  final double height;
  final EdgeInsets padding;

  const AnimatedSearchBar({
    super.key,
    this.height = 56,
    this.padding = const EdgeInsets.fromLTRB(20, 15, 20, 20),
  });

  @override
  State<AnimatedSearchBar> createState() => _AnimatedSearchBarState();
}

class _AnimatedSearchBarState extends State<AnimatedSearchBar>
    with TickerProviderStateMixin {
  List<String> _categoryNames = [];
  int _currentCategoryIndex = 0;
  bool _showCategory = true;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  void _loadCategories() {
    final categoryState = context.read<CategoryCubit>().state;
    if (categoryState is CategoryLoaded) {
      setState(() {
        _categoryNames =
            categoryState.categories
                .map((category) => category.name)
                .where((name) => name.trim().isNotEmpty)
                .toList();
      });
      if (_categoryNames.isNotEmpty) {
        _startCategoryRotation();
      }
    } else {
      context.read<CategoryCubit>().loadCategories();
    }
  }

  void _startCategoryRotation() async {
    if (_categoryNames.isEmpty) return;
    while (mounted) {
      await Future.delayed(const Duration(seconds: 2));
      if (!mounted) break;
      setState(() => _showCategory = false);
      await Future.delayed(const Duration(milliseconds: 450));
      if (!mounted) break;
      setState(() {
        _currentCategoryIndex =
            (_currentCategoryIndex + 1) % _categoryNames.length;
        _showCategory = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CategoryCubit, CategoryState>(
      listener: (context, state) {
        if (state is CategoryLoaded && _categoryNames.isEmpty) {
          setState(() {
            _categoryNames =
                state.categories
                    .map((category) => category.name)
                    .where((name) => name.trim().isNotEmpty)
                    .toList();
          });
          if (_categoryNames.isNotEmpty) {
            _startCategoryRotation();
          }
        }
      },
      child: Padding(
        padding: widget.padding,
        child: GestureDetector(
          onTap: () => context.router.push(PlacesSearchRoute()),
          child: Container(
            height: widget.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              color: Theme.of(context).colorScheme.surface,
              border: Border.all(
                color: Colors.grey.withOpacity(0.08),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(
                    Icons.search_rounded,
                    color: Theme.of(context).colorScheme.primary,
                    size: 24,
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Busca',
                        style: AppTextStyles.bodyMedium(context).copyWith(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withOpacity(0.6),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (_categoryNames.isNotEmpty) ...[
                        const SizedBox(width: 8),
                        SizedBox(
                          height: 24,
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 350),
                            switchInCurve: Curves.easeOutCubic,
                            switchOutCurve: Curves.easeInCubic,
                            transitionBuilder: (child, animation) {
                              final inAnimation = Tween<Offset>(
                                begin: const Offset(0, 0.7),
                                end: Offset.zero,
                              ).animate(animation);
                              final outAnimation = Tween<Offset>(
                                begin: Offset.zero,
                                end: const Offset(0, -0.7),
                              ).animate(animation);
                              if (child.key ==
                                  ValueKey(
                                    _categoryNames[_currentCategoryIndex],
                                  )) {
                                // Entrando
                                return SlideTransition(
                                  position: inAnimation,
                                  child: FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  ),
                                );
                              } else {
                                // Saliendo
                                return SlideTransition(
                                  position: outAnimation,
                                  child: FadeTransition(
                                    opacity: ReverseAnimation(animation),
                                    child: child,
                                  ),
                                );
                              }
                            },
                            child:
                                _showCategory
                                    ? Text(
                                      _categoryNames[_currentCategoryIndex],
                                      key: ValueKey(
                                        _categoryNames[_currentCategoryIndex],
                                      ),
                                      style: AppTextStyles.bodyMedium(
                                        context,
                                      ).copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface
                                            .withOpacity(0.6),
                                        fontWeight: FontWeight.w500,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    )
                                    : const SizedBox.shrink(),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withOpacity(0.08),
                    shape: BoxShape.circle,
                  ),
                  child: Material(
                    color: Colors.transparent,
                    shape: const CircleBorder(),
                    clipBehavior: Clip.antiAlias,
                    child: IconButton(
                      icon: Icon(
                        Icons.mic_rounded,
                        size: 22,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Búsqueda por voz no implementada aún',
                              style: AppTextStyles.bodyMedium(
                                context,
                              ).copyWith(color: Colors.white),
                            ),
                            backgroundColor: Colors.red,
                            duration: const Duration(seconds: 2),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            margin: const EdgeInsets.all(16),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
