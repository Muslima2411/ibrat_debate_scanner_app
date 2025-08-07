import 'dart:math' as math;
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibrat_debate_scanner_app/src/common/utils/extensions/context_extensions.dart';

import '../../../../generated/assets.dart';
import '../../../common/styles/app_colors.dart';
import '../../history/pages/history_page.dart';
import '../../home/pages/home_page.dart';
import '../../profile/pages/profile_page.dart';
import '../../statistics/pages/statistics_page.dart';
import '../view_models/navigation_controller.dart';
import '../widgets/scanner_button.dart';

class SmartBottomNavigation extends ConsumerWidget {
  final NavigationController navigationController;
  final List<String> iconAssets;
  final List<String> labels;

  const SmartBottomNavigation({
    super.key,
    required this.navigationController,
    required this.iconAssets,
    required this.labels,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenHeight = MediaQuery.of(context).size.height;
        final screenWidth = MediaQuery.of(context).size.width;

        // Determine layout type based on screen size
        final layoutType = _determineLayoutType(screenHeight, screenWidth);

        return _buildBottomBar(context, layoutType);
      },
    );
  }

  BottomNavLayoutType _determineLayoutType(double height, double width) {
    // Very small screens (old phones)
    if (height < 600 || width < 350) {
      return BottomNavLayoutType.iconOnly;
    }

    // Small screens
    if (height < 700 || width < 380) {
      return BottomNavLayoutType.compact;
    }

    // Normal screens
    return BottomNavLayoutType.normal;
  }

  Widget _buildBottomBar(BuildContext context, BottomNavLayoutType layoutType) {
    switch (layoutType) {
      case BottomNavLayoutType.iconOnly:
        return _buildIconOnlyBar(context);
      case BottomNavLayoutType.compact:
        return _buildCompactBar(context);
      case BottomNavLayoutType.normal:
        return _buildNormalBar(context);
    }
  }

  Widget _buildIconOnlyBar(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      elevation: 8,
      color: context.colorScheme.onTertiaryContainer,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(5, (index) {
          if (index == 2) return const SizedBox(width: 32);

          return _buildNavItem(
            context: context,
            index: index,
            config: const NavigationItemConfig(
              iconSize: 18,
              showLabels: false,
              padding: EdgeInsets.all(8),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildCompactBar(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 10,
      elevation: 8,
      color: context.colorScheme.onTertiaryContainer,
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(5, (index) {
          if (index == 2) return const SizedBox(width: 40);

          return _buildNavItem(
            context: context,
            index: index,
            config: NavigationItemConfig(
              iconSize: 20,
              fontSize: 10,
              showLabels: true,
              padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 2.w),
              spacing: 1,
            ),
          );
        }),
      ),
    );
  }

  Widget _buildNormalBar(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 14,
      elevation: 8,
      color: context.colorScheme.onTertiaryContainer,
      child: Container(
        height: math.min(75.h, 80),
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        child: Row(
          children: List.generate(5, (index) {
            if (index == 2) return const SizedBox(width: 56);

            return Expanded(
              child: _buildNavItem(
                context: context,
                index: index,
                config: NavigationItemConfig(
                  iconSize: math.min(22.h, 24),
                  fontSize: math.min(11.sp, 12),
                  showLabels: true,
                  padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 4.w),
                  spacing: 2.h,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required int index,
    required NavigationItemConfig config,
  }) {
    final isSelected = navigationController.isTabActive(index);
    final color = isSelected
        ? AppColors.primary
        : context.colorScheme.onPrimaryContainer.withOpacity(0.5);

    final iconAsset = iconAssets[index];
    final label = labels[index];

    return GestureDetector(
      onTap: () => navigationController.navigateToTab(index),
      child: Container(
        padding: config.padding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconAsset.isNotEmpty)
              Flexible(
                child: AnimatedScale(
                  scale: isSelected ? 1.1 : 1.0,
                  duration: const Duration(milliseconds: 200),
                  child: SvgPicture.asset(
                    iconAsset,
                    height: config.iconSize,
                    width: config.iconSize,
                    colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                  ),
                ),
              ),
            if (config.showLabels && label.isNotEmpty && config.spacing > 0)
              SizedBox(height: config.spacing),
            if (config.showLabels && label.isNotEmpty)
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 200),
                    style: TextStyle(
                      fontSize: config.fontSize,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w500,
                      color: color,
                    ),
                    child: Text(
                      label,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

enum BottomNavLayoutType { iconOnly, compact, normal }

class NavigationItemConfig {
  final double iconSize;
  final double fontSize;
  final bool showLabels;
  final EdgeInsets padding;
  final double spacing;

  const NavigationItemConfig({
    this.iconSize = 22,
    this.fontSize = 11,
    this.showLabels = true,
    this.padding = const EdgeInsets.all(8),
    this.spacing = 2,
  });
}

// Updated MainWrapperPage using the smart navigation
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
      bottomNavigationBar: SmartBottomNavigation(
        navigationController: navigationController,
        iconAssets: [
          Assets.iconsHomeIcon,
          Assets.iconsStatsIcon,
          '',
          Assets.iconsHistoryIcon,
          Assets.iconsProfileIcon,
        ],
        labels: [
          context.localized.home,
          context.localized.statistics,
          '',
          context.localized.history,
          context.localized.profile,
        ],
      ),
    );
  }
}
