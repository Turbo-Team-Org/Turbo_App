import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/core.dart';
import 'package:turbo_ui/turbo_ui.dart';
import 'package:turbo/favorites/state_management/cubit/favorite_cubit.dart';
import 'package:turbo/places/state_management/place_bloc/cubit/place_cubit.dart';
import 'feed_place_card.dart';

/// Grid de lugares para el feed
/// 
/// Maneja estados de carga, error y lista vacía automáticamente.
class PlacesGrid extends StatelessWidget {
  final int? selectedTabIndex;
  final LocationData? currentLocation;

  const PlacesGrid({
    super.key,
    this.selectedTabIndex,
    this.currentLocation,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaceCubit, PlaceState>(
      builder: (context, placeState) {
        return BlocBuilder<FavoriteCubit, FavoriteState>(
          builder: (context, favoriteState) {
            return _buildContent(context, placeState, favoriteState);
          },
        );
      },
    );
  }

  Widget _buildContent(
    BuildContext context,
    PlaceState placeState,
    FavoriteState favoriteState,
  ) {
    switch (placeState) {
      case PlacesInitial():
      case PlacesLoading():
        return _buildLoading(context);

      case PlacesLoaded():
        final places = _filterPlaces(placeState.places);
        if (places.isEmpty) {
          return _buildEmpty(context);
        }
        return _buildGrid(context, places, favoriteState);

      case PlacesError():
        return _buildError(context, placeState.error);
    }
  }

  List<Place> _filterPlaces(List<Place> places) {
    if (selectedTabIndex == null || selectedTabIndex == 0) {
      return places;
    }

    switch (selectedTabIndex) {
      case 1: // Ofertas
        return places.where((p) => p.offers.isNotEmpty).toList();
      case 2: // Top Rated
        return places.where((p) => p.rating >= 4).toList();
      case 3: // Económico
        return places.where((p) => p.averagePrice <= 25).toList();
      default:
        return places;
    }
  }

  Widget _buildLoading(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Cargando lugares...',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 64,
              color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'No hay lugares disponibles',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Intenta con otra búsqueda',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildError(BuildContext context, String error) {
    final colorScheme = Theme.of(context).colorScheme;

    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline_rounded,
                size: 64,
                color: TurboColors.error.withValues(alpha: 0.7),
              ),
              const SizedBox(height: 16),
              Text(
                'Algo salió mal',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                error,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: () => context.read<PlaceCubit>().getPlaces(),
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('Reintentar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGrid(
    BuildContext context,
    List<Place> places,
    FavoriteState favoriteState,
  ) {
    // Obtener IDs de favoritos
    final favoriteIds = <String>{};
    if (favoriteState is FavoriteLoaded) {
      favoriteIds.addAll(favoriteState.favorites.map((f) => f.placeId));
    }

    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.72,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final place = places[index];
            return FeedPlaceCard(
              place: place,
              index: index,
              isFavorite: favoriteIds.contains(place.id),
            );
          },
          childCount: places.length,
        ),
      ),
    );
  }
}
