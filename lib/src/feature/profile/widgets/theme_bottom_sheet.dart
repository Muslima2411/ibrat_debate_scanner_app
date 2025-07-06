import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibrat_debate_scanner_app/src/common/utils/extensions/context_extensions.dart';

import '../../../common/widget/app_material_context.dart';

class ThemeBottomSheet extends ConsumerWidget {
  const ThemeBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header Row
          Row(
            children: [
              Text(
                context.localized.chooseTheme,
                style: textTheme.titleMedium?.copyWith(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              CircleAvatar(
                radius: 16,
                backgroundColor: colors.outline.withOpacity(0.6),
                child: IconButton(
                  iconSize: 18.sp,
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),

          // Light Option
          _ThemeOption(
            title: context.localized.light,
            selected: themeController.isLight,
            isLight: true,
            onTap: () {
              if (!themeController.isLight) {
                themeController.switchTheme();
              }
            },
          ),
          // const SizedBox(height: 12),

          // Dark Option
          _ThemeOption(
            isLight: false,
            title: context.localized.dark,
            selected: themeController.isDark,
            onTap: () {
              if (!themeController.isDark) {
                themeController.switchTheme();
              }
            },
          ),
          SizedBox(height: 10.h),

          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.primary,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text(
              context.localized.select,
              style: textTheme.titleMedium?.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
                color: colors.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ThemeOption extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;
  final bool isLight;

  const _ThemeOption({
    required this.title,
    required this.selected,
    required this.onTap,
    required this.isLight,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Row(
        children: [
          Radio<bool>(
            value: true,
            groupValue: selected,
            onChanged: (_) => onTap(),
            activeColor: colors.primary,
          ),
          Expanded(child: Text(title, style: context.textTheme.bodyMedium)),
          Icon(
            isLight ? Icons.sunny : Icons.dark_mode_outlined,
            color: context.colorScheme.primary,
          ),
        ],
      ),
    );
  }
}
