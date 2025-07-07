import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibrat_debate_scanner_app/src/common/routes/app_router.dart';
import 'package:ibrat_debate_scanner_app/src/common/utils/extensions/context_extensions.dart';

import '../../../common/widget/app_material_context.dart';
import '../view_models/profile_vm.dart';
import '../widgets/language_bottom_sheet.dart';
import '../widgets/log_out_button.dart';
import '../widgets/theme_bottom_sheet.dart';

final profileViewModelProvider =
    ChangeNotifierProvider.autoDispose<ProfileViewModel>((ref) {
      return ProfileViewModel();
    });

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
            fontSize: 20.sp,
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
                _buildUserInfoSection(context, profileState, colors, textTheme),
                // Profile Options Section
                _buildProfileOptionsSection(context, colors, textTheme),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfoSection(
    BuildContext context,
    ProfileState profileState,
    ColorScheme colors,
    TextTheme textTheme,
  ) {
    if (profileState.isLoading) {
      return Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: colors.primary.withOpacity(0.3),
            child: const CircularProgressIndicator(strokeWidth: 2),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 120,
                height: 24,
                decoration: BoxDecoration(
                  color: colors.onSurface.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 160,
                height: 16,
                decoration: BoxDecoration(
                  color: colors.onSurface.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        ],
      );
    }

    if (profileState.error != null) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colors.errorContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(Icons.error_outline, color: colors.onErrorContainer),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                profileState.error!,
                style: textTheme.bodyMedium?.copyWith(
                  color: colors.onErrorContainer,
                ),
              ),
            ),
          ],
        ),
      );
    }

    final user = profileState.user;
    final displayName = user?.name ?? 'User';
    final displayEmail = user?.username ?? 'username@example.com';
    final initials = _getInitials(displayName);

    return Row(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: colors.primary,
          child: Text(
            initials,
            style: textTheme.titleLarge?.copyWith(
              color: colors.onPrimary,
              fontSize: 50.sp,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                displayName,
                style: textTheme.titleMedium?.copyWith(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                displayEmail,
                style: textTheme.bodySmall?.copyWith(
                  color: colors.onSurface.withOpacity(0.7),
                  fontSize: 14.sp,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfileOptionsSection(
    BuildContext context,
    ColorScheme colors,
    TextTheme textTheme,
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
            context.router.push(SettingsRoute());
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
