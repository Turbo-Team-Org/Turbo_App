import 'package:flutter/material.dart';
import 'package:turbo/places/place_repository/models/place/place.dart';
import 'package:turbo/app/shared/ui/rotation_3d.dart';
import 'package:turbo/app/shared/ui/styles.dart';

/// Widget que renderiza una tarjeta de lugar con efectos 3D
class PlaceCard3D extends StatelessWidget {
  final Place place;
  final double offset;
  final double cardWidth;
  final double cardHeight;
  final bool isFavorite;
  final Function() onFavoritePressed;

  const PlaceCard3D({
    Key? key,
    required this.place,
    this.offset = 0,
    this.cardWidth = 250,
    required this.cardHeight,
    required this.isFavorite,
    required this.onFavoritePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: cardWidth,
      margin: const EdgeInsets.only(top: 8),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: <Widget>[
          // Fondo de la tarjeta con sombras dinámicas según el offset
          _buildCardBackground(),

          // Imagen del lugar con efecto parallax
          Positioned(top: -15, child: _buildImageStack()),

          // Información del lugar
          _buildPlaceInfo(),

          // Botón de favorito
          Positioned(top: 10, right: 20, child: _buildFavoriteButton()),
        ],
      ),
    );
  }

  /// Construye el fondo de la tarjeta con efectos de sombra
  Widget _buildCardBackground() {
    return Container(
      margin: const EdgeInsets.only(top: 30, left: 12, right: 12, bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4 * offset.abs(),
            offset: Offset(offset * 5, 2),
          ),
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10 + 6 * offset.abs(),
            offset: Offset(offset * 10, 4),
          ),
        ],
      ),
    );
  }

  /// Construye la imagen del lugar con un efecto de parallax
  Widget _buildImageStack() {
    double maxParallax = 30;
    double globalOffset = offset * maxParallax * 2;
    double cardPadding = 24;
    double containerWidth = cardWidth - cardPadding;

    return Container(
      height: cardHeight * 0.6,
      width: containerWidth,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(offset * 2, 2),
          ),
        ],
      ),
      // Aplicamos transformación para crear efecto parallax
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Imagen principal
          Positioned(
            left: -globalOffset * 0.2,
            right: globalOffset * 0.2,
            top: 0,
            bottom: 0,
            child: Image.network(place.imageUrls.first, fit: BoxFit.cover),
          ),
          // Gradiente para mejorar la legibilidad
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.3)],
                stops: const [0.7, 1.0],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Construye la información del lugar
  Widget _buildPlaceInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // Espacio para la imagen
        SizedBox(width: double.infinity, height: cardHeight * 0.45),

        // Título del lugar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            place.name,
            style: AppStyles.placeTitle,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(height: 4),

        // Descripción del lugar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Text(
            place.description,
            style: AppStyles.placeDescription,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(height: 8),

        // Rating del lugar
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 16),
            const SizedBox(width: 4),
            Text(place.rating.toString(), style: AppStyles.placeRating),
          ],
        ),
        const Spacer(),

        // Botón de acción
        TextButton(
          onPressed: () {},
          child: Text('VER DETALLES', style: AppStyles.cardAction),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  /// Construye el botón de favorito
  Widget _buildFavoriteButton() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: isFavorite ? Colors.red : Colors.grey,
          size: 20,
        ),
        onPressed: onFavoritePressed,
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
      ),
    );
  }
}
