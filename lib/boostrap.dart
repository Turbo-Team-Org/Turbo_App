import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:path_provider/path_provider.dart';
import 'package:turbo/app/dependency_injection/init_config.dart';

/// Global instance of [GetIt] service locator.
GetIt sl = GetIt.I;

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar HydratedBloc storage para persistencia de estados
  final storageDir =
      kIsWeb
          ? HydratedStorageDirectory.web
          : HydratedStorageDirectory(
            (await getApplicationDocumentsDirectory()).path,
          );

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: storageDir,
  );

  // Inicializar datos de localización para formatear fechas
  await initializeDateFormatting('es_ES', null);
  await initDependencies(sl);
  runApp(await builder());
}
