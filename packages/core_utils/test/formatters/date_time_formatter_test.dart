import 'package:flutter_test/flutter_test.dart';
import 'package:core_utils/formatters/date_time_formatter.dart';

void main() {
  group('DateTimeFormatter', () {
    final date = DateTime(2023, 6, 1, 14, 30, 45);
    test('format uses default pattern', () {
      expect(DateTimeFormatter.format(date), '2023-06-01');
    });
    test('format uses custom pattern', () {
      expect(DateTimeFormatter.format(date, pattern: 'MMM d, yyyy'),
          'Jun 1, 2023');
    });
    test('formatTime uses default pattern', () {
      expect(DateTimeFormatter.formatTime(date), '14:30:45');
    });
    test('formatRelative returns correct string', () {
      final now = DateTime(2023, 6, 1, 16, 30, 45);
      expect(DateTimeFormatter.formatRelative(date, now: now), '2h ago');
      expect(
          DateTimeFormatter.formatRelative(now.subtract(Duration(seconds: 30)),
              now: now),
          '30s ago');
      expect(
          DateTimeFormatter.formatRelative(now.subtract(Duration(minutes: 5)),
              now: now),
          '5m ago');
      expect(
          DateTimeFormatter.formatRelative(now.subtract(Duration(days: 2)),
              now: now),
          '2d ago');
      expect(
          DateTimeFormatter.formatRelative(now.subtract(Duration(days: 10)),
              now: now),
          'May 22, 2023');
    });
  });
}
