class PercentageFormatter {
  static String format(num value, {int decimalPlaces = 0}) {
    final percent = (value * 100).toStringAsFixed(decimalPlaces);
    return '$percent%';
  }
}
