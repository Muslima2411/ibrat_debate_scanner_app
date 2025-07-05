import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibrat_debate_scanner_app/src/common/utils/extensions/context_extensions.dart';
import '../view_models/login_vm.dart';
import 'custom_text_field.dart';

class LoginForm extends StatefulWidget {
  final LoginVM vm;

  const LoginForm({super.key, required this.vm});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
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

        CustomTextField(
          controller: _usernameController,
          label: context.localized.username,
        ),
        SizedBox(height: 16.h),
        CustomTextField(
          controller: _passwordController,
          label: context.localized.password,
          obscureText: _obscurePassword,
          suffixIcon: IconButton(
            icon: Icon(
              _obscurePassword ? Icons.visibility_off : Icons.visibility,
              color: colors.tertiary,
            ),
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
          ),
        ),
        SizedBox(height: 20.h),

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
            onPressed: widget.vm.state.isLoading
                ? null
                : () {
                    widget.vm.login(
                      _usernameController.text.trim(),
                      _passwordController.text.trim(),
                      context,
                    );
                  },
            child: widget.vm.state.isLoading
                ? const CircularProgressIndicator()
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
        if (widget.vm.state.error != null)
          Text(
            widget.vm.state.error!,
            style: textTheme.bodySmall?.copyWith(
              color: colors.error,
              fontSize: 12.sp,
            ),
          ),
        Text(
          "© 2025 Ibrat Debate Team",
          style: textTheme.bodySmall?.copyWith(
            color: colors.primary,
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }
}
