import 'package:flutter/material.dart';

class AppTheme {
  // Color palette
  static const Color primaryWhite = Color(0xFFFFFFFF);
  static const Color lightBrown = Color(0xFFD2B48C);
  static const Color mediumBrown = Color(0xFFA0522D);
  static const Color darkBrown = Color(0xFF8B4513);
  static const Color creamWhite = Color(0xFFFAF9F6);
  static const Color textDark = Color(0xFF2C2C2C);
  static const Color textLight = Color(0xFF666666);
  static const Color errorRed = Color(0xFFE53935);

  static ThemeData lightTheme = ThemeData(
    primarySwatch: _createMaterialColor(mediumBrown),
    primaryColor: mediumBrown,
    scaffoldBackgroundColor: primaryWhite,
    fontFamily: 'Inter',
    
    appBarTheme: AppBarTheme(
      backgroundColor: primaryWhite,
      foregroundColor: textDark,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: textDark,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: const IconThemeData(color: mediumBrown),
    ),
    
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: mediumBrown,
        foregroundColor: primaryWhite,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: mediumBrown,
        side: const BorderSide(color: lightBrown, width: 2),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: creamWhite,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: lightBrown),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: lightBrown),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: mediumBrown, width: 2),
      ),
      labelStyle: const TextStyle(color: textLight),
      hintStyle: const TextStyle(color: textLight),
      errorStyle: const TextStyle(color: errorRed),
    ),
    
    cardTheme: CardThemeData(
      color: primaryWhite,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: primaryWhite,
      selectedItemColor: mediumBrown,
      unselectedItemColor: textLight,
      elevation: 8,
      type: BottomNavigationBarType.fixed,
    ),
  );

  static MaterialColor _createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}