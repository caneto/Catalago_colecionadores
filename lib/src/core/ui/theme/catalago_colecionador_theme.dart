import 'package:flutter/material.dart';

final class CatalagoColecionadorTheme {
  static const orangeColor = Color(0xFFFFAE45);
  static const textDescriptColor = Color(0xFFFFEFE9);
  static const blueColor = Color(0xFF0D40A6);
  static const whiteColor = Color(0xFFFFFFFF);
  static const textMain = Color.fromARGB(255, 32, 119, 68);
  static const textMainAccent = Color.fromARGB(255, 70, 30, 33);
  static const blackColor = Color(0xFF121721);
  static const blackClaroColor = Color(0xFF242E47);
  static const blueFaceBook = Color(0xFF3b5998);
  static const barColor = Color(0xFF364828);
  static const bgInput = Color(0xFF3f557a);
  static const bgCard = Color.fromARGB(255, 95, 124, 175);
  static const borderFooter = Color(0xFF472426);
  static const bgInputAccent = Color(0xFF137fec);
  static const navBarBackkgroundColor = Color(0xFFF1D0B1);
  static const navBarBoxItemColor = Color.fromARGB(255, 55, 48, 151);
  static const navBarBoxContornoColor = Color.fromARGB(255, 235, 174, 118);
  static const navBarBoxColor = Color(0xFFDCE9F1);
  static const lineDividColor = Color.fromARGB(255, 161, 226, 85);
  static const cardCategyColor = Color.fromARGB(255, 84, 123, 209);
  static const cardItemAndImageColor = Color.fromARGB(255, 84, 123, 209);

  static final _defaultInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: const BorderSide(color: textDescriptColor),
  );

  static String get font => 'Montserrat';

  static final lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: textDescriptColor),
    fontFamily: font,
    scaffoldBackgroundColor: textDescriptColor,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: textDescriptColor,
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

   static InputDecoration inputDecorationAddCard({
    String? hintText,
    Color colorSide = CatalagoColecionadorTheme.blueColor,
    bool isTextArea = false,
  }) {
    return InputDecoration(
      hintText: hintText,
      filled: true,
      fillColor: const Color.fromARGB(255, 221, 224, 226),
      hintStyle: TextStyle(
        color: Color.fromARGB(255, 45, 46, 44),
        fontWeight: FontWeight.w500,
        fontSize: 15,
        fontFamily: font,
      ),
      contentPadding: isTextArea
          ? const EdgeInsets.fromLTRB(14, 15, 14, 40)
          : const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: colorSide, width: 2),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
    );
  }

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
