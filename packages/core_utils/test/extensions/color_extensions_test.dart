import 'package:flutter/material.dart';
import 'package:test/test.dart';
import 'package:core_utils/core_utils.dart';

void main() {
  group('ColorExtensions', () {
    test('darken works correctly', () {
      final color = Colors.blue;
      final darkened = color.darken(0.2);
      expect(darkened.computeLuminance(), lessThan(color.computeLuminance()));
    });

    test('lighten works correctly', () {
      final color = Colors.blue;
      final lightened = color.lighten(0.2);
      expect(
          lightened.computeLuminance(), greaterThan(color.computeLuminance()));
    });

    test('isDark works correctly', () {
      expect(Colors.black.isDark, isTrue);
      expect(Colors.white.isDark, isFalse);
      expect(Colors.blue.isDark, isTrue);
      expect(Colors.yellow.isDark, isFalse);
    });

    test('contrastingColor works correctly', () {
      expect(Colors.black.contrastingColor, Colors.white);
      expect(Colors.white.contrastingColor, Colors.black);
      expect(Colors.blue.contrastingColor, Colors.white);
      expect(Colors.yellow.contrastingColor, Colors.black);
    });

    test('toHex works correctly', () {
      expect(const Color(0xFF000000).toHex, '#ff000000'); // Black
      expect(const Color(0xFFFFFFFF).toHex, '#ffffffff'); // White
      expect(const Color(0xFFFF0000).toHex, '#ffff0000'); // Pure Red
      expect(const Color(0xFF00FF00).toHex, '#ff00ff00'); // Pure Green
      expect(const Color(0xFF0000FF).toHex, '#ff0000ff'); // Pure Blue
    });

    test('darken and lighten respect bounds', () {
      final color = Colors.blue;
      expect(color.darken(1.0).computeLuminance(), 0.0);
      expect(color.lighten(1.0).computeLuminance(), 1.0);
    });
  });
}
