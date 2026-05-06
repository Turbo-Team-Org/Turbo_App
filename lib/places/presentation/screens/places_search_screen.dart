import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:core/core.dart';
import 'package:turbo/places/state_management/place_search_cubit/places_search_cubit.dart';
import 'package:turbo/places/presentation/widgets/places_search_bar.dart';
import 'package:turbo/places/presentation/widgets/place_compact_card.dart';
import 'dart:math' as math;

@RoutePage()
class PlacesSearchScreen extends StatefulWidget {
  final String? categoryId;
  final String? categoryName;
  final String? initialQuery;

  const PlacesSearchScreen({
    super.key,
    this.categoryId,
    this.categoryName,
    this.initialQuery,
  });

  @override
  State<PlacesSearchScreen> createState() => _PlacesSearchScreenState();
}

class _PlacesSearchScreenState extends State<PlacesSearchScreen>
    with TickerProviderStateMixin {
  GoogleMapController? _mapController;
  final PanelController _panelController = PanelController();

  late AnimationController _fabAnimationController;
  late Animation<double> _fabAnimation;

  // Nuevos controladores para animaciones de zoom
  late AnimationController _zoomAnimationController;
  late Animation<double> _zoomAnimation;
  late Animation<Offset> _slideAnimation;

  bool _isMapMode = true;
  double _panelPosition = 0.0;

  // Estado para el lugar seleccionado
  Place? _selectedPlace;
  Set<Marker> _markers = {};

  // Posición inicial del mapa (La Habana, Cuba)
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(23.1136, -82.3666),
    zoom: 12.0,
  );

  @override
  void initState() {
    super.initState();

    // Inicializar animaciones
    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fabAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fabAnimationController, curve: Curves.easeInOut),
    );

    // Inicializar animaciones de zoom
    _zoomAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _zoomAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _zoomAnimationController,
        curve: Curves.easeInOut,
      ),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _zoomAnimationController,
        curve: Curves.easeOutBack,
      ),
    );

    // Inicializar búsqueda
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PlacesSearchCubit>().initializeSearch(
        categoryId: widget.categoryId,
        initialQuery: widget.initialQuery,
      );
    });
  }

  @override
  void dispose() {
    _fabAnimationController.dispose();
    _zoomAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: BlocConsumer<PlacesSearchCubit, PlacesSearchState>(
        listener: (context, state) {
          // Actualizar marcadores cuando cambien los lugares
          if (state.places.isNotEmpty) {
            _updateMapMarkersAndCamera(state);
          }
        },
        builder: (context, state) {
          return SlidingUpPanel(
            controller: _panelController,
            maxHeight: MediaQuery.of(context).size.height * 0.85,
            minHeight: MediaQuery.of(context).size.height * 0.35,
            parallaxEnabled: true,
            parallaxOffset: 0.5,
            backdropEnabled: true,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            onPanelSlide: (position) {
              setState(() {
                _panelPosition = position;
                if (position > 0.5) {
                  _isMapMode = false;
                  _fabAnimationController.forward();
                } else {
                  _isMapMode = true;
                  _fabAnimationController.reverse();
                }
              });
            },
            panel: _buildPanel(state),
            body: _buildMapView(state),
          );
        },
      ),
      floatingActionButton: _buildFloatingActionButtons(context),
    );
  }

  Widget _buildMapView(PlacesSearchState state) {
    return Stack(
      children: [
        // Google Maps
        GoogleMap(
          onMapCreated: (GoogleMapController controller) {
            _mapController = controller;
            _updateMapMarkersAndCamera(state);
          },
          initialCameraPosition: _initialPosition,
          markers: _createMarkersFromPlaces(state.places),
          myLocationEnabled: false,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          mapToolbarEnabled: false,
          compassEnabled: true,
          trafficEnabled: false,
          buildingsEnabled: true,
          onTap: (LatLng position) {
            // Cerrar panel al tocar el mapa
            if (_panelPosition > 0.3) {
              _panelController.animatePanelToPosition(0.0);
            }

            // Limpiar selección al tocar el mapa
            _clearSelection();
          },
          onCameraMove: (CameraPosition position) {
            context.read<PlacesSearchCubit>().updateMapCenter(position.target);
          },
        ),

        // Overlay superior con barra de búsqueda
        Positioned(
          top: MediaQuery.of(context).padding.top,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(16),
            child: PlacesSearchBar(
              initialQuery: widget.initialQuery,
              onFilterPressed: _showFiltersBottomSheet,
            ),
          ),
        ),

        // Indicador de lugares encontrados
        Positioned(
          top: MediaQuery.of(context).padding.top + 80,
          left: 16,
          child: AnimatedOpacity(
            opacity: _isMapMode ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                '${state.places.length} lugares',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),

        // Overlay de información del lugar seleccionado
        if (_selectedPlace != null)
          Positioned(
            bottom: 100,
            left: 16,
            right: 16,
            child: SlideTransition(
              position: _slideAnimation,
              child: FadeTransition(
                opacity: _zoomAnimation,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
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
                          Icon(
                            Icons.location_on,
                            color: Theme.of(context).primaryColor,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              _selectedPlace!.name ?? 'Lugar sin nombre',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _selectedPlace = null;
                              });
                              _zoomAnimationController.reverse();
                            },
                            icon: const Icon(Icons.close, size: 20),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                      if (_selectedPlace!.address != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          _selectedPlace!.address!,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                      if (_selectedPlace!.rating != null) ...[
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              '${_selectedPlace!.rating!.toStringAsFixed(1)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildPanel(PlacesSearchState state) {
    return Column(
      children: [
        // Handle del panel
        Container(
          width: 40,
          height: 4,
          margin: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(2),
          ),
        ),

        // Header del panel
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.categoryName ?? 'Lugares encontrados',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                onPressed: _toggleView,
                icon: Icon(
                  _isMapMode ? Icons.list : Icons.map,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),

        const Divider(height: 1),

        // Lista de lugares
        Expanded(child: _buildPlacesList(state)),
      ],
    );
  }

  Widget _buildPlacesList(PlacesSearchState state) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.places.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_off, size: 64, color: Colors.grey.shade400),
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
              'Intenta con otra categoría o búsqueda',
              style: TextStyle(color: Colors.grey.shade500),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: state.places.length,
      itemBuilder: (context, index) {
        final place = state.places[index];
        return PlaceCompactCard(
          place: place,
          onTap: () => _selectPlace(place),
          isSelected: state.selectedPlace?.id == place.id,
        );
      },
    );
  }

  Widget _buildFloatingActionButtons(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Botón Mi Ubicación
        FloatingActionButton(
          heroTag: "location",
          mini: true,
          onPressed: _goToCurrentLocation,
          backgroundColor: Colors.white,
          foregroundColor: Colors.grey.shade700,
          child: const Icon(Icons.my_location),
        ),

        const SizedBox(height: 12),

        // Botón alternar vista (aparece cuando el panel está arriba)
        AnimatedBuilder(
          animation: _fabAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _fabAnimation.value,
              child: FloatingActionButton(
                heroTag: "toggle",
                onPressed: _toggleView,
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                child: Icon(_isMapMode ? Icons.list : Icons.map),
              ),
            );
          },
        ),
      ],
    );
  }

  Set<Marker> _createMarkersFromPlaces(List<Place> places) {
    final markers = <Marker>{};

    for (final place in places) {
      if (place.latitude == null || place.longitude == null) continue;

      final isSelected = _selectedPlace?.id == place.id;

      markers.add(
        Marker(
          markerId: MarkerId(place.id ?? ''),
          position: LatLng(place.latitude!, place.longitude!),
          infoWindow: InfoWindow(
            title: place.name ?? 'Lugar sin nombre',
            snippet: place.address ?? '',
          ),
          onTap: () => _selectPlace(place),
          // Marcador especial para el lugar seleccionado
          icon:
              isSelected
                  ? BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueRed,
                  )
                  : BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueBlue,
                  ),
          // Hacer el marcador seleccionado más grande
          anchor: isSelected ? const Offset(0.5, 1.0) : const Offset(0.5, 1.0),
          // Añadir animación al marcador seleccionado
          flat: !isSelected,
          rotation: isSelected ? 0.0 : 0.0,
          // Información adicional para el marcador seleccionado
          consumeTapEvents: true,
        ),
      );
    }

    return markers;
  }

  void _updateMapMarkersAndCamera(PlacesSearchState state) {
    if (_mapController != null && state.places.isNotEmpty) {
      // Centrar el mapa en los lugares encontrados
      if (state.mapCenter != null) {
        _mapController!.animateCamera(CameraUpdate.newLatLng(state.mapCenter!));
      } else {
        // Si no hay centro específico, usar el primer lugar
        final firstPlace = state.places.first;
        if (firstPlace.latitude != null && firstPlace.longitude != null) {
          _mapController!.animateCamera(
            CameraUpdate.newLatLng(
              LatLng(firstPlace.latitude!, firstPlace.longitude!),
            ),
          );
        }
      }
    }
  }

  void _selectPlace(Place place) {
    // Actualizar el estado del cubit
    context.read<PlacesSearchCubit>().selectPlace(place);

    // Actualizar el lugar seleccionado localmente
    setState(() {
      _selectedPlace = place;
    });

    // Animar cámara al lugar seleccionado con efecto de zoom suave
    if (_mapController != null &&
        place.latitude != null &&
        place.longitude != null) {
      // Crear una animación de zoom más sofisticada
      _animateToPlace(place);
    }

    // Cerrar panel si está muy arriba
    if (_panelPosition > 0.7) {
      _panelController.animatePanelToPosition(0.3);
    }
  }

  /// Anima la cámara hacia un lugar específico con efectos visuales
  void _animateToPlace(Place place) {
    if (_mapController == null ||
        place.latitude == null ||
        place.longitude == null)
      return;

    final targetPosition = LatLng(place.latitude!, place.longitude!);

    // Obtener la posición actual de la cámara
    _mapController!.getVisibleRegion().then((bounds) {
      // Calcular la distancia actual al lugar
      final currentCenter = LatLng(
        (bounds.northeast.latitude + bounds.southwest.latitude) / 2,
        (bounds.northeast.longitude + bounds.southwest.longitude) / 2,
      );

      // Determinar el nivel de zoom basado en la distancia
      final distance = _calculateDistance(currentCenter, targetPosition);
      final zoomLevel = _calculateOptimalZoom(distance);

      // Crear la animación de cámara
      final cameraPosition = CameraPosition(
        target: targetPosition,
        zoom: zoomLevel,
        tilt: 45.0, // Añadir inclinación para efecto 3D
        bearing: 0.0,
      );

      // Ejecutar la animación con duración personalizada
      _mapController!
          .animateCamera(CameraUpdate.newCameraPosition(cameraPosition))
          .then((_) {
            // Después de la animación, mostrar información del lugar
            _showPlaceInfo(place);
          });
    });
  }

  /// Calcula la distancia entre dos puntos (aproximación simple)
  double _calculateDistance(LatLng point1, LatLng point2) {
    // Usar una aproximación simple para evitar problemas con math
    final latDiff = (point2.latitude - point1.latitude).abs();
    final lonDiff = (point2.longitude - point1.longitude).abs();

    // Aproximación: 1 grado ≈ 111 km
    final latDistance = latDiff * 111000; // metros
    final lonDistance =
        lonDiff * 111000 * math.cos(point1.latitude * 0.0174533); // metros

    return math.sqrt(latDistance * latDistance + lonDistance * lonDistance);
  }

  /// Calcula el nivel de zoom óptimo basado en la distancia
  double _calculateOptimalZoom(double distance) {
    if (distance < 100) return 18.0; // Muy cerca
    if (distance < 500) return 16.0; // Cerca
    if (distance < 2000) return 14.0; // Media distancia
    if (distance < 5000) return 12.0; // Lejos
    return 10.0; // Muy lejos
  }

  /// Muestra información del lugar seleccionado
  void _showPlaceInfo(Place place) {
    // Iniciar animación de información
    _zoomAnimationController.forward();

    // El overlay se mostrará automáticamente cuando _selectedPlace no sea null
  }

  void _clearSelection() {
    // Actualizar el estado del cubit para limpiar la selección
    context.read<PlacesSearchCubit>().clearSelectedPlace();

    // Limpiar el lugar seleccionado localmente
    setState(() {
      _selectedPlace = null;
    });

    // Animar la cámara de vuelta a la posición inicial
    if (_mapController != null) {
      _mapController!.animateCamera(
        CameraUpdate.newCameraPosition(_initialPosition),
      );
    }
  }

  void _toggleView() {
    if (_isMapMode) {
      // Cambiar a vista de lista
      _panelController.animatePanelToPosition(1.0);
    } else {
      // Cambiar a vista de mapa
      _panelController.animatePanelToPosition(0.0);
    }
  }

  void _goToCurrentLocation() async {
    // TODO: Implementar geolocalización
    // Por ahora, centrar en La Habana
    if (_mapController != null) {
      _mapController!.animateCamera(
        CameraUpdate.newCameraPosition(_initialPosition),
      );
    }
  }

  void _showFiltersBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder:
          (context) => Container(
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                // Handle del bottom sheet
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),

                // Título
                Text(
                  'Filtros de búsqueda',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                // TODO: Implementar filtros
                const Expanded(
                  child: Center(child: Text('Filtros próximamente...')),
                ),
              ],
            ),
          ),
    );
  }
}

