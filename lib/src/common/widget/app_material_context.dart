import "package:flutter/material.dart";
import "../../feature/settings/inherited/inherited_local_notifier.dart";
import "../../feature/settings/inherited/inherited_theme_notifier.dart";
import "../../feature/settings/inherited/local_controller.dart";
import "../../feature/settings/inherited/theme_controller.dart";
import "../l10n/app_localizations.dart";
import "../routes/app_router.dart";

/// {@template app}
/// App widget.
/// {@endtemplate}
///

final ThemeController themeController = ThemeController();
final LocalController localController = LocalController();

@immutable
class MaterialContext extends StatelessWidget {
  MaterialContext({super.key}) : builderKey = GlobalKey();

  final GlobalKey builderKey;

  @override
  Widget build(BuildContext context) => InheritedThemeNotifier(
    themeController: themeController,
    child: InheritedLocalNotifier(
      localController: localController,
      child: Builder(
        builder: (BuildContext context) {
          return MaterialApp.router(
            onGenerateTitle: (BuildContext context) => "Ibrat Debate Team",
            routerConfig: AppRouter.router,
            restorationScopeId: "material_app",
            debugShowCheckedModeBanner: false,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale:
                InheritedLocalNotifier.maybeOf(context)?.appLocal ??
                const Locale("uz", "UZ"),
            theme:
                InheritedThemeNotifier.maybeOf(context)?.theme ??
                themeController.theme,
            builder: (BuildContext context, Widget? child) =>
                MediaQuery.withNoTextScaling(
                  key: builderKey,
                  child: child ?? const SizedBox.shrink(),
                ),
          );
        },
      ),
    ),
  );
}
