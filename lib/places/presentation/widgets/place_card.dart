import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turbo/authentication/state_managament/auth_cubit/cubit/auth_cubit_cubit.dart';
import 'package:turbo/favorites/state_management/cubit/favorite_cubit.dart';
import 'package:turbo/places/place_repository/models/place/place.dart';

class PlaceCard extends StatefulWidget {
  final Place place;
  final VoidCallback onTap;

  const PlaceCard({Key? key, required this.place, required this.onTap})
    : super(key: key);

  @override
  State<PlaceCard> createState() => _PlaceCardState();
}

class _PlaceCardState extends State<PlaceCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.3,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleFavorite() async {
    final authState = context.read<AuthCubit>().state;
    if (authState is! Authenticated) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Debes iniciar sesión para marcar favoritos'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    // Feedback háptico y animación
    HapticFeedback.mediumImpact();
    // Obtenemos el estado actual para decidir la animación
    final favoriteCubit = context.read<FavoriteCubit>();
    final isCurrentlyFavorite = favoriteCubit.isFavorite(widget.place.id);
    if (!isCurrentlyFavorite) {
      // Animar solo al marcar como favorito
      _controller.forward().then((_) => _controller.reverse());
    }

    // Actualizar en Firestore (ya no necesitamos setState local)
    await favoriteCubit.toggleFavorite(
      userId: authState.user.uid,
      placeId: widget.place.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Escuchar los cambios en FavoriteCubit
    final favoriteCubit = context.watch<FavoriteCubit>();
    final bool isFavorite = favoriteCubit.isFavorite(widget.place.id);

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Contenido de la tarjeta
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Imagen del lugar
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: Image.network(
                    widget.place.mainImage,
                    height: 200,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (context, error, stackTrace) => Container(
                          height: 200,
                          color: Colors.grey[300],
                          child: const Icon(
                            Icons.broken_image,
                            color: Colors.grey,
                            size: 50,
                          ),
                        ),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        height: 200,
                        color: Colors.grey[300],
                        child: Center(
                          child: CircularProgressIndicator(
                            value:
                                loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Información del lugar
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.place.name,
                        style: Theme.of(context).textTheme.titleLarge,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.place.description,
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Botón de favorito animado
            Positioned(
              top: 8,
              right: 8,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: _toggleFavorite,
                      customBorder: const CircleBorder(),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          // Usar el estado del cubit directamente
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.redAccent : Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
