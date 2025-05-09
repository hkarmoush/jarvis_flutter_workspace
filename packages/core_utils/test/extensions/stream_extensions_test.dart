import 'dart:async';
import 'package:test/test.dart';
import 'package:core_utils/core_utils.dart';

void main() {
  group('StreamExtensions - first/lastWhereOrNull', () {
    test('firstWhereOrNull finds matching element', () async {
      final stream = Stream.fromIterable([1, 2, 3, 4]);
      final result = await stream.firstWhereOrNull((x) => x > 2);
      expect(result, 3);
    });

    test('firstWhereOrNull returns null if none match', () async {
      final stream = Stream.fromIterable([1, 2]);
      final result = await stream.firstWhereOrNull((x) => x > 5);
      expect(result, isNull);
    });

    test('lastWhereOrNull finds last matching element', () async {
      final stream = Stream.fromIterable([1, 2, 3, 2, 1]);
      final result = await stream.lastWhereOrNull((x) => x < 3);
      expect(result, 1);
    });

    test('lastWhereOrNull returns null if none match', () async {
      final stream = Stream.fromIterable([1, 2]);
      final result = await stream.lastWhereOrNull((x) => x > 10);
      expect(result, isNull);
    });
  });

  group('StreamExtensions - buffer', () {
    test('buffer chunks the stream into fixed-size lists', () async {
      final controller = StreamController<int>();
      final buffered = controller.stream.buffer(3);
      final result = <List<int>>[];
      buffered.listen(result.add);

      controller.add(1);
      controller.add(2);
      controller.add(3);
      controller.add(4);
      controller.add(5);
      await controller.close();

      // Should emit [1,2,3] then remaining [4,5]
      expect(result, [
        [1, 2, 3],
        [4, 5]
      ]);
    });
  });

  group('StreamExtensions - debounce', () {
    test('debounce emits only the last event after silence', () async {
      final controller = StreamController<int>();
      final result = <int>[];
      controller.stream.debounce(Duration(milliseconds: 50)).listen(result.add);

      controller.add(1);
      await Future.delayed(Duration(milliseconds: 30));
      controller.add(2);
      await Future.delayed(Duration(milliseconds: 30));
      controller.add(3);
      await Future.delayed(Duration(milliseconds: 60));
      await controller.close();

      expect(result, [3]);
    }, timeout: Timeout(Duration(seconds: 1)));
  });

  group('StreamExtensions - throttle', () {
    test('throttle emits first event then skips until duration passes',
        () async {
      final controller = StreamController<int>();
      final result = <int>[];
      controller.stream.throttle(Duration(milliseconds: 50)).listen(result.add);

      controller.add(1);
      await Future.delayed(Duration(milliseconds: 30));
      controller.add(2);
      await Future.delayed(Duration(milliseconds: 60));
      controller.add(3);
      await Future.delayed(Duration(milliseconds: 60));
      await controller.close();

      // Should emit 1, then 3 (2 is ignored because it arrives during the throttle window)
      expect(result, [1, 3]);
    }, timeout: Timeout(Duration(seconds: 1)));
  });
}
