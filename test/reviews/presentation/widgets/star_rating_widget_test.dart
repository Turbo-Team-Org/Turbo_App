import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:turbo/reviews/presentation/widgets/star_rating_widget.dart';

void main() {
  testWidgets('onChanged actualiza la calificación', (tester) async {
    int? last;
    await tester.pumpWidget(
      MaterialApp(
        home: StatefulBuilder(
          builder: (context, setState) {
            return Scaffold(
              body: StarRatingWidget(
                value: last ?? 0,
                onChanged: (v) => setState(() => last = v),
              ),
            );
          },
        ),
      ),
    );

    await tester.tap(find.byType(InkWell).first);
    await tester.pump();
    expect(last, 1);
  });
}
