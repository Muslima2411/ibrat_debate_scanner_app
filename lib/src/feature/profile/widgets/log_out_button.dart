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
      onPressed: () async {
        await AppStorage.$delete(key: StorageKey.accessToken);
        await AppStorage.$delete(key: StorageKey.refreshToken);
        debugPrint("🔒 Token saved securely");
        context.router.popAndPush(LoginRoute());
      },
      iconAlignment: IconAlignment.end,
      icon: Icon(Icons.logout, color: context.colorScheme.primary),
      label: Text(
        context.localized.logout,
        style: context.textTheme.bodyMedium,
      ),
    );
  }
}
