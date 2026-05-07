import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turbo/app/core/theme/text_styles.dart';
import 'package:turbo/categories/state_management/category_cubit.dart';

class CategoriesTabBar extends StatelessWidget {
  final TabController tabController;

  const CategoriesTabBar({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        switch (state) {
          case CategoryLoaded():
            final categories = state.categories;

            // Actualizar el controlador si es necesario
            if (tabController.length != categories.length + 1) {
              // +1 para la pestaña "Todos"
              return const Text('Categorías cargando...');
            }

            return Material(
              color: Colors.transparent,
              elevation: 0,
              child: Container(
                margin: const EdgeInsets.only(bottom: 1),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      AppColors.primaryRed.withOpacity(0.05),
                      Colors.transparent,
                      AppColors.primaryRed.withOpacity(0.05),
                    ],
                  ),
                ),
                child: TabBar(
                  controller: tabController,
                  isScrollable: true,
                  indicatorColor: AppColors.primaryRed,
                  indicatorWeight: 3,
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  labelColor: AppColors.primaryRed,
                  unselectedLabelColor: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.7),
                  tabs: [
                    const Tab(text: 'Todos'),
                    ...categories
                        .map(
                          (category) => Tab(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (category.icon.isNotEmpty)
                                  Icon(
                                    IconData(
                                      int.tryParse(category.icon) ??
                                          0xe5d3, // Icono por defecto
                                      fontFamily: 'MaterialIcons',
                                    ),
                                  ),
                                if (category.icon.isNotEmpty)
                                  const SizedBox(width: 4),
                                Text(category.name),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ],
                ),
              ),
            );

          case CategoryLoading():
            return const Center(child: CircularProgressIndicator());

          case CategoryError():
            return Center(child: Text('Error: ${state.message}'));

          default:
            return const SizedBox();
        }
      },
    );
  }
}
