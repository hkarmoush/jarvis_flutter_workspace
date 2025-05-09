import 'package:flutter_test/flutter_test.dart';
import 'package:core_utils/formatters/credit_card_formatter.dart';

void main() {
  group('CreditCardFormatter', () {
    test('formats card with no spaces', () {
      expect(CreditCardFormatter.format('1234567812345678'),
          '1234 5678 1234 5678');
    });
    test('formats card with spaces', () {
      expect(CreditCardFormatter.format('1234 5678 1234 5678'),
          '1234 5678 1234 5678');
    });
    test('handles partial card number', () {
      expect(CreditCardFormatter.format('123456'), '1234 56');
    });
  });
}
