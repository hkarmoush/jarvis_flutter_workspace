import 'package:flutter_test/flutter_test.dart';
import 'package:core_utils/formatters/title_case_formatter.dart';

void main() {
  group('TitleCaseFormatter', () {
    test('formats to title case', () {
      expect(TitleCaseFormatter.format('hello world'), 'Hello World');
    });
    test('handles all caps', () {
      expect(TitleCaseFormatter.format('FOO BAR'), 'Foo Bar');
    });
    test('handles empty string', () {
      expect(TitleCaseFormatter.format(''), '');
    });
  });
}
