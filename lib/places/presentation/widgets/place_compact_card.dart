import 'package:flutter/material.dart';
import 'package:core/core.dart';

class PlaceCompactCard extends StatelessWidget {
  final Place place;
  final VoidCallback? onTap;
  final bool isSelected;

  const PlaceCompactCard({
    super.key,
    required this.place,
    this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border:
            isSelected
                ? Border.all(color: Theme.of(context).primaryColor, width: 2)
                : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Imagen del lugar
                _buildPlaceImage(),

                const SizedBox(width: 16),

                // Información del lugar
                Expanded(child: _buildPlaceInfo()),

                const SizedBox(width: 12),

                // Botón de acción
                _buildActionButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceImage() {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child:
          place.imageUrls.isNotEmpty
              ? ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  place.imageUrls.first,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return _buildPlaceholderImage();
                  },
                ),
              )
              : _buildPlaceholderImage(),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(_getPlaceIcon(), color: Colors.grey.shade600, size: 32),
    );
  }

  Widget _buildPlaceInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Nombre del lugar
        Text(
          place.name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),

        const SizedBox(height: 4),

        // Dirección
        if (place.address != null)
          Text(
            place.address!,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

        const SizedBox(height: 8),

        // Rating y precio
        Row(
          children: [
            // Rating
            if (place.rating != null) ...[
              Icon(Icons.star, size: 16, color: Colors.amber.shade600),
              const SizedBox(width: 4),
              Text(
                place.rating!.toStringAsFixed(1),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(width: 12),
            ],

            // Precio promedio
            if (place.averagePrice != null) ...[
              Icon(Icons.attach_money, size: 16, color: Colors.green.shade600),
              Text(
                '\$${place.averagePrice!.toStringAsFixed(0)}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.green.shade600,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        onPressed: () {
          // TODO: Navegar a detalles o booking
          onTap?.call();
        },
        icon: Icon(
          Icons.arrow_forward_ios,
          color: Theme.of(context).primaryColor,
          size: 16,
        ),
        constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
      ),
    );
  }

  IconData _getPlaceIcon() {
    // Determinar icono basado en categoría
    switch (place.categoryId?.toLowerCase()) {
      case 'restaurants':
      case 'restaurant':
        return Icons.restaurant;
      case 'bars':
      case 'bar':
        return Icons.local_bar;
      case 'hotels':
      case 'hotel':
        return Icons.hotel;
      case 'attractions':
      case 'attraction':
        return Icons.attractions;
      case 'shops':
      case 'shopping':
        return Icons.shopping_bag;
      default:
        return Icons.place;
    }
  }
}
