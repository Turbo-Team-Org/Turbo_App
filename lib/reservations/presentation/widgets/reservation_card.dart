import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:core/core.dart';

class ReservationCard extends StatelessWidget {
  final Reservation reservation;
  final bool showCancelButton;
  final VoidCallback? onCancel;
  final VoidCallback? onTap;

  const ReservationCard({
    super.key,
    required this.reservation,
    this.showCancelButton = false,
    this.onCancel,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header con status y código
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatusChip(reservation.status),
                  if (reservation.confirmationCode != null)
                    Text(
                      reservation.confirmationCode!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 12),

              // Nombre del lugar
              Text(
                reservation.placeName ?? '',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              // Información de la reserva
              _buildInfoRow(
                Icons.calendar_today,
                _formatDate(reservation.reservationDate),
                Colors.blue,
              ),

              const SizedBox(height: 4),

              _buildInfoRow(
                Icons.access_time,
                _formatTime(reservation.reservationDate),
                Colors.green,
              ),

              const SizedBox(height: 4),

              _buildInfoRow(
                Icons.people,
                '${reservation.partySize} ${reservation.partySize == 1 ? 'persona' : 'personas'}',
                Colors.orange,
              ),

              // Solicitudes especiales
              if (reservation.specialRequests?.isNotEmpty ?? false) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.purple.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.purple.shade200),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.note, size: 16, color: Colors.purple.shade600),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          reservation.specialRequests!,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.purple.shade700,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              // Botón de cancelar
              if (showCancelButton && onCancel != null) ...[
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: onCancel,
                    icon: const Icon(Icons.cancel_outlined, size: 16),
                    label: const Text('Cancelar'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.red,
                      backgroundColor: Colors.red.shade50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildStatusChip(ReservationStatus status) {
    Color color;
    String text;
    IconData icon;

    switch (status) {
      case ReservationStatus.pending:
        color = Colors.orange;
        text = 'Pendiente';
        icon = Icons.schedule;
        break;
      case ReservationStatus.confirmed:
        color = Colors.green;
        text = 'Confirmada';
        icon = Icons.check_circle;
        break;
      case ReservationStatus.cancelled:
        color = Colors.red;
        text = 'Cancelada';
        icon = Icons.cancel;
        break;
      case ReservationStatus.completed:
        color = Colors.blue;
        text = 'Completada';
        icon = Icons.done_all;
        break;
      default:
        color = Colors.grey;
        text = 'Desconocido';
        icon = Icons.help;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final reservationDate = DateTime(date.year, date.month, date.day);

    if (reservationDate == today) {
      return 'Hoy';
    } else if (reservationDate == tomorrow) {
      return 'Mañana';
    } else {
      return DateFormat('EEEE, d MMM', 'es_ES').format(date);
    }
  }

  String _formatTime(DateTime date) {
    return DateFormat('HH:mm').format(date);
  }
}
