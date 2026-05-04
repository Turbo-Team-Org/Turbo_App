import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:core/core.dart';
import 'package:turbo/places/state_management/place_search_cubit/places_search_cubit.dart';
import 'package:turbo/places/presentation/widgets/place_compact_card.dart';

class PlacesListSlide extends StatelessWidget {
  final PanelController panelController;
  final String? categoryName;

  const PlacesListSlide({
    super.key,
    required this.panelController,
    this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          // Handle del panel
          _buildPanelHandle(),

          // Header con título y cantidad
          _buildHeader(context),

          // Lista de lugares
          Expanded(
            child: BlocBuilder<PlacesSearchCubit, PlacesSearchState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return _buildLoadingState();
                } else if (state.error != null) {
                  return _buildErrorState(state.error!);
                } else if (state.places.isEmpty) {
                  return _buildEmptyState();
                } else {
                  return _buildPlacesList(state.places, state.selectedPlace);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPanelHandle() {
    return Container(
      width: 40,
      height: 4,
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return BlocBuilder<PlacesSearchCubit, PlacesSearchState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      categoryName ?? 'Lugares cercanos',
                      style: Theme.of(
                        context,
                      ).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${state.places.length} lugares encontrados',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              // Botón de ordenar
              IconButton(
                onPressed: () => _showSortOptions(context),
                icon: const Icon(Icons.sort),
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Buscando lugares...'),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            'Error al cargar lugares',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            error,
            style: TextStyle(color: Colors.grey.shade500),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            'No se encontraron lugares',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Intenta cambiar los filtros o la búsqueda',
            style: TextStyle(color: Colors.grey.shade500),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPlacesList(List<Place> places, Place? selectedPlace) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: places.length,
      itemBuilder: (context, index) {
        final place = places[index];
        final isSelected = selectedPlace?.id == place.id;

        return PlaceCompactCard(
          place: place,
          isSelected: isSelected,
          onTap: () {
            // Actualizar lugar seleccionado y mover mapa
            context.read<PlacesSearchCubit>().selectPlace(place);
          },
        );
      },
    );
  }

  void _showSortOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder:
          (context) => Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Ordenar por',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                _buildSortOption(context, 'Distancia', Icons.near_me),
                _buildSortOption(context, 'Calificación', Icons.star),
                _buildSortOption(context, 'Precio', Icons.attach_money),
                _buildSortOption(context, 'Popularidad', Icons.trending_up),

                const SizedBox(height: 20),
              ],
            ),
          ),
    );
  }

  Widget _buildSortOption(BuildContext context, String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).primaryColor),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        // TODO: Implementar lógica de ordenamiento
      },
    );
  }
}
