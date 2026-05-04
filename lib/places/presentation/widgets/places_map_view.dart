import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:core/core.dart';
import 'package:turbo/places/state_management/place_search_cubit/places_search_cubit.dart';

class PlacesMapView extends StatefulWidget {
  const PlacesMapView({super.key});

  @override
  State<PlacesMapView> createState() => _PlacesMapViewState();
}

class _PlacesMapViewState extends State<PlacesMapView> {
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};

  // Ubicación inicial (La Habana, Cuba)
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(23.1136, -82.3666),
    zoom: 12.0,
  );

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlacesSearchCubit, PlacesSearchState>(
      listener: (context, state) {
        _updateMarkers(state.places);
      },
      builder: (context, state) {
        return Stack(
          children: [
            // Google Map
            GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
                _updateMarkers(state.places);
              },
              initialCameraPosition: _initialPosition,
              markers: _markers,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              zoomControlsEnabled: false,
              mapToolbarEnabled: false,
              compassEnabled: true,
              trafficEnabled: false,
              buildingsEnabled: true,
              onTap: (LatLng position) {
                // Deseleccionar lugar al tocar el mapa
                context.read<PlacesSearchCubit>().clearSelection();
              },
              style: _getMapStyle(),
            ),

            // Información del lugar seleccionado
            if (state.selectedPlace != null)
              Positioned(
                bottom: 20,
                left: 16,
                right: 16,
                child: _buildSelectedPlaceCard(state.selectedPlace!),
              ),

            // Botón para centrar en mi ubicación
            Positioned(
              bottom: state.selectedPlace != null ? 200 : 80,
              right: 16,
              child: FloatingActionButton(
                heroTag: "centerLocation",
                mini: true,
                backgroundColor: Colors.white,
                foregroundColor: Theme.of(context).primaryColor,
                onPressed: _centerOnUserLocation,
                child: const Icon(Icons.my_location),
              ),
            ),

            // Botón para mostrar todos los lugares
            if (state.places.isNotEmpty)
              Positioned(
                bottom: state.selectedPlace != null ? 200 : 80,
                right: 76,
                child: FloatingActionButton(
                  heroTag: "showAllPlaces",
                  mini: true,
                  backgroundColor: Colors.white,
                  foregroundColor: Theme.of(context).primaryColor,
                  onPressed: () => _showAllPlaces(state.places),
                  child: const Icon(Icons.zoom_out_map),
                ),
              ),
          ],
        );
      },
    );
  }

  void _updateMarkers(List<Place> places) {
    if (_mapController == null) return;

    setState(() {
      _markers =
          places.map((place) {
            return Marker(
              markerId: MarkerId(place.id),
              position: LatLng(
                place.latitude ?? 23.1136,
                place.longitude ?? -82.3666,
              ),
              infoWindow: InfoWindow(
                title: place.name,
                snippet: place.description,
                onTap: () {
                  context.read<PlacesSearchCubit>().selectPlace(place);
                },
              ),
              icon: _getMarkerIcon(place.categoryId),
              onTap: () {
                context.read<PlacesSearchCubit>().selectPlace(place);
              },
            );
          }).toSet();
    });
  }

  BitmapDescriptor _getMarkerIcon(String? categoryId) {
    // Para este ejemplo usaremos el marcador por defecto
    // En el futuro puedes crear marcadores personalizados por categoría
    switch (categoryId) {
      case 'restaurants':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
      case 'bars':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
      case 'cafes':
        return BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueOrange,
        );
      case 'hotels':
        return BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueViolet,
        );
      default:
        return BitmapDescriptor.defaultMarker;
    }
  }

  Widget _buildSelectedPlaceCard(Place place) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  place.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  context.read<PlacesSearchCubit>().clearSelection();
                },
                icon: const Icon(Icons.close),
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
              ),
            ],
          ),
          if (place.description?.isNotEmpty ?? false) ...[
            const SizedBox(height: 8),
            Text(
              place.description!,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          const SizedBox(height: 12),
          Row(
            children: [
              if (place.rating != null) ...[
                Icon(Icons.star, color: Colors.amber, size: 16),
                const SizedBox(width: 4),
                Text('${place.rating}'),
                const SizedBox(width: 16),
              ],
              Icon(Icons.location_on, color: Colors.red, size: 16),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  place.address ?? 'Dirección no disponible',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Navegar a detalles del lugar
                // TODO: Implementar navegación a detalles
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Ver detalles'),
            ),
          ),
        ],
      ),
    );
  }

  void _centerOnUserLocation() async {
    if (_mapController != null) {
      // TODO: Obtener ubicación actual del usuario usando el LocationCubit
      // Por ahora centramos en La Habana
      await _mapController!.animateCamera(
        CameraUpdate.newCameraPosition(_initialPosition),
      );
    }
  }

  void _showAllPlaces(List<Place> places) async {
    if (_mapController == null || places.isEmpty) return;

    // Calcular los límites para mostrar todos los lugares
    double minLat = places.first.latitude ?? 23.1136;
    double maxLat = minLat;
    double minLng = places.first.longitude ?? -82.3666;
    double maxLng = minLng;

    for (final place in places) {
      final lat = place.latitude ?? 23.1136;
      final lng = place.longitude ?? -82.3666;

      minLat = lat < minLat ? lat : minLat;
      maxLat = lat > maxLat ? lat : maxLat;
      minLng = lng < minLng ? lng : minLng;
      maxLng = lng > maxLng ? lng : maxLng;
    }

    // Agregar padding a los límites
    const padding = 0.01;
    minLat -= padding;
    maxLat += padding;
    minLng -= padding;
    maxLng += padding;

    await _mapController!.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(minLat, minLng),
          northeast: LatLng(maxLat, maxLng),
        ),
        100.0, // padding
      ),
    );
  }

  String _getMapStyle() {
    // Estilo personalizado para el mapa (opcional)
    return '''
    [
      {
        "featureType": "poi",
        "elementType": "labels",
        "stylers": [
          {
            "visibility": "off"
          }
        ]
      }
    ]
    ''';
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}
