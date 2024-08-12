import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  primaryColor: const Color(0xFF292F36),
  scaffoldBackgroundColor: Colors.white,
  textTheme: GoogleFonts.poppinsTextTheme().copyWith(
    displayLarge: GoogleFonts.poppins(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: const Color(0xFFFFFFFF),
    ),
    titleLarge: GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: const Color(0xFF292F36),
    ),
    bodyLarge: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: const Color(0xFF292F36),
    ),
    bodyMedium: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: const Color(0xFF292F36),
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF292F36),
    elevation: 4,
    titleTextStyle: TextStyle(
      color: Color(0xFF292F36),
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(color: Color(0xFF292F36)),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: const Color(0xFF292F36),
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: const Color(0xFFFFFFFF),
      backgroundColor: const Color(0xFF292F36),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFFFFFFFF),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Color(0xFF292F36),
        width: 2,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: Color(0xFFBFC0C0),
        width: 1,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    labelStyle: GoogleFonts.poppins(
      color: const Color(0xFF292F36),
      fontSize: 16,
    ),
  ),
  cardTheme: CardTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    elevation: 4,
    margin: const EdgeInsets.all(8),
    color: const Color(0xFFFFFFFF),
  ),
  iconTheme: const IconThemeData(
    color: Color(0xFF292F36),
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: const Color(0xFF292F36),
    contentTextStyle: GoogleFonts.poppins(
      color: const Color(0xFFFFFFFF),
      fontSize: 16,
    ),
  ),
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF292F36),
    secondary: Color(0xFFA663CC),
    surface: Color(0xFFFFFFFF),
    error: Color(0xFFF02D3A),
    onPrimary: Color(0xFFFFFFFF),
    onSecondary: Color(0xFFFFFFFF),
    onSurface: Color(0xFF292F36),
    onError: Color(0xFFFFFFFF),
  ).copyWith(secondary: const Color(0xFFA663CC)),
);
