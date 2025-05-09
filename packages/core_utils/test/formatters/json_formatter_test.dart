import 'package:flutter_test/flutter_test.dart';
import 'package:core_utils/formatters/json_formatter.dart';

void main() {
  group('JsonFormatter', () {
    const minified = '{"a":1,"b":[2,3]}';
    const pretty = '{\n  "a": 1,\n  "b": [\n    2,\n    3\n  ]\n}';
    test('pretty prints JSON', () {
      expect(JsonFormatter.pretty(minified), pretty);
    });
    test('minifies JSON', () {
      expect(JsonFormatter.minify(pretty), minified);
    });
  });
}
