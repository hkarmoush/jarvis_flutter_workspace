import 'package:flutter_test/flutter_test.dart';
import 'package:core_utils/src/extensions/json_extensions.dart';

void main() {
  group('JsonExtensions', () {
    final json = {
      'str': 'hello',
      'int': 42,
      'bool': true,
      'list': [1, 2, 3],
      'map': {'a': 1},
      'double': 3.14,
    };

    test('getString returns string or default', () {
      expect(json.getString('str'), 'hello');
      expect(json.getString('missing', 'def'), 'def');
      expect(json.getString('int', 'def'), 'def');
    });
    test('getInt returns int or default', () {
      expect(json.getInt('int'), 42);
      expect(json.getInt('missing', 7), 7);
      expect(json.getInt('str', 7), 7);
    });
    test('getBool returns bool or default', () {
      expect(json.getBool('bool'), true);
      expect(json.getBool('missing', true), true);
      expect(json.getBool('str', false), false);
    });
    test('getList returns list or default', () {
      expect(json.getList<int>('list'), [1, 2, 3]);
      expect(json.getList<int>('missing', [4]), [4]);
      expect(json.getList<int>('str', [5]), [5]);
    });
    test('getMap returns map or default', () {
      expect(json.getMap('map'), {'a': 1});
      expect(json.getMap('missing', {'b': 2}), {'b': 2});
      expect(json.getMap('str', {'c': 3}), {'c': 3});
    });
    test('safeCast returns value of type or null', () {
      expect(json.safeCast<String>('str'), 'hello');
      expect(json.safeCast<int>('int'), 42);
      expect(json.safeCast<double>('double'), 3.14);
      expect(json.safeCast<bool>('str'), null);
      expect(json.safeCast<List>('int'), null);
    });
  });
}
