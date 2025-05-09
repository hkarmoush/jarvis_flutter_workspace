/// Utility extensions on Uri
extension UriExtensions on Uri {
  /// Returns a new Uri with the specified query parameters merged.
  Uri appendQueryParameters(Map<String, String> params) {
    final newParams = Map<String, String>.from(queryParameters)..addAll(params);
    return replace(queryParameters: newParams);
  }

  /// Returns a new Uri with [segments] appended to the path.
  Uri addPathSegments(String segments) {
    final parts = segments.split('/').where((s) => s.isNotEmpty);
    final newSegments = List<String>.from(pathSegments)..addAll(parts);
    return replace(pathSegments: newSegments);
  }

  /// Returns a new Uri without any query parameters.
  Uri withoutQuery() => replace(queryParameters: {});

  /// Returns a new Uri without fragment.
  Uri withoutFragment() => replace(fragment: '');
}
