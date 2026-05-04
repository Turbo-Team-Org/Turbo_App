import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'theme_event.dart';
import 'theme_state.dart';

export 'theme_event.dart';
export 'theme_state.dart';

/// Bloc para gestionar el tema de la aplicación
///
/// Usa [HydratedBloc] para persistir automáticamente el tema seleccionado
/// entre sesiones de la aplicación.
///
/// ## Uso
///
/// ```dart
/// // En main.dart, antes de runApp:
/// HydratedBloc.storage = await HydratedStorage.build(
///   storageDirectory: await getApplicationDocumentsDirectory(),
/// );
///
/// // Proveer el bloc
/// BlocProvider<ThemeBloc>(
///   create: (_) => ThemeBloc(),
///   child: MyApp(),
/// )
///
/// // En MaterialApp
/// BlocBuilder<ThemeBloc, ThemeState>(
///   builder: (context, state) {
///     return MaterialApp(
///       themeMode: state.themeMode,
///       theme: TurboTheme.light,
///       darkTheme: TurboTheme.dark,
///     );
///   },
/// )
///
/// // Cambiar tema
/// context.read<ThemeBloc>().add(ThemeEvent.setDarkTheme());
/// ```
class ThemeBloc extends HydratedBloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeState()) {
    on<ChangeTheme>(_onChangeTheme);
    on<ToggleTheme>(_onToggleTheme);
    on<SetSystemTheme>(_onSetSystemTheme);
    on<SetLightTheme>(_onSetLightTheme);
    on<SetDarkTheme>(_onSetDarkTheme);
  }

  void _onChangeTheme(ChangeTheme event, Emitter<ThemeState> emit) {
    emit(state.copyWith(themeMode: event.themeMode));
  }

  void _onToggleTheme(ToggleTheme event, Emitter<ThemeState> emit) {
    // Si está en system o light, cambia a dark
    // Si está en dark, cambia a light
    final newMode =
        state.themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    emit(state.copyWith(themeMode: newMode));
  }

  void _onSetSystemTheme(SetSystemTheme event, Emitter<ThemeState> emit) {
    emit(state.copyWith(themeMode: ThemeMode.system));
  }

  void _onSetLightTheme(SetLightTheme event, Emitter<ThemeState> emit) {
    emit(state.copyWith(themeMode: ThemeMode.light));
  }

  void _onSetDarkTheme(SetDarkTheme event, Emitter<ThemeState> emit) {
    emit(state.copyWith(themeMode: ThemeMode.dark));
  }

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    try {
      return ThemeState.fromJson(json);
    } catch (_) {
      return const ThemeState();
    }
  }

  @override
  Map<String, dynamic>? toJson(ThemeState state) {
    return state.toJson();
  }
}
