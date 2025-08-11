import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryWhite = Colors.white;
  static const Color accentBrown = Color(0xFF6D4C41);
  static const Color lightBrown = Color(0xFFA1887F);
  static const Color dividerColor = Color(0xFFD7CCC8);

  static ThemeData get theme {
    return ThemeData(
      scaffoldBackgroundColor: primaryWhite,
      appBarTheme: AppBarTheme(
        backgroundColor: primaryWhite,
        elevation: 0,
        iconTheme: const IconThemeData(color: accentBrown),
        titleTextStyle: GoogleFonts.lora(
          color: accentBrown,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      textTheme: GoogleFonts.loraTextTheme().copyWith(
        displayLarge: GoogleFonts.lora(color: accentBrown),
        displayMedium: GoogleFonts.lora(color: accentBrown),
        bodyLarge: GoogleFonts.lora(color: accentBrown),
        bodyMedium: GoogleFonts.lora(color: lightBrown),
        titleLarge: GoogleFonts.lora(
          color: accentBrown,
          fontWeight: FontWeight.bold,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: accentBrown,
          side: const BorderSide(color: lightBrown),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accentBrown,
          foregroundColor: primaryWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        ),
      ),
      cardTheme: CardThemeData(  // Changed from CardTheme to CardThemeData
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: lightBrown),
        ),
        margin: EdgeInsets.zero,  // Added recommended property
      ),
      dividerTheme: const DividerThemeData(
        color: dividerColor,
        thickness: 1,
        space: 1,
      ),
    );
  }
}