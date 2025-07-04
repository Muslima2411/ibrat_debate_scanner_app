import "dart:async";
import "package:meta/meta.dart";
import "package:package_info_plus/package_info_plus.dart";
import "../../../feature/settings/data/local_datasource.dart";
import "../../../feature/settings/data/local_repository.dart";
import "../../../feature/settings/data/theme_datasource.dart";
import "../../../feature/settings/data/theme_mode_codec.dart";
import "../../../feature/settings/data/theme_repository.dart";
import "../../local/app_storage.dart";
import "../../routes/app_router.dart";
import "../../utils/logger.dart";
import "../model/app_metadata.dart";
import "../model/dependencies.dart";

typedef _InitializationStep = FutureOr<void> Function(
  $MutableDependencies dependencies,
);

@internal
mixin InitializeDependencies {
  @protected
  Future<Dependencies> $initializeDependencies({
    void Function(int progress, String message)? onProgress,
  }) async {
    final List<(String, _InitializationStep)> steps = _initializationSteps;
    final $MutableDependencies dependencies = $MutableDependencies();
    final int totalSteps = steps.length;

    for (int currentStep = 0; currentStep < totalSteps; currentStep++) {
      final (String, _InitializationStep) step = steps[currentStep];
      final int percent = (currentStep * 100 ~/ totalSteps).clamp(0, 100);
      onProgress?.call(percent, step.$1);
      info(
        'Initialization | $currentStep/$totalSteps ($percent%) | "${step.$1}"',
      );
      await step.$2(dependencies);
    }

    return dependencies;
  }

  List<(String, _InitializationStep)> get _initializationSteps =>
      <(String, _InitializationStep)>[
        (
          "Platform pre-initialization",
          (_) async {},
        ),
        (
          "Creating app metadata",
          ($MutableDependencies dependencies) async {
            final PackageInfo packageInfo = await PackageInfo.fromPlatform();
            dependencies.appMetadata = AppMetadata(
              version: packageInfo.version,
              appName: packageInfo.appName,
              packageName: packageInfo.packageName,
              buildNumber: packageInfo.buildNumber,
            );
          }
        ),
        (
          "Database",
          ($MutableDependencies dependencies) async =>
              dependencies.flutterSecureStorage = AppStorage(),
        ),
        (
          "Settings",
          ($MutableDependencies dependencies) async {
            final LocaleRepositoryImpl localeRepository = LocaleRepositoryImpl(
              localeDataSource: LocaleDataSourceLocal(
                  flutterSecureStorage: dependencies.flutterSecureStorage),
            );

            final ThemeRepositoryImpl themeRepository = ThemeRepositoryImpl(
              themeDataSource: ThemeDataSourceLocal(
                secureStorage: dependencies.flutterSecureStorage,
                codec: const ThemeModeCodec(),
              ),
            );

            // final locale = await localeRepository.getLocale();
            // final theme = await themeRepository.getTheme();
            // log(locale?.languageCode.toString() ?? "  null");

            // final initialState = SettingsState.idle(
            //   appTheme: theme,
            //   locale: locale,
            // );
            //
            // final settingsBloc = SettingsBloc(
            //   localeRepository: localeRepository,
            //   themeRepository: themeRepository,
            //   initialState: initialState,
            // );
            //
            // dependencies.settingsBloc = settingsBloc;
          }
        ),
        (
          "Router",
          ($MutableDependencies dependencies) =>
              dependencies.router = AppRouter(),
        ),
      ];
}
