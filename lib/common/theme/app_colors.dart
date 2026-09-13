import 'package:flutter/material.dart';

/// Central color palette for the portfolio.
/// Dark, modern theme with a green accent (matches the CV's brand color).
class AppColors {
  AppColors._();

  static const Color background = Color(0xFF0A0E14);
  static const Color surface = Color(0xFF121722);
  static const Color surfaceLight = Color(0xFF1A2130);
  static const Color card = Color(0xFF161C29);

  static const Color primary = Color(0xFF16C784); // green accent
  static const Color primaryDark = Color(0xFF0E9A66);
  static const Color secondary = Color(0xFF3B82F6); // blue accent

  static const Color textPrimary = Color(0xFFF5F7FA);
  static const Color textSecondary = Color(0xFFAAB2C0);
  static const Color textMuted = Color(0xFF6B7280);

  static const Color border = Color(0xFF232B3A);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF16C784), Color(0xFF0E9A66)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroGlow = LinearGradient(
    colors: [Color(0xFF16C784), Color(0xFF3B82F6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
