import 'package:core/core.dart';
import 'package:turbo/app/core/use_case.dart';

class GetUserReservationsUseCase
    extends UseCase<Future<List<Reservation>>, String> {
  final ReservationRepository _reservationRepository;

  GetUserReservationsUseCase(this._reservationRepository);

  @override
  Future<List<Reservation>> call(String userId) async {
    try {
      return await _reservationRepository.getUserReservations(userId);
    } catch (e) {
      throw Exception('Error obteniendo reservas del usuario: $e');
    }
  }
}
