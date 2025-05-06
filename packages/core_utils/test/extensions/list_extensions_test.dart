import 'package:test/test.dart';
import 'package:core_utils/core_utils.dart';
import 'dart:math';

void main() {
  group('ListExtensions', () {
    test('unique returns unique elements', () {
      expect([1, 2, 2, 3, 3, 3].unique, [1, 2, 3]);
    });

    test('whereNotNull removes null values', () {
      final list = <int?>[1, null, 2, null, 3];
      expect(list.whereNotNull(), [1, 2, 3]);
    });

    test('random returns null for empty and an element for non-empty', () {
      expect(<int>[].random, isNull);
      final list = ['a', 'b', 'c'];
      expect(list.random, anyOf(['a', 'b', 'c']));
    });

    test('chunk splits list into chunks', () {
      expect([1, 2, 3, 4, 5].chunk(2), [
        [1, 2],
        [3, 4],
        [5]
      ]);
      expect([1, 2, 3].chunk(5), [
        [1, 2, 3]
      ]);
    });

    test('containsAll works as expected', () {
      expect([1, 2, 3].containsAll([2, 3]), isTrue);
      expect([1, 2].containsAll([2, 3]), isFalse);
    });

    test('elementAtOrNull returns element or null', () {
      final list = [10, 20, 30];
      expect(list.elementAtOrNull(1), 20);
      expect(list.elementAtOrNull(-1), isNull);
      expect(list.elementAtOrNull(3), isNull);
    });

    test('firstOrNull and lastOrNull behave correctly', () {
      final list = [10, 20, 30];
      expect(list.firstOrNull, 10);
      expect(list.lastOrNull, 30);
      expect(<int>[].firstOrNull, isNull);
      expect(<int>[].lastOrNull, isNull);
    });

    test('count returns the number of elements matching predicate', () {
      expect([1, 2, 3, 2, 4].count((e) => e > 2), 2);
    });

    test('groupBy groups elements by key', () {
      final list = ['a', 'bb', 'ccc', 'dd', 'e'];
      expect(list.groupBy((s) => s.length), {
        1: ['a', 'e'],
        2: ['bb', 'dd'],
        3: ['ccc'],
      });
    });

    test('distinctBy returns unique elements based on key', () {
      final list = ['apple', 'apricot', 'banana', 'avocado'];
      expect(list.distinctBy((s) => s[0]), ['apple', 'banana']);
    });

    test('firstWhereOrNull and lastWhereOrNull find elements or return null',
        () {
      final list = [1, 2, 3, 2, 1];
      expect(list.firstWhereOrNull((e) => e > 2), 3);
      expect(list.firstWhereOrNull((e) => e > 3), isNull);
      expect(list.lastWhereOrNull((e) => e < 3), 1);
      expect(list.lastWhereOrNull((e) => e < 0), isNull);
    });

    test('mapIndexed transforms elements with their indices', () {
      expect([10, 20, 30].mapIndexed((i, e) => e + i), [10, 21, 32]);
    });

    test('intersperse inserts separators correctly', () {
      expect([1, 2, 3].intersperse(0), [1, 0, 2, 0, 3]);
      expect(<int>[].intersperse(0), []);
    });

    test('windowed returns sliding windows with optional step', () {
      expect([1, 2, 3, 4].windowed(2), [
        [1, 2],
        [2, 3],
        [3, 4]
      ]);
      expect([1, 2, 3].windowed(5), []);
      expect([1, 2, 3].windowed(3), [
        [1, 2, 3]
      ]);
      expect([1, 2, 3, 4].windowed(2, step: 2), [
        [1, 2],
        [3, 4]
      ]);
    });

    test('zip combines two lists correctly', () {
      expect([1, 2, 3].zip(['a', 'b'], (a, b) => '$a$b'), ['1a', '2b']);
    });
  });

  group('NestedListExtensions', () {
    test('flatten flattens nested lists', () {
      expect(
          [
            [1, 2],
            [3, 4],
            [5]
          ].flatten(),
          [1, 2, 3, 4, 5]);
      expect(<List<int>>[].flatten(), []);
    });
  });

  group('NumericListExtensions', () {
    test('sum returns the total sum', () {
      expect([1, 2, 3].sum(), 6);
      expect(<int>[].sum(), 0);
    });

    test('average returns the average or 0.0 when empty', () {
      expect([1, 2, 3].average(), closeTo(2.0, 1e-6));
      expect(<int>[].average(), 0.0);
    });
  });

  group('ListExtensions Additional', () {
    test('shuffled returns same elements', () {
      final list = [1, 2, 3, 4, 5];
      final shuffled = list.shuffled(random: Random(0));
      expect(shuffled.toSet(), equals(list.toSet()));
      expect(shuffled.length, equals(list.length));
    });

    test('splitBy splits list by predicate', () {
      final list = [1, 2, 0, 3, 4, 0, 5];
      expect(list.splitBy((e) => e == 0), [
        [1, 2],
        [3, 4],
        [5]
      ]);
    });

    test('padRight and padLeft pad the list correctly', () {
      final list = [1, 2];
      expect(list.padRight(5, 0), [1, 2, 0, 0, 0]);
      expect(list.padRight(2, 0), [1, 2]);
      expect(list.padLeft(5, 0), [0, 0, 0, 1, 2]);
      expect(list.padLeft(2, 0), [1, 2]);
    });

    test('union, intersection, and difference behave correctly', () {
      final a = [1, 2, 3];
      final b = [2, 3, 4];
      expect(a.union(b), [1, 2, 3, 4]);
      expect(a.intersection(b), [2, 3]);
      expect(a.difference(b), [1]);
    });

    test('partition splits list based on predicate', () {
      final result = [1, 2, 3, 4, 5].partition((e) => e.isEven);
      expect(result.pass, [2, 4]);
      expect(result.fail, [1, 3, 5]);
    });
  });

  group('ComparableListExtensions', () {
    test('sorted and sortedBy work correctly', () {
      expect([3, 1, 2].sorted(), [1, 2, 3]);
      final words = ['apple', 'banana', 'pear'];
      expect(words.sortedBy((s) => s.length), ['pear', 'apple', 'banana']);
    });

    test('minOrNull and maxOrNull return correct values', () {
      expect([3, 1, 4, 2].minOrNull(), 1);
      expect([3, 1, 4, 2].maxOrNull(), 4);
      expect(<int>[].minOrNull(), isNull);
      expect(<int>[].maxOrNull(), isNull);
    });
  });

  group('ListExtensions Future', () {
    test('flatMap flattens and maps correctly', () {
      final list = [1, 2, 3];
      expect(list.flatMap((e) => [e, e * 2]), [1, 2, 2, 4, 3, 6]);
    });

    test('mapNotNull filters out null results', () {
      final list = [1, 2, 3, 4];
      final result = list.mapNotNull((e) => e.isEven ? e * 2 : null);
      expect(result, [4, 8]);
    });

    test('takeWhile and skipWhile work correctly', () {
      final list = [1, 2, 3, 1, 2];
      expect(list.takeWhile((e) => e < 3), [1, 2]);
      expect(list.skipWhile((e) => e < 3), [3, 1, 2]);
    });

    test('sample returns distinct random elements', () {
      final list = [1, 2, 3, 4, 5];
      final sample = list.sample(3, random: Random(0));
      expect(sample.length, 3);
      expect(sample.toSet().length, 3);
      expect(sample.every((e) => list.contains(e)), isTrue);
    });

    test('rotate rotates list correctly', () {
      final list = [1, 2, 3, 4, 5];
      expect(list.rotate(2), [3, 4, 5, 1, 2]);
      expect(list.rotate(-1), [5, 1, 2, 3, 4]);
    });

    test('toMap and sumBy compute correctly', () {
      final chars = ['a', 'bb', 'ccc'];
      final map = chars.toMap((e) => e, (e) => e.length);
      expect(map, {'a': 1, 'bb': 2, 'ccc': 3});
      final total = chars.sumBy((e) => e.length);
      expect(total, 6);
    });

    test('maxBy, minBy, and none work correctly', () {
      final list = ['a', 'bb', 'ccc'];
      expect(list.maxBy((e) => e.length), 'ccc');
      expect(list.minBy((e) => e.length), 'a');
      expect(list.none((e) => e.isEmpty), isTrue);
      expect(list.none((e) => e.length > 2), isFalse);
    });

    test('frequency computes counts correctly', () {
      final list = ['a', 'b', 'a', 'c', 'b'];
      expect(list.frequency(), {'a': 2, 'b': 2, 'c': 1});
    });

    test('takeRight and splitAt split correctly', () {
      final list = [1, 2, 3, 4];
      expect(list.takeRight(2), [3, 4]);
      expect(list.takeRight(5), [1, 2, 3, 4]);
      expect(list.splitAt(2), [
        [1, 2],
        [3, 4]
      ]);
      expect(list.splitAt(0), [
        [],
        [1, 2, 3, 4]
      ]);
      expect(list.splitAt(5), [
        [1, 2, 3, 4],
        []
      ]);
    });

    test('compress removes consecutive duplicates and pairwise pairs correctly',
        () {
      final list = [1, 1, 2, 2, 2, 3, 1];
      expect(list.compress(), [1, 2, 3, 1]);
      expect([1, 2, 3, 4].pairwise(), [
        [1, 2],
        [2, 3],
        [3, 4]
      ]);
      expect([1].pairwise(), []);
    });
  });
}
