import 'package:flutter_test/flutter_test.dart';
import 'package:core_utils/formatters/phone_number_formatter.dart';

void main() {
  group('PhoneNumberFormatter', () {
    test('formats valid 10-digit number', () {
      expect(PhoneNumberFormatter.format('1234567890'), '(123) 456-7890');
    });
    test('handles non-digit characters', () {
      expect(PhoneNumberFormatter.format('(123)456-7890'), '(123) 456-7890');
    });
    test('returns input for invalid length', () {
      expect(PhoneNumberFormatter.format('12345'), '12345');
    });
  });
}
