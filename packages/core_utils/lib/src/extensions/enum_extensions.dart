/// Utility extensions for Dart Enums

import 'list_extensions.dart';

extension EnumExtensions on Enum {
  /// Returns the enum value's name (after the dot).
  String toName() => toString().split('.').last;
}

extension EnumListExtensions<T extends Enum> on List<T> {
  /// Finds an enum value by its [name], or null if none match.
  T? fromName(String name) => firstWhereOrNull((e) => e.toName() == name);
}
