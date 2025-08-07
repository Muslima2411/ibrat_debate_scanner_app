import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibrat_debate_scanner_app/src/common/utils/extensions/context_extensions.dart';
import '../view_models/login_vm.dart';
import 'custom_text_field.dart';

class LoginForm extends ConsumerStatefulWidget {
  final LoginVM vm;

  const LoginForm({super.key, required this.vm});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm>
    with SingleTickerProviderStateMixin {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _shakeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.elasticIn),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _shakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // Listen to state changes for error handling
    ref.listen<LoginState>(loginVmProvider.select((vm) => vm.state), (
      prev,
      curr,
    ) {
      if (curr.error != null && curr.error != prev?.error) {
        _showErrorFeedback();
      }
    });

    final state = widget.vm.state;

    return AnimatedBuilder(
      animation: _shakeAnimation,
      builder: (context, child) {
        final offset =
            _shakeAnimation.value *
            ((_shakeController.status == AnimationStatus.forward ||
                    _shakeController.status == AnimationStatus.completed)
                ? (8 * (1 - _shakeAnimation.value))
                : 0);

        return Transform.translate(
          offset: Offset(
            offset * (1 - 2 * (_shakeAnimation.value % 0.5).abs()),
            0,
          ),
          child: child,
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.security, size: 48, color: colors.primary),
          SizedBox(height: 16.h),
          Text(context.localized.loginTitle, style: textTheme.headlineMedium),
          SizedBox(height: 8.h),
          Text(
            context.localized.loginSubtitle,
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium?.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 24.h),

          // Username field with error styling
          CustomTextField(
            controller: _usernameController,
            label: context.localized.username,
            hasError: state.error != null,
          ),
          SizedBox(height: 16.h),

          // Password field with error styling
          CustomTextField(
            controller: _passwordController,
            label: context.localized.password,
            obscureText: _obscurePassword,
            hasError: state.error != null,
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: state.error != null ? colors.error : colors.tertiary,
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
          ),
          SizedBox(height: 8.h),

          // Error message display
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: state.error != null ? null : 0,
            child: state.error != null
                ? Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12.w),
                    margin: EdgeInsets.only(bottom: 12.h),
                    decoration: BoxDecoration(
                      color: colors.errorContainer,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: colors.error, width: 1),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: colors.error,
                          size: 18.sp,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            state.error!,
                            style: textTheme.bodySmall?.copyWith(
                              color: colors.onErrorContainer,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => widget.vm.clearError(),
                          child: Icon(
                            Icons.close,
                            color: colors.error,
                            size: 16.sp,
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ),

          SizedBox(height: 12.h),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primary,
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: state.isLoading
                  ? null
                  : () {
                      // Clear error before attempting login
                      if (state.error != null) {
                        widget.vm.clearError();
                      }

                      widget.vm.login(
                        _usernameController.text.trim(),
                        _passwordController.text.trim(),
                        context,
                      );
                    },
              child: state.isLoading
                  ? SizedBox(
                      height: 20.h,
                      width: 20.w,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          colors.onPrimary,
                        ),
                      ),
                    )
                  : Text(
                      context.localized.loginButton,
                      style: textTheme.titleMedium?.copyWith(
                        color: colors.onPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
            ),
          ),
          SizedBox(height: 16.h),

          Text(
            "© 2025 Ibrat Debate Team",
            style: textTheme.bodySmall?.copyWith(
              color: colors.primary,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }

  void _showErrorFeedback() {
    // Haptic feedback
    HapticFeedback.mediumImpact();

    // Trigger shake animation
    _shakeController.forward().then((_) {
      _shakeController.reset();
    });
  }
}
