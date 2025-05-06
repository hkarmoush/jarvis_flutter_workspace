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
}
