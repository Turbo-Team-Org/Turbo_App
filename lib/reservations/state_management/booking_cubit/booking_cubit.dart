import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/core.dart';
import 'package:turbo/reservations/module/get_available_slots_use_case.dart';
import 'package:turbo/reservations/state_management/booking_cubit/booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  final GetAvailableSlotsUseCase _getAvailableSlotsUseCase;
  final ReservationRepository _reservationRepository;

  BookingCubit(this._getAvailableSlotsUseCase, this._reservationRepository)
    : super(const BookingState());

  // Obtener slots disponibles para una fecha específica
  Future<void> getAvailableSlotsForDate(String placeId, DateTime date) async {
    try {
      emit(state.copyWith(isLoading: true, error: null));

      final params = GetAvailableSlotsParams(
        placeId: placeId,
        date: date,
        minPartySize: 1,
      );

      final availableSlots = await _getAvailableSlotsUseCase.call(params);

      emit(
        state.copyWith(
          availableSlots: availableSlots,
          selectedDate: date,
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          error: 'Error cargando horarios disponibles: $e',
          isLoading: false,
        ),
      );
    }
  }

  // Obtener próximos horarios disponibles para la semana
  Future<void> getNextAvailableSlots(String placeId, {int days = 7}) async {
    try {
      final nextSlots = await _reservationRepository.getNextAvailableSlots(
        placeId,
        days: days,
      );

      emit(state.copyWith(nextAvailableSlots: nextSlots));
    } catch (e) {
      emit(state.copyWith(error: 'Error cargando próximos horarios: $e'));
    }
  }

  // Seleccionar un slot de tiempo
  void selectTimeSlot(ReservationTimeSlot slot) {
    emit(state.copyWith(selectedSlot: slot));
  }

  // Validar disponibilidad de slot
  Future<bool> validateTimeSlot({
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
    emit(const BookingState());
  }

  // Limpiar error
  void clearError() {
    emit(state.copyWith(error: null));
  }
}
