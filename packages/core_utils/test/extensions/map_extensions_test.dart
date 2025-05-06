import 'package:test/test.dart';
import 'package:core_utils/core_utils.dart';

void main() {
  group('MapExtensions', () {
    test('removeNullValues removes entries with null values', () {
      final map = <String, int?>{'a': 1, 'b': null, 'c': 3};
      final result = map.removeNullValues();
      expect(result, {'a': 1, 'c': 3});
    });

    test('inverted swaps keys and values', () {
      final map = <String, int>{'a': 1, 'b': 2, 'c': 3};
      final result = map.inverted;
      expect(result, {1: 'a', 2: 'b', 3: 'c'});
    });

    test('pick returns only specified keys', () {
      final map = {'a': 1, 'b': 2, 'c': 3};
      final result = map.pick(['a', 'c']);
      expect(result, {'a': 1, 'c': 3});
    });

    test('omit removes specified keys', () {
      final map = {'a': 1, 'b': 2, 'c': 3};
      final result = map.omit(['a', 'c']);
      expect(result, {'b': 2});
    });

    test('filter returns correct entries', () {
      final map = {'a': 1, 'b': 2, 'c': 3};
      final result = map.filter((k, v) => v > 1);
      expect(result, {'b': 2, 'c': 3});
    });

    test('mapKeys transforms keys correctly', () {
      final map = {'a': 1, 'b': 2};
      final result = map.mapKeys((k) => k.toUpperCase());
      expect(result, {'A': 1, 'B': 2});
    });

    test('mapValues transforms values correctly', () {
      final map = {'a': 1, 'b': 2};
      final result = map.mapValues((v) => v * 10);
      expect(result, {'a': 10, 'b': 20});
    });

    test('merge combines maps with override', () {
      final map1 = {'a': 1, 'b': 2};
      final map2 = {'b': 3, 'c': 4};
      final result = map1.merge(map2);
      expect(result, {'a': 1, 'b': 3, 'c': 4});
    });

    test('mergeAll combines multiple maps', () {
      final map1 = {'a': 1};
      final map2 = {'b': 2};
      final map3 = {'a': 3, 'c': 4};
      final result = map1.mergeAll([map2, map3]);
      expect(result, {'a': 3, 'b': 2, 'c': 4});
    });

    test('getOrDefault returns existing or default', () {
      final map = {'a': 1};
      expect(map.getOrDefault('a', 0), 1);
      expect(map.getOrDefault('b', 0), 0);
    });

    test('invertMulti groups keys by value', () {
      final map = {'a': 1, 'b': 2, 'c': 1};
      final result = map.invertMulti();
      expect(result.keys.toSet(), {1, 2});
      expect(result[1], containsAll(['a', 'c']));
      expect(result[2], ['b']);
    });

    test('pickByValue returns entries matching predicate', () {
      final map = {'a': 1, 'b': 2, 'c': 3};
      final result = map.pickByValue((v) => v.isEven);
      expect(result, {'b': 2});
    });

    test('omitByValue removes entries matching predicate', () {
      final map = {'a': 1, 'b': 2, 'c': 3};
      final result = map.omitByValue((v) => v.isEven);
      expect(result, {'a': 1, 'c': 3});
    });

    test('partition splits into pass and fail', () {
      final map = {'a': 1, 'b': 2, 'c': 3};
      final parts = map.partition((k, v) => v.isEven);
      expect(parts.pass, {'b': 2});
      expect(parts.fail, {'a': 1, 'c': 3});
    });
  });
}
