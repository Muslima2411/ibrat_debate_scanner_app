import "package:flutter_secure_storage/flutter_secure_storage.dart";

enum StorageKey {
  token,
  pinCode,
  locale,
  theme,
  user,
  coreMeta,
  PIN_SETUP_INCOMPLETE,
  CONFIRM_CODE,
  isBioOn,
}

class AppStorage extends FlutterSecureStorage {
  factory AppStorage() => _service;

  const AppStorage._internal();

  static const AppStorage _service = AppStorage._internal();
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future<String?> $read({required StorageKey key}) async {
    final String? value = await _storage.read(key: key.name);
    return value;
  }

  static Future<void> $write(
      {required StorageKey key, required String value}) async {
    await _storage.write(key: key.name, value: value);
  }

  static Future<void> clearAllData() async {
    await _storage.deleteAll();
  }

  static Future<void> $delete({required StorageKey key}) async {
    await _storage.delete(key: key.name);
  }
}
