import 'package:flutter_test/flutter_test.dart';
import 'package:core_utils/src/extensions/duration_extensions.dart';

void main() {
  group('DurationExtensions', () {
    test('toHms formats duration as HH:mm:ss', () {
      expect(Duration(hours: 2, minutes: 3, seconds: 4).toHms(), '02:03:04');
      expect(Duration(hours: 0, minutes: 0, seconds: 9).toHms(), '00:00:09');
      expect(Duration(hours: 12, minutes: 59, seconds: 59).toHms(), '12:59:59');
    });
    test('humanFriendly returns human readable string', () {
      expect(Duration(hours: 2, minutes: 3).humanFriendly(), '2h 3m');
      expect(Duration(hours: 0, minutes: 5).humanFriendly(), '5m');
      expect(Duration(hours: 1, minutes: 0).humanFriendly(), '1h');
      expect(Duration(hours: 0, minutes: 0).humanFriendly(), '');
    });
  });
}
