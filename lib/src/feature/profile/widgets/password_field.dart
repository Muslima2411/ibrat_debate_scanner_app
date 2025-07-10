import 'package:flutter/material.dart';
import 'package:ibrat_debate_scanner_app/src/common/utils/extensions/context_extensions.dart';

import '../pages/settings_page.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;

  const PasswordField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return SettingsTextField(
      controller: widget.controller,
      hintText: widget.label,
      icon: widget.icon,
      obscureText: _obscureText,
      suffixIcon: IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_off : Icons.visibility,
          color: context.colorScheme.onSurface.withOpacity(0.6),
        ),
        onPressed: () => setState(() => _obscureText = !_obscureText),
      ),
      label: widget.label,
    );
  }
}
