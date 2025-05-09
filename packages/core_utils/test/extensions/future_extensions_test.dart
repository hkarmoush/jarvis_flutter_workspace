import 'dart:async';
import 'package:test/test.dart';
import 'package:core_utils/core_utils.dart';

void main() {
  group('FutureExtensions', () {
    test('timeoutAfter completes before timeout', () async {
      final result =
          await Future.value(123).timeoutAfter(Duration(milliseconds: 10));
      expect(result, 123);
    });

    test('timeoutAfter throws TimeoutException when taking too long', () {
      final slowFuture = Future.delayed(Duration(milliseconds: 50), () => 'x');
      expect(
        () => slowFuture.timeoutAfter(Duration(milliseconds: 10)),
        throwsA(isA<TimeoutException>()),
      );
    });

    test('delay delays the future', () async {
      final start = DateTime.now();
      final result = await Future.value('ok').delay(Duration(milliseconds: 20));
      final elapsed = DateTime.now().difference(start);
      expect(elapsed.inMilliseconds, greaterThanOrEqualTo(20));
      expect(result, 'ok');
    });

    test('catchAs catches specific exception', () async {
      final f = Future<int>.error(FormatException('bad'))
          .catchAs<FormatException>((e) => 999);
      final result = await f;
      expect(result, 999);
    });

    test('catchAs does not catch other exception', () {
      final f = Future<int>.error(StateError('err'))
          .catchAs<FormatException>((e) => 123);
      expect(
        () => f,
        throwsA(isA<StateError>()),
      );
    });
  });

  group('FutureFunctionExtensions', () {
    test('retry succeeds before max attempts', () async {
      int count = 0;
      Future<String> func() async {
        count++;
        if (count < 3) throw Exception('fail');
        return 'success';
      }

      final result =
          await func.retry(5, delayBetween: Duration(milliseconds: 1));
      expect(result, 'success');
      expect(count, 3);
    });

    test('retry rethrows after too many attempts', () {
      int count = 0;
      Future<void> func() async {
        count++;
        throw Exception('always');
      }

      expect(
        () => func.retry(2, delayBetween: Duration(milliseconds: 1)),
        throwsA(isA<Exception>()),
      );
    });
  });

  group('FutureExtensions Additional', () {
    test('tap invokes action and returns value', () async {
      var called = false;
      final future = Future.value(42).tap((v) {
        expect(v, 42);
        called = true;
      });
      final result = await future;
      expect(result, 42);
      expect(called, isTrue);
    });

    test('onErrorReturn returns default on error', () async {
      final result = await Future<int>.error('err').onErrorReturn(7);
      expect(result, 7);
    });

    test('onErrorReturnWith invokes handler on error', () async {
      final handled =
          await Future<int>.error('fail').onErrorReturnWith((e, st) => 99);
      expect(handled, 99);
    });

    test('timeoutOrElse returns fallback on timeout', () async {
      final slow = Future.delayed(Duration(milliseconds: 50), () => 'x');
      final result = await slow.timeoutOrElse(Duration(milliseconds: 10), 'fb');
      expect(result, 'fb');
    });

    test('toResult wraps success and failure correctly', () async {
      final r1 = await Future.value('yes').toResult();
      expect(r1.isSuccess, isTrue);
      expect(r1.value, 'yes');
      final r2 = await Future<String>.error('bad').toResult();
      expect(r2.isFailure, isTrue);
      expect(r2.error, 'bad');
    });

    test('whenCompleteAsync runs callback after completion', () async {
      var done = false;
      final f = Future.value('v').whenCompleteAsync(() async {
        done = true;
      });
      final val = await f;
      expect(val, 'v');
      expect(done, isTrue);
    });

    test('ignoreError returns null on error', () async {
      final a = await Future<String>.error('x').ignoreError();
      expect(a, isNull);
      final b = await Future.value('ok').ignoreError();
      expect(b, 'ok');
    });
  });

  group('FutureFunctionExtensions Additional', () {
    test('retryWithBackoff succeeds with custom backoff', () async {
      int count = 0;
      Future<String> func() async {
        count++;
        if (count < 2) throw Exception('fail');
        return 'go';
      }

      final result = await func.retryWithBackoff(
        3,
        initialDelay: Duration(microseconds: 1),
        factor: 1.0,
      );
      expect(result, 'go');
      expect(count, 2);
    });

    test('retryWithBackoff rethrows after retries', () {
      var count = 0;
      Future<void> fn() async {
        count++;
        throw Exception('always');
      }

      expect(
        () => fn.retryWithBackoff(
          1,
          initialDelay: Duration(microseconds: 1),
          factor: 1.0,
        ),
        throwsA(isA<Exception>()),
      );
      expect(count, 1);
    });
  });
}
