import "package:flutter/widgets.dart";

import "theme_controller.dart";

@immutable
class InheritedThemeNotifier extends InheritedNotifier<ThemeController> {
  const InheritedThemeNotifier({
    required final ThemeController themeController,
    required super.child,
    super.key,
  }) : super(
          notifier: themeController,
        );

  static ThemeController? maybeOf(BuildContext context, {bool listen = true}) {
    if (listen) {
      return context.dependOnInheritedWidgetOfExactType<InheritedThemeNotifier>()?.notifier;
    } else {
      final Widget? inhW = context.getElementForInheritedWidgetOfExactType<InheritedThemeNotifier>()?.widget;
      return inhW is InheritedThemeNotifier ? inhW.notifier : null;
    }
  }
}
