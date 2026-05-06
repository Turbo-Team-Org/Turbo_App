import 'package:core/core.dart';
import 'package:turbo/app/core/use_case.dart';

class CreateReservationUseCase
    extends UseCase<Future<Reservation>, CreateReservationParams> {
  final ReservationRepository _reservationRepository;

  CreateReservationUseCase(this._reservationRepository);

  @override
  Future<Reservation> call(CreateReservationParams params) async {
    try {
      // Validar disponibilidad antes de crear
      final isAvailable = await _reservationRepository.isSlotAvailable(
        params.placeId,
        params.startTime,
        params.endTime,
        params.partySize,
      );

      if (!isAvailable) {
        throw Exception('Este horario ya no está disponible');
      }

      // Crear la reserva
      final reservation = await _reservationRepository.quickCreateReservation(
        placeId: params.placeId,
        userId: params.userId,
        dateTime: params.startTime,
        partySize: params.partySize,
        customerName: params.customerName,
        customerEmail: params.customerEmail,
        customerPhone: params.customerPhone,
        specialRequests: params.specialRequests,
      );

      return reservation;
    } catch (e) {
      throw Exception('Error creando reserva: $e');
    }
  }
}

class CreateReservationParams {
  final String placeId;
  final String userId;
  final DateTime startTime;
  final DateTime endTime;
  final int partySize;
  final String customerName;
  final String customerEmail;
  final String customerPhone;
  final String? specialRequests;

  CreateReservationParams({
    required this.placeId,
    required this.userId,
    required this.startTime,
    required this.endTime,
    required this.partySize,
    required this.customerName,
    required this.customerEmail,
    required this.customerPhone,
    this.specialRequests,
  });
}
