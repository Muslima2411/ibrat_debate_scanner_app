import "package:flutter_secure_storage/flutter_secure_storage.dart";
import "../../../feature/settings/data/local_datasource.dart";
import "../../local/app_storage.dart";
import "../../routes/app_router.dart";
import "app_metadata.dart";

abstract interface class Dependencies {
  abstract final AppMetadata appMetadata;

  abstract final FlutterSecureStorage flutterSecureStorage;

  abstract final AppRouter router;

}

final class $MutableDependencies implements Dependencies {
  $MutableDependencies();

  @override
  late AppMetadata appMetadata;

  @override
  late FlutterSecureStorage flutterSecureStorage;

  @override
  late AppRouter router;
}
