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
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await vm.fetchEvents();
          },
          child: CustomScrollView(
            slivers: [
              // Simple Collapsing Header - no title to avoid overflow
              SliverAppBar(
                expandedHeight: 110.h, // Increased height to prevent overflow
                floating: false,
                pinned: false, // Completely disappears when scrolled
                snap: false,
                elevation: 0,
                backgroundColor: Theme.of(context).colorScheme.surface,
                surfaceTintColor: Colors.transparent,
                automaticallyImplyLeading: false,
                flexibleSpace: FlexibleSpaceBar(
                  background: Padding(
                    padding: EdgeInsets.fromLTRB(
                      22,
                      20,
                      22,
                      10.h,
                    ), // Added bottom padding
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center, // Center the content
                      children: [
                        Flexible(child: buildHeader(context, vm.username)),
                        SizedBox(height: 8.h),
                        Divider(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withOpacity(0.1),
                          thickness: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Section Title
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(22, 16.h, 22, 16.h),
                  child: Text(
                    context.localized.debates,
                    style: context.textTheme.headlineSmall?.copyWith(
                      color: context.colorScheme.onSurface,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              // Content
              vm.isLoading
                  ? SliverFillRemaining(
                      child: const Center(child: CircularProgressIndicator()),
                    )
                  : vm.events.isEmpty
                  ? SliverFillRemaining(
                      child: Center(
                        child: Text(
                          context.localized.no_data,
                          style: context.textTheme.titleMedium?.copyWith(
                            color: context.colorScheme.onSurface,
                            fontWeight: FontWeight.w500,
                            fontSize: 20.sp,
                          ),
                        ),
                      ),
                    )
                  : SliverPadding(
                      padding: EdgeInsets.fromLTRB(22, 0, 22, 20),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final debate = vm.events[index];
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: index == vm.events.length - 1 ? 0 : 16.h,
                            ),
                            child: buildDebateCard(context, debate),
                          );
                        }, childCount: vm.events.length),
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
