import 'package:flutter_test/flutter_test.dart';
import 'package:core_utils/formatters/percentage_formatter.dart';

void main() {
  group('PercentageFormatter', () {
    test('formats with default decimal places', () {
      expect(PercentageFormatter.format(0.25), '25%');
    });
    test('formats with custom decimal places', () {
      expect(PercentageFormatter.format(0.1234, decimalPlaces: 2), '12.34%');
    });
  });
}
