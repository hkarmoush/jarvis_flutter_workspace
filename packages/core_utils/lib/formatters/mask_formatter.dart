class MaskFormatter {
  /// Applies a mask to the input string. Use '#' as a placeholder.
  /// Example: MaskFormatter.format('1234567890', mask: '(###) ###-####')
  static String format(String input, {required String mask}) {
    var result = '';
    var inputIndex = 0;
    for (var i = 0; i < mask.length && inputIndex < input.length; i++) {
      if (mask[i] == '#') {
        result += input[inputIndex];
        inputIndex++;
      } else {
        result += mask[i];
      }
    }
    return result;
  }
}
