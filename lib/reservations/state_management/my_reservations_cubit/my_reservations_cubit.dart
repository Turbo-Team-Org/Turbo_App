import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/core.dart';
import 'package:turbo/reservations/module/get_user_reservations_use_case.dart';
import 'package:turbo/reservations/module/cancel_reservation_use_case.dart';
import 'package:turbo/reservations/state_management/my_reservations_cubit/my_reservations_state.dart';

class MyReservationsCubit extends Cubit<MyReservationsState> {
  final GetUserReservationsUseCase _getUserReservationsUseCase;
  final CancelReservationUseCase _cancelReservationUseCase;
  final ReservationRepository _reservationRepository;
  final String userId;

  MyReservationsCubit(
    this._getUserReservationsUseCase,
    this._cancelReservationUseCase,
    this._reservationRepository,
    this.userId,
  ) : super(const MyReservationsState());

  // Cargar todas las reservas del usuario
  Future<void> loadUserReservations() async {
    try {
      emit(state.copyWith(isLoading: true, error: null));

      final allReservations = await _getUserReservationsUseCase.call(userId);

      // Separar por categorías
      final now = DateTime.now();
      final upcoming =
          allReservations
              .where(
                (r) =>
                    r.reservationDate.isAfter(now) &&
                    (r.status == ReservationStatus.confirmed ||
                        r.status == ReservationStatus.pending),
              )
              .toList();

      final past =
          allReservations
              .where(
                (r) =>
                    r.reservationDate.isBefore(now) ||
                    r.status == ReservationStatus.completed,
              )
              .toList();

      final cancelled =
          allReservations
              .where((r) => r.status == ReservationStatus.cancelled)
              .toList();

      emit(
        state.copyWith(
          upcomingReservations: upcoming,
          pastReservations: past,
          cancelledReservations: cancelled,
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(error: 'Error cargando reservas: $e', isLoading: false),
      );
    }
  }

  // Cancelar reserva
  Future<void> cancelReservation(String reservationId, String reason) async {
    try {
      emit(state.copyWith(isCancelling: true, error: null));

      final params = CancelReservationParams(
        reservationId: reservationId,
        reason: reason,
      );

      await _cancelReservationUseCase.call(params);

      // Recargar reservas después de cancelar
      await loadUserReservations();

      emit(
        state.copyWith(
          isCancelling: false,
          success: 'Reserva cancelada exitosamente',
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          error: 'Error cancelando reserva: $e',
          isCancelling: false,
        ),
      );
    }
  }

  // Stream para actualizaciones en tiempo real
  Stream<List<Reservation>> watchUserReservations() {
    return _reservationRepository.watchPlaceReservations(userId);
  }

  // Refrescar reservas
  Future<void> refreshReservations() async {
    await loadUserReservations();
  }

  // Limpiar mensajes
  void clearMessages() {
    emit(state.copyWith(error: null, success: null));
  }

  // Limpiar estado
  void clearState() {
    emit(const MyReservationsState());
  }
}
