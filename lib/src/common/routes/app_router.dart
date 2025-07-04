import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';

import '../../feature/auth/pages/login_page.dart';
import '../../feature/home/pages/home_page.dart';
import '../../feature/main/pages/main_wrapper_page.dart';
import '../../feature/main/pages/qr_code_scanner_page.dart';
import '../../feature/profile/pages/profile_page.dart';
import '../../feature/statistics/pages/statistics_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  static final RouterConfig<UrlState> router = AppRouter().config();

  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => <AutoRoute>[
    AutoRoute(path: '/login', page: LoginRoute.page, initial: true),
    AutoRoute(
      path: '/main',
      page: MainWrapperRoute.page,

      children: [
        AutoRoute(path: 'home', page: HomeRoute.page),
        AutoRoute(path: 'stats', page: StatisticsRoute.page),
        AutoRoute(path: 'profile', page: ProfileRoute.page),
      ],
    ),
    AutoRoute(path: '/qr', page: QrCodeScannerRoute.page),
    // guards: [AuthGuard()],
  ];
}

// // Optional: Define a simple AuthGuard for authentication
// class AuthGuard extends AutoRouteGuard {
//   @override
//   void onNavigation(NavigationResolver resolver, StackRouter router) {
//     const isAuthenticated = false;
//     if (isAuthenticated) {
//       resolver.next();
//     } else {
//       router.push(LoginRoute());
//     }
//   }
// }
