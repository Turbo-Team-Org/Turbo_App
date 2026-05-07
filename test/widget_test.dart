// Smoke test ligero: la app real (MyApp) necesita bootstrap completo (Firebase, DI, HydratedBloc).
// Aquí validamos la misma configuración de localización que usa AppView.

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:turbo/app/l10n/generated/app_localizations.dart';

void main() {
  testWidgets('localización carga y muestra appName', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('es'),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: Builder(
          builder: (context) {
            return Scaffold(
              body: Text(AppLocalizations.of(context).appName),
            );
          },
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.text('Turbo'), findsOneWidget);
  });
}
