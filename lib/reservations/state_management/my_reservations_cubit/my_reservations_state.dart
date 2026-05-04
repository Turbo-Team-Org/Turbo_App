import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:core/core.dart';

part 'my_reservations_state.freezed.dart';

@freezed
sealed class MyReservationsState with _$MyReservationsState {
  const factory MyReservationsState({
    @Default(false) bool isLoading,
    @Default(false) bool isCancelling,
    @Default([]) List<Reservation> upcomingReservations,
    @Default([]) List<Reservation> pastReservations,
    @Default([]) List<Reservation> cancelledReservations,
    String? error,
    String? success,
  }) = _MyReservationsState;
}
