import 'package:flutter_test/flutter_test.dart';
import 'package:core_utils/src/extensions/uri_extensions.dart';

void main() {
  group('UriExtensions', () {
    test('appendQueryParameters merges query params', () {
      final uri = Uri.parse('https://example.com?a=1');
      final result = uri.appendQueryParameters({'b': '2'});
      expect(result.toString(), contains('a=1'));
      expect(result.toString(), contains('b=2'));
    });
    test('addPathSegments appends segments', () {
      final uri = Uri.parse('https://example.com/foo');
      final result = uri.addPathSegments('bar/baz');
      expect(result.pathSegments, ['foo', 'bar', 'baz']);
    });
    test('withoutQuery removes query parameters', () {
      final uri = Uri.parse('https://example.com/foo?a=1');
      final result = uri.withoutQuery();
      expect(result.query, '');
      expect(result.toString(), isNot(contains('a=1')));
    });
    test('withoutFragment removes fragment', () {
      final uri = Uri.parse('https://example.com/foo#frag');
      final result = uri.withoutFragment();
      expect(result.fragment, '');
      expect(result.toString(), isNot(contains('#frag')));
    });
  });
}
