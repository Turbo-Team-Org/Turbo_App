/// Turbo App Localization
///
/// Barrel export file for localization utilities.
///
/// Usage:
/// ```dart
/// import 'package:turbo/app/l10n/l10n.dart';
///
/// // In your widget:
/// Text(context.l10n.appName)
/// ```
library;

export 'generated/app_localizations.dart';

import 'package:flutter/widgets.dart';
import 'generated/app_localizations.dart';

/// Extension on BuildContext for easy access to localizations
extension AppLocalizationsX on BuildContext {
  /// Returns the current [AppLocalizations] instance.
  ///
  /// Usage: `context.l10n.appName`
  AppLocalizations get l10n => AppLocalizations.of(this);
}

/// List of supported locales in the app
const List<Locale> supportedLocales = [
  Locale('es'), // Spanish (default)
  Locale('en'), // English
];

/// Returns a greeting based on the current time of day
String getTimeBasedGreeting(AppLocalizations l10n) {
  final hour = DateTime.now().hour;

  if (hour >= 5 && hour < 12) {
    return l10n.greetingMorning;
  } else if (hour >= 12 && hour < 18) {
    return l10n.greetingAfternoon;
  } else if (hour >= 18 && hour < 22) {
    return l10n.greetingEvening;
  } else {
    return l10n.greetingDefault;
  }
}
