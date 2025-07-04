import "dart:ui" as ui;

import "package:flutter/material.dart";
import "package:l/l.dart";
import "package:shared_preferences/shared_preferences.dart";

import "../../../common/local/app_storage.dart";
import "../../../common/styles/app_theme.dart";

// ignore: prefer_mixin
class ThemeController with ChangeNotifier {
  ThemeController() : _isLight = ui.window.platformBrightness != ui.Brightness.dark {
    SharedPreferences.getInstance().then<void>(
      (SharedPreferences sp) {
        final bool? theme = sp.getBool(StorageKey.theme.name);
        if (theme != null && theme != isLight) {
          _isLight = theme;
          notifyListeners();
        }
      },
      onError: l.w,
    );
  }

  ThemeData get theme => isLight ? AppTheme.light() : AppTheme.dark();

  bool get isLight => _isLight;

  bool get isDark => !isLight;

  bool _isLight;

  void switchTheme() {
    _isLight = !_isLight;
    SharedPreferences.getInstance().then<void>(
      (SharedPreferences sp) {
        sp.setBool(StorageKey.theme.name, _isLight);
      },
      onError: l.w,
    );
    notifyListeners();
  }
}
