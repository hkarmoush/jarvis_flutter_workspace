extension StringExtensions on String {
  /// Returns true if the string is a valid email address
  bool get isEmail => RegExp(
        r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
      ).hasMatch(this);

  /// Returns true if the string is a valid phone number
  bool get isPhoneNumber => RegExp(
        r'^\+?[0-9]{10,}$',
      ).hasMatch(this);

  /// Capitalizes the first letter of the string
  String get capitalize =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';

  /// Returns true if the string is null or empty
  bool get isNullOrEmpty => isEmpty;

  /// Returns the string with the first letter of each word capitalized
  String get titleCase => split(' ').map((word) => word.capitalize).join(' ');
}
