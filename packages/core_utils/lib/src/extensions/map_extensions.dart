extension MapExtensions<K, V> on Map<K, V> {
  /// Returns a new map with null values removed
  Map<K, V> removeNullValues() {
    return Map<K, V>.fromEntries(
      entries.where((entry) => entry.value != null),
    );
  }

  /// Returns a new map with keys and values swapped
  Map<V, K> get inverted {
    return Map<V, K>.fromEntries(
      entries.map((entry) => MapEntry(entry.value, entry.key)),
    );
  }

  /// Returns a new map with only the specified keys
  Map<K, V> pick(List<K> keys) {
    return Map<K, V>.fromEntries(
      entries.where((entry) => keys.contains(entry.key)),
    );
  }

  /// Returns a new map without the specified keys
  Map<K, V> omit(List<K> keys) {
    return Map<K, V>.fromEntries(
      entries.where((entry) => !keys.contains(entry.key)),
    );
  }
}
