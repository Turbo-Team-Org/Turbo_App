import 'package:core/core.dart';
import 'package:turbo/app/core/use_case.dart';

class CancelReservationUseCase extends UseCase<void, CancelReservationParams> {
  final ReservationRepository _reservationRepository;

  CancelReservationUseCase(this._reservationRepository);

  @override
  Future<void> call(CancelReservationParams params) async {
    try {
      await _reservationRepository.cancelReservation(
        params.reservationId,
        reason: params.reason,
      );
    } catch (e) {
      throw Exception('Error cancelando reserva: $e');
    }
  }
}

class CancelReservationParams {
  final String reservationId;
  final String reason;

  CancelReservationParams({required this.reservationId, required this.reason});
}
