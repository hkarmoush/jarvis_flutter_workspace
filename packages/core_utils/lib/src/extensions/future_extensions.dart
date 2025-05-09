// Utility extensions for working with Futures
import 'dart:async';

extension FutureExtensions<T> on Future<T> {
  /// Throws a [TimeoutException] if this future does not complete within [duration].
  Future<T> timeoutAfter(Duration duration) => this.timeout(duration);

  /// Delays the completion of this future by [duration].
  Future<T> delay(Duration duration) async {
    await Future.delayed(duration);
    return await this;
  }

  /// Catches errors of type [E], converting them via [handler].
  Future<T> catchAs<E extends Object>(T Function(E) handler) =>
      this.catchError((e) => handler(e as E), test: (e) => e is E);
}

extension FutureFunctionExtensions<T> on Future<T> Function() {
  /// Retries the function up to [retries] times with optional [delayBetween] between attempts.
  Future<T> retry(int retries, {Duration? delayBetween}) async {
    for (var attempt = 0;; attempt++) {
      try {
        return await this();
      } catch (e) {
        if (attempt >= retries) rethrow;
        if (delayBetween != null) {
          await Future.delayed(delayBetween);
        }
      }
    }
  }
}

/// A container for capturing success or failure of a Future.
class Result<T> {
  /// The successful value, null on failure.
  final T? value;

  /// The error object, null on success.
  final Object? error;

  /// The stack trace for the error, if any.
  final StackTrace? stackTrace;

  Result.success(this.value)
      : error = null,
        stackTrace = null;
  Result.failure(this.error, [this.stackTrace]) : value = null;

  /// True if the future completed successfully.
  bool get isSuccess => error == null;

  /// True if the future failed.
  bool get isFailure => !isSuccess;
}

extension FutureExtensionsAdditional<T> on Future<T> {
  /// Invokes [action] on the successful result, then returns the original value.
  Future<T> tap(void Function(T value) action) async {
    final v = await this;
    action(v);
    return v;
  }

  /// Returns [defaultValue] if this future throws any error.
  Future<T> onErrorReturn(T defaultValue) async {
    try {
      return await this;
    } catch (_) {
      return defaultValue;
    }
  }

  /// If this future fails, invokes [handler] to compute a fallback.
  Future<T> onErrorReturnWith(
      T Function(Object error, StackTrace st) handler) async {
    try {
      return await this;
    } catch (e, st) {
      return handler(e, st);
    }
  }

  /// Throws a [TimeoutException] or returns [fallback] on timeout.
  Future<T> timeoutOrElse(Duration duration, T fallback) {
    return this.timeout(duration, onTimeout: () => fallback);
  }

  /// Wraps the result or error in a [Result].
  Future<Result<T>> toResult() async {
    try {
      final v = await this;
      return Result.success(v);
    } catch (e, st) {
      return Result.failure(e, st);
    }
  }

  /// Invokes [action] in the `whenComplete` phase, awaiting if it returns a Future.
  Future<T> whenCompleteAsync(FutureOr<void> Function() action) {
    return this.whenComplete(action);
  }

  /// Catches any error and returns `null` instead.
  Future<T?> ignoreError() async {
    try {
      return await this;
    } catch (_) {
      return null;
    }
  }
}

extension FutureFunctionExtensionsAdditional<T> on Future<T> Function() {
  /// Retries with exponential backoff: initial delay [initialDelay] multiplied by [factor].
  Future<T> retryWithBackoff(
    int retries, {
    Duration initialDelay = const Duration(milliseconds: 100),
    double factor = 2.0,
  }) async {
    var delayDuration = initialDelay;
    for (var attempt = 0;; attempt++) {
      try {
        return await this();
      } catch (e) {
        if (attempt >= retries) rethrow;
        await Future.delayed(delayDuration);
        delayDuration = Duration(
          microseconds: (delayDuration.inMicroseconds * factor).toInt(),
        );
      }
    }
  }
}
