// lib/utils/app_colors.dart
import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF6A4C93);
  static const Color primaryDark = Color(0xFF5A3C80);
  static const Color primaryLight = Color(0xFF7D5BA6);
  
  // Accent Colors
  static const Color accent = Color(0xFFFF6B6B);
  static const Color accentDark = Color(0xFFE55A5A);
  static const Color accentLight = Color(0xFFFF8585);
  
  // Background Colors
  static const Color background = Color(0xFFF8F9FA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color card = Color(0xFFFFFFFF);
  
  // Text Colors
  static const Color textPrimary = Color(0xFF2D3748);
  static const Color textSecondary = Color(0xFF718096);
  static const Color textDisabled = Color(0xFFA0AEC0);
  static const Color textInverse = Color(0xFFFFFFFF);
  
  // Status Colors
  static const Color success = Color(0xFF48BB78);
  static const Color warning = Color(0xFFED8936);
  static const Color error = Color(0xFFF56565);
  static const Color info = Color(0xFF4299E1);
  
  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color gray50 = Color(0xFFF7FAFC);
  static const Color gray100 = Color(0xFFEDF2F7);
  static const Color gray200 = Color(0xFFE2E8F0);
  static const Color gray300 = Color(0xFFCBD5E0);
  static const Color gray400 = Color(0xFFA0AEC0);
  static const Color gray500 = Color(0xFF718096);
  static const Color gray600 = Color(0xFF4A5568);
  static const Color gray700 = Color(0xFF2D3748);
  static const Color gray800 = Color(0xFF1A202C);
  static const Color gray900 = Color(0xFF171923);
  
  // Additional Colors
  static const Color lightBrown = Color(0xFFD7CCC8);
  static const Color lightPurple = Color(0xFFEDE7F6);
  static const Color lightPink = Color(0xFFFCE4EC);
  static const Color lightBlue = Color(0xFFE3F2FD);
  static const Color lightGreen = Color(0xFFE8F5E9);
  
  // Gradient Colors
  static const Gradient primaryGradient = LinearGradient(
    colors: [primary, accent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const Gradient secondaryGradient = LinearGradient(
    colors: [accentLight, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // Social Media Colors
  static const Color facebook = Color(0xFF1877F2);
  static const Color instagram = Color(0xFFE4405F);
  static const Color twitter = Color(0xFF1DA1F2);
  static const Color youtube = Color(0xFFFF0000);
  static const Color linkedin = Color(0xFF0A66C2);
  static const Color tiktok = Color(0xFF000000);
  
  // Shadow Colors
  static const Color shadowLight = Color(0x0D000000);
  static const Color shadowMedium = Color(0x1A000000);
  static const Color shadowDark = Color(0x33000000);
  
  // Border Colors
  static const Color borderLight = Color(0xFFE2E8F0);
  static const Color borderMedium = Color(0xFFCBD5E0);
  static const Color borderDark = Color(0xFFA0AEC0);
  
  // Overlay Colors
  static const Color overlayLight = Color(0x0DFFFFFF);
  static const Color overlayMedium = Color(0x1AFFFFFF);
  static const Color overlayDark = Color(0x33FFFFFF);
  
  // Transparent Colors
  static const Color transparent = Color(0x00000000);
  static const Color primaryTransparent = Color(0x1A6A4C93);
  static const Color accentTransparent = Color(0x1AFF6B6B);
  static const Color successTransparent = Color(0x1A48BB78);
  static const Color errorTransparent = Color(0x1AF56565);
  
  // Get color shades for different states
  static Color getPrimaryShade(int shade) {
    switch (shade) {
      case 50: return const Color(0xFFF5F3FF);
      case 100: return const Color(0xFFEDE9FE);
      case 200: return const Color(0xFFDDD6FE);
      case 300: return const Color(0xFFC4B5FD);
      case 400: return const Color(0xFFA78BFA);
      case 500: return primary;
      case 600: return const Color(0xFF7C3AED);
      case 700: return const Color(0xFF6D28D9);
      case 800: return const Color(0xFF5B21B6);
      case 900: return const Color(0xFF4C1D95);
      default: return primary;
    }
  }
  
  // Get text color based on background brightness
  static Color getTextColorForBackground(Color backgroundColor) {
    final brightness = ThemeData.estimateBrightnessForColor(backgroundColor);
    return brightness == Brightness.dark ? textInverse : textPrimary;
  }
  
  // Check if color is light
  static bool isLightColor(Color color) {
    return ThemeData.estimateBrightnessForColor(color) == Brightness.light;
  }
  
  // Get contrast color
  static Color getContrastColor(Color color) {
    return isLightColor(color) ? black : white;
  }
}