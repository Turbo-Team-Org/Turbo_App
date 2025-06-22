import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:core/core.dart';

class ReservationSummaryCard extends StatelessWidget {
  final String placeName;
  final DateTime selectedDate;
  final ReservationTimeSlot selectedSlot;
  final int partySize;

  const ReservationSummaryCard({
    super.key,
    required this.placeName,
    required this.selectedDate,
    required this.selectedSlot,
    required this.partySize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Icon(
                Icons.restaurant_menu,
                color: Theme.of(context).colorScheme.primary,
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Resumen de tu reserva',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Información del lugar
          _buildInfoRow(
            icon: Icons.location_on,
            label: 'Restaurante',
            value: placeName,
            context: context,
          ),

          const SizedBox(height: 12),

          // Fecha
          _buildInfoRow(
            icon: Icons.calendar_today,
            label: 'Fecha',
            value: DateFormat(
              'EEEE, d MMMM yyyy',
              'es_ES',
            ).format(selectedDate),
            context: context,
          ),

          const SizedBox(height: 12),

          // Horario
          _buildInfoRow(
            icon: Icons.access_time,
            label: 'Horario',
            value: selectedSlot.formattedTime,
            context: context,
          ),

          const SizedBox(height: 12),

          // Número de personas
          _buildInfoRow(
            icon: Icons.people,
            label: 'Personas',
            value: '$partySize ${partySize == 1 ? 'persona' : 'personas'}',
            context: context,
          ),

          const SizedBox(height: 16),

          // Divider
          Divider(color: Colors.grey.shade300),

          const SizedBox(height: 16),

          // Nota informativa
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.green.shade200),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.green.shade600,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Tu reserva será confirmada inmediatamente',
                    style: TextStyle(
                      color: Colors.green.shade700,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required BuildContext context,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 20,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
