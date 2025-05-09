import 'package:flutter_test/flutter_test.dart';
import 'package:core_utils/formatters/iban_formatter.dart';

void main() {
  group('IBANFormatter', () {
    test('formats IBAN with no spaces', () {
      expect(IBANFormatter.format('DE89370400440532013000'),
          'DE89 3704 0044 0532 0130 00');
    });
    test('formats IBAN with spaces', () {
      expect(IBANFormatter.format('DE89 3704 0044 0532 0130 00'),
          'DE89 3704 0044 0532 0130 00');
    });
    test('handles partial IBAN', () {
      expect(IBANFormatter.format('DE8937'), 'DE89 37');
    });
  });
}
