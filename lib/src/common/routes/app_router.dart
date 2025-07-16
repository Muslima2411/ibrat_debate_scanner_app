import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';

import '../../../setup.dart';
import '../../data/entity/user_model/user_model.dart';
import '../../feature/auth/pages/login_page.dart';
import '../../feature/history/pages/history_page.dart';
import '../../feature/home/pages/home_page.dart';
import '../../feature/init/init_page.dart';
import '../../feature/main/pages/main_wrapper_page.dart';
import '../../feature/main/pages/qr_code_scanner_page.dart';
import '../../feature/profile/pages/profile_page.dart';
import '../../feature/profile/pages/settings_page.dart';
import '../../feature/statistics/pages/statistics_page.dart';
import '../widget/empty_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  static final RouterConfig<UrlState> router = AppRouter().config();

  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => <AutoRoute>[
    // Login route (no guard needed)
    AutoRoute(path: '/', page: InitRoute.page, initial: true),

    AutoRoute(path: '/login', page: LoginRoute.page),

    // Main app routes (protected by AuthGuard)
    AutoRoute(
      path: '/main',
      // initial: true,
      // guards: [AuthGuard()],
      page: MainWrapperRoute.page,
      children: [
        // Default tab when accessing root
        AutoRoute(path: 'home', page: HomeRoute.page, initial: true),
        AutoRoute(path: 'history', page: HistoryRoute.page),
        AutoRoute(path: 'stats', page: StatisticsRoute.page),
        AutoRoute(path: 'profile', page: ProfileRoute.page),
      ],
    ),

    AutoRoute(
      path: '/qr',
      page: QrCodeScannerRoute.page,
      // guards: [AuthGuard()],
    ),
    AutoRoute(
      path: '/settings',
      page: SettingsRoute.page,
      // guards: [AuthGuard()],
    ),
  ];
}

// bool get _isLoggedIn => token != null;
//
// class AuthGuard extends AutoRouteGuard {
//   @override
//   void onNavigation(NavigationResolver resolver, StackRouter router) {
//     if (_isLoggedIn) {
//       resolver.next();
//     } else {
//       router.replaceAll([const LoginRoute()]);
//     }
//   }
// }
