import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibrat_debate_scanner_app/src/common/utils/extensions/context_extensions.dart';

import '../../../../generated/assets.dart';
import '../../../common/routes/app_router.dart';

class ScannerButton extends StatelessWidget {
  const ScannerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: CircleBorder(),
      backgroundColor: context.colorScheme.primary,
      // minWidth: double.infinity,
      // color: context.colorScheme.primary,
      foregroundColor: context.colorScheme.onPrimary,
      // onPressed: () => _openQRScanner(context),
      onPressed: () => context.router.push(const QrCodeScannerRoute()),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: SvgPicture.asset(
          Assets.iconsQrCodeIcon,
          width: 34.w,
          height: 34.h,
        ),
      ),
    );
  }

  void _openQRScanner(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: context.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        // margin: EdgeInsets.on(20),
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.qr_code_scanner_rounded,
              size: 48,
              color: context.colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              context.localized.qrScannerTitle,
              style: context.textTheme.headlineSmall?.copyWith(
                color: context.colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              context.localized.qrScannerSubtitle,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurface.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Future.microtask(() {
                  context.router.push(const QrCodeScannerRoute());
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: context.colorScheme.primary,
                foregroundColor: context.colorScheme.onPrimary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(context.localized.openScanner),
            ),
          ],
        ),
      ),
    );
  }
}
