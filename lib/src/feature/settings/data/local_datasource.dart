import "dart:ui";
import "package:flutter_secure_storage/flutter_secure_storage.dart";
import "package:shared_preferences/shared_preferences.dart";

import "../../../common/local/app_storage.dart";
import "../model/language_type.dart";

abstract interface class LocaleDataSource {
  Future<void> setLocale(Locale locale);

  Future<Locale?> getLocale();
}

final class LocaleDataSourceLocal implements LocaleDataSource {
  const LocaleDataSourceLocal({required this.flutterSecureStorage});

  final FlutterSecureStorage flutterSecureStorage;

  @override
  Future<void> setLocale(Locale locale) async {
    await flutterSecureStorage.write(key: "settings.locale", value:locale.languageCode);
  }

  @override
  Future<Locale?> getLocale() async {
    final String? languageCode = await flutterSecureStorage.read(key: "settings.locale");

    if (languageCode == null) {
      return null;
    }

    return Locale.fromSubtags(languageCode: languageCode);
  }
}
