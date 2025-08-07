import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? errorText;
  final bool hasError;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.obscureText = false,
    this.suffixIcon,
    this.errorText,
    this.hasError = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: textTheme.bodyMedium?.copyWith(color: colors.onSurface),
      decoration: InputDecoration(
        floatingLabelStyle: TextStyle(
          color: hasError ? colors.error : colors.primary,
        ),
        labelStyle: TextStyle(color: hasError ? colors.error : colors.tertiary),
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: hasError ? colors.error : colors.outline,
            width: hasError ? 1.5 : 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: hasError ? colors.error : colors.primary,
            width: hasError ? 2.0 : 2.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colors.error, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colors.error, width: 2.0),
        ),
        suffixIcon: suffixIcon,
        errorText: errorText?.isEmpty == true ? null : errorText,
      ),
    );
  }
}
