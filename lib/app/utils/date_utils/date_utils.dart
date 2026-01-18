import 'package:intl/intl.dart';

class TurboDateUtils {
  static String formatDate(DateTime date, {String format = 'd/M/yyyy h a'}) {
    final formatter = DateFormat(format);
    return formatter.format(date);
  }
}
