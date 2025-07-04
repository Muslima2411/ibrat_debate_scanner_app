import "package:meta/meta.dart";

@immutable
final class Config {
  const Config._();

  static final EnvironmentFlavor environment = EnvironmentFlavor.from(
    "development",
  );

  static const String baseUrl = "";
}

/// Environment flavor.
/// e.g. development, staging, production
enum EnvironmentFlavor {
  /// Development
  development("development"),

  /// Staging
  staging("staging"),

  /// Production
  production("production");

  const EnvironmentFlavor(this.value);

  factory EnvironmentFlavor.from(String? value) =>
      switch (value?.trim().toLowerCase()) {
        "development" || "debug" || "develop" || "dev" => development,
        "staging" || "profile" || "stage" || "stg" => staging,
        "production" || "release" || "prod" || "prd" => production,
        _ => const bool.fromEnvironment("dart.vm.product")
            ? production
            : development,
      };

  /// development, staging, production
  final String value;

  /// Whether the environment is development.
  bool get isDevelopment => this == development;

  /// Whether the environment is staging.
  bool get isStaging => this == staging;

  /// Whether the environment is production.
  bool get isProduction => this == production;
}
