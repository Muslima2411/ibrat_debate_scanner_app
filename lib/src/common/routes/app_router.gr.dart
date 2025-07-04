// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomePage();
    },
  );
}

/// generated route for
/// [LoginPage]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LoginPage();
    },
  );
}

/// generated route for
/// [MainWrapperPage]
class MainWrapperRoute extends PageRouteInfo<MainWrapperRouteArgs> {
  MainWrapperRoute({Key? key, List<PageRouteInfo>? children})
    : super(
        MainWrapperRoute.name,
        args: MainWrapperRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'MainWrapperRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MainWrapperRouteArgs>(
        orElse: () => const MainWrapperRouteArgs(),
      );
      return MainWrapperPage(key: args.key);
    },
  );
}

class MainWrapperRouteArgs {
  const MainWrapperRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'MainWrapperRouteArgs{key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MainWrapperRouteArgs) return false;
    return key == other.key;
  }

  @override
  int get hashCode => key.hashCode;
}

/// generated route for
/// [ProfilePage]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProfilePage();
    },
  );
}

/// generated route for
/// [QrCodeScannerPage]
class QrCodeScannerRoute extends PageRouteInfo<void> {
  const QrCodeScannerRoute({List<PageRouteInfo>? children})
    : super(QrCodeScannerRoute.name, initialChildren: children);

  static const String name = 'QrCodeScannerRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const QrCodeScannerPage();
    },
  );
}

/// generated route for
/// [StatisticsPage]
class StatisticsRoute extends PageRouteInfo<void> {
  const StatisticsRoute({List<PageRouteInfo>? children})
    : super(StatisticsRoute.name, initialChildren: children);

  static const String name = 'StatisticsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const StatisticsPage();
    },
  );
}
