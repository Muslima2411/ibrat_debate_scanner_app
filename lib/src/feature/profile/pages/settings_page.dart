import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibrat_debate_scanner_app/src/common/styles/app_colors.dart';
import 'package:ibrat_debate_scanner_app/src/common/utils/extensions/context_extensions.dart';

@RoutePage()
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _nameController = TextEditingController(text: "John Doe");
  final _emailController = TextEditingController(text: "john@example.com");
  final _phoneController = TextEditingController(text: "+998 90 123 45 67");

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text(
          context.localized.settings,
          style: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w500,
            color: colorScheme.onSurface,
            fontSize: 24.sp,
          ),
        ),
        backgroundColor: colorScheme.surface,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Info Section
            Text(
              textAlign: TextAlign.center,
              context.localized.profileInfo,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 16),

            // Editable Fields
            _buildTextField(
              context,
              controller: _nameController,
              label: context.localized.username,
              icon: Icons.person,
            ),
            const SizedBox(height: 12),
            _buildTextField(
              context,
              controller: _emailController,
              label: context.localized.email,
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 12),
            _buildTextField(
              context,
              controller: _phoneController,
              label: context.localized.phone,
              icon: Icons.phone,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 22),

            Divider(
              color: colorScheme.onSurfaceVariant.withOpacity(0.2),
              thickness: 1,
            ),
            const SizedBox(height: 22),
            MaterialButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    final TextEditingController currentPasswordController =
                        TextEditingController();
                    final TextEditingController newPasswordController =
                        TextEditingController();
                    bool isPasswordVisible = false;

                    return StatefulBuilder(
                      builder: (context, setState) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: context.colorScheme.surface,
                          title: Text(
                            context.localized.changePassword,
                            style: context.textTheme.titleMedium?.copyWith(
                              color: context.colorScheme.onSurface,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: currentPasswordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: context.localized.currentPassword,
                                  prefixIcon: Icon(
                                    Icons.lock_outline,
                                    color: context.colorScheme.primary,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              TextField(
                                controller: newPasswordController,
                                obscureText: !isPasswordVisible,
                                decoration: InputDecoration(
                                  labelText: context.localized.newPassword,
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: context.colorScheme.primary,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      isPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color:
                                          context.colorScheme.onSurfaceVariant,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        isPasswordVisible = !isPasswordVisible;
                                      });
                                    },
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                context.localized.cancel,
                                style: context.textTheme.bodyMedium?.copyWith(
                                  color: context.colorScheme.error,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: context.colorScheme.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                final currentPassword =
                                    currentPasswordController.text;
                                final newPassword = newPasswordController.text;

                                /// TODO: Implement change password logic
                                debugPrint(
                                  'Current: $currentPassword, New: $newPassword',
                                );
                                Navigator.pop(context);
                              },
                              child: Text(
                                context.localized.confirm,
                                style: context.textTheme.bodyMedium?.copyWith(
                                  color: context.colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
              color: context.colorScheme.primaryContainer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
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
                  Icon(
                    Icons.lock,
                    color: context.colorScheme.onPrimaryContainer,
                  ),
                ],
              ),
            ),
            const Spacer(),

            // Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  // TODO: Implement save logic
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(context.localized.savedSuccessfully),
                    ),
                  );
                },
                // icon: const Icon(Icons.save),
                label: Text(
                  context.localized.save,
                  style: textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 20.sp,
                    color: AppColors.onPrimary,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  foregroundColor: colorScheme.onPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context, {
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: colorScheme.primary),
        suffixIcon: suffixIcon,
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
