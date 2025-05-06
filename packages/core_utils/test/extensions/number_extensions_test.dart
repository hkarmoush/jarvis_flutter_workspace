import 'package:test/test.dart';
import 'package:core_utils/core_utils.dart';

void main() {
  group('IntExtensions', () {
    test('duration getters', () {
      expect(500.milliseconds, Duration(milliseconds: 500));
      expect(2.seconds, Duration(seconds: 2));
      expect(3.minutes, Duration(minutes: 3));
      expect(4.hours, Duration(hours: 4));
      expect(5.days, Duration(days: 5));
    });

    test('isEven and isOdd', () {
      expect(2.isEven, isTrue);
      expect(3.isEven, isFalse);
      expect(2.isOdd, isFalse);
      expect(3.isOdd, isTrue);
    });

    test('isPrime', () {
      expect(2.isPrime, isTrue);
      expect(3.isPrime, isTrue);
      expect(4.isPrime, isFalse);
      expect(17.isPrime, isTrue);
      expect(1.isPrime, isFalse);
      expect(0.isPrime, isFalse);
      expect((-7).isPrime, isFalse);
    });

    test('factorial', () {
      expect(0.factorial, 1);
      expect(1.factorial, 1);
      expect(5.factorial, 120);
      expect(() => (-1).factorial, throwsArgumentError);
    });

    test('withCommas', () {
      expect(1000.withCommas, '1,000');
      expect(1234567.withCommas, '1,234,567');
      expect(12.withCommas, '12');
    });

    test('toRoman', () {
      expect(1.toRoman, 'I');
      expect(4.toRoman, 'IV');
      expect(9.toRoman, 'IX');
      expect(58.toRoman, 'LVIII');
      expect(1994.toRoman, 'MCMXCIV');
      expect(() => 0.toRoman, throwsArgumentError);
      expect(() => 4000.toRoman, throwsArgumentError);
    });
  });

  group('DoubleExtensions', () {
    test('roundToDecimalPlaces', () {
      expect(1.2345.roundToDecimalPlaces(2), closeTo(1.23, 0.001));
      expect(1.2355.roundToDecimalPlaces(2), closeTo(1.24, 0.001));
    });

    test('isInteger', () {
      expect(2.0.isInteger, isTrue);
      expect(2.5.isInteger, isFalse);
    });

    test('percentage and percentageString', () {
      expect(0.25.percentage, closeTo(25.0, 0.001));
      expect(0.25.percentageString, '25.0%');
    });

    test('toCurrency', () {
      expect(12.345.toCurrency(), '\$12.35');
      expect(12.345.toCurrency(symbol: '€', decimalPlaces: 1), '€12.3');
    });

    test('formatWithCommas', () {
      expect(1234567.89.formatWithCommas(), '1,234,567.89');
      expect(1234.0.formatWithCommas(decimalPlaces: 0), '1,234');
    });

    test('toFraction', () {
      expect(1.5.toFraction(), '3/2');
      expect(0.25.toFraction(), '1/4');
      expect(2.0.toFraction(), '2');
    });

    test('toScientificNotation', () {
      expect(12345.0.toScientificNotation(), '1.23e4');
      expect(0.00123.toScientificNotation(decimalPlaces: 3), '1.230e-3');
      expect(0.0.toScientificNotation(), '0');
    });
  });
}
