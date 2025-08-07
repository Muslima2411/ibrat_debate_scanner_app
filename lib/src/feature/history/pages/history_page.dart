import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibrat_debate_scanner_app/src/common/utils/extensions/context_extensions.dart';
import 'package:ibrat_debate_scanner_app/src/data/entity/ticket_model/ticket_model.dart';
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
        children: [Expanded(child: _buildTicketsContent(context, vm, ref))],
      ),
    );
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

    if (vm.allTickets.isEmpty) {
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
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 82.h),
      itemCount: vm.allTickets.length,
      itemBuilder: (context, index) {
        final ticket = vm.allTickets[index];
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
                  '${ticket.debate.region!.name} • ${ticket.debate.district!.name}',
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
