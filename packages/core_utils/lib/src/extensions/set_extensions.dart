// Utility extensions for Set<T>
extension SetExtensions<T> on Set<T> {
  /// Returns the union of this set and [other].
  Set<T> unionWith(Set<T> other) => union(other);

  /// Returns the intersection of this set and [other].
  Set<T> intersectionWith(Set<T> other) => intersection(other);

  /// Returns the difference between this set and [other].
  Set<T> differenceWith(Set<T> other) => difference(other);

  /// Removes null elements from the set (for nullable T).
  Set<T> removeNulls() => where((e) => e != null).toSet();

  /// Splits the set into chunks of [size], preserving iteration order.
  List<Set<T>> chunk(int size) {
    final items = toList();
    final result = <Set<T>>[];
    for (var i = 0; i < items.length; i += size) {
      result.add(items
          .sublist(i, i + size > items.length ? items.length : i + size)
          .toSet());
    }
    return result;
  }

  /// Partitions the set into two sets: pass and fail.
  Map<bool, Set<T>> partition(bool Function(T) test) {
    final pass = <T>{};
    final fail = <T>{};
    for (var e in this) {
      if (test(e)) {
        pass.add(e);
      } else {
        fail.add(e);
      }
    }
    return {true: pass, false: fail};
  }
}
