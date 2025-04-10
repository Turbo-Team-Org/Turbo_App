import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:turbo/app/dependency_injection/init_config.dart';

/// Global instance of [GetIt] service locator.
GetIt sl = GetIt.I;
Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar datos de localización para formatear fechas
  await initializeDateFormatting('es_ES', null);

  await initCore(sl);
  runApp(await builder());
}
