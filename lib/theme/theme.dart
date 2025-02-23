import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF1877F2).withOpacity(0.2),
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
        color: Colors.black.withOpacity(0.7),
        fontSize: 20,
        fontWeight: FontWeight.w700),
    displaySmall: TextStyle(
        color: Colors.black.withOpacity(0.4),
        fontSize: 14,
        fontWeight: FontWeight.w600),
    headlineSmall: TextStyle(
        color: Colors.black.withOpacity(0.7),
        fontSize: 24,
        fontWeight: FontWeight.w700),
    bodySmall: TextStyle(
        color: Colors.black.withOpacity(0.4),
        fontSize: 18,
        fontWeight: FontWeight.w600),
  ),
);
