import 'package:flutter_test/flutter_test.dart';
import 'package:core_utils/formatters/compact_number_formatter.dart';

void main() {
  group('CompactNumberFormatter', () {
    test('formats thousands', () {
      expect(CompactNumberFormatter.format(1200), '1.2K');
    });
    test('formats millions', () {
      expect(CompactNumberFormatter.format(2500000), '2.5M');
    });
  });
}
