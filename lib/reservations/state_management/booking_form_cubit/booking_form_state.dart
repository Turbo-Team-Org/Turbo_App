import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:core/core.dart';

part 'booking_form_state.freezed.dart';

@freezed
sealed class BookingFormState with _$BookingFormState {
  const factory BookingFormState({
    @Default(false) bool isCreating,
    @Default(false) bool success,
    Reservation? createdReservation,
    String? error,
  }) = _BookingFormState;
}
