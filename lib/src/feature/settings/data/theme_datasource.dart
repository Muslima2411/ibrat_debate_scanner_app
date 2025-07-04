import "dart:async";
import "dart:convert";

import "package:flutter/material.dart" show ThemeMode;
import "package:flutter_secure_storage/flutter_secure_storage.dart";
import "../../../common/local/app_storage.dart";
import "../../../common/styles/app_theme.dart";

abstract interface class ThemeDataSource {
  Future<void> setTheme(AppTheme theme);
  Future<AppTheme?> getTheme();
}

final class ThemeDataSourceLocal implements ThemeDataSource {
  const ThemeDataSourceLocal({
    required this.secureStorage,
    required this.codec,
  });

  final FlutterSecureStorage secureStorage;
  final Codec<ThemeMode, String> codec;

  @override
  Future<void> setTheme(AppTheme theme) async => secureStorage.write(key: StorageKey.theme.name, value: codec.encode(theme.mode),);

  @override
  Future<AppTheme?> getTheme() async {

    final String? type = await secureStorage.read(key: StorageKey.theme.name);

    if (type == null) {
      return null;
    }else{
      return AppTheme(mode: codec.decode(type));
    }
  }
}
