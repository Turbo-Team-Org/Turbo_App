import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:animate_do/animate_do.dart';
import 'package:turbo/app/core/theme/text_styles.dart';

class OfferCard extends StatelessWidget {
  final Offer offer;
  final int index;

  const OfferCard({super.key, required this.offer, required this.index});

  @override
  Widget build(BuildContext context) {
    // Verificar si hay datos disponibles y asegurar que se usen los campos correctos
    final String title =
        offer.name.isNotEmpty
            ? offer.name
            : offer.offerTitle.isNotEmpty
            ? offer.offerTitle
            : "Oferta Especial";

    final String description =
        offer.description.isNotEmpty
            ? offer.description
            : offer.offerDescription.isNotEmpty
            ? offer.offerDescription
            : "Sin descripción disponible";

    // Validar fechas
    final bool isValid = offer.offerValidUntil.isAfter(DateTime.now());

    return FadeInRight(
      delay: Duration(milliseconds: 100 * index),
      duration: const Duration(milliseconds: 400),
      child: ConstrainedBox(
        // Usar ConstrainedBox para controlar el tamaño exacto
        constraints: const BoxConstraints(
          maxWidth: 260,
          maxHeight: 175, // Altura ligeramente reducida
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient:
                index % 2 == 0
                    ? AppColors.redGradient
                    : AppColors.purpleGradient,
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
              // Elemento decorativo (simplificado)
              Positioned(
                right: -20,
                bottom: -20,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                ),
              ),

              // Contenido de la oferta
              Padding(
                padding: const EdgeInsets.all(12), // Reducido padding
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Fila superior: título y icono
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '¡OFERTA!', // Texto más corto
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            _getOfferIcon(title),
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 4),

                    // Descripción
                    Text(
                      description,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const Spacer(),

                    // Fila inferior: fecha de validez y botón
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          isValid
                              ? 'Válido: ${_formatDate(offer.offerValidUntil)}'
                              : 'Expirada',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 10,
                            fontStyle:
                                isValid ? FontStyle.normal : FontStyle.italic,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor:
                                index % 2 == 0
                                    ? AppColors.primaryRed
                                    : const Color(0xFF8E2DE2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            minimumSize: const Size(0, 0), // Sin tamaño mínimo
                            tapTargetSize:
                                MaterialTapTargetSize
                                    .shrinkWrap, // Reduce el tamaño de toque
                            visualDensity:
                                VisualDensity.compact, // Más compacto
                          ),
                          child: const Text(
                            'Ver Detalles',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 9,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Marca de validez (opcional, solo si no es válida)
              if (!isValid)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red.shade800,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(16),
                        bottomLeft: Radius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'EXPIRADA',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
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

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month'; // Formato más corto sin año
  }
}
