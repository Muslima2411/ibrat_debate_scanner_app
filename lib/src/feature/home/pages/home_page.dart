import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibrat_debate_scanner_app/src/common/utils/extensions/context_extensions.dart';
import 'package:ibrat_debate_scanner_app/src/feature/main/widgets/scanner_button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../generated/assets.dart';
import '../../../data/entity/debate_models/debate_event_model.dart';
import '../view_models/home_vm.dart';

@RoutePage()
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(homeViewModelProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: EdgeInsets.fromLTRB(22, 20, 22, 0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context, vm.username),
              Divider(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                thickness: 1,
              ),
              SizedBox(height: 16.h),
              Text(
                context.localized.debates,
                style: context.textTheme.headlineSmall?.copyWith(
                  color: context.colorScheme.onSurface,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await vm.fetchEvents();
                  },
                  child: vm.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : vm.events.isEmpty
                      ? ListView(
                          // Required for pull-to-refresh to work
                          children: [
                            SizedBox(height: 100),
                            Center(
                              child: Text(
                                context.localized.no_data,
                                style: context.textTheme.titleMedium?.copyWith(
                                  color: context.colorScheme.onSurface,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20.sp,
                                ),
                              ),
                            ),
                          ],
                        )
                      : ListView.separated(
                          itemCount: vm.events.length,
                          separatorBuilder: (_, __) => SizedBox(height: 16.h),
                          itemBuilder: (context, index) {
                            final debate = vm.events[index];
                            return _buildDebateCard(context, debate);
                          },
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: const ScannerButton(),
    );
  }

  Widget _buildHeader(BuildContext context, String username) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.localized.welcome,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              username,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
        Image.asset(Assets.imagesIbratFLogo),
      ],
    );
  }

  Widget _buildDebateCard(BuildContext context, DebateEvent debate) {
    final theme = Theme.of(context);
    final dateStr = debate.date?.toString().split('T').first;
    final timeStr = debate.time;
    final createdAt = debate.createdAt.toString().split('T').first ?? "—";
    final updatedAt = debate.updatedAt.toString().split('T').first ?? "—";
    final telegramLink = debate.district.telegramGroupLink ?? "—";

    return ExpansionTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      tilePadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      childrenPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      collapsedBackgroundColor: Theme.of(context).colorScheme.primaryContainer,
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            debate.region.name,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 20.sp,
            ),
          ),
          Text(
            debate.district.name,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 16.sp,
              color: theme.colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
        ],
      ),
      subtitle: (dateStr != null || timeStr != null)
          ? Text(
              [
                if (dateStr != null) "📅 $dateStr",
                if (timeStr != null) "🕒 $timeStr",
              ].join("   "),
            )
          : null,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: debate.isPassed
                  ? theme.colorScheme.primary.withOpacity(0.15)
                  : theme.colorScheme.secondary.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              debate.isPassed ? "Passed" : "Pending",
              style: theme.textTheme.labelMedium?.copyWith(
                color: debate.isPassed
                    ? theme.colorScheme.primary
                    : theme.colorScheme.secondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            const Icon(Icons.calendar_today, size: 16),
            const SizedBox(width: 8),
            Text("Created at: $createdAt"),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.update, size: 16),
            const SizedBox(width: 8),
            Text("Updated at: $updatedAt"),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.telegram, size: 16),
            const SizedBox(width: 8),
            Expanded(
              child: InkWell(
                onTap: () async {
                  final uri = Uri.tryParse(telegramLink);
                  if (uri != null && await canLaunchUrl(uri)) {
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Could not launch Telegram link'),
                      ),
                    );
                  }
                },
                child: Text(
                  telegramLink,
                  style: const TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
