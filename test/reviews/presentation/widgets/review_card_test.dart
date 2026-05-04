import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core/core.dart';
import 'package:turbo/app/l10n/l10n.dart';
import 'package:turbo/reviews/presentation/widgets/review_card.dart';

void main() {
  testWidgets('muestra nombre y comentario', (tester) async {
    final review = Review(
      id: '1',
      userId: 'u1',
      userName: 'María',
      userAvatar: '',
      comment: 'Excelente servicio y ambiente',
      rating: 5,
      date: DateTime(2024, 3, 10),
    );

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('es'),
        home: Scaffold(body: ReviewCard(review: review)),
      ),
    );

    expect(find.text('María'), findsOneWidget);
    expect(find.textContaining('Excelente'), findsOneWidget);
  });
}
