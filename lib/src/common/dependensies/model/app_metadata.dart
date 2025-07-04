import 'package:meta/meta.dart';

@immutable
class AppMetadata {
  const AppMetadata({
    required this.version,
    required this.appName,
    required this.packageName,
    required this.buildNumber,
  });

  final String version;
  final String appName;
  final String packageName;
  final String buildNumber;
}
