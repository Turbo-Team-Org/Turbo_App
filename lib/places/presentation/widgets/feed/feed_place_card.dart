import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:turbo_ui/turbo_ui.dart';
import 'package:turbo/app/core/extensions/place_extensions.dart';
import 'package:turbo/app/l10n/l10n.dart';
import 'package:turbo/authentication/state_management/auth_cubit/cubit/auth_cubit_cubit.dart';
import 'package:turbo/favorites/state_management/cubit/favorite_cubit.dart';
import 'package:turbo/places/presentation/screens/business_detail.dart';

/// Tarjeta de lugar para el feed con diseño moderno
/// 
/// Características:
/// - Imagen con Hero animation
/// - Botón de favorito
/// - Badge de estado (abierto/cerrado)
/// - Rating y precio
/// - Animación de tap
class FeedPlaceCard extends StatefulWidget {
  final Place place;
  final int index;
  final bool isFavorite;

  const FeedPlaceCard({
    super.key,
    required this.place,
    required this.index,
    this.isFavorite = false,
  });

  @override
  State<FeedPlaceCard> createState() => _FeedPlaceCardState();
}

class _FeedPlaceCardState extends State<FeedPlaceCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  void _navigateToDetails() {
    HapticFeedback.lightImpact();
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        reverseTransitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: BusinessDetailsScreen(id: widget.place.id),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return FadeInUp(
      delay: Duration(milliseconds: 80 * (widget.index % 6)),
      duration: const Duration(milliseconds: 500),
      child: GestureDetector(
        onTapDown: (_) => _scaleController.forward(),
        onTapCancel: () => _scaleController.reverse(),
        onTapUp: (_) {
          _scaleController.reverse().then((_) => _navigateToDetails());
        },
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: child,
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withValues(alpha: 0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImageSection(context),
                _buildInfoSection(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection(BuildContext context) {
    final place = widget.place;
    final colorScheme = Theme.of(context).colorScheme;

    return Stack(
      children: [
        // Imagen principal
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: Hero(
            tag: 'place_image_${place.id}',
            child: AspectRatio(
              aspectRatio: 1.15,
              child: CachedNetworkImage(
                imageUrl: place.mainImage.isNotEmpty
                    ? place.mainImage
                    : (place.imageUrls.isNotEmpty
                        ? place.imageUrls.first
                        : ''),
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: colorScheme.surfaceContainerHighest,
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: colorScheme.primary.withValues(alpha: 0.5),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: colorScheme.surfaceContainerHighest,
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    size: 40,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
          ),
        ),

        // Botón de favorito
        Positioned(
          top: 8,
          right: 8,
          child: _FavoriteButton(
            placeId: place.id,
            isFavorite: widget.isFavorite,
          ),
        ),

        // Badge de estado
        if (place.isOpen)
          Positioned(
            top: 8,
            left: 8,
            child: _StatusBadge(isOpen: place.isOpen),
          ),
      ],
    );
  }

  Widget _buildInfoSection(BuildContext context) {
    final place = widget.place;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Nombre
          Text(
            place.name,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),

          // Dirección
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 14,
                color: colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  place.address,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Rating y Precio
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Rating
              Row(
                children: [
                  Icon(
                    Icons.star_rounded,
                    color: TurboColors.gold,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    place.rating.toStringAsFixed(1),
                    style: theme.textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ],
              ),

              // Precio
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '\$${place.averagePrice.toStringAsFixed(0)}',
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Botón de favorito con animación
class _FavoriteButton extends StatelessWidget {
  final String placeId;
  final bool isFavorite;

  const _FavoriteButton({
    required this.placeId,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          HapticFeedback.lightImpact();
          final authState = context.read<AuthCubit>().state;
          if (authState is Authenticated) {
            context.read<FavoriteCubit>().toggleFavorite(
              userId: authState.user.uid,
              placeId: placeId,
            );
          }
        },
        customBorder: const CircleBorder(),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: colorScheme.surface.withValues(alpha: 0.95),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            transitionBuilder: (child, animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: Icon(
              isFavorite ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
              key: ValueKey(isFavorite),
              color: isFavorite ? TurboColors.error : colorScheme.onSurfaceVariant,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}

/// Badge de estado del lugar
class _StatusBadge extends StatelessWidget {
  final bool isOpen;

  const _StatusBadge({required this.isOpen});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = context.l10n;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: colorScheme.surface.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: isOpen ? TurboColors.success : TurboColors.error,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            isOpen ? l10n.placeOpen : l10n.placeClosed,
            style: TextStyle(
              color: isOpen ? TurboColors.success : TurboColors.error,
              fontSize: 10,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}
