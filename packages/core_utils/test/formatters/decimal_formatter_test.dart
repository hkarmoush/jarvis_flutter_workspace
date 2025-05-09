import 'package:flutter_test/flutter_test.dart';
import 'package:core_utils/formatters/decimal_formatter.dart';

void main() {
  group('DecimalFormatter', () {
    test('formats with default decimal places', () {
      expect(DecimalFormatter.format(3.14159), '3.14');
    });
    test('formats with custom decimal places', () {
      expect(DecimalFormatter.format(3.14159, decimalPlaces: 4), '3.1416');
    });
  });
}
