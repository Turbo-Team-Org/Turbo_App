import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:turbo/app/core/extensions/place_extensions.dart';
import 'package:turbo/app/core/theme/text_styles.dart';
import 'package:animate_do/animate_do.dart';

class BusinessHeader extends StatelessWidget {
  final Place place;

  const BusinessHeader({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    final daySchedule =
        place.scheduleForWeekday(DateTime.now().weekday);
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
                    ? (daySchedule != null && daySchedule.closing.isNotEmpty
                        ? 'Cierra a las ${daySchedule.closing}'
                        : 'Abierto ahora')
                    : (daySchedule != null && daySchedule.opening.isNotEmpty
                        ? 'Abre a las ${daySchedule.opening}'
                        : 'Cerrado ahora'),
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
