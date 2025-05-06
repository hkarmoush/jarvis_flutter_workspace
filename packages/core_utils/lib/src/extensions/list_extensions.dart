import 'dart:math';

/// A result type for partitioning a list into two groups.
class ListPartition<T> {
  /// Elements that satisfy the predicate.
  final List<T> pass;

  /// Elements that do not satisfy the predicate.
  final List<T> fail;

  ListPartition(this.pass, this.fail);
}

extension ListExtensions<T> on List<T> {
  /// Returns a new list with unique elements
  List<T> get unique => toSet().toList();

  /// Returns a new list with elements that satisfy the predicate
  List<T> whereNotNull() => where((element) => element != null).toList();

  /// Returns a random element from the list
  T? get random =>
      isEmpty ? null : this[DateTime.now().millisecondsSinceEpoch % length];

  /// Returns a new list with elements in chunks of specified size
  List<List<T>> chunk(int size) {
    final chunks = <List<T>>[];
    for (var i = 0; i < length; i += size) {
      chunks.add(sublist(i, i + size > length ? length : i + size));
    }
    return chunks;
  }

  /// Returns true if the list contains all elements of another list
  bool containsAll(List<T> other) {
    return other.every((element) => contains(element));
  }

  /// Returns the element at the given index or null if out of range
  T? elementAtOrNull(int index) =>
      (index >= 0 && index < length) ? this[index] : null;

  /// Returns the first element or null if the list is empty
  T? get firstOrNull => isEmpty ? null : first;

  /// Returns the last element or null if the list is empty
  T? get lastOrNull => isEmpty ? null : last;

  /// Returns the number of elements matching the predicate
  int count(bool Function(T) test) => where(test).length;

  /// Groups elements by the key returned by the selector function
  Map<K, List<T>> groupBy<K>(K Function(T) keySelector) {
    final Map<K, List<T>> map = {};
    for (var element in this) {
      final key = keySelector(element);
      map.putIfAbsent(key, () => []).add(element);
    }
    return map;
  }

  /// Returns a list of unique elements based on the key returned by the selector function
  List<T> distinctBy<K>(K Function(T) keySelector) {
    final seen = <K>{};
    final list = <T>[];
    for (var element in this) {
      final key = keySelector(element);
      if (seen.add(key)) {
        list.add(element);
      }
    }
    return list;
  }

  /// Returns the first element matching the predicate or null
  T? firstWhereOrNull(bool Function(T element) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }

  /// Returns the last element matching the predicate or null
  T? lastWhereOrNull(bool Function(T element) test) {
    for (var i = length - 1; i >= 0; i--) {
      final element = this[i];
      if (test(element)) return element;
    }
    return null;
  }

  /// Transforms elements with their indices and returns a new list
  List<R> mapIndexed<R>(R Function(int index, T element) transform) {
    final result = <R>[];
    for (var i = 0; i < length; i++) {
      result.add(transform(i, this[i]));
    }
    return result;
  }

  /// Inserts the separator between elements and returns a new list
  List<T> intersperse(T separator) {
    if (isEmpty) return [];
    final result = <T>[];
    for (var i = 0; i < length; i++) {
      result.add(this[i]);
      if (i < length - 1) {
        result.add(separator);
      }
    }
    return result;
  }

  /// Creates sliding windows of the list of given size and step
  List<List<T>> windowed(int size, {int step = 1}) {
    final windows = <List<T>>[];
    if (size <= 0 || isEmpty) return windows;
    for (var i = 0; i <= length - size; i += step) {
      windows.add(sublist(i, i + size));
    }
    return windows;
  }

  /// Zips this list with another list using the combiner function
  List<R> zip<T2, R>(List<T2> other, R Function(T a, T2 b) combiner) {
    final minLength = length < other.length ? length : other.length;
    final result = <R>[];
    for (var i = 0; i < minLength; i++) {
      result.add(combiner(this[i], other[i]));
    }
    return result;
  }

  /// Returns a new list with elements in random order
  List<T> shuffled({Random? random}) {
    final list = toList();
    list.shuffle(random);
    return list;
  }

  /// Splits the list into sublists separated by elements matching [predicate]
  List<List<T>> splitBy(bool Function(T element) predicate) {
    final result = <List<T>>[];
    var current = <T>[];
    for (var element in this) {
      if (predicate(element)) {
        if (current.isNotEmpty) {
          result.add(current);
          current = <T>[];
        }
      } else {
        current.add(element);
      }
    }
    if (current.isNotEmpty) result.add(current);
    return result;
  }

  /// Pads the list on the right with [fillValue] to reach [length]
  List<T> padRight(int length, T fillValue) {
    if (this.length >= length) return toList();
    final result = toList();
    result.addAll(List<T>.filled(length - this.length, fillValue));
    return result;
  }

  /// Pads the list on the left with [fillValue] to reach [length]
  List<T> padLeft(int length, T fillValue) {
    if (this.length >= length) return toList();
    final count = length - this.length;
    return [...List<T>.filled(count, fillValue), ...this];
  }

  /// Returns the union of this list and [other], with unique elements
  List<T> union(List<T> other) => [...this, ...other].unique;

  /// Returns elements present in both this list and [other]
  List<T> intersection(List<T> other) =>
      where((e) => other.contains(e)).toList().unique;

  /// Returns elements in this list that are not in [other]
  List<T> difference(List<T> other) =>
      where((e) => !other.contains(e)).toList();

