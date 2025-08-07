import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibrat_debate_scanner_app/src/common/utils/extensions/context_extensions.dart';

import '../../../data/entity/debate_models/debate_event_model.dart';
import '../view_models/history_view_model.dart';

class FilterDialog extends StatefulWidget {
  final dynamic vm;
  final WidgetRef ref;

  const FilterDialog({super.key, required this.vm, required this.ref});

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  Region? selectedRegion;
  District? selectedDistrict;
  bool? showCheckedOnly;

  @override
  void initState() {
    super.initState();
    selectedRegion = widget.vm.selectedRegion;
    selectedDistrict = widget.vm.selectedDistrict;
    showCheckedOnly = widget.vm.showCheckedOnly;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      title: Row(
        children: [
          Icon(Icons.tune, size: 24.sp),
          SizedBox(width: 8.w),
          Text(
            context.localized.filter_tickets,
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 20.sp,
            ),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Filter
            Text(
              context.localized.status,
              style: context.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 8.h),
            Wrap(
              spacing: 8.w,
              children: [
                _buildFilterChip(
                  context,
                  context.localized.all,
                  showCheckedOnly == null,
                  () => setState(() => showCheckedOnly = null),
                ),
                _buildFilterChip(
                  context,
                  context.localized.checked_only,
                  showCheckedOnly == true,
                  () => setState(() => showCheckedOnly = true),
                ),
                _buildFilterChip(
                  context,
                  context.localized.pending_only,
                  showCheckedOnly == false,
                  () => setState(() => showCheckedOnly = false),
                ),
              ],
            ),

            SizedBox(height: 20.h),

            // Region Filter
            Text(
              context.localized.region,
              style: context.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 8.h),
            DropdownButtonFormField2<Region>(
              value: selectedRegion,
              isExpanded: true,
              decoration: InputDecoration(
                hintText: context.localized.select_region,
                hintStyle: TextStyle(
                  color: context.colorScheme.onSurfaceVariant,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 8.h,
                ),
                isDense: true,
              ),
              dropdownStyleData: DropdownStyleData(
                maxHeight: 200.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              items: [
                DropdownMenuItem<Region>(
                  value: null,
                  child: Text(
                    context.localized.all_regions,
                    style: TextStyle(
                      color: context.colorScheme.onSurfaceVariant,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                ...widget.vm.regions.map<DropdownMenuItem<Region>>((region) {
                  return DropdownMenuItem<Region>(
                    value: region,
                    child: Text(
                      region.name,
                      style: TextStyle(
                        color: context.colorScheme.onSurfaceVariant,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
              ],
              onChanged: (region) {
                setState(() {
                  selectedRegion = region;
                  selectedDistrict = null; // Reset district when region changes
                });
              },
            ),

            SizedBox(height: 16.h),

            // District Filter
            Text(
              context.localized.district,
              style: context.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 8.h),
            selectedRegion == null
                ? Container(
                    height: 48.h,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: context.colorScheme.outline.withOpacity(0.5),
                      ),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          context.localized.select_region_first,
                          style: TextStyle(
                            color: context.colorScheme.onSurfaceVariant
                                .withOpacity(0.6),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  )
                : DropdownButtonFormField2<District>(
                    value: selectedDistrict,
                    isExpanded: true,
                    decoration: InputDecoration(
                      hintText: context.localized.all_districts,
                      hintStyle: TextStyle(
                        color: context.colorScheme.onSurfaceVariant,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 8.h,
                      ),
                      isDense: true,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 200.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    items: [
                      DropdownMenuItem<District>(
                        value: null,
                        child: Text(
                          context.localized.all_districts,
                          style: TextStyle(
                            color: context.colorScheme.onSurfaceVariant,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      ...selectedRegion!.districts
                          .map<DropdownMenuItem<District>>((district) {
                            return DropdownMenuItem<District>(
                              value: district,
                              child: Text(
                                district.name,
                                style: TextStyle(
                                  color: context.colorScheme.onSurfaceVariant,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          })
                          .toList(),
                    ],
                    onChanged: (district) {
                      setState(() => selectedDistrict = district);
                    },
                  ),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    context.localized.cancel,
                    style: TextStyle(
                      color: context.colorScheme.onSurface,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp, // Slightly smaller
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      selectedRegion = null;
                      selectedDistrict = null;
                      showCheckedOnly = null;
                    });
                  },
                  child: Text(
                    context.localized.clearAll,
                    style: TextStyle(
                      color: context.colorScheme.onSurface,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    widget.ref
                        .read(historyViewModelProvider.notifier)
                        .applyFilters(
                          region: selectedRegion,
                          district: selectedDistrict,
                          showCheckedOnly: showCheckedOnly,
                        );
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                  ),
                  child: Text(
                    context.localized.apply,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(
    BuildContext context,
    String label,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return FilterChip(
      label: Text(
        label,
        style: context.textTheme.bodySmall?.copyWith(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: isSelected
              ? context.colorScheme.onPrimary
              : context.colorScheme.onSurfaceVariant,
        ),
      ),
      selected: isSelected,
      onSelected: (_) => onTap(),
      backgroundColor: context.colorScheme.surfaceVariant,
      selectedColor: context.colorScheme.primary,
      checkmarkColor: context.colorScheme.onPrimary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
    );
  }
}
