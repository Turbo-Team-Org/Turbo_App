import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turbo/app/routes/router/app_router.gr.dart';
import 'package:turbo/authentication/state_management/auth_cubit/cubit/auth_cubit_cubit.dart';
import 'package:turbo/favorites/presentation/widgets/favorite_place_card.dart';
import 'package:turbo/favorites/state_management/cubit/favorite_cubit.dart';

import 'package:animate_do/animate_do.dart';

@RoutePage()
class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  void _loadFavorites() {
    final authState = context.read<AuthCubit>().state;
    if (authState is Authenticated) {
      context.read<FavoriteCubit>().getFavorites(authState.user.uid);
    } else {
      // Opcional: Mostrar mensaje si no está autenticado
      // (aunque la navegación debería prevenir esto)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Favoritos'),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          switch (state) {
            case FavoriteInitial():
              return const SizedBox.shrink();
            case FavoriteLoading():
              return const Center(child: CircularProgressIndicator());

            case FavoriteLoaded(:final favorites):
              if (favorites.isEmpty) {
                return Center(
                  child: FadeInUp(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.favorite_border,
                          size: 80,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Aún no tienes favoritos',
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Explora lugares y marca los que más te gusten',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(color: Colors.grey[500]),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: () async => _loadFavorites(),
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    final favorite = favorites[index];
                    if (favorite.place == null) {
                      return const SizedBox.shrink();
                    }
                    return FadeInUp(
                      delay: Duration(milliseconds: 100 * index),
                      child: FavoritePlaceCard(
                        place: favorite.place!,
                        onTap: () {
                          AutoRouter.of(
                            context,
                          ).push(BusinessDetailsRoute(id: favorite.place!.id));
                        },
                      ),
                    );
                  },
                ),
              );

            case FavoriteError(:final message):
              return Center(
                child: FadeInUp(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 80,
                        color: Colors.red[300],
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Ocurrió un error',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(color: Colors.red[600]),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: Text(
                          message,
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: _loadFavorites,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Reintentar'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[400],
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
