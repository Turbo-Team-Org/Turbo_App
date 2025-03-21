import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:turbo/app/core/no_params.dart';
import 'package:turbo/authentication/authentication_repository/models/auth_user.dart';
import 'package:turbo/authentication/module/authentication_module.dart';

part 'auth_cubit_state.dart';
part 'auth_cubit_cubit.freezed.dart';

class AuthCubit extends Cubit<AuthCubitState> {
  final AuthenticationModule authenticationModule;
  late final StreamSubscription<AuthUser?> _authSubscription;

  AuthCubit({required this.authenticationModule})
    : super(const AuthCubitState.initial()) {
    _authSubscription = authenticationModule.call(NoParams()).listen((user) {
      print("📱 AuthCubit - Stream listener - Usuario: ${user?.uid ?? 'null'}");
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    });
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
