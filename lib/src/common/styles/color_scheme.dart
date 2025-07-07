import 'package:flutter/material.dart'
    show Brightness, Color, ColorScheme, Colors;

import 'app_colors.dart';

const ColorScheme lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: AppColors.primary,
  onPrimary: AppColors.onPrimary,
  primaryContainer: AppColors
      .backgroundLight, // Consider creating a separate container color if needed
  onPrimaryContainer: AppColors.textSecondaryLight,
  secondary: AppColors.secondary,
  onSecondary: AppColors.onSecondary,
  secondaryContainer: AppColors.surfaceLight,
  onSecondaryContainer: AppColors.onSurfaceLight,
  tertiary: AppColors.textSecondaryLight, // Closest alternative
  onTertiary: AppColors.textSecondaryDark, // Or define a new light tone
  tertiaryContainer: AppColors.success, // Assuming green icon
  onTertiaryContainer: AppColors.backgroundLight,
  error: AppColors.error,
  onError: AppColors.onError,
  errorContainer: AppColors.warning, // You may want a lighter red
  onErrorContainer: AppColors.onWarning, // For contrast
  surface: AppColors.surfaceLight,
  onSurface: AppColors.onSurfaceLight,
  surfaceTint: AppColors.info, // For visual emphasis
  onSurfaceVariant: AppColors.textPrimaryLight,
  outline: AppColors.borderLight,
  outlineVariant: AppColors.textSecondaryLight,
  shadow: AppColors.textPrimaryLight, // Closest, define separate if needed
  scrim: AppColors.success, // Fallback; create custom if needed
  inverseSurface: AppColors.backgroundLight,
  onInverseSurface: AppColors.textSecondaryLight,
  inversePrimary: AppColors.secondaryVariant,
);
const ColorScheme darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: AppColors.primary, // You may want to define a new dark primary
  onPrimary: AppColors.onPrimary,
  primaryContainer: AppColors.cardDark, // Fallback
  onPrimaryContainer: AppColors.textPrimaryDark,
  secondary: AppColors.secondary,
  onSecondary: AppColors.onSecondary,
  secondaryContainer: AppColors.surfaceDark,
  onSecondaryContainer: AppColors.onSurfaceDark,
  tertiary: AppColors.textSecondaryDark,
  onTertiary: AppColors.onSurfaceDark,
  tertiaryContainer: AppColors.surfaceDark,
  onTertiaryContainer: AppColors.backgroundDark,
  error: AppColors.error,
  onError: AppColors.onError,
  errorContainer: AppColors.warning, // Consider adding a darker red
  onErrorContainer: AppColors.onWarning,
  surface: AppColors.surfaceDark,
  onSurface: AppColors.onSurfaceDark,
  onSurfaceVariant: AppColors.textSecondaryDark,
  outline: AppColors.borderDark,
  outlineVariant: AppColors.textSecondaryDark,
  shadow: AppColors.textPrimaryDark,
  scrim: AppColors.error,
  inverseSurface: AppColors.surfaceLight,
  onInverseSurface: AppColors.textPrimaryLight,
  inversePrimary: AppColors.secondary,
  surfaceTint: AppColors.info,
);
