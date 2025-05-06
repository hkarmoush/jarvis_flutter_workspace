library core_utils;

export 'src/extensions/string_extensions.dart';
export 'src/extensions/date_time_extensions.dart';
export 'src/extensions/widget_extensions.dart';
export 'src/extensions/list_extensions.dart';
export 'src/extensions/map_extensions.dart';
export 'src/extensions/color_extensions.dart';
export 'src/extensions/context_extensions.dart';
export 'src/extensions/number_extensions.dart';
export 'src/extensions/file_extensions.dart';
export 'src/formatters/currency_formatter.dart';
export 'src/validators/input_validators.dart';

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}
