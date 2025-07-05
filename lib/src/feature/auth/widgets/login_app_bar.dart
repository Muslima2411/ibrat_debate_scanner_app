import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../common/styles/app_colors.dart';
import '../../profile/widgets/language_bottom_sheet.dart';
import '../../profile/widgets/theme_bottom_sheet.dart';

class LoginAppBar extends StatelessWidget {
  const LoginAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.transparent,
      elevation: 0,
      actions: [
        Row(
          children: [
            _circleIconButton(
              context,
              icon: Icons.language,
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: AppColors.transparent,
                  isScrollControlled: true,
                  builder: (_) => const LanguageBottomSheet(),
                );
              },
            ),
            SizedBox(width: 12.w),
            _circleIconButton(
              context,
              icon: Icons.brightness_6,
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  builder: (_) => const ThemeBottomSheet(),
                );
              },
            ),
            SizedBox(width: 8.w),
          ],
        ),
      ],
    );
  }

  Widget _circleIconButton(
    BuildContext context, {
    required IconData icon,
    required VoidCallback onTap,
  }) {
    final colors = Theme.of(context).colorScheme;

    return IconButton(
      style: IconButton.styleFrom(
        backgroundColor: colors.outline.withOpacity(0.6),
        shape: const CircleBorder(),
      ),
      icon: Icon(icon, size: 24.sp),
      color: colors.primary,
      onPressed: onTap,
    );
  }
}
