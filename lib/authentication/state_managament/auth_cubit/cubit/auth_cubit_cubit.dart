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
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    });
  }
  Future<void> checkAuthStatus() async {
    final user = await authenticationModule.call(NoParams()).first;
    if (user != null) {
      emit(Authenticated(user));
    } else {
      emit(Unauthenticated());
    }
  }

  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }
}
