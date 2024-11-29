import 'package:flutter/material.dart';
import 'package:todo_app/constants.dart';

class AppThemes {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    textTheme: const TextTheme(
      titleSmall: TextStyle(
        fontSize: 24,
        color: Colors.black,
      ),
    ),
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        color: Colors.black,
      ),
    ),
  );
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkGreyClr,
    textTheme: const TextTheme(
      titleSmall: TextStyle(
        fontSize: 24,
        color: Colors.white,
      ),
    ),
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        color: Colors.white,
      ),
    ),
  );
}
