// A dictionary type alias for `Map<K, V>`.
typedef Dictionary<K, V> = Map<K, V>;

// A key/value pair type alias for `MapEntry<K, V>`.
typedef KVPair<K, V> = MapEntry<K, V>;

// A result type for partitioning a map into two groups.
class PartitionResult<K, V> {
  /// Entries that satisfy the predicate.
  final Dictionary<K, V> pass;

  /// Entries that do not satisfy the predicate.
  final Dictionary<K, V> fail;

  PartitionResult(this.pass, this.fail);
}

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

  /// Returns a new map containing only entries where [predicate] is true.
  Dictionary<K, V> filter(bool Function(K key, V value) predicate) {
    return Dictionary<K, V>.fromEntries(
      entries.where((e) => predicate(e.key, e.value)),
    );
  }

  /// Transforms each key using [transform], preserving values.
  Dictionary<NewK, V> mapKeys<NewK>(NewK Function(K key) transform) {
    return Dictionary<NewK, V>.fromEntries(
      entries.map((e) => KVPair(transform(e.key), e.value)),
    );
  }

  /// Transforms each value using [transform], preserving keys.
  Dictionary<K, NewV> mapValues<NewV>(NewV Function(V value) transform) {
    return Dictionary<K, NewV>.fromEntries(
      entries.map((e) => KVPair(e.key, transform(e.value))),
    );
  }

  /// Merges this map with [other], where entries in [other] override.
  Dictionary<K, V> merge(Dictionary<K, V> other) {
    final result = Dictionary<K, V>.from(this);
    result.addAll(other);
    return result;
  }

  /// Merges all provided maps into one, in order.
  Dictionary<K, V> mergeAll(Iterable<Dictionary<K, V>> maps) {
    final result = Dictionary<K, V>.from(this);
    for (final m in maps) {
      result.addAll(m);
    }
    return result;
  }

  /// Retrieves the value for [key], or returns [defaultValue] if absent.
  V getOrDefault(K key, V defaultValue) =>
      containsKey(key) ? this[key]! : defaultValue;

  /// Inverts the map, collecting duplicate values into lists of keys.
  Dictionary<V, List<K>> invertMulti() {
    final result = <V, List<K>>{};
    for (final e in entries) {
      result.putIfAbsent(e.value, () => []).add(e.key);
    }
    return result;
  }

  /// Returns a new map containing only entries where the value satisfies [predicate].
  Dictionary<K, V> pickByValue(bool Function(V value) predicate) =>
      Dictionary<K, V>.fromEntries(
        entries.where((e) => predicate(e.value)),
      );

  /// Returns a new map without entries where the value satisfies [predicate].
  Dictionary<K, V> omitByValue(bool Function(V value) predicate) =>
      Dictionary<K, V>.fromEntries(
        entries.where((e) => !predicate(e.value)),
      );

  /// Partitions the map into entries that pass and fail [predicate].
  PartitionResult<K, V> partition(bool Function(K key, V value) predicate) {
    final pass = <K, V>{};
    final fail = <K, V>{};
    for (final e in entries) {
      if (predicate(e.key, e.value)) {
        pass[e.key] = e.value;
      } else {
        fail[e.key] = e.value;
      }
    }
    return PartitionResult(pass, fail);
  }
}
