import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:turbo/app/l10n/l10n.dart';
import 'package:turbo/users/presentation/widgets/profile_photo_source_sheet.dart';

void main() {
  testWidgets('al elegir galería hace pop con ImageSource.gallery', (tester) async {
    ImageSource? picked;

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('es'),
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return FilledButton(
                onPressed: () async {
                  picked = await ProfilePhotoSourceSheet.show(context);
                },
                child: const Text('open'),
              );
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();

    expect(find.text('Galería'), findsOneWidget);
    expect(find.text('Cámara'), findsOneWidget);

    await tester.tap(find.text('Galería'));
    await tester.pumpAndSettle();

    expect(picked, ImageSource.gallery);
  });

  testWidgets('al elegir cámara hace pop con ImageSource.camera', (tester) async {
    ImageSource? picked;

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('en'),
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return FilledButton(
                onPressed: () async {
                  picked = await ProfilePhotoSourceSheet.show(context);
                },
                child: const Text('open'),
              );
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Camera'));
    await tester.pumpAndSettle();

    expect(picked, ImageSource.camera);
  });
}
