import "dart:ui";

import "package:flutter/material.dart";
import "package:meta/meta.dart";

@immutable
final class AppColors {
  const AppColors._();

  static const Color transparent = Colors.transparent;
  static const Color primary = Color(0xFFFF8C00); // Orange
  static const Color primaryVariant = Color(0xFFFF7F00);
  static const Color onPrimary = Color(0xFFFFFFFF);

  // Secondary Colors
  static const Color secondary = Color(0xFF6C757D);
  static const Color secondaryVariant = Color(0xFF5A6268);
  static const Color onSecondary = Color(0xFFFFFFFF);

  // Surface Colors - Light Theme
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color onSurfaceLight = Color(0xFF212529);
  static const Color backgroundLight = Color(0xFFF8F9FA);

  // Surface Colors - Dark Theme
  static const Color surfaceDark = Color(0xFF1E1E1E);
  static const Color onSurfaceDark = Color(0xFFE0E0E0);
  static const Color backgroundDark = Color(0xFF121212);

  // Status Colors
  static const Color success = Color(0xFF28A745);
  static const Color onSuccess = Color(0xFFFFFFFF);
  static const Color error = Color(0xFFDC3545);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color warning = Color(0xFFFFC107);
  static const Color onWarning = Color(0xFF212529);
  static const Color info = Color(0xFF17A2B8);
  static const Color onInfo = Color(0xFFFFFFFF);

  // Card Colors
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardDark = Color(0xFF2C2C2C);

  // Border Colors
  static const Color borderLight = Color(0xFFE9ECEF);
  static const Color borderDark = Color(0xFF495057);

  // Text Colors
  static const Color textPrimaryLight = Color(0xFF212529);
  static const Color textSecondaryLight = Color(0xFF6C757D);
  static const Color textPrimaryDark = Color(0xFFE0E0E0);
  static const Color textSecondaryDark = Color(0xFFADB5BD);
}
