import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';
import 'package:turbo/app/routes/router/app_router.gr.dart';
import 'package:turbo/categories/state_management/category_cubit.dart';
import 'package:turbo/places/presentation/widgets/place_card.dart';

@RoutePage()
class CategoryDetailsScreen extends StatelessWidget {
  final Category category;

  const CategoryDetailsScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, categoryState) {
        switch (categoryState) {
          case PlacesInCategory():
            final places = categoryState.places;

            return Scaffold(
              body: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      expandedHeight: 200.0,
                      floating: false,
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                        title: FadeInDown(
                          duration: const Duration(milliseconds: 500),
                          child: Text(
                            category.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        background: Stack(
                          fit: StackFit.expand,
                          children: [
                            if (category.imageUrl != null)
                              FadeIn(
                                duration: const Duration(milliseconds: 800),
                                child: Image.network(
                                  category.imageUrl!,
                                  fit: BoxFit.cover,
                                ),
                              )
                            else
                              Container(
                                color: Theme.of(
                                  context,
                                ).colorScheme.primary.withAlpha(26),
                                child: Icon(
                                  IconData(
                                    int.tryParse(category.icon) ?? 0xe5d3,
                                    fontFamily: 'MaterialIcons',
                                  ),
                                  size: 48,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withAlpha(179),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ];
                },
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (category.description != null &&
                        category.description!.isNotEmpty)
                      FadeInUp(
                        duration: const Duration(milliseconds: 500),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            category.description!,
                            style: Theme.of(
                              context,
                            ).textTheme.bodyLarge?.copyWith(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurface.withAlpha(179),
                            ),
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                      child: Row(
                        children: [
                          Icon(
                            Icons.place,
                            size: 20,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${places.length} lugares',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child:
                          places.isEmpty
                              ? Center(
                                child: FadeIn(
                                  duration: const Duration(milliseconds: 500),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.search_off,
                                        size: 64,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSurface.withAlpha(77),
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        'No hay lugares en esta categoría',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleMedium?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface
                                              .withAlpha(179),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              : ListView.builder(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                itemCount: places.length,
                                itemBuilder: (context, index) {
                                  final place = places[index];
                                  return FadeInLeft(
                                    duration: Duration(
                                      milliseconds: 300 + (index * 100),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 16,
                                      ),
                                      child: PlaceCard(
                                        place: place,
                                        onTap:
                                            () => context.router.push(
                                              BusinessDetailsRoute(
                                                id: place.id,
                                              ),
                                            ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                    ),
                  ],
                ),
              ),
            );

          case CategoryLoading():
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );

          case CategoryError():
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Error: ${categoryState.message}',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
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