  /// Partitions the list into elements that satisfy the predicate and those that don't
  ListPartition<T> partition(bool Function(T element) predicate) {
    final pass = <T>[];
    final fail = <T>[];
    for (final e in this) {
      if (predicate(e)) {
        pass.add(e);
      } else {
        fail.add(e);
      }
    }
    return ListPartition(pass, fail);
  }

  /// Applies [transform] to each element and flattens the result.
  List<R> flatMap<R>(Iterable<R> Function(T) transform) =>
      expand(transform).toList();

  /// Applies [transform] to each element and collects non-null results.
  List<R> mapNotNull<R>(R? Function(T) transform) =>
      map(transform).where((e) => e != null).cast<R>().toList();

  /// Returns the first contiguous elements that satisfy [test].
  List<T> takeWhile(bool Function(T) test) {
    final result = <T>[];
    for (var e in this) {
      if (!test(e)) break;
      result.add(e);
    }
    return result;
  }

  /// Returns a list excluding the first contiguous elements that satisfy [test].
  List<T> skipWhile(bool Function(T) test) {
    var i = 0;
    while (i < length && test(this[i])) {
      i++;
    }
    return sublist(i);
  }

  /// Returns a random sample of [count] distinct elements.
  List<T> sample(int count, {Random? random}) {
    final rng = random ?? Random();
    final temp = toList();
    final result = <T>[];
    for (var i = 0; i < count && temp.isNotEmpty; i++) {
      final index = rng.nextInt(temp.length);
      result.add(temp.removeAt(index));
    }
    return result;
  }

  /// Rotates the list to the left by [positions].
  List<T> rotate(int positions) {
    if (isEmpty) return [];
    final n = length;
    final shift = ((positions % n) + n) % n;
    return [...sublist(shift), ...sublist(0, shift)];
  }

  /// Creates a map from the list using [keySelector] and [valueSelector].
  Map<K, V> toMap<K, V>(
      K Function(T) keySelector, V Function(T) valueSelector) {
    final map = <K, V>{};
    for (var e in this) {
      map[keySelector(e)] = valueSelector(e);
    }
    return map;
  }

  /// Sums values selected by [selector].
  num sumBy(num Function(T) selector) => map(selector).toList().sum();

  /// Returns the element with the maximum [keySelector] or null if empty.
  T? maxBy<K extends Comparable>(K Function(T) keySelector) => isEmpty
      ? null
      : reduce((a, b) => keySelector(a).compareTo(keySelector(b)) >= 0 ? a : b);

  /// Returns the element with the minimum [keySelector] or null if empty.
  T? minBy<K extends Comparable>(K Function(T) keySelector) => isEmpty
      ? null
      : reduce((a, b) => keySelector(a).compareTo(keySelector(b)) <= 0 ? a : b);

  /// Returns true if no elements match the [test].
  bool none(bool Function(T) test) => !any(test);

  /// Returns a map of element frequencies.
  Map<T, int> frequency() {
    final freq = <T, int>{};
    for (var e in this) {
      freq[e] = (freq[e] ?? 0) + 1;
    }
    return freq;
  }

  /// Returns the last [count] elements or the whole list if [count] >= length.
  List<T> takeRight(int count) =>
      length <= count ? toList() : sublist(length - count);

  /// Splits the list at [index] into two lists: prefix and suffix.
  List<List<T>> splitAt(int index) {
    var idx = index;
    if (idx < 0) idx = 0;
    if (idx > length) idx = length;
    return [sublist(0, idx), sublist(idx)];
  }

  /// Removes consecutive duplicate elements.
  List<T> compress() {
    if (isEmpty) return [];
    final result = <T>[first];
    for (var i = 1; i < length; i++) {
      if (this[i] != this[i - 1]) {
        result.add(this[i]);
      }
    }
    return result;
  }

  /// Returns list of adjacent element pairs.
  List<List<T>> pairwise() {
    final result = <List<T>>[];
    for (var i = 0; i < length - 1; i++) {
      result.add([this[i], this[i + 1]]);
    }
    return result;
  }
}

extension NestedListExtensions<E> on List<List<E>> {
  /// Flattens a list of lists into a single list
  List<E> flatten() => expand((x) => x).toList();
}

extension NumericListExtensions on List<num> {
  /// Returns the sum of all elements in the list
  num sum() => fold(0, (previous, element) => previous + element);

  /// Returns the average of all elements in the list
  double average() => isEmpty ? 0.0 : sum() / length;
}

/// Extension for lists of Comparable elements.
extension ComparableListExtensions<T extends Comparable> on List<T> {
  /// Returns a sorted copy of the list in ascending order.
  List<T> sorted() => toList()..sort();

  /// Returns a sorted copy of the list by the provided key selector in ascending order.
  List<T> sortedBy<K extends Comparable>(K Function(T element) keySelector) {
    final list = toList();
    list.sort((a, b) => keySelector(a).compareTo(keySelector(b)));
    return list;
  }

  /// Returns the minimum element or null if the list is empty.
  T? minOrNull() =>
      isEmpty ? null : reduce((a, b) => a.compareTo(b) < 0 ? a : b);

  /// Returns the maximum element or null if the list is empty.
  T? maxOrNull() =>
      isEmpty ? null : reduce((a, b) => a.compareTo(b) > 0 ? a : b);
}
