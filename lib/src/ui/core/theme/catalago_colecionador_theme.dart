import 'package:flutter/material.dart';

final class CatalagoColecionadorTheme {
  static const orangeColor = Color(0xFFFFAE45);
  static const lightOrangeColor = Color(0xFFFFEFE9);
  static const blueColor = Color(0xFF0D40A6);
  static const whiteColor = Color(0xFFFFFFFF);
  static const blackColor = Color(0xFF121721);
  static const blackClaroColor = Color(0xFF242E47);
  static const blueFaceBook = Color(0xFF3b5998);
  static const barColor = Color(0xFF364828);
  static const navBarBackkgroundColor = Color(0xFFF1D0B1);
  static const navBarBoxItemColor = Color.fromARGB(255, 55, 48, 151);
  static const navBarBoxContornoColor = Color.fromARGB(255, 235, 174, 118);
  static const navBarBoxColor = Color(0xFFDCE9F1);

  static final _defaultInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: const BorderSide(color: lightOrangeColor),
  );

  static String get font => 'Montserrat';

  static final lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: lightOrangeColor),
    fontFamily: font,
    scaffoldBackgroundColor: lightOrangeColor,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: lightOrangeColor,
      labelStyle: const TextStyle(
        fontSize: 14,
        color: orangeColor,
        fontWeight: FontWeight.w700,
      ),
      floatingLabelStyle: const TextStyle(
        color: blueColor,
        fontWeight: FontWeight.w600,
      ),
      border: _defaultInputBorder,
      enabledBorder: _defaultInputBorder,
      focusedBorder: _defaultInputBorder,
      errorBorder: _defaultInputBorder.copyWith(
        borderSide: const BorderSide(color: Colors.red),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        side: const BorderSide(color: blueColor),
        foregroundColor: blueColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: const TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: blueColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: const TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );

  static final darkTheme = lightTheme;

  static final textBold = TextStyle(
    fontWeight: FontWeight.bold,
    fontFamily: font,
  );

  static final textExtraBold = TextStyle(
    fontWeight: FontWeight.w800,
    fontFamily: font,
  );

  static final textTextButtonLabel = textBold.copyWith(fontSize: 15);

  static const titleStyle = TextStyle(
    color: blueColor,
    fontSize: 32,
    fontWeight: FontWeight.w900,
  );

  static const titleStyleNormal = TextStyle(
    color: blueColor,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static const titleSmallStyle = TextStyle(
    color: blueColor,
    fontSize: 24,
    fontWeight: FontWeight.w900,
  );

  static const subTitleSmallStyle = TextStyle(
    color: blueColor,
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );
}
