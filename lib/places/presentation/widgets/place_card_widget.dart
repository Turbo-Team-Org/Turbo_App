import 'package:flutter/material.dart';

import '../../place_repository/models/place/place.dart';

class PlaceCard extends StatelessWidget {
  final Place place;
  final bool? isFavorite;
  final Function() onFavoritePressed;
  const PlaceCard({
    super.key,
    this.isFavorite,
    required this.place,
    required this.onFavoritePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SizedBox(
        width: 235, // Ancho fijo para la tarjeta
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen del lugar
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: Image.network(
                place.imageUrls.first, // URL de la imagen
                width: double.infinity, // Ocupa todo el ancho disponible
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            // Contenido de la tarjeta
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título del lugar
                  Text(
                    place.name,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),

                  Text(
                    place.description,
                    style: TextStyle(fontSize: 15, color: Colors.grey[600]),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  // Rating del lugar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            place.rating.toString(),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 184, 181, 181),
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(
                          isFavorite! ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite! ? Colors.red : Colors.grey,
                        ),
                        onPressed: onFavoritePressed,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
