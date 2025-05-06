import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:turbo/app/routes/router/app_router.gr.dart';
import 'package:turbo/categories/state_management/category_bloc/category_cubit/cubit/category_cubit.dart';
import 'package:turbo/places/presentation/widgets/place_card.dart';
import 'package:turbo/places/state_management/place_bloc/cubit/place_cubit.dart';

@RoutePage()
class CategoryDetailsScreen extends StatelessWidget {
  final String categoryId;

  const CategoryDetailsScreen({
    super.key,
    @PathParam('categoryId') required this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, categoryState) {
        switch (categoryState) {
          case CategoryLoaded():
            final category = categoryState.categories.firstWhere(
              (c) => c.id == categoryId,
              orElse: () => throw Exception('Categoría no encontrada'),
            );

            return Scaffold(
              body: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      expandedHeight: 200.0,
                      floating: false,
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                        title: Text(category.name),
                        background:
                            category.imageUrl != null
                                ? Image.network(
                                  category.imageUrl!,
                                  fit: BoxFit.cover,
                                )
                                : Container(color: Colors.red.shade400),
                      ),
                    ),
                  ];
                },
                body: BlocProvider(
                  create:
                      (_) =>
                          GetIt.I<PlaceCubit>()
                            ..getPlacesByCategory(categoryId),
                  child: BlocBuilder<PlaceCubit, PlaceState>(
                    builder: (context, placeState) {
                      switch (placeState) {
                        case PlacesLoading():
                          return const Center(
                            child: CircularProgressIndicator(),
                          );

                        case PlacesLoaded():
                          final places = placeState.places;

                          if (places.isEmpty) {
                            return const Center(
                              child: Text('No hay lugares en esta categoría'),
                            );
                          }

                          return ListView.builder(
                            padding: const EdgeInsets.all(16.0),
                            itemCount: places.length,
                            itemBuilder: (context, index) {
                              final place = places[index];
                              return PlaceCard(
                                place: place,
                                onTap:
                                    () => context.router.push(
                                      BusinessDetailsRoute(id: place.id),
                                    ),
                              );
                            },
                          );

                        case PlacesError():
                          return Center(
                            child: Text('Error: ${placeState.error}'),
                          );

                        default:
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                      }
                    },
                  ),
                ),
              ),
            );

          case CategoryLoading():
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );

          case CategoryError():
            return Scaffold(
              body: Center(child: Text('Error: ${categoryState.message}')),
            );

          default:
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
        }
      },
    );
  }
}
