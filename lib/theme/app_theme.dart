import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color.fromRGBO(162, 43, 42, 1);
  static const Color secondary = Color.fromRGBO(133, 46, 44, 1);
  static const Color grayLight = Color.fromRGBO(217, 216, 214, 1);
  static const Color gray = Color.fromRGBO(167, 168, 169, 1);
  static const Color grayDark = Color.fromRGBO(99, 101, 105, 1);
  static const Color tegraBlue = Color(0xFF2dbec2);
  static ThemeData lightTheme = ThemeData.light().copyWith(
    //Color primario
    useMaterial3: true,
    primaryColor: primary,
    //AppBar Theme
    appBarTheme: const AppBarTheme(
      color: primary,
      elevation: 0,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
          primary: primary, textStyle: const TextStyle(color: Colors.white)),
    ),
    //FloatingActionButtons
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: primary),

    //ElevatedTButtons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: primary,
        shape: const StadiumBorder(),
        elevation: 0,
      ),
    ),

    //Inputs
    inputDecorationTheme: const InputDecorationTheme(
      floatingLabelStyle: TextStyle(color: primary),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primary),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primary),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
    ),
  );
}
