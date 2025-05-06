import 'package:flutter/material.dart';

extension WidgetExtensions on Widget {
  /// Adds padding to the widget
  Widget padding(EdgeInsetsGeometry padding) {
    return Padding(padding: padding, child: this);
  }

  /// Centers the widget
  Widget center() {
    return Center(child: this);
  }

  /// Adds a border radius to the widget
  Widget borderRadius(double radius) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: this,
    );
  }

  /// Adds a background color to the widget
  Widget backgroundColor(Color color) {
    return DecoratedBox(
      decoration: BoxDecoration(color: color),
      child: this,
    );
  }

  /// Makes the widget clickable
  Widget onTap(VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: this,
    );
  }
}
