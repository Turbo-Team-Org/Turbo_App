import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:turbo/app/routes/router/app_router.gr.dart';
import 'package:turbo/categories/presentation/widgets/category_card.dart';
import 'package:turbo/categories/state_management/category_bloc/category_cubit/cubit/category_cubit.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        switch (state) {
          case CategoryLoaded():
            final featuredCategories =
                state.categories.where((cat) => cat.isFeatured).toList();

            if (featuredCategories.isEmpty) {
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
                      const Text(
                        'Categorías destacadas',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed:
                            () => context.router.push(const CategoriesRoute()),
                        child: const Text('Ver todas'),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    scrollDirection: Axis.horizontal,
                    itemCount: featuredCategories.length,
                    itemBuilder: (context, index) {
                      final category = featuredCategories[index];
                      return SizedBox(
                        width: 160,
                        child: CategoryCard(
                          category: category,
                          onTap:
                              () => context.router.push(
                                CategoryDetailsRoute(categoryId: category.id),
                              ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}
