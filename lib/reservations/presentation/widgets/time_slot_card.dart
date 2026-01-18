import 'package:flutter/material.dart';
import 'package:core/core.dart';

class TimeSlotCard extends StatelessWidget {
  final ReservationTimeSlot slot;
  final bool isSelected;
  final VoidCallback onTap;

  const TimeSlotCard({
    super.key,
    required this.slot,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: slot.hasAvailability ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: _getBackgroundColor(context),
          border: Border.all(
            color: _getBorderColor(context),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow:
              isSelected
                  ? [
                    BoxShadow(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                  : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Hora
            Text(
              slot.formattedTime,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: _getTextColor(context),
              ),
            ),

            const SizedBox(height: 4),

            // Disponibilidad
            Text(
              _getAvailabilityText(),
              style: TextStyle(fontSize: 12, color: _getSubtextColor(context)),
            ),
          ],
        ),
      ),
    );
  }

  Color _getBackgroundColor(BuildContext context) {
    if (!slot.hasAvailability) {
      return Colors.grey.shade100;
    }

    if (isSelected) {
      return Theme.of(context).colorScheme.primary.withOpacity(0.1);
    }

    return Theme.of(context).colorScheme.surface;
  }

  Color _getBorderColor(BuildContext context) {
    if (!slot.hasAvailability) {
      return Colors.grey.shade300;
    }

    if (isSelected) {
      return Theme.of(context).colorScheme.primary;
    }

    return Theme.of(context).colorScheme.outline;
  }

  Color _getTextColor(BuildContext context) {
    if (!slot.hasAvailability) {
      return Colors.grey.shade500;
    }

    if (isSelected) {
      return Theme.of(context).colorScheme.primary;
    }

    return Theme.of(context).colorScheme.onSurface;
  }

  Color _getSubtextColor(BuildContext context) {
    if (!slot.hasAvailability) {
      return Colors.grey.shade400;
    }

    return Colors.grey.shade600;
  }

  String _getAvailabilityText() {
    if (!slot.hasAvailability) {
      return 'No disponible';
    }

    if (slot.availableSlots == 1) {
      return '1 espacio';
    }

    return '${slot.availableSlots} espacios';
  }
}
