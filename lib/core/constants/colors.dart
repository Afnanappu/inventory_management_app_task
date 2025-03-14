import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors (Green-based)
  static const Color primaryLight = Color(0xFF70E985);
  static const Color primary = Color(0xFF48D861);
  static const Color primaryDark = Color(0xFF3DB552);
  static const Color primaryDarker = Color(0xFF2E8C3F);

  // Accent Colors (Teal-based)
  static const Color accent = Color(0xFF26A69A);
  static const Color accentLight = Color(0xFF4DB6AC);

  // Neutral Colors
  static const Color surfaceWhite = Color(0xFFFFFFFF);
  static const Color surfaceLight = Color(0xFFF5F5F5);
  static const Color surfaceGrey = Color(0xFFE0E0E0);
  static const Color surfaceDark = Color(0xFF616161);
  static const Color surfaceDarker = Color(0xFF424242);
  static const Color scaffoldBackground = Color(0xFFFAFAFA);

  // Text Colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textDark = Color(0xFF000000);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFCA28);
  static const Color error = Color(0xFFFF5252);

  // Utility Colors
  static const Color transparent = Color(0x00000000);

  // Getters
  static Color get primaryContrast => textOnPrimary;
  static Color get disabled => textSecondary.withValues(alpha: 0.38);
}
