import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibrat_debate_scanner_app/src/common/utils/extensions/context_extensions.dart';
import 'package:ibrat_debate_scanner_app/src/feature/profile/widgets/password_field.dart';
import '../view_models/change_password_view_model.dart';

class ChangePasswordDialog extends ConsumerStatefulWidget {
  const ChangePasswordDialog({super.key});

  @override
  ConsumerState<ChangePasswordDialog> createState() =>
      _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends ConsumerState<ChangePasswordDialog> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Listen to text changes and update the view model
    _currentPasswordController.addListener(() {
      ref
          .read(changePasswordViewModelProvider)
          .updateCurrentPassword(_currentPasswordController.text);
    });

    _newPasswordController.addListener(() {
      ref
          .read(changePasswordViewModelProvider)
          .updateNewPassword(_newPasswordController.text);
    });

    _confirmPasswordController.addListener(() {
      ref
          .read(changePasswordViewModelProvider)
          .updateConfirmPassword(_confirmPasswordController.text);
    });
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(changePasswordViewModelProvider);
    final state = viewModel.state;

    if (state.showResult && state.resultMessage != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showResultDialog(context, state.resultMessage!, state.isSuccess);
      });
    }

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
            _buildCurrentPasswordField(context, state),
            const SizedBox(height: 20),
            _buildNewPasswordField(context, state),
            if (state.errorMessage != null) ...[
              const SizedBox(height: 12),
              _buildErrorMessage(context, state.errorMessage!),
            ],
            const SizedBox(height: 32),
            _buildActions(context, state),
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

  Widget _buildCurrentPasswordField(BuildContext context, state) {
    return PasswordField(
      controller: _currentPasswordController,
      label: context.localized.currentPassword,
      enabled: !state.isLoading,
    );
  }

  Widget _buildNewPasswordField(BuildContext context, state) {
    return PasswordField(
      controller: _newPasswordController,
      label: context.localized.newPassword,
      enabled: !state.isLoading,
    );
  }

  Widget _buildErrorMessage(BuildContext context, String message) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: EdgeInsets.only(top: 12.h, left: 12.w, right: 12.w),
      decoration: BoxDecoration(
        color: context.colorScheme.error.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: context.colorScheme.error.withOpacity(0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.error_outline, color: context.colorScheme.error, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.error,
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context, state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: state.isLoading
              ? null
              : () {
                  ref.read(changePasswordViewModelProvider).resetState();
                  Navigator.pop(context);
                },
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          child: Text(
            context.localized.cancel,
            style: context.textTheme.bodyLarge?.copyWith(
              color: state.isLoading
                  ? context.colorScheme.error.withOpacity(0.5)
                  : context.colorScheme.error,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: context.colorScheme.primary,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onPressed: state.isLoading ? null : () => _handlePasswordChange(),
          child: state.isLoading
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      context.colorScheme.onPrimary,
                    ),
                  ),
                )
              : Text(
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

  void _handlePasswordChange() {
    ref.read(changePasswordViewModelProvider).changePassword();
  }

  void _showResultDialog(BuildContext context, String message, bool isSuccess) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: context.colorScheme.surface,
        title: Row(
          children: [
            Icon(
              isSuccess ? Icons.check_circle : Icons.error,
              color: isSuccess ? Colors.green : context.colorScheme.error,
              size: 24,
            ),
            const SizedBox(width: 12),
            Text(
              isSuccess ? 'Success' : 'Error',
              style: context.textTheme.titleMedium?.copyWith(
                color: isSuccess ? Colors.green : context.colorScheme.error,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        content: Container(
          constraints: const BoxConstraints(maxWidth: 300),
          child: Text(
            message,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurface,
              height: 1.4,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close result dialog
              ref.read(changePasswordViewModelProvider).dismissResult();

              if (isSuccess) {
                Navigator.pop(context, true);
              }
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              backgroundColor: isSuccess
                  ? Colors.green.withOpacity(0.1)
                  : context.colorScheme.error.withOpacity(0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'OK',
              style: context.textTheme.bodyMedium?.copyWith(
                color: isSuccess ? Colors.green : context.colorScheme.error,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
