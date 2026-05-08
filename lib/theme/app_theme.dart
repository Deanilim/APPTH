import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primary = Color(0xFF6C63FF);
  static const Color secondary = Color(0xFFFF6584);
  static const Color background = Color(0xFFFFFBF0);
  static const Color success = Color(0xFF43D98E);
  static const Color warning = Color(0xFFFFD93D);

  static final BorderRadius borderRadius = BorderRadius.circular(24);

  static ThemeData get theme {
    final textTheme = GoogleFonts.fredokaTextTheme();

    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: background,
      textTheme: textTheme,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        primary: primary,
        secondary: secondary,
        surface: background,
      ),
      cardTheme: CardTheme(
        elevation: 6,
        shadowColor: Colors.black12,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
          textStyle: textTheme.titleLarge,
        ),
      ),
    );
  }
}
