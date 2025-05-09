import 'package:intl/intl.dart';

class CompactNumberFormatter {
  static String format(num value, {String? locale}) {
    return NumberFormat.compact(locale: locale).format(value);
  }
}
