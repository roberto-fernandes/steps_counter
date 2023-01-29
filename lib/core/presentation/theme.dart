import 'package:flutter/material.dart';

const _kOrange = Color.fromRGBO(247, 165, 108, 1.0);
const _fadeGray = Color.fromRGBO(237, 241, 243, 1.0);
const _gray = Color.fromRGBO(166, 172, 180, 1.0);
const _softBlue = Color.fromRGBO(89, 98, 116, 1.0);
const _darkBlue = Color.fromRGBO(31, 52, 85, 1.0);

final defaultTheme = ThemeData(
  fontFamily: 'lato',
  primaryColor: _kOrange,
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: _kOrange,
    onPrimary: _softBlue,
    secondary: _darkBlue,
    onSecondary: _fadeGray,
    error: Colors.red,
    onError: Colors.white,
    background: Colors.white,
    onBackground: _darkBlue,
    surface: _kOrange,
    onSurface: _softBlue,
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all<Color>(_gray),
      backgroundColor: MaterialStateProperty.all<Color>(_fadeGray),
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
        const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      ),
      textStyle: MaterialStateProperty.all<TextStyle>(
        const TextStyle(
          fontSize: 12,
        ),
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
      ),
    ),
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.w700,
      color: _darkBlue,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      color: _darkBlue,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      color: _darkBlue,
    ),
  ),
);
