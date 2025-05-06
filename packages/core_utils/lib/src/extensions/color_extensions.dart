import 'package:flutter/material.dart';

extension ColorExtensions on Color {
  /// Returns a darker shade of the color
  Color darken([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }

  /// Returns a lighter shade of the color
  Color lighten([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final hslLight =
        hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
    return hslLight.toColor();
  }

  /// Returns true if the color is dark
  bool get isDark {
    final luminance = computeLuminance();
    return luminance < 0.5;
  }

  /// Returns a contrasting color (black or white) based on the color's brightness
  Color get contrastingColor {
    return isDark ? Colors.white : Colors.black;
  }

  /// Returns the color as a hex string
  String get toHex {
    return '#${toARGB32().toRadixString(16).padLeft(8, '0')}';
  }
}
