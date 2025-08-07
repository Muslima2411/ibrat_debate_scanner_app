import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibrat_debate_scanner_app/src/common/utils/extensions/context_extensions.dart';

import '../../../common/widget/app_material_context.dart';
import '../../home/view_models/user_vm.dart';
import '../view_models/profile_vm.dart';
import '../widgets/flexible_user_info_section.dart';
import '../widgets/language_bottom_sheet.dart';
import '../widgets/log_out_button.dart';
import '../widgets/theme_bottom_sheet.dart';

// final profileViewModelProvider =
//     ChangeNotifierProvider.autoDispose<ProfileViewModel>((ref) {
//       return ProfileViewModel();
//     });

@RoutePage()
class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final profileState = ref.watch(profileViewModelProvider).state;

    // ref.read(profileViewModelProvider).refreshUserData();

    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          context.localized.profile,
          style: textTheme.bodyLarge?.copyWith(
            fontSize: 24.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          if (profileState.isRefreshing)
            const Padding(
              padding: EdgeInsets.only(right: 16),
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          LogOutButton(),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(profileViewModelProvider.notifier).refreshUserData();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              spacing: 60.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User Info Section
                _buildUserInfoSection(context, ref),
                // Profile Options Section
                _buildProfileOptionsSection(
                  context,
                  colors,
                  textTheme,
                  profileState,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfoSection(BuildContext context, WidgetRef ref) {
    final profileVM = ref.watch(profileViewModelProvider);
    final userVM = ref.watch(userVmProvider);

    return FlexibleUserInfoSection(
      isLoading: profileVM.state.isLoading,
      isUserLoading: userVM.state.isLoading,
      error: profileVM.state.error,
      userError: userVM.state.error,
      user: profileVM.user,
      displayUsername: profileVM.displayUsername,
      onRetry: () => ref.read(profileViewModelProvider).refreshUserData(),
      onRefresh: () => ref.read(profileViewModelProvider).refreshUserData(),
    );
  }

  Widget _buildProfileOptionsSection(
    BuildContext context,
    ColorScheme colors,
    TextTheme textTheme,
    ProfileState profileState,
  ) {
    return Column(
      spacing: 20.h,
      children: [
        _ProfileCard(
          icon: Icons.settings,
          text: context.localized.settings,
          colors: colors,
          textTheme: textTheme,
          onTap: () {
            // context.router.push(SettingsRoute(user: profileState.user));

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                backgroundColor: colors.surfaceVariant,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                duration: const Duration(seconds: 2),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.info_outline, color: colors.onSurfaceVariant),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        context.localized.featureNotAvailableMessage,
                        style: textTheme.bodyMedium?.copyWith(
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        Divider(color: colors.onSurface.withOpacity(0.1), thickness: 1),
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
        _ProfileCard(
          icon: Icons.wb_sunny_outlined,
          text: context.localized.theme,
          trailing: Text(
            themeController.isLight ? "Light" : "Dark",
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
    );
  }

  String _getInitials(String name) {
    if (name.isEmpty) return 'U';

    final words = name.trim().split(' ');
    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    } else {
      return name[0].toUpperCase();
    }
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
      color: colors.primaryContainer,
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
