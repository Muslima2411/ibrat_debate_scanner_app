import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibrat_debate_scanner_app/src/common/styles/app_colors.dart';
import 'package:ibrat_debate_scanner_app/src/common/utils/extensions/context_extensions.dart';

import '../../../data/entity/user_model/user_model.dart';
import '../view_models/settings_view_model.dart';
import '../widgets/animated_drop_down.dart';
import '../widgets/change_password_dialog.dart';
import '../widgets/settings_text_field.dart';

@RoutePage()
class SettingsPage extends ConsumerStatefulWidget {
  final UserModel? user;

  const SettingsPage({super.key, this.user});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  @override
  void initState() {
    super.initState();
    // Initialize the view model with user data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(settingsViewModelProvider).initializeWithUser(widget.user);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        context.localized.settings,
        style: context.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w500,
          color: context.colorScheme.onSurface,
          fontSize: 24.sp,
        ),
      ),
      surfaceTintColor: context.colorScheme.surface,
      backgroundColor: context.colorScheme.surface,
      elevation: 0,
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(22.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight - 44.0,
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    _buildHeader(context),
                    const SizedBox(height: 16),
                    _buildUserInfoSection(context),
                    const SizedBox(height: 22),
                    _buildDivider(context),
                    const SizedBox(height: 22),
                    _buildChangePasswordButton(context),
                    const SizedBox(height: 22),
                    const Spacer(),
                    _buildSaveButton(context),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Text(
      context.localized.profileInfo,
      textAlign: TextAlign.center,
      style: context.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w500,
        color: context.colorScheme.onSurface,
      ),
    );
  }

  Widget _buildUserInfoSection(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final viewModel = ref.watch(settingsViewModelProvider);
        final state = viewModel.state;

        return Column(
          children: [
            if (state.user?.username != null) ...[
              _buildUsernameCard(context, state.user!),
              const SizedBox(height: 12),
            ],
            SettingsTextField(
              controller: viewModel.nameController,
              label: context.localized.name,
              // icon: Icons.person,
              hintText: context.localized.enter_name,
            ),
            const SizedBox(height: 12),
            SettingsTextField(
              controller: viewModel.phoneController,
              label: context.localized.phone,
              // icon: Icons.phone,
              keyboardType: TextInputType.phone,
              inputFormatters: [viewModel.phoneFormatter],
              hintText: "+998 (90) 123-45-67",
            ),
            const SizedBox(height: 12),
            AnimatedDropdown(
              label: context.localized.age,
              icon: Icons.calendar_today,
              items: SettingsViewModel.ageRanges,
              selectedValue: state.selectedAgeRange,
              onChanged: (value) {
                if (value != null) {
                  viewModel.setSelectedAgeRange(value);
                }
              },
            ),
            const SizedBox(height: 12),
            AnimatedDropdown(
              label: context.localized.english_level,
              icon: Icons.language,
              items: SettingsViewModel.englishLevels,
              selectedValue: state.selectedEnglishLevel,
              onChanged: (value) {
                if (value != null) {
                  viewModel.setSelectedEnglishLevel(value);
                }
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildUsernameCard(BuildContext context, UserModel user) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.colorScheme.outline),
      ),
      child: Row(
        children: [
          Icon(Icons.alternate_email, color: context.colorScheme.primary),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.localized.username,
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                  fontSize: 12.sp,
                ),
              ),
              Text(
                user.username,
                style: context.textTheme.bodyLarge?.copyWith(
                  color: context.colorScheme.onSurface,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Divider(
      color: context.colorScheme.onSurfaceVariant.withOpacity(0.2),
      thickness: 1,
    );
  }

  Widget _buildChangePasswordButton(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) => const ChangePasswordDialog(),
        );
      },
      color: context.colorScheme.primaryContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      elevation: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            context.localized.changePassword,
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.w500,
            ),
          ),
          Icon(Icons.lock, color: context.colorScheme.onPrimaryContainer),
        ],
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final viewModel = ref.watch(settingsViewModelProvider);
        final state = viewModel.state;

        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: state.isSaving
                ? null
                : () => _saveUserInfo(context, ref),
            style: ElevatedButton.styleFrom(
              backgroundColor: context.colorScheme.primary,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              foregroundColor: context.colorScheme.onPrimary,
            ),
            child: state.isSaving
                ? SizedBox(
                    height: 20.sp,
                    width: 20.sp,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        context.colorScheme.onPrimary,
                      ),
                    ),
                  )
                : Text(
                    context.localized.save,
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 20.sp,
                      color: AppColors.onPrimary,
                    ),
                  ),
          ),
        );
      },
    );
  }

  Future<void> _saveUserInfo(BuildContext context, WidgetRef ref) async {
    final viewModel = ref.read(settingsViewModelProvider);

    await viewModel.saveUserInfo();

    if (mounted) {
      final state = viewModel.state;
      if (state.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.error!),
            backgroundColor: context.colorScheme.error,
          ),
        );
        viewModel.clearError();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.localized.savedSuccessfully)),
        );
      }
    }
  }
}
