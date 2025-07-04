import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:l/l.dart";
import "package:shared_preferences/shared_preferences.dart";

import "../model/language_type.dart";

const String _spLocalKey = "app_local";

ChangeNotifierProvider<LocalController> localVM =
    ChangeNotifierProvider<LocalController>((ChangeNotifierProviderRef<LocalController> ref) => LocalController());

class LocalController with ChangeNotifier {
  LocalController() : _appLocal = "ru" {
    SharedPreferences.getInstance().then<void>(
      (SharedPreferences sp) {
        final String? appLocal = sp.getString(_spLocalKey);
        if (appLocal != null && appLocal.isNotEmpty) {
          _appLocal = appLocal;
          notifyListeners();
        }
      },
      onError: l.w,
    );
  }

  Locale get appLocal => _appLocal == "uz"
      ? const Locale("uz", "UZ")
      : _appLocal == "en"
          ? const Locale("en", "EN")
          : const Locale("ru", "RU");

  String _appLocal;

  void changeLocal(LanguageType langCode) {
    _appLocal = langCode.name;

    SharedPreferences.getInstance().then<void>(
      (SharedPreferences sp) {
        sp.setString(_spLocalKey, _appLocal);
      },
      onError: l.w,
    );
    notifyListeners();
  }

  String get selectedLanguage => _appLocal;
}
