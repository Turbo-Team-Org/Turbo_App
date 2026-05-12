import 'package:core/core.dart';

/// Compatibility helpers for the trimmed [Place] model.
///
/// The Core model dropped `averagePrice` and `schedules` in favour of
/// `priceLevel` and `openingHours`. These extensions reconstruct the
/// previous public surface so the UI keeps a single source of truth.
extension PlacePricingX on Place {
  /// Coste nominal del lugar derivado de [priceLevel].
  ///
  /// Cada nivel suma un escalón de 25 (en la moneda de UI vigente).
  /// `priceLevel = 0` se interpreta como "sin precio definido".
  double get averagePrice => priceLevel * 25.0;
}

/// Día simple de horario derivado de [Place.openingHours].
class DaySchedule {
  const DaySchedule({required this.opening, required this.closing});

  final String opening;
  final String closing;
}

extension PlaceScheduleX on Place {
  static const List<String> _weekdayKeys = <String>[
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
    'saturday',
    'sunday',
  ];

  /// Devuelve el horario del [weekday] (1=lunes ... 7=domingo) si existe.
  DaySchedule? scheduleForWeekday(int weekday) {
    if (weekday < 1 || weekday > 7) return null;
    final raw = openingHours[_weekdayKeys[weekday - 1]];
    if (raw == null || raw.isEmpty) return null;
    final opening = raw['opening'] ?? raw['open'] ?? '';
    final closing = raw['closing'] ?? raw['close'] ?? '';
    if (opening.isEmpty && closing.isEmpty) return null;
    return DaySchedule(opening: opening, closing: closing);
  }
}
