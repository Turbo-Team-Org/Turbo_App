import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:turbo/app/core/theme/text_styles.dart';
import 'package:turbo/app/utils/app_preferences.dart';
import 'package:turbo/app/utils/theme/style.dart';
import 'package:turbo/authentication/state_managament/auth_cubit/cubit/auth_cubit_cubit.dart';
import 'package:turbo/favorites/state_management/cubit/favorite_cubit.dart';
import 'package:turbo/places/state_management/place_bloc/cubit/place_cubit.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../place_repository/models/place/place.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
// Importar los widgets separados
import '../widgets/business_details/business_sliver_app_bar.dart';
import '../widgets/business_details/business_header.dart';
import '../widgets/business_details/description_section.dart';
import '../widgets/business_details/offer_section.dart';
import '../widgets/business_details/review_section.dart';

@RoutePage()
class BusinessDetailsScreen extends StatefulWidget {
  final String id;

  const BusinessDetailsScreen({super.key, required this.id});

  @override
  State<BusinessDetailsScreen> createState() => _BusinessDetailsScreenState();
}

class _BusinessDetailsScreenState extends State<BusinessDetailsScreen> {
  bool _showAppBarBackground = false;
  final ScrollController _scrollController = ScrollController();
  String _userName = "explorador";
  String _userPhotoUrl = "";
  final prefs = AppPreferences();

  @override
  void initState() {
    super.initState();
    // Cambiar el estado de la barra de estado para hacerla transparente
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent),
    );

    // Añadir listener para detectar scroll y cambiar la apariencia del AppBar
    _scrollController.addListener(_onScroll);

    // Cargar datos del usuario
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userName = prefs.getString('userName');
      final userPhotoUrl = prefs.getString('userPhotoUrl');

      if (mounted) {
        setState(() {
          if (userName != null && userName.isNotEmpty) {
            _userName = userName;
          }

          if (userPhotoUrl != null && userPhotoUrl.isNotEmpty) {
            _userPhotoUrl = userPhotoUrl;
          }
        });
      }
    } catch (e) {
      debugPrint('Error cargando datos de usuario: $e');
    }
  }

  void _onScroll() {
    final showBackground = _scrollController.offset > 180;
    if (showBackground != _showAppBarBackground) {
      setState(() {
        _showAppBarBackground = showBackground;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _launchMaps(Place place) async {
    final query = Uri.encodeComponent('${place.name}, ${place.address}, Cuba');
    final url = 'https://maps.apple.com/?q=$query';

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      // Fallback para Android o si Apple Maps no está disponible
      final googleUrl =
          'https://www.google.com/maps/search/?api=1&query=$query';
      if (await canLaunchUrl(Uri.parse(googleUrl))) {
        await launchUrl(Uri.parse(googleUrl));
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No se pudo abrir la aplicación de mapas'),
            ),
          );
        }
      }
    }
  }

  void _makePhoneCall() async {
    // Aquí normalmente usaríamos el número telefónico del negocio
    const phoneNumber = 'tel:+5358464372';
    if (await canLaunchUrl(Uri.parse(phoneNumber))) {
      await launchUrl(Uri.parse(phoneNumber));
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No se pudo realizar la llamada telefónica'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaceCubit, PlaceState>(
      builder: (context, state) {
        if (state is PlacesLoading || state is PlacesInitial) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          );
        } else if (state is PlacesLoaded) {
          // Encontrar el lugar por su ID
          final place = state.places.firstWhere(
            (p) => p.id == widget.id,
            orElse:
                () => Place(
                  id: '',
                  name: 'No encontrado',
                  description: '',
                  address: '',
                  averagePrice: 0,
                  imageUrls: [],
                  rating: 0,
                  reviews: [],
                ),
          );

          if (place.id.isEmpty) {
            return Scaffold(
              body: Center(
                child: Text('No se encontró el negocio con ID: ${widget.id}'),
              ),
            );
          }

          return Scaffold(
            body: CustomScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              slivers: [
                // AppBar con imagen de fondo
                BusinessSliverAppBar(
                  place: place,
                  showBackground: _showAppBarBackground,
                  prefs: prefs,
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Información principal del negocio (nombre, dirección, etc)
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BusinessHeader(place: place),
                            const SizedBox(height: 24),

                            // Sección de descripción
                            DescriptionSection(place: place),
                            const SizedBox(height: 24),

                            // Botón del menú si está disponible
                            if (place.menuUrl.isNotEmpty)
                              FadeInUp(
                                delay: const Duration(milliseconds: 200),
                                duration: const Duration(milliseconds: 400),
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Styles.turboRed,
                                        Theme.of(
                                          context,
                                        ).colorScheme.primary.withOpacity(0.9),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary.withOpacity(0.3),
                                        blurRadius: 8,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () async {
                                        if (await canLaunchUrl(
                                          Uri.parse(place.menuUrl),
                                        )) {
                                          await launchUrl(
                                            Uri.parse(place.menuUrl),
                                          );
                                        } else {
                                          if (mounted) {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  'No se pudo abrir el menú',
                                                ),
                                              ),
                                            );
                                          }
                                        }
                                      },
                                      borderRadius: BorderRadius.circular(15),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 16,
                                          horizontal: 20,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                color: Colors.white.withOpacity(
                                                  0.2,
                                                ),
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                Icons.menu_book,
                                                color: Colors.white,
                                                size: 24,
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            const Text(
                                              'Ver Menú',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Container(
                                              padding: const EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                color: Colors.white.withOpacity(
                                                  0.2,
                                                ),
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                Icons.arrow_forward_ios,
                                                color: Colors.white,
                                                size: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            if (place.menuUrl.isNotEmpty)
                              const SizedBox(height: 24),

                            // Sección de ofertas
                            OfferSection(place: place),
                            const SizedBox(height: 24),

                            // Sección de reseñas
                            ReviewSection(place: place),
                            const SizedBox(
                              height: 80,
                            ), // Espacio para la barra inferior
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            bottomNavigationBar: BottomActionBar(
              place: place,
              onCall: _makePhoneCall,
              onNavigate: () => _launchMaps(place),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                final authState = context.read<AuthCubit>().state;
                if (authState is Authenticated) {
                  final favoriteCubit = context.read<FavoriteCubit>();
                  favoriteCubit.toggleFavorite(
                    userId: authState.user.uid,
                    placeId: place.id,
                  );
                }
              },
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: BlocBuilder<FavoriteCubit, FavoriteState>(
                builder: (context, favState) {
                  bool isFavorite = false;
                  if (favState is FavoriteLoaded) {
                    isFavorite = favState.favorites.any(
                      (fav) => fav.placeId.toString() == place.id,
                    );
                  }
                  return Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Colors.white,
                  );
                },
              ),
            ),
          );
        } else if (state is PlacesError) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 60, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Error al cargar la información',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.error,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => context.router.pop(),
                    child: const Text('Volver'),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          );
        }
      },
    );
  }
}

class BottomActionBar extends StatelessWidget {
  final Place place;
  final VoidCallback onCall;
  final VoidCallback onNavigate;

  const BottomActionBar({
    super.key,
    required this.place,
    required this.onCall,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: const Duration(milliseconds: 400),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.call, size: 18),
                  label: const Text('Llamar'),
                  onPressed: onCall,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.directions, size: 18),
                  label: const Text('Ir'),
                  onPressed: onNavigate,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
