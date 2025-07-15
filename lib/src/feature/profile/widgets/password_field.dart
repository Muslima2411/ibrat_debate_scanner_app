import 'package:flutter/material.dart';
import 'package:ibrat_debate_scanner_app/src/feature/profile/widgets/settings_text_field.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool? enabled;

  const PasswordField({
    super.key,
    required this.controller,
    required this.label,
    this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsTextField(
      controller: controller,
      hintText: label,
      enabled: enabled,
      // icon: icon,
      label: label,
    );
  }
}
