import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:turbo/app/core/theme/text_styles.dart';
import 'package:turbo/authentication/state_managament/auth_cubit/cubit/auth_cubit_cubit.dart';
import 'package:turbo/favorites/state_management/cubit/favorite_cubit.dart';
import 'package:turbo/places/state_management/place_bloc/cubit/place_cubit.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../reviews/review_repository/models/review.dart';
import '../../place_repository/models/offer/offer.dart';
import '../../place_repository/models/place/place.dart';
import '../widgets/feed_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';
import 'dart:async';

@RoutePage()
class BusinessDetailsScreen extends StatefulWidget {
  final String id;

  const BusinessDetailsScreen({super.key, required this.id});

  @override
  State<BusinessDetailsScreen> createState() => _BusinessDetailsScreenState();
}

class _BusinessDetailsScreenState extends State<BusinessDetailsScreen> {
  final PageController _pageController = PageController();
  int _currentImageIndex = 0;
  bool _showAppBarBackground = false;
  final ScrollController _scrollController = ScrollController();
  String _userName = "explorador";
  String _userPhotoUrl = "";

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
    _pageController.dispose();
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
      }
    }
  }

  void _launchPhone() async {
    const phoneNumber = "+53 5555 5555"; // Número ficticio para demostración
    final url = 'tel:$phoneNumber';

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PlaceCubit, PlaceState>(
        builder: (_, state) {
          switch (state) {
            case PlacesLoaded():
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
                return const Center(child: Text('No se encontró el negocio'));
              }

              return CustomScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                slivers: [
                  BusinessSliverAppBar(place: place),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BusinessHeader(place: place),
                          const SizedBox(height: 20),
                          DescriptionSection(place: place),
                          const SizedBox(height: 20),
                          RatingSection(place: place),
                          const SizedBox(height: 24),
                          OfferSection(place: place),
                          const SizedBox(height: 24),
                          ReviewSection(place: place),
                          const SizedBox(
                            height: 80,
                          ), // Space for bottom buttons
                        ],
                      ),
                    ),
                  ),
                ],
              );

            case PlacesLoading():
            case PlacesInitial():
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(
                      color: AppColors.primaryRed,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Cargando detalles...',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: AppTextStyles.fontSizeMd,
                      ),
                    ),
                  ],
                ),
              );

            case PlacesError():
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: AppColors.primaryRed,
                      size: 64,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Error: ${state.error}',
                      style: const TextStyle(
                        color: AppColors.primaryRed,
                        fontSize: AppTextStyles.fontSizeMd,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () => context.read<PlaceCubit>().getPlaces(),
                      icon: const Icon(Icons.refresh),
                      label: const Text('Reintentar'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryRed,
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
              );
          }
        },
      ),
      bottomSheet: BlocBuilder<PlaceCubit, PlaceState>(
        builder: (context, state) {
          switch (state) {
            case PlacesLoaded():
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

              if (place.id.isEmpty) return const SizedBox();

              return BottomActionBar(
                place: place,
                onCall: _launchPhone,
                onNavigate: () => _launchMaps(place),
              );

            default:
              return const SizedBox();
          }
        },
      ),
    );
  }

  void _showAddReviewModal(BuildContext context, String placeId) {
    // Implementar la lógica para mostrar el modal de agregar reseña
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Añadir reseña',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Funcionalidad en desarrollo...',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cerrar'),
                ),
              ],
            ),
          ),
    );
  }
}

// Widgets stateless para mejorar el rendimiento

class BusinessSliverAppBar extends StatelessWidget {
  final Place place;

