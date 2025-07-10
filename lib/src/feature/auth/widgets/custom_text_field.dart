import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool obscureText;
  final Widget? suffixIcon;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.obscureText = false,
    this.suffixIcon,
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
        floatingLabelStyle: TextStyle(color: colors.primary),
        labelStyle: TextStyle(color: colors.tertiary),
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
