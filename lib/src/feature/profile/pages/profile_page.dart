import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibrat_debate_scanner_app/src/common/utils/extensions/context_extensions.dart';

import '../../../common/widget/app_material_context.dart';
import '../../settings/inherited/local_controller.dart';
import '../widgets/language_bottom_sheet.dart';
import '../widgets/theme_bottom_sheet.dart';

@RoutePage()
class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          context.localized.profile,
          style: textTheme.bodyLarge?.copyWith(
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              // TODO: Add logout logic
            },
            iconAlignment: IconAlignment.end,
            icon: Icon(Icons.logout, color: colors.primary),
            label: Text(context.localized.logout, style: textTheme.bodyMedium),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          spacing: 60.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Info
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: colors.primary,
                  child: Text(
                    "J",
                    style: textTheme.titleLarge?.copyWith(
                      color: colors.onPrimary,
                      fontSize: 50.sp,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "John Doe",
                      style: textTheme.titleMedium?.copyWith(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "johndoe@gmail.com",
                      style: textTheme.bodySmall?.copyWith(
                        color: colors.onSurface.withOpacity(0.7),
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // const SizedBox(height: 24),

            // Settings
            Column(
              spacing: 20.h,
              children: [
                _ProfileCard(
                  icon: Icons.settings,
                  text: context.localized.settings,
                  colors: colors,
                  textTheme: textTheme,
                  onTap: () {
                    // TODO: Navigate to settings
                  },
                ),
                // const SizedBox(height: 20),
                Divider(
                  color: context.colorScheme.onSurface.withOpacity(0.1),
                  thickness: 1,
                ), // const SizedBox(height: 20),
                // Language
                _ProfileCard(
                  icon: Icons.language,
                  text: context.localized.language,
                  trailing: Text(
                    localController.selectedLanguage,
                    style: textTheme.bodyMedium?.copyWith(
                      color: colors.onSurface.withOpacity(0.7),
                    ),
                  ),
                  colors: colors,
                  textTheme: textTheme,
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      builder: (_) => const LanguageBottomSheet(),
                    );
                  },
                ),
                // const SizedBox(height: 12),
                //
                // // Theme
                _ProfileCard(
                  icon: Icons.wb_sunny_outlined,
                  text: context.localized.theme,
                  trailing: Text(
                    themeController.isLight ? "Light" : "Dark", // Dynamic
                    style: textTheme.bodyMedium?.copyWith(
                      color: colors.onSurface.withOpacity(0.7),
                    ),
                  ),
                  colors: colors,
                  textTheme: textTheme,
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      builder: (_) => const ThemeBottomSheet(),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  final IconData icon;
  final String text;
  final Widget? trailing;
  final ColorScheme colors;
  final TextTheme textTheme;
  final VoidCallback onTap;

  const _ProfileCard({
    required this.icon,
    required this.text,
    this.trailing,
    required this.colors,
    required this.textTheme,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 62.h,
      onPressed: onTap,
      color: colors.onTertiaryContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0,
      child: ListTile(
        leading: Icon(icon, color: colors.primary),
        title: Text(text, style: textTheme.bodyLarge),
        trailing: trailing,
        // onTap: onTap,
      ),
    );
  }
}
