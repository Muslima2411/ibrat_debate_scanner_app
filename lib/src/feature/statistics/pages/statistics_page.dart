import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibrat_debate_scanner_app/src/common/utils/extensions/context_extensions.dart';

@RoutePage()
class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.localized.statistics,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w500,
            color: context.colorScheme.onSurface,
            fontSize: 24.sp,
          ),
        ),
        backgroundColor: context.colorScheme.surface,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Text(
            context.localized.statistics_not_available_yet,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
              color: context.colorScheme.onPrimaryContainer,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
