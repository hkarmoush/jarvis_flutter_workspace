import 'package:flutter_test/flutter_test.dart';
import 'package:core_utils/formatters/sentence_case_formatter.dart';

void main() {
  group('SentenceCaseFormatter', () {
    test('formats to sentence case', () {
      expect(SentenceCaseFormatter.format('hello world'), 'Hello world');
    });
    test('handles all caps', () {
      expect(SentenceCaseFormatter.format('FOO BAR'), 'Foo bar');
    });
    test('handles empty string', () {
      expect(SentenceCaseFormatter.format(''), '');
    });
  });
}
