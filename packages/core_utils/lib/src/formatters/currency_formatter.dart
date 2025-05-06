import 'package:intl/intl.dart';

class CurrencyFormatter {
  static final _currencyFormat = NumberFormat.currency(
    locale: 'en_US',
    symbol: '\$',
    decimalDigits: 2,
  );

  /// Formats a number as currency
  static String format(double amount) {
    return _currencyFormat.format(amount);
  }

  /// Parses a currency string to a double
  static double parse(String amount) {
    try {
      return _currencyFormat.parse(amount) as double;
    } catch (e) {
      return 0.0;
    }
  }
}
