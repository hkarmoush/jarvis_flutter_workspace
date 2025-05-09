class FileSizeFormatter {
  static String format(int bytes, {int decimalPlaces = 1}) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(decimalPlaces)} KB';
    }
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(decimalPlaces)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(decimalPlaces)} GB';
  }
}
