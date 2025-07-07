import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyle {
  static final TextTheme lightTextTheme = TextTheme(
    bodyLarge: _baseStyle(
      FontSize.size16,
      FontWeight.w500,
      AppColors.textPrimaryLight,
    ),
    bodyMedium: _baseStyle(
      FontSize.size14,
      FontWeight.w400,
      AppColors.textPrimaryLight,
    ),
    bodySmall: _baseStyle(
      FontSize.size6_4,
      FontWeight.w400,
      AppColors.textPrimaryLight,
    ),
    displayLarge: _baseStyle(
      FontSize.size62,
      FontWeight.w600,
      AppColors.textPrimaryLight,
    ),
    displayMedium: _baseStyle(
      FontSize.size42,
      FontWeight.w600,
      AppColors.textPrimaryLight,
    ),
    displaySmall: _baseStyle(
      FontSize.size32,
      FontWeight.w400,
      AppColors.textPrimaryLight,
    ),
    headlineLarge: _baseStyle(
      FontSize.size32,
      FontWeight.w600,
      AppColors.textPrimaryLight,
    ),
    headlineMedium: _baseStyle(
      FontSize.size26,
      FontWeight.w600,
      AppColors.textPrimaryLight,
    ),
    headlineSmall: _baseStyle(
      FontSize.size24,
      FontWeight.w500,
      AppColors.textPrimaryLight,
    ),
    labelLarge: _baseStyle(
      FontSize.size16,
      FontWeight.w700,
      AppColors.textPrimaryLight,
    ),
    labelMedium: _baseStyle(
      FontSize.size14,
      FontWeight.w600,
      AppColors.textPrimaryLight,
    ),
    labelSmall: _baseStyle(
      FontSize.size12,
      FontWeight.w600,
      AppColors.textPrimaryLight,
    ),
    titleLarge: _baseStyle(
      FontSize.size28,
      FontWeight.w600,
      AppColors.textPrimaryLight,
    ),
    titleMedium: _baseStyle(
      FontSize.size18,
      FontWeight.w700,
      AppColors.textPrimaryLight,
    ),
    titleSmall: _baseStyle(
      FontSize.size18,
      FontWeight.w400,
      AppColors.textPrimaryLight,
    ),
  );

  static final TextTheme darkTextTheme = TextTheme(
    bodyLarge: _baseStyle(
      FontSize.size16,
      FontWeight.w500,
      AppColors.textPrimaryDark,
    ),
    bodyMedium: _baseStyle(
      FontSize.size16,
      FontWeight.w400,
      AppColors.textPrimaryDark,
    ),
    bodySmall: _baseStyle(
      FontSize.size6_4,
      FontWeight.w400,
      AppColors.textPrimaryDark,
    ),
    displayLarge: _baseStyle(
      FontSize.size62,
      FontWeight.w600,
      AppColors.textPrimaryDark,
    ),
    displayMedium: _baseStyle(
      FontSize.size42,
      FontWeight.w600,
      AppColors.textPrimaryDark,
    ),
    displaySmall: _baseStyle(
      FontSize.size32,
      FontWeight.w400,
      AppColors.textPrimaryDark,
    ),
    headlineLarge: _baseStyle(
      FontSize.size32,
      FontWeight.w600,
      AppColors.textPrimaryDark,
    ),
    headlineMedium: _baseStyle(
      FontSize.size26,
      FontWeight.w500,
      AppColors.textPrimaryDark,
    ),
    headlineSmall: _baseStyle(
      FontSize.size24,
      FontWeight.w500,
      AppColors.textPrimaryDark,
    ),
    labelLarge: _baseStyle(
      FontSize.size16,
      FontWeight.w700,
      AppColors.textPrimaryDark,
    ),
    labelMedium: _baseStyle(
      FontSize.size14,
      FontWeight.w600,
      AppColors.textPrimaryDark,
    ),
    labelSmall: _baseStyle(
      FontSize.size12,
      FontWeight.w600,
      AppColors.textPrimaryDark,
    ),
    titleLarge: _baseStyle(
      FontSize.size28,
      FontWeight.w600,
      AppColors.textPrimaryDark,
    ),
    titleMedium: _baseStyle(
      FontSize.size18,
      FontWeight.w500,
      AppColors.textPrimaryDark,
    ),
    titleSmall: _baseStyle(
      FontSize.size18,
      FontWeight.w400,
      AppColors.textPrimaryDark,
    ),
  );

  static TextStyle _baseStyle(double size, FontWeight weight, Color color) =>
      TextStyle(
        fontSize: size,
        fontWeight: weight,
        color: color,
        fontFamily: "Poppins",
        letterSpacing: 0.1,
      );
}

class FontSize {
  static const double size6_4 = 6.4;
  static const double size12 = 12;
  static const double size14 = 14;
  static const double size16 = 16;
  static const double size18 = 18;
  static const double size24 = 24;
  static const double size26 = 26;
  static const double size28 = 28;
  static const double size32 = 32;
  static const double size42 = 42;
  static const double size62 = 62;
}
