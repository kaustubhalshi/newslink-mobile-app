import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryPink = Color(0xFFFF69B4);
  static const Color secondaryPink = Color(0xFFFF1493);
  static const Color lightPink = Color(0xFFFFB6C1);
  static const Color darkPink = Color(0xFFC71585);

  static const LinearGradient pinkGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryPink, secondaryPink],
  );

  static const Color lightBackground = Color(0xFFFAFAFA);
  static const Color lightSurface = Colors.white;
  static const Color lightText = Color(0xFF212121);
  static const Color lightTextSecondary = Color(0xFF757575);

  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkText = Color(0xFFE0E0E0);
  static const Color darkTextSecondary = Color(0xFFB0B0B0);

  static const Color errorColor = Color(0xFFD32F2F);
  static const Color dividerColor = Color(0xFFE0E0E0);
}
