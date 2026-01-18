import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:turbo/app/core/no_params.dart';
import 'package:turbo/app/notification/service/notification_service.dart';
import 'package:core/core.dart';
import 'package:turbo/authentication/module/authentication_module.dart';

part 'auth_cubit_state.dart';
part 'auth_cubit_cubit.freezed.dart';

class AuthCubit extends Cubit<AuthCubitState> {
  final AuthenticationModule authenticationModule;
  late final StreamSubscription<AuthUser?> _authSubscription;
  final NotificationService notificationService;

  AuthCubit({
    required this.authenticationModule,
    required this.notificationService,
  }) : super(const AuthCubitState.initial()) {
    _authSubscription = authenticationModule.call(NoParams()).listen((user) {
      print("📱 AuthCubit - Stream listener - Usuario: ${user?.uid ?? 'null'}");
      if (user != null) {
        emit(Authenticated(user));
        _handleNotificationPermission(user);
      } else {
        emit(Unauthenticated());
      }
    });
  }
  Future<void> _handleNotificationPermission(AuthUser user) async {
    await notificationService.initialize();
    bool permissionGranted = await notificationService.requestPermission();
    if (permissionGranted) {
      try {
        await notificationService.saveTokenToDatabase(user.uid);
      } catch (e) {
        print('Error al guardar token FCM después del login: $e');
      }
    }
  }

  Future<void> checkAuthStatus() async {
    print(
      "📱 AuthCubit - checkAuthStatus - Verificando estado de autenticación",
    );
    try {
      final user = await authenticationModule.call(NoParams()).first;
      print(
        "📱 AuthCubit - checkAuthStatus - Usuario obtenido: ${user?.uid ?? 'null'}",
      );

      if (user != null) {
        print(
          "📱 AuthCubit - checkAuthStatus - Emitiendo estado Authenticated",
        );
        emit(Authenticated(user));
      } else {
        print(
          "📱 AuthCubit - checkAuthStatus - Emitiendo estado Unauthenticated",
        );
        emit(Unauthenticated());
      }
    } catch (error) {
      print("📱 AuthCubit - checkAuthStatus - Error: $error");
      // En caso de error, asumimos que el usuario no está autenticado
      emit(Unauthenticated());
    }
  }

  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }
}
