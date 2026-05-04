import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core/core.dart';
import 'package:turbo/app/l10n/l10n.dart';
import 'package:turbo/reviews/presentation/widgets/reviews_summary_widget.dart';

void main() {
  testWidgets('muestra promedio con reseñas', (tester) async {
    final reviews = [
      Review(
        id: '1',
        userId: 'a',
        userName: 'A',
        userAvatar: '',
        comment: 'x',
        rating: 4,
        date: DateTime(2024),
      ),
      Review(
        id: '2',
        userId: 'b',
        userName: 'B',
        userAvatar: '',
        comment: 'y',
        rating: 2,
        date: DateTime(2024),
      ),
    ];

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('es'),
        home: Scaffold(body: ReviewsSummaryWidget(reviews: reviews)),
      ),
    );

    expect(find.text('3.0'), findsOneWidget);
  });
}