// Pantalla de test simple para Google Maps
class GoogleMapsTestScreen extends StatefulWidget {
  const GoogleMapsTestScreen({super.key});

  @override
  State<GoogleMapsTestScreen> createState() => _GoogleMapsTestScreenState();
}

class _GoogleMapsTestScreenState extends State<GoogleMapsTestScreen> {
  GoogleMapController? _mapController;
  String _status = "🔄 Inicializando Google Maps...";

  static const CameraPosition _laHabana = CameraPosition(
    target: LatLng(23.1136, -82.3666),
    zoom: 12.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🧪 Test Google Maps'),
        backgroundColor: Colors.green.shade600,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Status
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color:
                _status.contains("✅")
                    ? Colors.green.shade100
                    : Colors.blue.shade100,
            child: Text(
              _status,
              style: const TextStyle(fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ),

          // Google Map
          Expanded(
            child: GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
                setState(() {
                  _status = "✅ Google Maps cargado correctamente!";
                });
              },
              initialCameraPosition: _laHabana,
              markers: {
                const Marker(
                  markerId: MarkerId('habana'),
                  position: LatLng(23.1136, -82.3666),
                  infoWindow: InfoWindow(
                    title: 'La Habana',
                    snippet: 'Cuba 🇨🇺',
                  ),
                ),
              },
            ),
          ),
        ],
      ),
    );
  }
}
