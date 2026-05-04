import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('lib/ does not import mock_data nor DataLoaderManager', () {
    final result = Process.runSync(
      'grep',
      ['-rEn', '--include=*.dart', 'mock_data|DataLoaderManager', 'lib/'],
      workingDirectory: Directory.current.path,
    );
    expect(
      result.exitCode,
      1,
      reason:
          'Found mock_data or DataLoaderManager in lib/. Stdout:\n${result.stdout}',
    );
  });

  test(
    'lib/ does not import cloud_firestore except notification_service '
    '(legacy until notifications-fix)',
    () {
      final result = Process.runSync(
        'grep',
        ['-rEn', '--include=*.dart', 'cloud_firestore', 'lib/'],
        workingDirectory: Directory.current.path,
      );
      final lines = (result.stdout as String)
          .split('\n')
          .where((l) => l.isNotEmpty)
          .where(
            (l) => !l.contains(
              'lib/app/notification/service/notification_service.dart',
            ),
          )
          .toList();
      expect(
        lines,
        isEmpty,
        reason: 'Found unauthorized cloud_firestore imports:\n${lines.join('\n')}',
      );
    },
  );
}
