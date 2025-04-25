import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF1877F2).withOpacity(0.4),
      titleTextStyle: TextStyle(
          color: Color(0xFF1877F2), fontSize: 24, fontWeight: FontWeight.w700),
      iconTheme: IconThemeData(color: Color(0xFF1877F2))),
  colorScheme: ColorScheme.fromSeed(
    seedColor: Color(0xFF1877F2),
  ),
  scaffoldBackgroundColor: Colors.white,
  useMaterial3: true,
  dividerColor: Color(0xFF1877F2).withOpacity(0.2),
  textTheme: TextTheme(
    bodyMedium: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w700,
        height: 1.2),
    displaySmall: TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 1.2),
    headlineSmall: TextStyle(
        color: Colors.black,
        fontSize: 24,
        fontWeight: FontWeight.w700,
        height: 1.2),
    bodySmall: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.2),
  ),
);

final darkTheme = ThemeData(
  appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF1877F2),
      titleTextStyle: TextStyle(
          color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700),
      iconTheme: IconThemeData(color: Colors.white)),
  colorScheme: ColorScheme.fromSeed(
    seedColor: Color(0xFF1877F2),
  ),
  scaffoldBackgroundColor: Color(0xFF1C1E21),
  useMaterial3: true,
  dividerColor: Color(0xFF1C1E21),
  textTheme: TextTheme(
    bodyMedium: TextStyle(
        color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
    displaySmall: TextStyle(
        color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w600),
    headlineSmall: TextStyle(
        color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700),
    bodySmall: TextStyle(
        color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
  ),
);
