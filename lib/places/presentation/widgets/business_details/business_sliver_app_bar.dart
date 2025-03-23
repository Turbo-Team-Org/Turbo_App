import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turbo/app/core/theme/text_styles.dart';
import 'package:animate_do/animate_do.dart';
import 'package:turbo/favorites/state_management/cubit/favorite_cubit.dart';
import 'package:turbo/places/place_repository/models/place/place.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BusinessSliverAppBar extends StatelessWidget {
  final Place place;
  final bool showBackground;

  const BusinessSliverAppBar({
    super.key,
    required this.place,
    required this.showBackground,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 250,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Usar CachedNetworkImage directamente
            place.imageUrls.isNotEmpty
                ? CachedNetworkImage(
                  imageUrl:
                      place.mainImage.isNotEmpty
                          ? place.mainImage
                          : place.imageUrls.first,
                  fit: BoxFit.cover,
                  placeholder:
                      (context, url) => Container(
                        color: Colors.grey.shade300,
                        child: const Center(child: CircularProgressIndicator()),
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
                )
                : Container(
                  color: Colors.grey.shade300,
                  child: const Center(
                    child: Icon(
                      Icons.image_not_supported,
                      size: 50,
                      color: Colors.grey,
                    ),
                  ),
                ),

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
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).colorScheme.primary,
            ),
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

              if (state is FavoriteLoaded) {
                isFavorite = state.favorites.any(
                  (fav) => fav.placeId.toString() == place.id,
                );
              }

              return CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.9),
                child: IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color:
                        isFavorite
                            ? Theme.of(context).colorScheme.primary
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
                    backgroundColor: Theme.of(context).colorScheme.primary,
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
