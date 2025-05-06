import 'package:flutter_test/flutter_test.dart';
import 'package:core_utils/core_utils.dart';

class TestDateTime {
  static DateTime? _now;
  static DateTime get now => _now ?? DateTime.now();
  static void setNow(DateTime dateTime) => _now = dateTime;
  static void reset() => _now = null;
}

void main() {
  group('DateTimeExtensions', () {
    final fixedNow = DateTime(2024, 3, 15, 14, 30); // March 15, 2024, 2:30 PM
    final today = DateTime(2024, 3, 15, 10, 0); // Same day, different time
    final yesterday = DateTime(2024, 3, 14, 10, 0); // Previous day
    final lastWeek = DateTime(2024, 3, 8, 10, 0); // 7 days ago
    final oldDate = DateTime(2024, 2, 1, 10, 0); // Old date

    setUp(() {
      // Override DateTime.now() for testing
      TestDateTime.setNow(fixedNow);
    });

    tearDown(() {
      TestDateTime.reset();
    });

    test('isToday returns correct value', () {
      expect(today.isToday(fixedNow), isTrue);
      expect(yesterday.isToday(fixedNow), isFalse);
      expect(lastWeek.isToday(fixedNow), isFalse);
    });

    test('isYesterday returns correct value', () {
      expect(yesterday.isYesterday(fixedNow), isTrue);
      expect(today.isYesterday(fixedNow), isFalse);
      expect(lastWeek.isYesterday(fixedNow), isFalse);
    });

    test('humanReadable returns correct format', () {
      expect(today.humanReadable(fixedNow), 'Today');
      expect(yesterday.humanReadable(fixedNow), 'Yesterday');
      expect(lastWeek.humanReadable(fixedNow), '8/3/2024');
      expect(oldDate.humanReadable(fixedNow), '1/2/2024');
    });

    test('time12Hour returns correct format', () {
      // Test AM times
      expect(DateTime(2024, 3, 15, 0, 0).time12Hour, '12:00 AM'); // Midnight
      expect(DateTime(2024, 3, 15, 9, 5).time12Hour, '9:05 AM'); // Morning
      expect(
          DateTime(2024, 3, 15, 11, 59).time12Hour, '11:59 AM'); // Late morning

      // Test PM times
      expect(DateTime(2024, 3, 15, 12, 0).time12Hour, '12:00 PM'); // Noon
      expect(DateTime(2024, 3, 15, 15, 30).time12Hour, '3:30 PM'); // Afternoon
      expect(DateTime(2024, 3, 15, 23, 59).time12Hour, '11:59 PM'); // Night
    });

    test('humanReadable returns correct format for old dates', () {
      final oldDate = DateTime(2024, 2, 1, 10, 0);
      expect(oldDate.humanReadable(fixedNow), '1/2/2024');
    });
  });
}
