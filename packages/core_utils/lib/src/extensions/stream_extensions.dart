import 'dart:async';

extension StreamExtensions<T> on Stream<T> {
  /// Returns the first element matching [test], or null if none.
  Future<T?> firstWhereOrNull(bool Function(T) test) async {
    await for (final element in this) {
      if (test(element)) return element;
    }
    return null;
  }

  /// Returns the last element matching [test], or null if none.
  Future<T?> lastWhereOrNull(bool Function(T) test) async {
    T? result;
    await for (final element in this) {
      if (test(element)) result = element;
    }
    return result;
  }

  /// Buffers events into lists of size [count].
  Stream<List<T>> buffer(int count) async* {
    final buffer = <T>[];
    await for (final element in this) {
      buffer.add(element);
      if (buffer.length >= count) {
        yield List.unmodifiable(buffer);
        buffer.clear();
      }
    }
    if (buffer.isNotEmpty) {
      yield List.unmodifiable(buffer);
    }
  }

  /// Emits only the latest event after [duration] of silence.
  Stream<T> debounce(Duration duration) {
    late StreamController<T> controller;
    Timer? timer;
    T? lastValue;
    controller = StreamController<T>(
      onListen: () {
        listen(
          (event) {
            lastValue = event;
            timer?.cancel();
            timer = Timer(duration, () {
              controller.add(lastValue as T);
              lastValue = null;
            });
          },
          onError: controller.addError,
          onDone: () {
            timer?.cancel();
            controller.close();
          },
        );
      },
      onCancel: () => timer?.cancel(),
    );
    return controller.stream;
  }

  /// Emits the first event and then ignores subsequent events for [duration].
  Stream<T> throttle(Duration duration) {
    late StreamController<T> controller;
    bool ready = true;
    controller = StreamController<T>(
      onListen: () {
        listen(
          (event) {
            if (!ready) return;
            ready = false;
            controller.add(event);
            Timer(duration, () {
              ready = true;
            });
          },
          onError: controller.addError,
          onDone: controller.close,
        );
      },
      onCancel: () {},
    );
    return controller.stream;
  }
}
