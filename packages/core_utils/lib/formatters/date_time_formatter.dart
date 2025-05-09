import 'package:intl/intl.dart';

class DateTimeFormatter {
  static String format(DateTime date, {String pattern = 'yyyy-MM-dd'}) {
    return DateFormat(pattern).format(date);
  }

  static String formatTime(DateTime date, {String pattern = 'HH:mm:ss'}) {
    return DateFormat(pattern).format(date);
  }

  static String formatRelative(DateTime date, {DateTime? now}) {
    now ??= DateTime.now();
    final diff = now.difference(date);
    if (diff.inSeconds < 60) return '${diff.inSeconds}s ago';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return DateFormat('yMMMd').format(date);
  }
}