  const BusinessSliverAppBar({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 250,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            ImageCarousel(place: place),

            // Gradient overlay for better text visibility - usando el nuevo gradiente
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.3),
                    Colors.black.withOpacity(0.7),
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
            // Añadimos indicador de estado abierto/cerrado en una posición destacada
            if (place.isOpen)
              Positioned(
                bottom: 20,
                left: 20,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 2,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        'ABIERTO AHORA',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            // Nombre del negocio en la imagen para mejorar UX
            Positioned(
              bottom: place.isOpen ? 70 : 20,
              left: 20,
              right: 20,
              child: Text(
                place.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      offset: Offset(0, 2),
                      blurRadius: 4,
                      color: Colors.black54,
                    ),
                  ],
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      leading: FadeInLeft(
        duration: const Duration(milliseconds: 300),
        child: CircleAvatar(
          backgroundColor: Colors.white.withOpacity(0.9),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.primaryRed),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      actions: [
        FadeInRight(
          duration: const Duration(milliseconds: 300),
          child: BlocBuilder<FavoriteCubit, FavoriteState>(
            builder: (context, state) {
              bool isFavorite = false;

              switch (state) {
                case FavoriteLoaded():
                  isFavorite = state.favorites.contains(place.id);
                  break;
                default:
                  isFavorite = false;
              }

              return CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.9),
                child: IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color:
                        isFavorite
                            ? AppColors.primaryRed
                            : Colors.grey.shade600,
                  ),
                  onPressed: () {
                    final favoriteCubit = context.read<FavoriteCubit>();
                    favoriteCubit.toggleFavorite(int.parse(place.id), '');
                    HapticFeedback.mediumImpact(); // Vibración al dar "Me gusta"
                  },
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 8),
        FadeInRight(
          duration: const Duration(milliseconds: 400),
          child: CircleAvatar(
            backgroundColor: Colors.white.withOpacity(0.9),
            child: IconButton(
              icon: Icon(Icons.share, color: Colors.grey.shade600),
              onPressed: () {
                // Implementar compartir
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Compartiendo negocio...',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: AppColors.primaryRed,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(width: 16),
      ],
    );
  }
}

class BusinessHeader extends StatelessWidget {
  final Place place;

  const BusinessHeader({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    // Quitamos el nombre del negocio ya que lo mostramos en la imagen
    return FadeInUp(
      duration: const Duration(milliseconds: 400),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.location_on, size: 22, color: AppColors.primaryRed),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  place.address,
                  style: AppTextStyles.bodyLarge(
                    context,
                  ).copyWith(color: Colors.grey.shade700),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.access_time, size: 22, color: AppColors.primaryRed),
              const SizedBox(width: 8),
              Text(
                place.isOpen
                    ? place.schedules.isNotEmpty &&
                            DateTime.now().weekday - 1 < place.schedules.length
                        ? 'Cierra a las ${place.schedules[DateTime.now().weekday - 1].closing}'
                        : 'Abierto ahora'
                    : place.schedules.isNotEmpty &&
                        DateTime.now().weekday - 1 < place.schedules.length
                    ? 'Abre a las ${place.schedules[DateTime.now().weekday - 1].opening}'
                    : 'Cerrado ahora',
                style: AppTextStyles.bodyLarge(context).copyWith(
                  color:
                      place.isOpen
                          ? Colors.green.shade700
                          : Colors.red.shade700,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DescriptionSection extends StatelessWidget {
  final Place place;

  const DescriptionSection({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      delay: const Duration(milliseconds: 100),
      duration: const Duration(milliseconds: 400),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Acerca de',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            place.description,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: place.tags.map((tag) => _buildTag(context, tag)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(BuildContext context, String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        '#$tag',
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class RatingSection extends StatelessWidget {
  final Place place;

  const RatingSection({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      delay: const Duration(milliseconds: 200),
      duration: const Duration(milliseconds: 400),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.secondaryBlue.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.star_rate_rounded,
                  color: AppColors.secondaryBlue,
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'Calificaciones y Reseñas',
                style: AppTextStyles.titleMedium(
                  context,
                ).copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FadeIn(
                duration: const Duration(milliseconds: 500),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          place.rating.toStringAsFixed(1),
                          style: AppTextStyles.titleLarge(context).copyWith(
                            fontSize: 32.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondaryBlue,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'de 5',
                          style: AppTextStyles.bodyMedium(context).copyWith(
                            color: Theme.of(
                              context,
                            ).colorScheme.onBackground.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < place.rating.floor()
                              ? Icons.star_rounded
                              : index < place.rating
                              ? Icons.star_half_rounded
                              : Icons.star_outline_rounded,
                          color: AppColors.secondaryBlue,
                          size: 18,
                        );
                      }),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${place.reviews.length} reseñas',
                      style: AppTextStyles.bodyMedium(context).copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.onBackground.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  children: List.generate(5, (index) {
                    final ratingLevel = 5 - index;
                    final reviewsWithRating =
                        place.reviews
                            .where((r) => r.rating == ratingLevel)
                            .length;
                    final percentage =
                        place.reviews.isEmpty
                            ? 0.0
                            : reviewsWithRating / place.reviews.length;

                    return SlideInRight(
                      delay: Duration(milliseconds: 100 * index),
                      duration: const Duration(milliseconds: 500),
                      from: 50,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            Text(
                              '$ratingLevel',
                              style: AppTextStyles.bodySmall(context),
                            ),
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.star,
                              size: 14,
                              color: AppColors.secondaryBlue,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: LinearProgressIndicator(
                                  value: percentage,
                                  backgroundColor: Theme.of(
                                    context,
                                  ).colorScheme.onBackground.withOpacity(0.1),
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                        AppColors.secondaryBlue,
                                      ),
                                  minHeight: 8,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${(percentage * 100).toInt()}%',
                              style: AppTextStyles.bodySmall(context),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class OfferSection extends StatelessWidget {
  final Place place;

  const OfferSection({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    if (place.offers.isEmpty) {
      return const SizedBox();
    }

    return FadeInUp(
      delay: const Duration(milliseconds: 300),
      duration: const Duration(milliseconds: 400),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  // Icono con fondo para las ofertas
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primaryRed.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.local_offer,
                      color: AppColors.primaryRed,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Ofertas y Promociones',
                    style: AppTextStyles.titleMedium(context).copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryRed,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Text(
                      'Ver todas',
                      style: TextStyle(
                        color: AppColors.primaryRed,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: AppColors.primaryRed,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: place.offers.length,
              itemBuilder: (context, index) {
                final offer = place.offers[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: OfferCard(offer: offer, index: index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class OfferCard extends StatelessWidget {
  final Offer offer;
  final int index;

  const OfferCard({super.key, required this.offer, required this.index});

  @override
  Widget build(BuildContext context) {
    return FadeInRight(
      delay: Duration(milliseconds: 100 * index),
      duration: const Duration(milliseconds: 400),
      child: Container(
        width: 260,
        decoration: BoxDecoration(
          gradient:
              index % 2 == 0 ? AppColors.redGradient : AppColors.purpleGradient,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: (index % 2 == 0
                      ? AppColors.primaryRed
                      : const Color(0xFF8E2DE2))
                  .withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Elemento decorativo
            Positioned(
              right: -30,
              bottom: -30,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            // Icono de oferta
            Positioned(
              top: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _getOfferIcon(offer.name),
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            // Contenido de la oferta
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '¡OFERTA ESPECIAL!',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        offer.name.isNotEmpty ? offer.name : offer.offerTitle,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        offer.description.isNotEmpty
                            ? offer.description
                            : offer.offerDescription,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 14,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  // Botón para ver la oferta
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor:
                            index % 2 == 0
                                ? AppColors.primaryRed
                                : const Color(0xFF8E2DE2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Ver Detalles',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getOfferIcon(String offerName) {
    final name = offerName.toLowerCase();
    if (name.contains('descuento') || name.contains('off')) {
      return Icons.discount;
    } else if (name.contains('2x1') || name.contains('gratis')) {
      return Icons.card_giftcard;
    } else if (name.contains('bebida') || name.contains('cóctel')) {
      return Icons.local_bar;
    } else if (name.contains('comida') || name.contains('menú')) {
      return Icons.restaurant;
    } else {
      return Icons.local_offer;
    }
  }
}

class ReviewSection extends StatelessWidget {
  final Place place;

  const ReviewSection({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    if (place.reviews.isEmpty) {
      return const SizedBox();
    }

    return FadeInUp(
      delay: const Duration(milliseconds: 300),
      duration: const Duration(milliseconds: 400),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.rate_review_rounded,
                      color: Theme.of(context).colorScheme.primary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Reseñas de Clientes',
                    style: AppTextStyles.titleMedium(
                      context,
                    ).copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Ver todas',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...List.generate(
            min(3, place.reviews.length),
            (index) => FadeInLeft(
              delay: Duration(milliseconds: 100 * index),
              duration: const Duration(milliseconds: 400),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: ReviewCard(review: place.reviews[index]),
              ),
            ),
          ),
          Center(
            child: TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add_comment_outlined),
              label: const Text('Escribir una reseña'),
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withOpacity(0.5),
                    width: 1,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  final Review review;

  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Color(
                    (Random().nextDouble() * 0xFFFFFF).toInt(),
                  ).withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    review.userName.isNotEmpty
                        ? review.userName[0].toUpperCase()
                        : 'U',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.userName.isNotEmpty ? review.userName : 'Usuario',
                      style: AppTextStyles.bodyMedium(
                        context,
                      ).copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        ...List.generate(5, (index) {
                          return Icon(
                            index < review.rating
                                ? Icons.star
                                : Icons.star_border,
                            color: AppColors.secondaryBlue,
                            size: 14,
                          );
                        }),
                        const SizedBox(width: 8),
                        Text(
                          _formatDate(review.date),
                          style: AppTextStyles.bodySmall(context).copyWith(
                            color: Theme.of(
                              context,
                            ).colorScheme.onBackground.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (review.comment.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(review.comment, style: AppTextStyles.bodyMedium(context)),
          ],
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays < 1) {
      if (difference.inHours < 1) {
        return 'Hace ${difference.inMinutes} minutos';
      }
      return 'Hace ${difference.inHours} horas';
    } else if (difference.inDays < 7) {
      return 'Hace ${difference.inDays} días';
    } else if (difference.inDays < 30) {
      return 'Hace ${(difference.inDays / 7).floor()} semanas';
    } else if (difference.inDays < 365) {
      return 'Hace ${(difference.inDays / 30).floor()} meses';
    } else {
      return 'Hace ${(difference.inDays / 365).floor()} años';
    }
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.call),
                label: const Text('Llamar'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: onCall,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.directions),
                label: const Text('Cómo llegar'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  backgroundColor: Colors.blue,
                ),
                onPressed: onNavigate,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageCarousel extends StatefulWidget {
  final Place place;

  const ImageCarousel({super.key, required this.place});

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Iniciar autoplay después de que el widget se construya
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoPlay();
    });
  }

  @override
  void dispose() {
    _stopAutoPlay();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoPlay() {
    // Cancelar timer existente si hay uno
    _stopAutoPlay();
    // Crear nuevo timer para cambiar página cada 5 segundos
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_pageController.hasClients) {
        if (_currentPage < _getImages().length - 1) {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
          );
        } else {
          // Volver a la primera página con una animación suave
          _pageController.animateToPage(
            0,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  void _stopAutoPlay() {
    _timer?.cancel();
    _timer = null;
  }

  List<String> _getImages() {
    // Usar todas las imágenes disponibles, incluyendo la principal si existe
    List<String> images = [];

    if (widget.place.mainImage.isNotEmpty) {
      images.add(widget.place.mainImage);
    }

    // Añadir el resto de imágenes, evitando duplicados
    for (var image in widget.place.imageUrls) {
      if (image.isNotEmpty && image != widget.place.mainImage) {
        images.add(image);
      }
    }

    // Si no hay imágenes, usar una imagen de marcador de posición
    if (images.isEmpty) {
      images.add('https://via.placeholder.com/400x250?text=Sin+Imágenes');
    }

    return images;
  }

  @override
  Widget build(BuildContext context) {
    final images = _getImages();

    return Stack(
      children: [
        // PageView para el carrusel
        PageView.builder(
          controller: _pageController,
          itemCount: images.length,
          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
            });
          },
          itemBuilder: (context, index) {
            return FadeIn(
              duration: const Duration(milliseconds: 300),
              child: Hero(
                tag:
                    index == 0 && widget.place.mainImage.isNotEmpty
                        ? 'place_image_${widget.place.id}'
                        : 'place_image_${widget.place.id}_$index',
                child: CachedNetworkImage(
                  imageUrl: images[index],
                  fit: BoxFit.cover,
                  placeholder:
                      (context, url) => Container(
                        color: Colors.grey.shade300,
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryRed,
                          ),
                        ),
                      ),
                  errorWidget:
                      (context, url, error) => Container(
                        color: Colors.grey.shade300,
                        child: const Icon(
                          Icons.image_not_supported,
                          size: 50,
                          color: Colors.grey,
                        ),
                      ),
                ),
              ),
            );
          },
        ),

        // Indicador de página
        if (images.length > 1)
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Center(
              child: FadeInUp(
                duration: const Duration(milliseconds: 400),
                delay: const Duration(milliseconds: 400),
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: images.length,
                  effect: ExpandingDotsEffect(
                    activeDotColor: AppColors.primaryRed,
                    dotColor: Colors.white.withOpacity(0.7),
                    dotHeight: 8,
                    dotWidth: 8,
                    expansionFactor: 3,
                    spacing: 5,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
