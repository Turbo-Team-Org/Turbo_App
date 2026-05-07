import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:turbo/app/l10n/l10n.dart';
import 'package:turbo/places/module/params/search_filters_params.dart';
import 'package:turbo/places/presentation/widgets/search_filters_sheet.dart';

void main() {
  testWidgets('renderiza controles de filtros principales',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('es'),
        home: Scaffold(
          body: SearchFiltersSheet(
            initialFilters: const SearchFiltersParams(),
            onApply: (_) {},
            onClear: () {},
          ),
        ),
      ),
    );

    expect(find.text('Filtros de búsqueda'), findsOneWidget);
    expect(find.text('Calificación mínima'), findsOneWidget);
    expect(find.text('Abierto ahora'), findsOneWidget);
    expect(find.text('Ordenar por'), findsOneWidget);
  });
}
