import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import 'package:ibrat_debate_scanner_app/src/common/styles/app_colors.dart';
import 'package:ibrat_debate_scanner_app/src/common/utils/extensions/context_extensions.dart';
import 'package:ibrat_debate_scanner_app/src/feature/statistics/pages/statistics_page.dart';
import 'package:ibrat_debate_scanner_app/src/feature/home/pages/home_page.dart';
import 'package:ibrat_debate_scanner_app/src/feature/profile/pages/profile_page.dart';

import '../../../../generated/assets.dart';
import '../view_models/main_wrapper_vm.dart';

@RoutePage()
class MainWrapperPage extends ConsumerWidget {
  const MainWrapperPage({super.key});

  final _navScreens = const [HomePage(), StatisticsPage(), ProfilePage()];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navIndexProvider);
    final controller = PersistentTabController(initialIndex: currentIndex);

    return PersistentTabView(
      context,
      controller: controller,
      navBarHeight: 80.h,
      onItemSelected: (index) {
        ref.read(navIndexProvider.notifier).state = index;
      },
      screens: _navScreens,
      backgroundColor: context.colorScheme.onTertiaryContainer,
      decoration: NavBarDecoration(
        colorBehindNavBar: context.colorScheme.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.r),
          topRight: Radius.circular(25.r),
        ),
      ),
      navBarStyle: NavBarStyle.style1,
      items: [
        PersistentBottomNavBarItem(
          icon: SvgPicture.asset(
            Assets.iconsHomeIcon,
            colorFilter: ColorFilter.mode(
              currentIndex == 0
                  ? AppColors.primary
                  : context.colorScheme.onPrimaryContainer.withOpacity(.5),
              BlendMode.srcIn,
            ),
          ),
          title: context.localized.home,
          activeColorPrimary: AppColors.primary,
          inactiveColorPrimary: AppColors.onPrimary.withOpacity(.5),
        ),
        PersistentBottomNavBarItem(
          icon: SvgPicture.asset(
            Assets.iconsStatsIcon,
            colorFilter: ColorFilter.mode(
              currentIndex == 1
                  ? AppColors.primary
                  : context.colorScheme.onPrimaryContainer.withOpacity(.5),
              BlendMode.srcIn,
            ),
          ),
          title: context.localized.statistics,
          activeColorPrimary: AppColors.primary,
          inactiveColorPrimary: AppColors.onPrimary.withOpacity(.5),
        ),
        PersistentBottomNavBarItem(
          icon: SvgPicture.asset(
            Assets.iconsProfileIcon,
            colorFilter: ColorFilter.mode(
              currentIndex == 2
                  ? AppColors.primary
                  : context.colorScheme.onPrimaryContainer.withOpacity(.5),
              BlendMode.srcIn,
            ),
          ),
          title: context.localized.profile,
          activeColorPrimary: AppColors.primary,
          inactiveColorPrimary: AppColors.onPrimary.withOpacity(.5),
        ),
      ],
    );
  }
}
