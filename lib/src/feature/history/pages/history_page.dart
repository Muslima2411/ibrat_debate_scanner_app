import 'package:auto_route/annotations.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibrat_debate_scanner_app/src/common/utils/extensions/context_extensions.dart';
import '../../../data/entity/debate_models/debate_event_model.dart';
import '../view_models/history_view_model.dart';

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
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () =>
                ref.read(historyViewModelProvider.notifier).loadTickets(),
          ),
        ],
      ),
      body: vm.isLoadingRegions || vm.isLoadingTickets
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16.w),
                    color: context.colorScheme.surfaceVariant,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField2<Region>(
                                value: vm.selectedRegion,
                                isExpanded: true,
                                decoration: InputDecoration(
                                  labelText: 'Region',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                    vertical: 4.h,
                                  ),
                                  isDense: true,
                                ),
                                buttonStyleData: ButtonStyleData(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.w,
                                  ),
                                  height: 48.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                ),
                                dropdownStyleData: DropdownStyleData(
                                  maxHeight: 300.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                ),
                                iconStyleData: IconStyleData(
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    size: 24.sp,
                                  ),
                                ),
                                style: context.textTheme.bodyMedium?.copyWith(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500,
                                  color: context.colorScheme.onSurface,
                                ),
                                items: vm.regions.isEmpty
                                    ? [
                                        DropdownMenuItem<Region>(
                                          value: null,
                                          enabled: false,
                                          child: Text('No regions available'),
                                        ),
                                      ]
                                    : vm.regions.map((region) {
                                        return DropdownMenuItem<Region>(
                                          value: region,
                                          child: Text(
                                            region.name,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        );
                                      }).toList(),
                                onChanged: vm.regions.isEmpty
                                    ? null
                                    : (region) {
                                        ref
                                            .read(
                                              historyViewModelProvider.notifier,
                                            )
                                            .selectRegion(region);
                                      },
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: DropdownButtonFormField2<District>(
                                value: vm.selectedDistrict,
                                isExpanded: true,
                                decoration: InputDecoration(
                                  labelText: 'District',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                    vertical: 4.h,
                                  ),
                                  isDense: true,
                                ),
                                buttonStyleData: ButtonStyleData(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.w,
                                  ),
                                  height: 48.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                ),
                                dropdownStyleData: DropdownStyleData(
                                  maxHeight: 300.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                ),
                                iconStyleData: IconStyleData(
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    size: 24.sp,
                                  ),
                                ),
                                style: context.textTheme.bodyMedium?.copyWith(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500,
                                  color: context.colorScheme.onSurface,
                                ),
                                items: vm.availableDistricts.isEmpty
                                    ? [
                                        DropdownMenuItem<District>(
                                          value: null,
                                          enabled: false,
                                          child: Text('Select a region first'),
                                        ),
                                      ]
                                    : vm.availableDistricts.map((district) {
                                        return DropdownMenuItem<District>(
                                          value: district,
                                          child: Text(
                                            district.name,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        );
                                      }).toList(),
                                onChanged: vm.availableDistricts.isEmpty
                                    ? null
                                    : (district) {
                                        ref
                                            .read(
                                              historyViewModelProvider.notifier,
                                            )
                                            .selectDistrict(district);
                                      },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Found ${vm.filteredTickets.length} checked tickets',
                                style: context.textTheme.bodyMedium?.copyWith(
                                  color: context.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ),
                            if (vm.selectedRegion != null ||
                                vm.selectedDistrict != null)
                              Flexible(
                                child: TextButton(
                                  onPressed: () => ref
                                      .read(historyViewModelProvider.notifier)
                                      .clearFilters(),
                                  child: Text(
                                    context.localized.clear,
                                    style: context.textTheme.bodyMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: context.colorScheme.primary,
                                        ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        if (vm.error != null)
                          Padding(
                            padding: EdgeInsets.only(top: 8.h),
                            child: Text(
                              vm.error!,
                              style: TextStyle(
                                color: context.colorScheme.error,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  vm.filteredTickets.isEmpty
                      ? SizedBox(
                          height: 300.h,
                          child: Center(
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
                                  vm.selectedRegion != null ||
                                          vm.selectedDistrict != null
                                      ? 'No checked tickets found for selected filters'
                                      : context.localized.no_history,
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                    color: context.colorScheme.onSurfaceVariant,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.all(16.w),
                          itemCount: vm.filteredTickets.length,
                          itemBuilder: (context, index) {
                            final ticket = vm.filteredTickets[index];
                            return Card(
                              margin: EdgeInsets.only(bottom: 12.h),
                              child: Padding(
                                padding: EdgeInsets.all(16.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      ticket.user.name ?? ticket.user.username,
                                      style: context.textTheme.titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                    SizedBox(height: 8.h),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          size: 16.sp,
                                          color: context.colorScheme.primary,
                                        ),
                                        SizedBox(width: 4.w),
                                        Expanded(
                                          child: Text(
                                            '${ticket.debate.region.name} • ${ticket.debate.district.name}',
                                            style: context.textTheme.bodySmall
                                                ?.copyWith(
                                                  fontSize: 12.sp,
                                                  color: context
                                                      .colorScheme
                                                      .primary,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.h),
                                    if (ticket.debate.date != null &&
                                        ticket.debate.time != null)
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.event,
                                            size: 16.sp,
                                            color: context
                                                .colorScheme
                                                .onSurfaceVariant,
                                          ),
                                          SizedBox(width: 4.w),
                                          Expanded(
                                            child: Text(
                                              '${_formatDate(ticket.debate.date!)} at ${ticket.debate.time}',
                                              style: context.textTheme.bodySmall
                                                  ?.copyWith(
                                                    fontSize: 12.sp,
                                                    color: context
                                                        .colorScheme
                                                        .onSurfaceVariant,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    SizedBox(height: 8.h),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.access_time,
                                          size: 16.sp,
                                          color: context
                                              .colorScheme
                                              .onSurfaceVariant,
                                        ),
                                        SizedBox(width: 4.w),
                                        Expanded(
                                          child: Text(
                                            'Checked: ${_formatDate(ticket.updatedAt)}',
                                            style: context.textTheme.bodySmall
                                                ?.copyWith(
                                                  fontSize: 12.sp,
                                                  color: context
                                                      .colorScheme
                                                      .onSurfaceVariant,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ],
              ),
            ),
    );
  }
}
