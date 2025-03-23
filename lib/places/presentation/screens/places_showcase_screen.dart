import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turbo/places/place_repository/models/place/place.dart';
import 'package:turbo/places/presentation/widgets/place_card_list_3d.dart';
import 'package:turbo/places/state_management/place_bloc/cubit/place_cubit.dart';
import 'package:turbo/favorites/state_management/cubit/favorite_cubit.dart';

@RoutePage()
class PlacesShowcaseScreen extends StatefulWidget {
  const PlacesShowcaseScreen({Key? key}) : super(key: key);

  @override
  State<PlacesShowcaseScreen> createState() => _PlacesShowcaseScreenState();
}

class _PlacesShowcaseScreenState extends State<PlacesShowcaseScreen> {
  Place? selectedPlace;
  Map<String, bool> favoritePlaces = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Descubre Lugares'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocConsumer<PlaceCubit, PlaceState>(
        listener: (context, state) {
          switch (state) {
            case PlacesLoaded(:final places) when places.isNotEmpty:
              setState(() {
                selectedPlace = places.first;
              });
            default:
              break;
          }
        },
        builder: (context, placeState) {
          return BlocConsumer<FavoriteCubit, FavoriteState>(
            listener: (context, favoriteState) {
              switch (favoriteState) {
                case FavoriteLoaded(:final favorites):
                  setState(() {
                    favoritePlaces = {
                      for (var favorite in favorites)
                        favorite.placeId.toString(): true,
                    };
                  });
                default:
                  break;
              }
            },
            builder: (context, favoriteState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Mostrar la información del lugar seleccionado
                  if (selectedPlace != null)
                    _buildSelectedPlaceInfo(selectedPlace!),

                  const SizedBox(height: 20),

                  // Título de la sección
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Lugares Destacados',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Mostrar la lista de lugares con efecto 3D
                  _buildPlacesList(placeState),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildSelectedPlaceInfo(Place place) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            place.name,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1a1a1a),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.location_on,
                size: 16,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  place.address,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildInfoChip(Icons.star, '${place.rating}', Colors.amber),
              const SizedBox(width: 12),
              _buildInfoChip(
                Icons.access_time,
                place.isOpen ? 'Abierto' : 'Cerrado',
                place.isOpen ? Colors.green : Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlacesList(PlaceState state) {
    return switch (state) {
      PlacesLoading() => const Expanded(
        child: Center(child: CircularProgressIndicator()),
      ),
      PlacesLoaded(:final places) when places.isEmpty => const Expanded(
        child: Center(child: Text('No hay lugares disponibles')),
      ),
      PlacesLoaded(:final places) => Expanded(
        child: PlaceCardList3D(
          places: places,
          onPlaceChange: (place) {
            setState(() {
              selectedPlace = place;
            });
          },
          onFavoriteToggle: (place, isFavorite) {
            context.read<FavoriteCubit>().toggleFavorite(
              int.parse(place.id),
              '',
            );
          },
          favoritePlaces: favoritePlaces,
        ),
      ),
      PlacesError(:final error) => Expanded(
        child: Center(child: Text('Error: $error')),
      ),
      _ => const SizedBox.shrink(),
    };
  }
}
