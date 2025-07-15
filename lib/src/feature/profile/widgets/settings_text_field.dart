import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibrat_debate_scanner_app/src/common/utils/extensions/context_extensions.dart';

class SettingsTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  // final IconData icon;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final String? hintText;
  final bool? enabled;

  const SettingsTextField({
    super.key,
    required this.controller,
    required this.label,
    // required this.icon,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.suffixIcon,
    this.inputFormatters,
    this.hintText,
    this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      enabled: enabled ?? true,
      decoration: InputDecoration(
        // prefixIcon: Icon(icon, color: context.colorScheme.primary, size: 16),
        suffixIcon: suffixIcon,
        hintStyle: context.textTheme.bodyMedium?.copyWith(
          fontSize: 18.sp,
          color: context.colorScheme.onSurface.withOpacity(0.6),
        ),
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
