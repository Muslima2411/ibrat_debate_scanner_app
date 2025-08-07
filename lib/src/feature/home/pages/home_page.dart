import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibrat_debate_scanner_app/src/common/utils/extensions/context_extensions.dart';

import '../view_models/home_vm.dart';
import '../widgets/build_debate_card.dart';
import '../widgets/build_header_widget.dart';

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
              buildHeader(context, vm.username),
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
                            return buildDebateCard(context, debate);
                          },
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: const ScannerButton(),
    );
  }
}
