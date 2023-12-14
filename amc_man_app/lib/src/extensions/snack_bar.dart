import 'package:flutter/material.dart';

extension BuildContextX on BuildContext {
  void showSnackbar(String text, [Duration? duration]) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(_snackBar(text, duration));
  }

  SnackBar _snackBar(String text, [Duration? duration]) => SnackBar(
        content: Text(text),
        duration: duration ?? const Duration(seconds: 2),
      );
}
