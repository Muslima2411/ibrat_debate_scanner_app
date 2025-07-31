import 'package:auto_route/annotations.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibrat_debate_scanner_app/src/common/utils/extensions/context_extensions.dart';
import 'package:ibrat_debate_scanner_app/src/common/widget/app_material_context.dart';
import 'package:ibrat_debate_scanner_app/src/data/entity/ticket_model/ticket_model.dart';
import '../../../data/entity/debate_models/debate_event_model.dart';
import '../view_models/history_view_model.dart';
import '../widgets/filter_dialog.dart';
import '../widgets/tickets_detail_dialog.dart';

@RoutePage()
class HistoryPage extends ConsumerWidget {
  const HistoryPage({super.key});

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year}';
    } catch (_) {
      return dateString;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(historyViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.localized.history,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w500,
            color: context.colorScheme.onSurface,
            fontSize: 24.sp,
          ),
        ),
        backgroundColor: context.colorScheme.surface,
        elevation: 0,
        surfaceTintColor: context.colorScheme.surface,
        actions: [
          IconButton(
            icon: Icon(Icons.tune, size: 24.sp),
            onPressed: () => _showFilterDialog(context, ref, vm),
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () =>
                ref.read(historyViewModelProvider.notifier).loadTickets(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Summary Bar
          // _buildFilterSummary(context, vm, ref),
          // Tickets List
          Expanded(child: _buildTicketsContent(context, vm, ref)),
        ],
      ),
    );
  }

  Widget _buildFilterSummary(BuildContext context, dynamic vm, WidgetRef ref) {
    final hasFilters =
        vm.selectedRegion != null ||
        vm.selectedDistrict != null ||
        vm.showCheckedOnly != null;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceVariant.withOpacity(0.5),
        border: Border(
          bottom: BorderSide(
            color: context.colorScheme.outline.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.filter_list,
            size: 20.sp,
            color: context.colorScheme.onSurfaceVariant,
          ),
          SizedBox(width: 8.w),
          // Expanded(
          //   child: Text(
          //     _getFilterSummaryText(vm, context),
          //     style: context.textTheme.bodyMedium?.copyWith(
          //       color: context.colorScheme.onSurfaceVariant,
          //       fontSize: 14.sp,
          //     ),
          //   ),
          // ),
          // if (hasFilters)
          //   TextButton(
          //     onPressed: () =>
          //         ref.read(historyViewModelProvider.notifier).clearAllFilters(),
          //     style: TextButton.styleFrom(
          //       padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
          //       minimumSize: Size.zero,
          //     ),
          //     child: Text(
          //       'Clear',
          //       style: context.textTheme.bodySmall?.copyWith(
          //         color: context.colorScheme.primary,
          //         fontWeight: FontWeight.w500,
          //       ),
          //     ),
          //   ),
          TextButton(
            onPressed: () => _showFilterDialog(context, ref, vm),
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
              minimumSize: Size.zero,
            ),
            child: Text(
              context.localized.filter,
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.primary,
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getFilterSummaryText(dynamic vm, BuildContext c) {
    final filters = <String>[];

    if (vm.showCheckedOnly == true) {
      filters.add(c.localized.checked_only);
    } else if (vm.showCheckedOnly == false) {
      filters.add(c.localized.pending_only);
    }

    if (vm.selectedRegion != null) {
      filters.add(vm.selectedRegion.name);
    }

    if (vm.selectedDistrict != null) {
      filters.add(vm.selectedDistrict.name);
    }

    final count = vm.filteredTickets.length.toString();

    if (filters.isEmpty) {
      String aa = c.localized.found_tickets_with_filters(count, filters);
      return aa;
    }
    String aa = c.localized.found_tickets_with_filters(count, filters);
    return aa;
  }

  void _showFilterDialog(BuildContext context, WidgetRef ref, dynamic vm) {
    showDialog(
      context: context,
      builder: (context) => FilterDialog(vm: vm, ref: ref),
    );
  }

  Widget _buildTicketsContent(BuildContext context, dynamic vm, WidgetRef ref) {
    if (vm.isLoadingTickets) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16.h),
            Text(
              context.localized.loading_tickets,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      );
    }

    if (vm.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64.sp,
              color: context.colorScheme.error,
            ),
            SizedBox(height: 16.h),
            Text(
              vm.error!,
              style: TextStyle(
                fontSize: 16.sp,
                color: context.colorScheme.error,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: () =>
                  ref.read(historyViewModelProvider.notifier).loadTickets(),
              child: Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (vm.filteredTickets.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.history,
              size: 64.sp,
              color: context.colorScheme.onSurfaceVariant,
            ),
            SizedBox(height: 16.h),
            Text(
              context.localized.no_tickets_found,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: vm.filteredTickets.length,
      itemBuilder: (context, index) {
        final ticket = vm.filteredTickets[index];
        return _buildTicketCard(context, ticket, ref);
      },
    );
  }

  Widget _buildTicketCard(
    BuildContext context,
    TicketModel ticket,
    WidgetRef ref,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final statusColor = ticket.isChecked ? Colors.green : Colors.orange;

    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[850] : Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isDark
              ? Colors.grey[700]!.withOpacity(0.3)
              : Colors.grey[200]!,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.2)
                : Colors.grey.withOpacity(0.08),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12.r),
        child: InkWell(
          onTap: () => _showTicketDialog(context, ticket, ref),
          borderRadius: BorderRadius.circular(12.r),
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header row
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        ticket.user.name ?? ticket.user.username,
                        style: context.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                          color: isDark ? Colors.white : Colors.grey[800],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text(
                        ticket.isChecked
                            ? context.localized.checked
                            : context.localized.pending,
                        style: context.textTheme.labelSmall?.copyWith(
                          color: statusColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 9.sp,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8.h),

                // Location
                Text(
                  '${ticket.debate.region.name} • ${ticket.debate.district.name}',
                  style: context.textTheme.bodySmall?.copyWith(
                    fontSize: 12.sp,
                    color: isDark ? Colors.grey[300] : Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                SizedBox(height: 4.h),

                // Date/Time and Created/Checked info in one row
                Row(
                  children: [
                    // Date/Time
                    if (ticket.debate.date != null &&
                        ticket.debate.time != null)
                      Expanded(
                        child: Text(
                          '${_formatDate(ticket.debate.date!)} • ${ticket.debate.time}',
                          style: context.textTheme.bodySmall?.copyWith(
                            fontSize: 11.sp,
                            color: isDark ? Colors.grey[400] : Colors.grey[600],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                    // Spacer
                    SizedBox(width: 8.w),

                    // Created/Checked time
                    Text(
                      '${ticket.isChecked ? context.localized.checked_at : context.localized.created_at}: ${_formatDate(ticket.isChecked ? ticket.updatedAt : (ticket.createdAt ?? ticket.updatedAt))}',
                      style: context.textTheme.bodySmall?.copyWith(
                        fontSize: 10.sp,
                        color: isDark ? Colors.grey[500] : Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget _buildSimpleInfoRow(
  //   BuildContext context, {
  //   required String label,
  //   required String value,
  //   required bool isDark,
  // }) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         label,
  //         style: context.textTheme.labelMedium?.copyWith(
  //           color: isDark ? Colors.grey[400] : Colors.grey[600],
  //           fontWeight: FontWeight.w500,
  //           fontSize: 11.sp,
  //         ),
  //       ),
  //       SizedBox(height: 4.h),
  //       Text(
  //         value,
  //         style: context.textTheme.bodyMedium?.copyWith(
  //           fontWeight: FontWeight.w600,
  //           fontSize: 13.sp,
  //           color: isDark ? Colors.white : Colors.grey[800],
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // Widget _buildStatusChip(BuildContext context, TicketModel ticket) {
  //   final isChecked = ticket.isChecked;
  //   return Container(
  //     padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
  //     decoration: BoxDecoration(
  //       color: isChecked
  //           ? Colors.green.withOpacity(0.1)
  //           : Colors.orange.withOpacity(0.1),
  //       borderRadius: BorderRadius.circular(12.r),
  //       border: Border.all(
  //         color: isChecked ? Colors.green : Colors.orange,
  //         width: 1,
  //       ),
  //     ),
  //     child: Text(
  //       isChecked ? 'Checked' : 'Pending',
  //       style: context.textTheme.bodySmall?.copyWith(
  //         fontSize: 11.sp,
  //         color: isChecked ? Colors.green : Colors.orange,
  //         fontWeight: FontWeight.w600,
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget _buildInfoRow(
  //   BuildContext context,
  //   IconData icon,
  //   String text,
  //   Color color,
  // ) {
  //   return Row(
  //     children: [
  //       Icon(icon, size: 16.sp, color: color),
  //       SizedBox(width: 6.w),
  //       Expanded(
  //         child: Text(
  //           text,
  //           style: context.textTheme.bodySmall?.copyWith(
  //             fontSize: 12.sp,
  //             color: color,
  //             fontWeight: FontWeight.w500,
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  void _showTicketDialog(
    BuildContext context,
    TicketModel ticket,
    WidgetRef ref,
  ) {
    showDialog(
      context: context,
      builder: (_) => TicketDetailDialog(ticket: ticket, ref: ref),
    );
  }
}
