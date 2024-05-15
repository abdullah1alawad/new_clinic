import 'package:flutter/material.dart';

class ThemeConfig {
  //Colors for theme
  static Color lightPrimary = Colors.blue;
  static Color darkPrimary = const Color(0xff1f1f1f);
  static Color lightInversePrimary = Colors.amberAccent;
  static Color darkInversePrimary = Colors.white;
  static Color lightAccent = Colors.white;
  static Color darkAccent = Colors.lightBlue;
  static Color lightBG = Colors.blue.shade100;
  static Color darkBG = const Color(0xff121212);
  static Color lightLabel = Colors.blue.shade300;
  static Color badgeColor = Colors.red;

  static ThemeData lightTheme = ThemeData(
    primaryColor: lightPrimary,
    scaffoldBackgroundColor: lightBG,
    appBarTheme: AppBarTheme(
      backgroundColor: lightPrimary,
      //elevation: 0,
      toolbarTextStyle: TextTheme(
        titleLarge: TextStyle(
          color: darkBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ).bodyMedium,
      titleTextStyle: TextTheme(
        titleLarge: TextStyle(
          color: lightAccent,
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),
      ).titleLarge,
      centerTitle: true,
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: lightPrimary,
      secondary: lightAccent,
      inversePrimary: lightInversePrimary,
      background: lightBG,
      brightness: Brightness.light,
    ),
    fontFamily: 'ElMessiri',
    textTheme: ThemeData.light().textTheme.copyWith(
          titleSmall: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'ElMessiri',
            fontWeight: FontWeight.bold,
          ),
          titleLarge: const TextStyle(
            color: Colors.blue,
            fontSize: 26,
            fontFamily: 'ElMessiri',
            fontWeight: FontWeight.bold,
          ),
          labelMedium: TextStyle(
            color: lightLabel,
            fontSize: 18,
            fontFamily: 'ElMessiri',
            //fontWeight: FontWeight.bold,
          ),
        ),
    useMaterial3: true,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: darkPrimary,
    scaffoldBackgroundColor: darkBG,
    appBarTheme: AppBarTheme(
      backgroundColor: darkPrimary,
      //elevation: 0,
      toolbarTextStyle: TextTheme(
        titleLarge: TextStyle(
          color: lightBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ).bodyMedium,
      titleTextStyle: TextTheme(
        titleLarge: TextStyle(
          color: darkAccent,
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),
      ).titleLarge,
      centerTitle: true,
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: darkPrimary,
      secondary: darkAccent,
      inversePrimary: darkInversePrimary,
      background: darkBG,
      brightness: Brightness.dark,
    ),
    fontFamily: 'ElMessiri',
    textTheme: ThemeData.light().textTheme.copyWith(
          titleSmall: TextStyle(
            color: darkAccent,
            fontSize: 20,
            fontFamily: 'ElMessiri',
            fontWeight: FontWeight.bold,
          ),
          titleLarge: const TextStyle(
            color: Colors.blue,
            fontSize: 26,
            fontFamily: 'ElMessiri',
            fontWeight: FontWeight.bold,
          ),
          labelMedium: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'ElMessiri',
            //fontWeight: FontWeight.bold,
          ),
        ),
    useMaterial3: true,
  );
}
