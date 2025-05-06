extension DateTimeExtensions on DateTime {
  /// Returns true if the date is today
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Returns true if the date is yesterday
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  /// Returns the date in a human-readable format
  String get humanReadable {
    if (isToday) return 'Today';
    if (isYesterday) return 'Yesterday';

    final difference = DateTime.now().difference(this);
    if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    }

    return '$day/$month/$year';
  }

  /// Returns the time in 12-hour format
  String get time12Hour {
    final hour = this.hour % 12;
    final period = this.hour < 12 ? 'AM' : 'PM';
    return '${hour == 0 ? 12 : hour}:${minute.toString().padLeft(2, '0')} $period';
  }
}
