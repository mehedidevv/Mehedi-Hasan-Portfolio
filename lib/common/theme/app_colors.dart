import 'package:flutter/material.dart';

/// Central color palette for the portfolio.
/// Futuristic dark theme with vibrant emerald, cyber cyan & electric blue accents.
class AppColors {
  AppColors._();

  static const Color background = Color(0xFF080C14);
  static const Color surface = Color(0xFF0E131F);
  static const Color surfaceLight = Color(0xFF161E2E);
  static const Color card = Color(0xFF121824);

  static const Color primary = Color(0xFF16C784); // Vibrant Emerald Neon
  static const Color primaryDark = Color(0xFF0E9A66);
  static const Color primaryLight = Color(0xFF00E5FF); // Cyber Cyan
  static const Color secondary = Color(0xFF3B82F6); // Electric Royal Blue
  static const Color accentPurple = Color(0xFF8B5CF6); // Neon Purple

  static const Color textPrimary = Color(0xFFF8FAFC);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textMuted = Color(0xFF64748B);

  static const Color border = Color(0xFF1E293B);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF16C784), Color(0xFF00E5FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroGlow = LinearGradient(
    colors: [Color(0xFF16C784), Color(0xFF00E5FF), Color(0xFF3B82F6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cyberGlow = LinearGradient(
    colors: [Color(0xFF00E5FF), Color(0xFF8B5CF6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient glassGradient = LinearGradient(
    colors: [
      Color(0x22FFFFFF),
      Color(0x0D080C14),
      Color(0x1AFFFFFF),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
