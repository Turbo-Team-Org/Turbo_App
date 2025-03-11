import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turbo/favorites/favorite_repository/models/favorite.dart';
import 'package:turbo/places/place_repository/models/place/place.dart';
import '../../../places/presentation/widgets/feed_widgets.dart';
import '../../../places/state_management/place_bloc/cubit/place_cubit.dart';
import '../../state_management/cubit/favorite_cubit.dart';

@RoutePage()
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mis Favoritos')),
      body: BlocBuilder<PlaceCubit, PlaceState>(
        builder: (context, state) {
          switch (state) {
            case PlaceState.initial:
              return const Center(child: Text('Cargando lugares...'));
            case PlaceState.loading:
              return const Center(child: CircularProgressIndicator());
            case PlaceState.loaded:
              (placesdata) {
                return BlocBuilder<FavoriteCubit, FavoriteState>(
                  builder: (context, state) {
                    switch (state) {
                      case FavoriteState.initial:
                        return const Center(
                          child: Text('Cargando favoritos...'),
                        );
                      case FavoriteState.loading:
                        return const Center(child: CircularProgressIndicator());
                      case FavoriteState.loaded:
                        (List<Favorite> favorites) {
                          List<Place> places = placesdata;
                          final favoritePlaces =
                              places
                                  .where(
                                    (place) => favorites
                                        .map((favorite) => favorite.placeId)
                                        .contains(place.id),
                                  )
                                  .toList();

                          if (favoritePlaces.isEmpty) {
                            return const Center(
                              child: Text('No tienes lugares favoritos.'),
                            );
                          }

                          return ListView.builder(
                            itemCount: favoritePlaces.length,
                            itemBuilder: (context, index) {
                              final place = favoritePlaces[index];
                              return PlaceCard(
                                place: place,
                                isFavorite: favorites.any(
                                  (fav) => fav.placeId == place.id,
                                ),
                                onFavoritePressed: () {
                                  //        context.read<FavoriteCubit>().toggleFavorite(
                                  //          place.id,
                                  //          1,
                                  //       );
                                },
                              );
                            },
                          );
                        };
                      case FavoriteState.error:
                        return Center(child: Text('Error: cargando los fav'));
                      default:
                        return Container();
                    }
                    return Container(); // Para manejar cualquier caso no cubierto
                  },
                );
              };
            case PlaceState.error:
              return Center(child: Text('Error: cargando los lugares'));
            default:
              return Container();
          }

          return Container(); // Para manejar cualquier caso no cubierto
        },
      ),
    );
  }
}
