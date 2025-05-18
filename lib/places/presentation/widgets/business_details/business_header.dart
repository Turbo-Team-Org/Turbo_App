import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:turbo/app/core/theme/text_styles.dart';
import 'package:animate_do/animate_do.dart';

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
