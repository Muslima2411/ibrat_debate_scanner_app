import "package:flutter/cupertino.dart";
import "package:l/l.dart";

import "src/common/local/app_storage.dart";

Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  await getStorageValues();
}

String? token;
String? user;

Future<void> getStorageValues() async {
  token = await AppStorage.$read(key: StorageKey.accessToken);
  user = await AppStorage.$read(key: StorageKey.user);

  l.w(
    token ??
        "------\n------------\n-----------\n-------"
            " ====================================",
  );

  l.w(
    user ??
        "------\n------------\n-----------\n-------"
            " ====================================",
  );
}
