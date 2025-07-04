import 'package:flutter/material.dart';

import '../model/dependencies.dart';

class DependenciesScope extends StatelessWidget {
  const DependenciesScope({
    required this.initialization,
    required this.child,
    this.splashScreen,
    this.errorBuilder,
    super.key,
  });

  static Dependencies of(BuildContext context) => maybeOf(context) ?? _notFoundInheritedWidgetOfExactType();

  static Dependencies? maybeOf(BuildContext context) =>
      switch (context.getElementForInheritedWidgetOfExactType<_InheritedDependencies>()?.widget) {
        final _InheritedDependencies inheritedDependencies =>
          inheritedDependencies.dependencies,
        _ => null,
      };

  static Never _notFoundInheritedWidgetOfExactType() => throw ArgumentError(
        "Out of scope, not found inherited widget "
            "a DependenciesScope of the exact type",
        "out_of_scope",
      );

  final Future<Dependencies> initialization;
  final Widget? splashScreen;
  final Widget Function(Object error, StackTrace? stackTrace)? errorBuilder;
  final Widget child;

  @override
  Widget build(BuildContext context) => FutureBuilder<Dependencies>(
        future: initialization,
        builder: (BuildContext context, AsyncSnapshot<Dependencies> snapshot) =>
            switch ((snapshot.data, snapshot.error, snapshot.stackTrace)) {
          (final Dependencies dependencies, null, null) =>
            _InheritedDependencies(
              dependencies: dependencies,
              child: child,
            ),
          (_, final Object error, final StackTrace? stackTrace) =>
            errorBuilder?.call(error, stackTrace) ?? ErrorWidget(error),
          _ => splashScreen ?? const SizedBox.shrink(),
        },
      );
}

class _InheritedDependencies extends InheritedWidget {
  const _InheritedDependencies({
    required this.dependencies,
    required super.child,
  });

  final Dependencies dependencies;

  @override
  bool updateShouldNotify(covariant _InheritedDependencies oldWidget) => false;
}
