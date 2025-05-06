import 'dart:math' as math;

extension IntExtensions on int {
  /// Returns a Duration in milliseconds
  Duration get milliseconds => Duration(milliseconds: this);

  /// Returns a Duration in seconds
  Duration get seconds => Duration(seconds: this);

  /// Returns a Duration in minutes
  Duration get minutes => Duration(minutes: this);

  /// Returns a Duration in hours
  Duration get hours => Duration(hours: this);

  /// Returns a Duration in days
  Duration get days => Duration(days: this);

  /// Returns true if the number is even
  bool get isEven => this % 2 == 0;

  /// Returns true if the number is odd
  bool get isOdd => this % 2 != 0;

  /// Returns true if the number is prime
  bool get isPrime {
    if (this <= 1) return false;
    if (this <= 3) return true;
    if (this % 2 == 0 || this % 3 == 0) return false;
    for (int i = 5; i * i <= this; i += 6) {
      if (this % i == 0 || this % (i + 2) == 0) return false;
    }
    return true;
  }

  /// Returns the factorial of the number
  int get factorial {
    if (this < 0)
      throw ArgumentError('Factorial is not defined for negative numbers');
    if (this <= 1) return 1;
    return this * (this - 1).factorial;
  }

  /// Returns the number formatted with commas
  String get withCommas => toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]},',
      );

  /// Returns the number as a Roman numeral
  String get toRoman {
    if (this <= 0 || this > 3999) {
      throw ArgumentError(
          'Roman numerals are only defined for numbers between 1 and 3999');
    }
    final romanNumerals = {
      1000: 'M',
      900: 'CM',
      500: 'D',
      400: 'CD',
      100: 'C',
      90: 'XC',
      50: 'L',
      40: 'XL',
      10: 'X',
      9: 'IX',
      5: 'V',
      4: 'IV',
      1: 'I',
    };
    var result = '';
    var number = this;
    for (final entry in romanNumerals.entries) {
      while (number >= entry.key) {
        result += entry.value;
        number -= entry.key;
      }
    }
    return result;
  }
}

extension DoubleExtensions on double {
  /// Rounds the number to the specified decimal places
  double roundToDecimalPlaces(int places) {
    final factor = math.pow(10, places).toDouble();
    return (this * factor).round() / factor;
  }

  /// Returns true if the number is an integer
  bool get isInteger => this == round();

  /// Returns the percentage of the number (0-100)
  double get percentage => this * 100;

  /// Returns the number as a percentage string
  String get percentageString => '${percentage.roundToDecimalPlaces(2)}%';

  /// Returns the number formatted as currency
  String toCurrency({String symbol = '\$', int decimalPlaces = 2}) {
    return '$symbol${toStringAsFixed(decimalPlaces)}';
  }

  /// Returns the number formatted with commas and decimal places
  String formatWithCommas({int decimalPlaces = 2}) {
    final parts = toStringAsFixed(decimalPlaces).split('.');
    final integerPart = parts[0].replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
    return decimalPlaces > 0 ? '$integerPart.${parts[1]}' : integerPart;
  }

  /// Returns the number as a fraction string
  String toFraction() {
    if (isInteger) return toInt().toString();

    final tolerance = 1.0E-6;
    var h1 = 1, h2 = 0;
    var k1 = 0, k2 = 1;
    var b = this;

    do {
      final a = b.floor();
      var aux = h1;
      h1 = a * h1 + h2;
      h2 = aux;
      aux = k1;
      k1 = a * k1 + k2;
      k2 = aux;
      b = 1 / (b - a);
    } while ((this - h1 / k1).abs() > this * tolerance);

    return '$h1/$k1';
  }

  /// Returns the number as a scientific notation string
  String toScientificNotation({int decimalPlaces = 2}) {
    if (this == 0) return '0';
    final exponent = (math.log(abs()) / math.ln10).floor();
    final mantissa = this / math.pow(10, exponent);
    return '${mantissa.toStringAsFixed(decimalPlaces)}e$exponent';
  }
}
