import 'package:flutter/material.dart';
import 'package:turbo/app/core/theme/text_styles.dart';
import 'package:turbo/places/place_repository/models/place/place.dart';
import 'package:animate_do/animate_do.dart';
import 'offer_card.dart';

class OfferSection extends StatelessWidget {
  final Place place;

  const OfferSection({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    // Si no hay ofertas, mostrar un mensaje informativo para mejor experiencia de usuario
    if (place.offers.isEmpty) {
      return FadeInUp(
        delay: const Duration(milliseconds: 300),
        duration: const Duration(milliseconds: 400),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
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
            const SizedBox(height: 16),
            // Hacemos que este contenedor tenga una altura fija para evitar overflow
            SizedBox(
              height: 175, // Misma altura que las tarjetas de ofertas
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 24,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.local_offer_outlined,
                        size: 48,
                        color: Colors.grey.shade400,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No hay ofertas disponibles en este momento',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
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
              // Solo mostramos "Ver todas" si hay más de 3 ofertas
              if (place.offers.length > 3)
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
            height: 175,
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
