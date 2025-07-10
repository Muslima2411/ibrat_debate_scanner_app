import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibrat_debate_scanner_app/src/common/utils/extensions/context_extensions.dart';
import 'package:ibrat_debate_scanner_app/src/feature/profile/widgets/password_field.dart';

class ChangePasswordDialog extends StatefulWidget {
  const ChangePasswordDialog({super.key});

  @override
  State<ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: context.colorScheme.surface,
      child: Container(
        width: MediaQuery.of(context).size.width,
        constraints: const BoxConstraints(maxWidth: 450, minHeight: 300),
        padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 24),
            _buildCurrentPasswordField(context),
            const SizedBox(height: 20),
            _buildNewPasswordField(context),
            const SizedBox(height: 42),
            _buildActions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Text(
      context.localized.changePassword,
      style: context.textTheme.titleLarge?.copyWith(
        color: context.colorScheme.onSurface,
        fontSize: 20.sp,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildCurrentPasswordField(BuildContext context) {
    return PasswordField(
      controller: _currentPasswordController,
      label: context.localized.currentPassword,
      icon: Icons.lock_outline_rounded,
    );
  }

  Widget _buildNewPasswordField(BuildContext context) {
    return PasswordField(
      controller: _newPasswordController,
      label: context.localized.newPassword,
      icon: Icons.lock_rounded,
    );
  }

  Widget _buildActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          child: Text(
            context.localized.cancel,
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colorScheme.error,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: context.colorScheme.primary,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onPressed: () => _handlePasswordChange(context),
          child: Text(
            context.localized.confirm,
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colorScheme.onPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  void _handlePasswordChange(BuildContext context) {
    final currentPassword = _currentPasswordController.text;
    final newPassword = _newPasswordController.text;

    // TODO: Implement real password change logic
    debugPrint('Current: $currentPassword, New: $newPassword');
    Navigator.pop(context);
  }
}
