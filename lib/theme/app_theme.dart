import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color background = Color(0xFFFFF0F5);
  static const Color backgroundLight = Color(0xFFFFE4E1);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color divider = Color(0xFFFFB6C1);
  static const Color textPrimary = Color(0xFF2D132C);
  static const Color textSecondary = Color(0xFF6B4F67);
  static const Color textMuted = Color(0xFF9E8A9A);
  static const Color accent = Color(0xFFFF1493);
  static const Color accentLight = Color(0xFFFF69B4);
  static const Color cardBorder = Color(0xFFFFB6C1);
  static const Color tagBorder = Color(0xFFFFC0CB);
}

class AppTextStyles {
  static TextStyle get navBrand => GoogleFonts.playfairDisplay(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: -0.5,
      );

  static TextStyle get navLink => GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        letterSpacing: 1.5,
      );

  static TextStyle get heroTitle => GoogleFonts.playfairDisplay(
        fontSize: 120,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        height: 0.95,
        letterSpacing: -4,
      );

  static TextStyle get heroTitleAccent => GoogleFonts.playfairDisplay(
        fontSize: 120,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.italic,
        color: AppColors.accent,
        height: 0.95,
        letterSpacing: -4,
      );

  static TextStyle get sectionLabel => GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        color: AppColors.textMuted,
        letterSpacing: 3,
      );

  static TextStyle get sectionHeading => GoogleFonts.playfairDisplay(
        fontSize: 72,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        height: 1.05,
        letterSpacing: -2,
      );

  static TextStyle get sectionHeadingItalic => GoogleFonts.playfairDisplay(
        fontSize: 72,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.italic,
        color: AppColors.accent,
        height: 1.05,
        letterSpacing: -2,
      );

  static TextStyle get bodyLarge => GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
        height: 1.6,
      );

  static TextStyle get body => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        height: 1.7,
      );

  static TextStyle get bodySmall => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        height: 1.6,
      );

  static TextStyle get metaLabel => GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        color: AppColors.textMuted,
        letterSpacing: 2,
      );

  static TextStyle get metaValue => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
        height: 1.4,
      );

  static TextStyle get skillName => GoogleFonts.playfairDisplay(
        fontSize: 22,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
      );

  static TextStyle get skillNumber => GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: AppColors.textMuted,
        letterSpacing: 1,
      );

  static TextStyle get projectNumber => GoogleFonts.playfairDisplay(
        fontSize: 80,
        fontWeight: FontWeight.w700,
        color: AppColors.accent,
        height: 1,
      );

  static TextStyle get projectCategory => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.textMuted,
        letterSpacing: 2,
      );

  static TextStyle get projectTitle => GoogleFonts.playfairDisplay(
        fontSize: 48,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        height: 1.1,
        letterSpacing: -1,
      );

  static TextStyle get projectSubtitle => GoogleFonts.playfairDisplay(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.italic,
        color: AppColors.textSecondary,
        height: 1.5,
      );

  static TextStyle get tagText => GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        letterSpacing: 1.5,
      );

  static TextStyle get tickerText => GoogleFonts.playfairDisplay(
        fontSize: 64,
        fontWeight: FontWeight.w400,
        color: AppColors.textMuted,
        height: 1.2,
      );

  static TextStyle get contactHeading => GoogleFonts.playfairDisplay(
        fontSize: 96,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        height: 1.0,
        letterSpacing: -3,
      );

  static TextStyle get contactHeadingItalic => GoogleFonts.playfairDisplay(
        fontSize: 96,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.italic,
        color: AppColors.accent,
        height: 1.0,
        letterSpacing: -3,
      );

  static TextStyle get emailLink => GoogleFonts.playfairDisplay(
        fontSize: 28,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
        decoration: TextDecoration.underline,
        decorationColor: AppColors.textPrimary,
        height: 1.4,
      );

  static TextStyle get footerText => GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        color: AppColors.textMuted,
        letterSpacing: 1.5,
      );

  static TextStyle get buttonText => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.5,
      );

  static TextStyle get marqueeText => GoogleFonts.playfairDisplay(
        fontSize: 56,
        fontWeight: FontWeight.w300,
        color: AppColors.textMuted.withOpacity(0.6),
        height: 1.2,
      );

  static TextStyle get heroTagline => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        letterSpacing: 2,
      );

  static TextStyle get heroDescription => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        height: 1.7,
      );

  static TextStyle get aboutHeadingLarge => GoogleFonts.playfairDisplay(
        fontSize: 80,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        height: 1.0,
        letterSpacing: -3,
      );

  static TextStyle get aboutHeadingItalic => GoogleFonts.playfairDisplay(
        fontSize: 80,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.italic,
        color: AppColors.accent,
        height: 1.0,
        letterSpacing: -3,
      );
}

ThemeData buildAppTheme() {
  return ThemeData(
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.accent,
      surface: AppColors.surface,
    ),
    useMaterial3: true,
  );
}
