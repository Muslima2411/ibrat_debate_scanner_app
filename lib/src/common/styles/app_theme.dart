import "package:flutter/foundation.dart";
import "package:flutter/material.dart";

import "color_scheme.dart";
import "text_style.dart";

@immutable
final class AppTheme {
  /// {@macro app_theme}
  AppTheme({required this.mode})
    : darkTheme = ThemeData(
        textTheme: AppTextStyle.lightTextTheme,
        brightness: Brightness.dark,
        colorScheme: darkColorScheme,
        useMaterial3: true,
      ),
      lightTheme = ThemeData(
        textTheme: AppTextStyle.darkTextTheme,
        brightness: Brightness.light,
        useMaterial3: true,
        colorScheme: lightColorScheme,
      );

  final ThemeMode mode;
  final ThemeData darkTheme;
  final ThemeData lightTheme;

  static ThemeData light() => ThemeData(
    textTheme: AppTextStyle.lightTextTheme,
    brightness: Brightness.light,
    useMaterial3: true,
    colorScheme: lightColorScheme,
  );

  static ThemeData dark() => ThemeData(
    textTheme: AppTextStyle.darkTextTheme,

    brightness: Brightness.dark,
    colorScheme: darkColorScheme,
    useMaterial3: true,
  );

  ThemeData computeTheme() {
    switch (mode) {
      case ThemeMode.light:
        return lightTheme;
      case ThemeMode.dark:
        return darkTheme;
      case ThemeMode.system:
        return PlatformDispatcher.instance.platformBrightness == Brightness.dark
            ? darkTheme
            : lightTheme;
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppTheme &&
          runtimeType == other.runtimeType &&
          mode == other.mode;

  @override
  int get hashCode => mode.hashCode;
}
