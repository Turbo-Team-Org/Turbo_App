import 'package:core/core.dart';
import 'package:turbo/app/core/use_case.dart';

class GetAvailableSlotsUseCase
    extends
        UseCase<Future<List<ReservationTimeSlot>>, GetAvailableSlotsParams> {
  final ReservationRepository _reservationRepository;

  GetAvailableSlotsUseCase(this._reservationRepository);

  @override
  Future<List<ReservationTimeSlot>> call(GetAvailableSlotsParams params) async {
    try {
      final availableSlots = await _reservationRepository.getAvailableSlots(
        params.placeId,
        params.date,
      );

      // Filtrar solo slots con disponibilidad
      return availableSlots
          .where(
            (slot) =>
                slot.hasAvailability &&
                slot.availableSlots >= params.minPartySize,
          )
          .toList();
    } catch (e) {
      throw Exception('Error obteniendo horarios disponibles: $e');
    }
  }
}

class GetAvailableSlotsParams {
  final String placeId;
  final DateTime date;
  final int minPartySize;

  GetAvailableSlotsParams({
    required this.placeId,
    required this.date,
    this.minPartySize = 1,
  });
}
