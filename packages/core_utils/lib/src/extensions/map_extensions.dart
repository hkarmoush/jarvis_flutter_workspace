// A dictionary type alias for `Map<K, V>`.
typedef Dictionary<K, V> = Map<K, V>;

// A key/value pair type alias for `MapEntry<K, V>`.
typedef KVPair<K, V> = MapEntry<K, V>;

extension MapExtensions<K, V> on Dictionary<K, V> {
  /// Returns a new map containing only entries with non-null values.
  Dictionary<K, V> removeNullValues() => Dictionary<K, V>.fromEntries(
      entries.where((KVPair<K, V> e) => e.value != null));

  /// Returns a new map where each key and value are swapped.
  Dictionary<V, K> get inverted => Dictionary<V, K>.fromEntries(
      entries.map((KVPair<K, V> e) => KVPair(e.value, e.key)));

  /// Returns a new map containing only the entries with the specified [keys].
  Dictionary<K, V> pick(List<K> keys) => Dictionary<K, V>.fromEntries(
      entries.where((KVPair<K, V> e) => keys.contains(e.key)));

  /// Returns a new map without the entries for the specified [keys].
  Dictionary<K, V> omit(List<K> keys) => Dictionary<K, V>.fromEntries(
      entries.where((KVPair<K, V> e) => !keys.contains(e.key)));
}
