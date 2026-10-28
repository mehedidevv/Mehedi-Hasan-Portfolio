import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static const List<String> headingFontFallback = ['Hind Siliguri', 'sans-serif'];
  static const List<String> bodyFontFallback = ['Hind Siliguri', 'sans-serif'];
  static const List<String> monoFontFallback = ['monospace'];

  // Font families for easy access
  static String get headingFont => GoogleFonts.spaceGrotesk().fontFamily!;
  static String get bodyFont => GoogleFonts.inter().fontFamily!;
  static String get monoFont => GoogleFonts.jetBrainsMono().fontFamily!;

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.primary,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
      ),
      fontFamily: GoogleFonts.inter().fontFamily,
      fontFamilyFallback: bodyFontFallback,
      textTheme: TextTheme(
        // H1 - Hero name, main headings
        displayLarge: GoogleFonts.spaceGrotesk(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w700,
          fontSize: 56, // Base max size for H1
          height: 1.1,
          letterSpacing: -1.12, // -0.02em
        ),
        // H2 - Section titles
        displayMedium: GoogleFonts.spaceGrotesk(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w700,
          fontSize: 40, // Base max size for H2
          height: 1.2,
          letterSpacing: -0.4, // -0.01em
        ),
        // H3 - Subsection titles
        displaySmall: GoogleFonts.spaceGrotesk(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w500,
          fontSize: 24, // Base max size for H3
          height: 1.3,
        ),
        // Hero subtitle / role
        headlineMedium: GoogleFonts.inter(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w400,
          fontSize: 24,
          height: 1.5,
        ),
        // Card titles
        titleLarge: GoogleFonts.spaceGrotesk(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w500,
          fontSize: 20,
          height: 1.3,
        ),
        // Emphasized text
        titleMedium: GoogleFonts.inter(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
        // Body text - paragraphs (desktop size, scales in UI)
        bodyLarge: GoogleFonts.inter(
          color: AppColors.textSecondary,
          fontSize: 17,
          height: 1.6,
          fontWeight: FontWeight.w400,
        ),
        // Project description, card text
        bodyMedium: GoogleFonts.inter(
          color: AppColors.textSecondary,
          fontSize: 15,
          height: 1.6,
          fontWeight: FontWeight.w400,
        ),
        // Buttons, navbar links
        labelLarge: GoogleFonts.inter(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
        // Tech tags, skill labels
        labelSmall: GoogleFonts.jetBrainsMono(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w400,
          fontSize: 13,
        ),
        // Footer text, small captions
        bodySmall: GoogleFonts.inter(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
      ),
      // Apply fonts to buttons and form fields
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          textStyle: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 15, letterSpacing: 0.15),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 15, letterSpacing: 0.15),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          textStyle: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 15, letterSpacing: 0.15),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 14),
        hintStyle: GoogleFonts.inter(fontWeight: FontWeight.w400, fontSize: 16), // 16px to prevent iOS zoom
      ),
      dividerColor: AppColors.border,
    );
  }
}
