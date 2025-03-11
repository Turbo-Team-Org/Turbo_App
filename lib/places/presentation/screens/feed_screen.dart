import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turbo/app/routes/router/app_router.gr.dart';
import 'package:turbo/app/utils/app_preferences.dart';
import 'package:turbo/authentication/state_managament/auth_cubit/cubit/auth_cubit_cubit.dart';

import 'package:turbo/favorites/state_management/cubit/favorite_cubit.dart';

import 'package:turbo/places/state_management/place_bloc/cubit/place_cubit.dart';

import '../widgets/feed_widgets.dart';

@RoutePage()
class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final _preferences = AppPreferences();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<AuthCubit, AuthCubitState>(
        builder: (context, userstate) {
          switch (userstate) {
            case Unauthenticated():
              {
                context.replaceRoute(SignInRoute());
              }

            case Authenticated(:final user):
              {
                context.read<FavoriteCubit>().getFavorites(user.uid);
                return SafeArea(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(245, 245, 247, 0.6),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SearchBarWidget(),
                          const SizedBox(height: 16),
                          Text(
                            "Bienvenido ${user.displayName ?? 'Usuario'}, Explora \n Los mejores lugares y negocios",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 16),
                          CategoryTabs(
                            categories: const [
                              "Populares",
                              "Mejores Ofertas",
                              "Trending",
                              "Precio-Calidad",
                            ],
                            onCategorySelected: (index) {
                              print("Seleccionado: $index");
                            },
                          ),
                          const SizedBox(height: 20),
                          BlocBuilder<PlaceCubit, PlaceState>(
                            builder: (context, placeState) {
                              switch (placeState) {
                                case PlacesLoading():
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );

                                case PlacesInitial():
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );

                                case PlacesLoaded():
                                  return Expanded(
                                    child: ListView(
                                      children: [
                                        SizedBox(
                                          height: 300,
                                          child: BlocBuilder<
                                            FavoriteCubit,
                                            FavoriteState
                                          >(
                                            builder: (context, favoriteState) {
                                              switch (favoriteState) {
                                                case FavoriteLoaded():
                                                  return ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount:
                                                        placeState
                                                            .places
                                                            .length,
                                                    itemBuilder: (
                                                      context,
                                                      index,
                                                    ) {
                                                      final place =
                                                          placeState
                                                              .places[index];
                                                      return InkWell(
                                                        onTap: () {
                                                          context.router.push(
                                                            BusinessDetailsRoute(
                                                              place: place,
                                                            ),
                                                          );
                                                        },
                                                        child: PlaceCard(
                                                          place: place,
                                                          isFavorite: favoriteState
                                                              .favorites
                                                              .any(
                                                                (fav) =>
                                                                    fav.placeId ==
                                                                    place.id,
                                                              ),
                                                          onFavoritePressed: () {
                                                            context
                                                                .read<
                                                                  FavoriteCubit
                                                                >()
                                                                .toggleFavorite(
                                                                  place.id,
                                                                  user.uid,
                                                                );
                                                          },
                                                        ),
                                                      );
                                                    },
                                                  );
                                                case FavoriteInitial():
                                                  Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                case FavoriteLoading():
                                                  Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                case FavoriteError():
                                                  (error) {
                                                    Center(child: Text(error));
                                                  };
                                              }
                                              return SizedBox();
                                            },
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        CategoriesSection(),
                                      ],
                                    ),
                                  );

                                case PlacesError():
                                  (error) {
                                    return Center(child: Text("Error $error"));
                                  };
                              }
                              return SizedBox();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }

            default:
              break;
          }

          return CircularProgressIndicator.adaptive();
        },
      ),
    );
  }
}
