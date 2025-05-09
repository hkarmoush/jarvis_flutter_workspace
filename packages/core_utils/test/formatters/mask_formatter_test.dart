import 'package:flutter_test/flutter_test.dart';
import 'package:core_utils/formatters/mask_formatter.dart';

void main() {
  group('MaskFormatter', () {
    test('formats phone number', () {
      expect(MaskFormatter.format('1234567890', mask: '(###) ###-####'),
          '(123) 456-7890');
    });
    test('formats credit card', () {
      expect(
          MaskFormatter.format('1234567812345678', mask: '#### #### #### ####'),
          '1234 5678 1234 5678');
    });
    test('handles partial input', () {
      expect(MaskFormatter.format('12345', mask: '###-###'), '123-45');
    });
  });
}
