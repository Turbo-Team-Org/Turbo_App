import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:core/core.dart';

@RoutePage()
class ReservationDetailsPage extends StatelessWidget {
  final String reservationId;
  final Reservation? reservation;

  const ReservationDetailsPage({
    super.key,
    required this.reservationId,
    this.reservation,
  });

  @override
  Widget build(BuildContext context) {
    // Si no se pasa la reserva, podrías cargarla aquí con el ID
    if (reservation == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Detalles de Reserva')),
        body: const Center(child: Text('Reserva no encontrada')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles de Reserva'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => _shareReservation(context),
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header con status
            _buildStatusHeader(context),

            const SizedBox(height: 24),

            // Información principal
            _buildMainInfo(context),

            const SizedBox(height: 24),

            // Detalles de la reserva
            _buildReservationDetails(context),

            const SizedBox(height: 24),

            // Información de contacto
            _buildContactInfo(context),

            if (reservation!.specialRequests?.isNotEmpty ?? false) ...[
              const SizedBox(height: 24),
              _buildSpecialRequests(context),
            ],

            const SizedBox(height: 24),

            // Acciones
            _buildActions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: _getStatusGradient(),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(_getStatusIcon(), size: 48, color: Colors.white),
          const SizedBox(height: 12),
          Text(
            _getStatusText(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Código: ${reservation!.confirmationCode}',
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildMainInfo(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              reservation!.placeName ?? 'Restaurante',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            _buildInfoRow(
              Icons.calendar_today,
              'Fecha',
              DateFormat(
                'EEEE, d MMMM yyyy',
                'es_ES',
              ).format(reservation!.reservationDate),
            ),

            const SizedBox(height: 12),

            _buildInfoRow(
              Icons.access_time,
              'Horario',
              DateFormat('HH:mm').format(reservation!.reservationDate),
            ),

            const SizedBox(height: 12),

            _buildInfoRow(
              Icons.people,
              'Personas',
              '${reservation!.partySize} ${reservation!.partySize == 1 ? 'persona' : 'personas'}',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReservationDetails(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Detalles de la Reserva',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            _buildInfoRow(
              Icons.confirmation_number,
              'Código de confirmación',
              reservation!.confirmationCode!,
              copyable: true,
            ),

            const SizedBox(height: 12),

            _buildInfoRow(
              Icons.schedule,
              'Fecha de creación',
              DateFormat(
                'd MMM yyyy, HH:mm',
                'es_ES',
              ).format(reservation!.reservationDate),
            ),

            if (reservation!.status == ReservationStatus.cancelled) ...[
              const SizedBox(height: 12),
              _buildInfoRow(
                Icons.cancel,
                'Fecha de cancelación',
                DateFormat(
                  'd MMM yyyy, HH:mm',
                  'es_ES',
                ).format(reservation!.updatedAt!),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildContactInfo(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Información de Contacto',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            _buildInfoRow(Icons.person, 'Nombre', reservation!.customerName),

            const SizedBox(height: 12),

            _buildInfoRow(
              Icons.email,
              'Email',
              reservation!.customerEmail,
              copyable: true,
            ),

            const SizedBox(height: 12),

            _buildInfoRow(
              Icons.phone,
              'Teléfono',
              reservation!.customerPhone,
              copyable: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecialRequests(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Solicitudes Especiales',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.note, color: Colors.blue.shade600, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      reservation!.specialRequests!,
                      style: TextStyle(
                        color: Colors.blue.shade700,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    final canCancel = reservation!.canBeCancelled;

    return Column(
      children: [
        if (canCancel)
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => _showCancelDialog(context),
              icon: const Icon(Icons.cancel_outlined),
              label: const Text('Cancelar Reserva'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
                side: const BorderSide(color: Colors.red),
                minimumSize: const Size.fromHeight(48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

        const SizedBox(height: 12),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () => _shareReservation(context),
            icon: const Icon(Icons.share),
            label: const Text('Compartir Reserva'),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(
    IconData icon,
    String label,
    String value, {
    bool copyable = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 20, color: Colors.grey.shade600),
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
              const SizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      value,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (copyable)
                    IconButton(
                      onPressed: () => _copyToClipboard(value),
                      icon: const Icon(Icons.copy, size: 16),
                      constraints: const BoxConstraints(),
                      padding: const EdgeInsets.all(8),
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  LinearGradient _getStatusGradient() {
    switch (reservation!.status) {
      case ReservationStatus.confirmed:
        return const LinearGradient(colors: [Colors.green, Colors.lightGreen]);
      case ReservationStatus.pending:
        return const LinearGradient(colors: [Colors.orange, Colors.deepOrange]);
      case ReservationStatus.cancelled:
        return const LinearGradient(colors: [Colors.red, Colors.redAccent]);
      case ReservationStatus.completed:
        return const LinearGradient(colors: [Colors.blue, Colors.lightBlue]);
      default:
        return const LinearGradient(colors: [Colors.grey, Colors.blueGrey]);
    }
  }

  IconData _getStatusIcon() {
    switch (reservation!.status) {
      case ReservationStatus.confirmed:
        return Icons.check_circle;
      case ReservationStatus.pending:
        return Icons.schedule;
      case ReservationStatus.cancelled:
        return Icons.cancel;
      case ReservationStatus.completed:
        return Icons.done_all;
      default:
        return Icons.help;
    }
  }

  String _getStatusText() {
    switch (reservation!.status) {
      case ReservationStatus.confirmed:
        return 'Confirmada';
      case ReservationStatus.pending:
        return 'Pendiente';
      case ReservationStatus.cancelled:
        return 'Cancelada';
      case ReservationStatus.completed:
        return 'Completada';
      default:
        return 'Desconocido';
    }
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }

  void _shareReservation(BuildContext context) {
    final text = '''
🍽️ Reserva Confirmada

📍 ${reservation!.placeName ?? 'Restaurante'}
📅 ${DateFormat('EEEE, d MMMM yyyy', 'es_ES').format(reservation!.reservationDate)}
🕒 ${DateFormat('HH:mm').format(reservation!.reservationDate)}
👥 ${reservation!.partySize} personas
🎫 Código: ${reservation!.confirmationCode}

Estado: ${_getStatusText()}
''';

    // Aquí podrías usar el paquete share_plus para compartir
    // Share.share(text);

    // Por ahora, solo copiamos al portapapeles
    _copyToClipboard(text);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Detalles de reserva copiados al portapapeles'),
      ),
    );
  }

  void _showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Cancelar Reserva'),
            content: const Text(
              '¿Estás seguro de que quieres cancelar esta reserva? Esta acción no se puede deshacer.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Mantener'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Aquí implementarías la lógica de cancelación
                  // context.read<SomeCubit>().cancelReservation(reservation!.id);
                },
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: const Text('Cancelar Reserva'),
              ),
            ],
          ),
    );
  }
}
