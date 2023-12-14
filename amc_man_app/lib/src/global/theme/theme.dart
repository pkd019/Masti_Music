import 'package:flutter/material.dart';

enum AppTheme { light, dark }

final appThemeData = {
  AppTheme.light: lightTheme,
  AppTheme.dark: darkTheme,
};

final lightTheme = ThemeData.light().copyWith();
final darkTheme = ThemeData.localize(
  ThemeData.dark().copyWith(
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Colors.teal),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.teal),
      ),
    ),
  ),
  lightTheme.textTheme,
);
