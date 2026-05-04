import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/core.dart';
import 'package:turbo/reservations/module/create_reservation_use_case.dart';
import 'package:turbo/reservations/state_management/booking_form_cubit/booking_form_state.dart';

class BookingFormCubit extends Cubit<BookingFormState> {
  final CreateReservationUseCase _createReservationUseCase;
  final ReservationRepository _reservationRepository;

  BookingFormCubit(this._createReservationUseCase, this._reservationRepository)
    : super(const BookingFormState());

  // Crear nueva reserva
  Future<void> createReservation({
    required String placeId,
    required String userId,
    required DateTime startTime,
    required DateTime endTime,
    required int partySize,
    required String customerName,
    required String customerEmail,
    required String customerPhone,
    String? specialRequests,
  }) async {
    try {
      emit(state.copyWith(isCreating: true, error: null));

      final params = CreateReservationParams(
        placeId: placeId,
        userId: userId,
        startTime: startTime,
        endTime: endTime,
        partySize: partySize,
        customerName: customerName,
        customerEmail: customerEmail,
        customerPhone: customerPhone,
        specialRequests: specialRequests,
      );

      final reservation = await _createReservationUseCase.call(params);

      emit(
        state.copyWith(
          createdReservation: reservation,
          isCreating: false,
          success: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(error: 'Error creando reserva: $e', isCreating: false),
      );
    }
  }

  // Validar disponibilidad antes de crear
  Future<bool> validateSlotAvailability({
    required String placeId,
    required DateTime startTime,
    required DateTime endTime,
    required int partySize,
  }) async {
    try {
      return await _reservationRepository.isSlotAvailable(
        placeId,
        startTime,
        endTime,
        partySize,
      );
    } catch (e) {
      return false;
    }
  }

  // Limpiar estado
  void clearState() {
    emit(const BookingFormState());
  }

  // Limpiar error
  void clearError() {
    emit(state.copyWith(error: null));
  }

  // Limpiar success
  void clearSuccess() {
    emit(state.copyWith(success: false));
  }
}
