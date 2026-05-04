import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:core/core.dart';

part 'booking_state.freezed.dart';

@freezed
sealed class BookingState with _$BookingState {
  const factory BookingState({
    @Default(false) bool isLoading,
    @Default([]) List<ReservationTimeSlot> availableSlots,
    @Default([]) List<ReservationTimeSlot> nextAvailableSlots,
    ReservationTimeSlot? selectedSlot,
    DateTime? selectedDate,
    String? error,
    String? success,
  }) = _BookingState;
}
