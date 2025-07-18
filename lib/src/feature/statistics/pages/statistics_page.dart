import 'package:auto_route/auto_route.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibrat_debate_scanner_app/src/common/utils/extensions/context_extensions.dart';

import '../../../data/entity/debate_models/debate_event_model.dart';
import '../../../data/entity/stats/statistics_models.dart';
import '../view_models/statistics_view_model.dart';

@RoutePage()
class StatisticsPage extends ConsumerStatefulWidget {
  const StatisticsPage({super.key});

  @override
  ConsumerState<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends ConsumerState<StatisticsPage> {
  @override
  void initState() {
    super.initState();
    // Load regions when page is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(statisticsViewModelProvider).loadRegions();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(statisticsViewModelProvider);
    final regions = viewModel.regions;
    final availableDistricts = viewModel.availableDistricts;
    final selectedRegion = viewModel.selectedRegion;
    final selectedDistrict = viewModel.selectedDistrict;
    final statistics = viewModel.statistics;
    final isLoadingRegions = viewModel.isLoadingRegions;
    final isLoadingStats = viewModel.isLoadingStats;
    final error = viewModel.error;

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
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Error Message
            if (error != null)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12.w),
                margin: EdgeInsets.only(bottom: 16.h),
                decoration: BoxDecoration(
                  color: context.colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: context.colorScheme.onErrorContainer,
                      size: 20.sp,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        error,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colorScheme.onErrorContainer,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () =>
                          ref.read(statisticsViewModelProvider).clearError(),
                      icon: Icon(
                        Icons.close,
                        color: context.colorScheme.onErrorContainer,
                        size: 18.sp,
                      ),
                    ),
                  ],
                ),
              ),

            // Dropdowns
            Row(
              children: [
                // Region Dropdown
                Expanded(
                  child: DropdownButtonFormField2<Region>(
                    value: selectedRegion,
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
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
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
                      icon: isLoadingRegions
                          ? SizedBox(
                              width: 20.w,
                              height: 20.h,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 24.sp,
                            ),
                    ),
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: context.colorScheme.onSurface,
                    ),
                    items: regions.map((region) {
                      return DropdownMenuItem<Region>(
                        value: region,
                        child: Text(
                          region.name,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList(),
                    onChanged: isLoadingRegions
                        ? null
                        : (region) {
                            ref
                                .read(statisticsViewModelProvider)
                                .selectRegion(region);
                          },
                  ),
                ),

                SizedBox(width: 12.w),

                // District Dropdown
                Expanded(
                  child: DropdownButtonFormField2<District>(
                    value: selectedDistrict,
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
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
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
                    items: availableDistricts.map((district) {
                      return DropdownMenuItem<District>(
                        value: district,
                        child: Text(
                          district.name,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList(),
                    onChanged: selectedRegion == null
                        ? null
                        : (district) {
                            ref
                                .read(statisticsViewModelProvider)
                                .selectDistrict(district);
                          },
                  ),
                ),
              ],
            ),

            SizedBox(height: 30.h),

            // Statistics Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildStatisticsContent(
                  context,
                  statistics,
                  selectedRegion,
                  selectedDistrict,
                  isLoadingStats,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticsContent(
    BuildContext context,
    StatisticsResponse? statistics,
    Region? selectedRegion,
    District? selectedDistrict,
    bool isLoadingStats,
  ) {
    if (isLoadingStats) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16.h),
            Text(
              'Loading statistics...',
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      );
    }

    if (selectedRegion == null && selectedDistrict == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.analytics_outlined,
              size: 64.sp,
              color: context.colorScheme.onSurfaceVariant,
            ),
            SizedBox(height: 16.h),
            Text(
              'Please select region and district to view statistics',
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    if (selectedRegion == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.analytics_outlined,
              size: 64.sp,
              color: context.colorScheme.onSurfaceVariant,
            ),
            SizedBox(height: 16.h),
            Text(
              'Please select a region to view statistics',
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    if (statistics == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.info_outline,
              size: 64.sp,
              color: context.colorScheme.onSurfaceVariant,
            ),
            SizedBox(height: 16.h),
            Text(
              context.localized.statistics_not_available_yet,
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return DataTable2(
      columnSpacing: 16.w,
      horizontalMargin: 12.w,
      headingTextStyle: context.textTheme.labelLarge?.copyWith(
        fontWeight: FontWeight.w600,
        color: context.colorScheme.primary,
      ),
      dataTextStyle: context.textTheme.bodyMedium?.copyWith(
        color: context.colorScheme.onSurface,
        fontWeight: FontWeight.w400,
      ),
      columns: const [
        DataColumn2(label: Text('Metric'), size: ColumnSize.L),
        DataColumn2(label: Text('Count'), size: ColumnSize.S),
      ],
      rows: [
        DataRow(
          cells: [
            DataCell(Text('Total Registered')),
            DataCell(Text('${statistics.allCount}')),
          ],
        ),
        DataRow(
          cells: [
            DataCell(Text('Attended')),
            DataCell(Text('${statistics.hasComeCount}')),
          ],
        ),
        DataRow(
          cells: [
            DataCell(Text('Attendance Rate')),
            DataCell(
              Text(
                statistics.allCount > 0
                    ? '${((statistics.hasComeCount / statistics.allCount) * 100).toStringAsFixed(1)}%'
                    : '0%',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
