import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:ibrat_debate_scanner_app/src/common/styles/app_colors.dart';
import 'package:ibrat_debate_scanner_app/src/common/utils/extensions/context_extensions.dart';
import 'package:ibrat_debate_scanner_app/src/feature/history/pages/history_page.dart';
import 'package:ibrat_debate_scanner_app/src/feature/home/pages/home_page.dart';
import 'package:ibrat_debate_scanner_app/src/feature/main/widgets/scanner_button.dart';
import 'package:ibrat_debate_scanner_app/src/feature/profile/pages/profile_page.dart';
import 'package:ibrat_debate_scanner_app/src/feature/statistics/pages/statistics_page.dart';

import '../../../../generated/assets.dart';
import '../view_models/navigation_controller.dart';

@RoutePage()
class MainWrapperPage extends ConsumerWidget {
  const MainWrapperPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationState = ref.watch(navigationControllerProvider);
    final navigationController = ref.read(
      navigationControllerProvider.notifier,
    );
    final currentIndex = navigationState.currentIndex;

    final List<Widget> screens = const [
      HomePage(),
      StatisticsPage(),
      SizedBox(),
      HistoryPage(),
      ProfilePage(),
    ];

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: ScannerButton(),
      extendBody: true,
      body: IndexedStack(index: currentIndex, children: screens),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 14,
        elevation: 8,
        color: context.colorScheme.onTertiaryContainer,
        child: SizedBox(
          height: 75.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(5, (index) {
              // Skip the middle FAB position
              if (index == 2) {
                return const SizedBox(width: 56);
              }

              final isSelected = navigationController.isTabActive(index);
              final color = isSelected
                  ? AppColors.primary
                  : context.colorScheme.onPrimaryContainer.withOpacity(0.5);

              final iconAsset = _getIconAsset(index);
              final label = _getLabel(context, index);

              return Expanded(
                child: Material(
                  color: Colors.transparent,
                  child: GestureDetector(
                    onTap: () => navigationController.navigateToTab(index),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 10.h,
                        horizontal: 8.w,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (iconAsset.isNotEmpty)
                            SvgPicture.asset(
                              iconAsset,
                              height: 22.h,
                              colorFilter: ColorFilter.mode(
                                color,
                                BlendMode.srcIn,
                              ),
                            ),
                          if (label.isNotEmpty) SizedBox(height: 2.h),
                          if (label.isNotEmpty)
                            Text(
                              label,
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w500,
                                color: color,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  String _getIconAsset(int index) {
    const icons = [
      Assets.iconsHomeIcon,
      Assets.iconsStatsIcon,
      '', // FAB placeholder
      Assets.iconsHistoryIcon,
      Assets.iconsProfileIcon,
    ];
    return icons[index];
  }

  String _getLabel(BuildContext context, int index) {
    final labels = [
      context.localized.home,
      context.localized.statistics,
      '',
      context.localized.history,
      context.localized.profile,
    ];
    return labels[index];
  }
}
