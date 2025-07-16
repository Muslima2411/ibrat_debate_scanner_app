import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:ibrat_debate_scanner_app/src/common/styles/app_colors.dart';
import 'package:ibrat_debate_scanner_app/src/common/utils/extensions/context_extensions.dart';
import 'package:ibrat_debate_scanner_app/src/feature/history/pages/history_page.dart';
import 'package:ibrat_debate_scanner_app/src/feature/home/pages/home_page.dart';
import 'package:ibrat_debate_scanner_app/src/feature/profile/pages/profile_page.dart';
import 'package:ibrat_debate_scanner_app/src/feature/statistics/pages/statistics_page.dart';
import 'package:ibrat_debate_scanner_app/src/feature/main/widgets/scanner_button.dart';

import '../../../../generated/assets.dart';
import '../view_models/main_wrapper_vm.dart';

@RoutePage()
class MainWrapperPage extends ConsumerWidget {
  const MainWrapperPage({super.key});

  final List<Widget> _screens = const [
    HomePage(),
    StatisticsPage(),
    SizedBox(), // Placeholder for center FAB
    HistoryPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navIndexProvider);

    return Scaffold(
      body: _screens[currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: ScannerButton(), // Custom FAB
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 0,
        // surfaceTintColor: AppColors.transparent,
        elevation: 8,
        color: context.colorScheme.onTertiaryContainer,
        child: SizedBox(
          height: 75.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(5, (index) {
              if (index == 2) return const SizedBox(width: 56); // FAB gap

              final isSelected = index == currentIndex;
              final color = isSelected
                  ? AppColors.primary
                  : context.colorScheme.onPrimaryContainer.withOpacity(0.5);

              final iconAsset = [
                Assets.iconsHomeIcon,
                Assets.iconsStatsIcon,
                '', // FAB placeholder
                Assets.iconsHistoryIcon,
                Assets.iconsProfileIcon,
              ][index];

              final label = [
                context.localized.home,
                context.localized.statistics,
                '',
                context.localized.history,
                context.localized.profile,
              ][index];

              return GestureDetector(
                onTap: () => ref.read(navIndexProvider.notifier).state = index,
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (iconAsset.isNotEmpty)
                        SvgPicture.asset(
                          iconAsset,
                          height: 22.h,
                          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
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
                        ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
