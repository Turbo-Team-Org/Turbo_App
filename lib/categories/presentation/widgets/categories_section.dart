import 'package:animate_do/animate_do.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turbo/app/routes/router/app_router.gr.dart';
import 'package:turbo/categories/presentation/widgets/category_card.dart';
import 'package:turbo/categories/state_management/category_bloc/category_cubit/cubit/category_cubit.dart';

class CategoriesSection extends StatelessWidget {
  final String title;
  final bool showViewAll;
  final double height;
  final double categoryWidth;
  final bool onlyFeatured;

  const CategoriesSection({
    Key? key,
    this.title = 'Categorías destacadas',
    this.showViewAll = true,
    this.height = 160,
    this.categoryWidth = 180,
    this.onlyFeatured = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state is CategoryInitial) {
          context.read<CategoryCubit>().loadCategories();
          return _buildLoadingIndicator();
        }

        if (state is CategoryLoading) {
          return _buildLoadingIndicator();
        }

        if (state is CategoryLoaded) {
          // Filtrar categorías destacadas si es necesario
          final categories =
              onlyFeatured
                  ? state.categories.where((c) => c.isFeatured).toList()
                  : state.categories;

          if (categories.isEmpty) {
            return const SizedBox.shrink();
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    if (showViewAll)
                      TextButton(
                        onPressed:
                            () => context.router.push(const CategoriesRoute()),
                        child: const Text(
                          'Ver todas',
                          style: TextStyle(
                            color: Colors.red,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(
                height: height,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return FadeInLeft(
                      delay: Duration(milliseconds: 100 * index),
                      duration: const Duration(milliseconds: 500),
                      child: SizedBox(
                        width: categoryWidth,
                        child: CategoryCard(
                          category: category,
                          onTap:
                              () => context.router.push(
                                CategoryDetailsRoute(categoryId: category.id),
                              ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }

        if (state is CategoryError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 48),
                  const SizedBox(height: 16),
                  Text(
                    'Error al cargar categorías: ${state.message}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.red,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return _buildLoadingIndicator();
      },
    );
  }

  Widget _buildLoadingIndicator() {
    return SizedBox(
      height: height,
      child: const Center(
        child: CircularProgressIndicator(color: Colors.red, strokeWidth: 2),
      ),
    );
  }
}
