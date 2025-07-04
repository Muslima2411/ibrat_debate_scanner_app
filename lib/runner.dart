import "dart:async";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:l/l.dart";
import "setup.dart";
import "src/app.dart";
import "src/common/dependensies/initialization/initialization.dart";
import "src/common/dependensies/widget/dependencies_scope.dart";
import "src/common/utils/error_util.dart";

void run() => l.capture<void>(
      () => runZonedGuarded<Future<void>>(
        () async {
          final InitializationExecutor initialization = InitializationExecutor();
          await setup();
          runApp(
            DependenciesScope(
              initialization: initialization(
                orientations: <DeviceOrientation>[
                  DeviceOrientation.portraitUp,
                  DeviceOrientation.portraitDown,
                ],
              ),
              splashScreen: const MaterialApp(
                home: Scaffold(
                  body: Center(
                    child: Text("SPLASH"),
                  ),
                ),
              ),
              child: const ProviderScope(child: App())
            ),

          );
        },
        (Object error, StackTrace stackTrace) => ErrorUtil.logError(
          error,
          stackTrace,
          hint: "ROOT | ",
        ),
      ),
      const LogOptions(
        outputInRelease: true,
      ),
    );
