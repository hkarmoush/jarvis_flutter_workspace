import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  /// Returns the screen size
  Size get screenSize => MediaQuery.of(this).size;

  /// Returns the screen width
  double get screenWidth => screenSize.width;

  /// Returns the screen height
  double get screenHeight => screenSize.height;

  /// Returns true if the screen is in portrait mode
  bool get isPortrait => screenHeight > screenWidth;

  /// Returns true if the screen is in landscape mode
  bool get isLandscape => screenWidth > screenHeight;

  /// Returns the theme
  ThemeData get theme => Theme.of(this);

  /// Returns the text theme
  TextTheme get textTheme => theme.textTheme;

  /// Returns the color scheme
  ColorScheme get colorScheme => theme.colorScheme;

  /// Returns the device pixel ratio
  double get pixelRatio => MediaQuery.of(this).devicePixelRatio;

  /// Returns the view padding
  EdgeInsets get viewPadding => MediaQuery.of(this).viewPadding;

  /// Returns the view insets
  EdgeInsets get viewInsets => MediaQuery.of(this).viewInsets;

  /// Returns true if the keyboard is visible
  bool get isKeyboardVisible => viewInsets.bottom > 0;

  /// Shows a snackbar
  void showSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
    Color? backgroundColor,
    TextStyle? textStyle,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message, style: textStyle),
        duration: duration,
        action: action,
        backgroundColor: backgroundColor,
      ),
    );
  }

  /// Shows a dialog with a title and message
  Future<bool?> showAlertDialog({
    required String title,
    required String message,
    String? confirmText,
    String? cancelText,
    Color? confirmButtonColor,
    Color? cancelButtonColor,
  }) {
    return showDialog<bool>(
      context: this,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          if (cancelText != null)
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(cancelText),
              style: TextButton.styleFrom(
                foregroundColor: cancelButtonColor,
              ),
            ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(confirmText ?? 'OK'),
            style: TextButton.styleFrom(
              foregroundColor: confirmButtonColor,
            ),
          ),
        ],
      ),
    );
  }

  /// Shows a bottom sheet
  Future<T?> showBottomSheet<T>({
    required Widget child,
    bool isDismissible = true,
    bool enableDrag = true,
    Color? backgroundColor,
    double? elevation,
    ShapeBorder? shape,
  }) {
    return showModalBottomSheet<T>(
      context: this,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: backgroundColor,
      elevation: elevation,
      shape: shape,
      builder: (context) => child,
    );
  }

  /// Navigates to a new screen
  Future<T?> push<T>(Widget page) {
    return Navigator.of(this).push(
      MaterialPageRoute(builder: (context) => page),
    );
  }

  /// Replaces the current screen with a new one
  Future<T?> pushReplacement<T>(Widget page) {
    return Navigator.of(this).pushReplacement(
      MaterialPageRoute(builder: (context) => page),
    );
  }

  /// Pops the current screen
  void pop<T>([T? result]) {
    Navigator.of(this).pop(result);
  }

  /// Returns true if the current route can be popped
  bool get canPop => Navigator.of(this).canPop();
}
