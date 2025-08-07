import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:ibrat_debate_scanner_app/src/common/utils/extensions/context_extensions.dart';

import '../../../../generated/assets.dart';

Widget buildHeader(BuildContext context, String username) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        flex: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome text
            AutoSizeText(
              context.localized.welcome,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              minFontSize: 14,
              maxFontSize: 24,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4.h),
            // Username with flexible sizing
            _buildUsernameText(context, username),
          ],
        ),
      ),

      // Spacer
      SizedBox(width: 8.w),

      // Right side - Image (fixed)
      Flexible(
        flex: 1,
        child: Image.asset(
          Assets.imagesIbratDebate,
          height: 80.h,
          width: 100.w,
          fit: BoxFit.contain,
        ),
      ),
    ],
  );
}

/// Build username text with smart sizing and overflow handling
Widget _buildUsernameText(BuildContext context, String username) {
  // Process username to remove id_admin prefix
  final displayUsername = _processUsernameForDisplay(username);

  return LayoutBuilder(
    builder: (context, constraints) {
      return AutoSizeText(
        displayUsername.isNotEmpty ? displayUsername : 'User',
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
        ),
        maxLines: 2, // Allow 2 lines for long usernames
        minFontSize: 12, // Minimum readable size
        maxFontSize: 18, // Maximum size
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.start,
        // Custom text scaler for better control
        textScaleFactor: MediaQuery.of(context).textScaleFactor.clamp(0.8, 1.2),
      );
    },
  );
}

/// Process username by removing first two parts and formatting for display
String _processUsernameForDisplay(String username) {
  if (username.isEmpty) return '';

  try {
    final parts = username.split('_');

    // If username has less than 3 parts, return as is
    if (parts.length <= 2) {
      return _formatUsernameDisplay(username);
    }

    // Remove first two parts (id_admin) and join the rest
    final processedParts = parts.skip(2).toList();
    final processedUsername = processedParts.join('_');

    return _formatUsernameDisplay(processedUsername);
  } catch (e) {
    debugPrint("❌ Error processing username: $e");
    // Return formatted original username if processing fails
    return _formatUsernameDisplay(username);
  }
}

/// Format username for better display (replace underscores with spaces, capitalize)
String _formatUsernameDisplay(String username) {
  if (username.isEmpty) return '';

  try {
    // Replace underscores with spaces
    String formatted = username.replaceAll('_', ' ');

    // Capitalize each word
    formatted = formatted
        .split(' ')
        .map((word) {
          if (word.isEmpty) return word;
          return word[0].toUpperCase() + word.substring(1).toLowerCase();
        })
        .join(' ');

    return formatted;
  } catch (e) {
    debugPrint("❌ Error formatting username: $e");
    return username; // Return original if formatting fails
  }
}

// Alternative simpler version without formatting
Widget _buildHeaderSimple(BuildContext context, String username) {
  return Row(
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                context.localized.welcome,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Container(
              width: double.infinity,
              child: Text(
                _processUsernameSimple(username),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
      const SizedBox(width: 8),
      Image.asset(
        Assets.imagesIbratDebate,
        height: 80.h,
        width: 100.w,
        fit: BoxFit.contain,
      ),
    ],
  );
}

/// Simple username processing (just remove id_admin)
String _processUsernameSimple(String username) {
  if (username.isEmpty) return 'User';

  final parts = username.split('_');
  if (parts.length <= 2) return username;

  return parts.skip(2).join('_');
}
