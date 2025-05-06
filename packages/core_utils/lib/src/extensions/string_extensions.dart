extension StringExtensions on String {
  /// Returns true if the string is a valid email address
  bool get isEmail => RegExp(
        r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
      ).hasMatch(this);

  /// Returns true if the string is a valid phone number
  bool get isPhoneNumber => RegExp(
        r'^\+?[0-9]{10,}',
      ).hasMatch(this);

  /// Capitalizes the first letter of the string
  String get capitalize =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';

  /// Returns true if the string is null or empty
  bool get isNullOrEmpty => isEmpty;

  /// Returns the string with the first letter of each word capitalized
  String get titleCase => split(' ').map((word) => word.capitalize).join(' ');

  /// Returns the string reversed
  String get reverse => split('').reversed.join();

  /// Returns true if the string contains only numbers
  bool get isNumeric => RegExp(r'^-?\d+(\.\d+)?$').hasMatch(this);

  /// Returns true if the string contains only letters
  bool get isAlpha => RegExp(r'^[a-zA-Z]+$').hasMatch(this);

  /// Returns true if the string contains only letters and numbers
  bool get isAlphanumeric => RegExp(r'^[a-zA-Z0-9]+$').hasMatch(this);

  /// Removes all whitespace from the string
  String get removeWhitespace => replaceAll(RegExp(r'\s+'), '');

  /// Truncates the string to a given length, adding ellipsis if needed
  String truncate(int length, {String ellipsis = '...'}) {
    if (this.length <= length) return this;
    return substring(0, length) + ellipsis;
  }

  /// Converts the string to snake_case
  String get toSnakeCase =>
      replaceAllMapped(RegExp(r'([a-z0-9])([A-Z])'), (m) => '${m[1]}_${m[2]}')
          .replaceAll(RegExp(r'\s+'), '_')
          .toLowerCase();

  /// Converts the string to camelCase
  String get toCamelCase {
    final words = split(RegExp(r'[_\-\s]+'));
    return words.first.toLowerCase() +
        words.skip(1).map((w) => w.capitalize).join();
  }

  /// Converts the string to kebab-case
  String get toKebabCase =>
      replaceAllMapped(RegExp(r'([a-z0-9])([A-Z])'), (m) => '${m[1]}-${m[2]}')
          .replaceAll(RegExp(r'\s+'), '-')
          .toLowerCase();

  /// Repeats the string a given number of times
  String repeat(int times) => List.filled(times, this).join();
}
