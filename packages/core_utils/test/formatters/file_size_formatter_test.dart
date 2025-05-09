import 'package:flutter_test/flutter_test.dart';
import 'package:core_utils/formatters/file_size_formatter.dart';

void main() {
  group('FileSizeFormatter', () {
    test('formats bytes', () {
      expect(FileSizeFormatter.format(512), '512 B');
    });
    test('formats KB', () {
      expect(FileSizeFormatter.format(2048), '2.0 KB');
    });
    test('formats MB', () {
      expect(FileSizeFormatter.format(1048576), '1.0 MB');
    });
    test('formats GB', () {
      expect(FileSizeFormatter.format(1073741824), '1.0 GB');
    });
    test('formats with custom decimal places', () {
      expect(FileSizeFormatter.format(2048, decimalPlaces: 2), '2.00 KB');
    });
  });
}
