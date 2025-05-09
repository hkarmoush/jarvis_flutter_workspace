import 'package:flutter_test/flutter_test.dart';
import 'package:core_utils/src/extensions/set_extensions.dart';

void main() {
  group('SetExtensions', () {
    test('unionWith returns union of sets', () {
      final a = {1, 2};
      final b = {2, 3};
      expect(a.unionWith(b), {1, 2, 3});
    });
    test('intersectionWith returns intersection of sets', () {
      final a = {1, 2};
      final b = {2, 3};
      expect(a.intersectionWith(b), {2});
    });
    test('differenceWith returns difference of sets', () {
      final a = {1, 2};
      final b = {2, 3};
      expect(a.differenceWith(b), {1});
    });
    test('removeNulls removes null elements', () {
      final a = <int?>{1, null, 2};
      expect(a.removeNulls(), {1, 2});
    });
    test('chunk splits set into chunks', () {
      final a = {1, 2, 3, 4};
      final chunks = a.chunk(2);
      expect(chunks.length, 2);
      expect(chunks[0].length, 2);
      expect(chunks[1].length, 2);
      expect(chunks.expand((e) => e).toSet(), a);
    });
    test('partition splits set by predicate', () {
      final a = {1, 2, 3, 4};
      final result = a.partition((e) => e.isEven);
      expect(result[true], {2, 4});
      expect(result[false], {1, 3});
    });
  });
}
