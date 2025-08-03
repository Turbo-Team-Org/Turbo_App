import 'package:get_it/get_it.dart';
import 'package:core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Use Cases
import 'package:turbo/reservations/module/get_available_slots_use_case.dart';
import 'package:turbo/reservations/module/create_reservation_use_case.dart';
import 'package:turbo/reservations/module/get_user_reservations_use_case.dart';
import 'package:turbo/reservations/module/cancel_reservation_use_case.dart';

// Cubits
import 'package:turbo/reservations/state_management/booking_cubit/booking_cubit.dart';
import 'package:turbo/reservations/state_management/booking_form_cubit/booking_form_cubit.dart';
import 'package:turbo/reservations/state_management/my_reservations_cubit/my_reservations_cubit.dart';

class ReservationsModule {
  static void setup() {
    final getIt = GetIt.instance;

    // Use Cases
    getIt.registerLazySingleton<GetAvailableSlotsUseCase>(
      () => GetAvailableSlotsUseCase(getIt<ReservationRepository>()),
    );

    getIt.registerLazySingleton<CreateReservationUseCase>(
      () => CreateReservationUseCase(getIt<ReservationRepository>()),
    );

    getIt.registerLazySingleton<GetUserReservationsUseCase>(
      () => GetUserReservationsUseCase(getIt<ReservationRepository>()),
    );

    getIt.registerLazySingleton<CancelReservationUseCase>(
      () => CancelReservationUseCase(getIt<ReservationRepository>()),
    );

    // Cubits - Factory para crear nuevas instancias cada vez
    getIt.registerFactory<BookingCubit>(
      () => BookingCubit(
        getIt<GetAvailableSlotsUseCase>(),
        getIt<ReservationRepository>(),
      ),
    );

    getIt.registerFactory<BookingFormCubit>(
      () => BookingFormCubit(
        getIt<CreateReservationUseCase>(),
        getIt<ReservationRepository>(),
      ),
    );

    getIt.registerFactoryParam<MyReservationsCubit, String, void>(
      (userId, _) => MyReservationsCubit(
        getIt<GetUserReservationsUseCase>(),
        getIt<CancelReservationUseCase>(),
        getIt<ReservationRepository>(),
        userId,
      ),
    );
  }

  // Helper para crear MyReservationsCubit con el usuario actual
  static MyReservationsCubit createMyReservationsCubit() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('Usuario no autenticado');
    }

    return GetIt.instance<MyReservationsCubit>(param1: user.uid);
  }
}
