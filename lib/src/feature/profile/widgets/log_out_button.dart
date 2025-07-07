import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ibrat_debate_scanner_app/src/common/routes/app_router.dart';
import 'package:ibrat_debate_scanner_app/src/common/utils/extensions/context_extensions.dart';

import '../../../common/local/app_storage.dart';

class LogOutButton extends StatelessWidget {
  const LogOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () => _showLogoutConfirmation(context),
      iconAlignment: IconAlignment.end,
      icon: Icon(Icons.logout, color: context.colorScheme.primary),
      label: Text(
        context.localized.logout,
        style: context.textTheme.bodyMedium,
      ),
    );
  }

  Future<void> _showLogoutConfirmation(BuildContext context) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            context.localized.logout_title,
            style: context.textTheme.titleMedium?.copyWith(
              color: context.colorScheme.onSurface,
            ),
          ),
          content: Text(
            context.localized.logout_message,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurface.withOpacity(0.8),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text(
                context.localized.cancel,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.primary,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: context.colorScheme.primary,
              ),
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

    if (confirmed == true) {
      await AppStorage.$delete(key: StorageKey.accessToken);
      await AppStorage.$delete(key: StorageKey.refreshToken);
      await AppStorage.$delete(key: StorageKey.user);
      debugPrint("🔒 Tokens cleared securely");

      if (context.mounted) {
        context.router.replaceAll([const LoginRoute()]);
      }
    }
  }
}
