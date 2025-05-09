/// Utility extensions on JSON-like maps
extension JsonExtensions on Map<String, dynamic> {
  /// Returns the string value for [key], or [defaultValue] if missing or not a string.
  String getString(String key, [String defaultValue = '']) {
    final v = this[key];
    return v is String ? v : defaultValue;
  }

  /// Returns the int value for [key], or [defaultValue] if missing or not an int.
  int getInt(String key, [int defaultValue = 0]) {
    final v = this[key];
    return v is int ? v : defaultValue;
  }

  /// Returns the boolean value for [key], or [defaultValue] if missing or not a bool.
  bool getBool(String key, [bool defaultValue = false]) {
    final v = this[key];
    return v is bool ? v : defaultValue;
  }

  /// Returns the list of [T] for [key], or [defaultValue] if missing or not a list.
  List<T> getList<T>(String key, [List<T> defaultValue = const []]) {
    final v = this[key];
    if (v is List) {
      try {
        return List<T>.from(v);
      } catch (_) {}
    }
    return defaultValue;
  }

  /// Returns the map for [key], or [defaultValue] if missing or not a map.
  Map<String, dynamic> getMap(String key,
      [Map<String, dynamic> defaultValue = const {}]) {
    final v = this[key];
    if (v is Map) {
      try {
        return Map<String, dynamic>.from(v);
      } catch (_) {}
    }
    return defaultValue;
  }

  /// Safely casts the value for [key] to [T], or returns null if not of type [T].
  T? safeCast<T>(String key) {
    final v = this[key];
    return v is T ? v : null;
  }
}
