import "package:flutter/widgets.dart";

import "local_controller.dart";

@immutable
class InheritedLocalNotifier extends InheritedNotifier<LocalController> {
  const InheritedLocalNotifier({
    required final LocalController localController,
    required super.child,
    super.key,
  }) : super(
          notifier: localController,
        );

  static LocalController? maybeOf(BuildContext context, {bool listen = true}) {
    if (listen) {
      return context.dependOnInheritedWidgetOfExactType<InheritedLocalNotifier>()?.notifier;
    } else {
      final Widget? inhW = context.getElementForInheritedWidgetOfExactType<InheritedLocalNotifier>()?.widget;
      return inhW is InheritedLocalNotifier ? inhW.notifier : null;
    }
  }
}
