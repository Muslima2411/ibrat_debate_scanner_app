import 'package:auto_route/auto_route.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibrat_debate_scanner_app/src/common/utils/extensions/context_extensions.dart';

@RoutePage()
class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  int? selectedRegionId;
  int? selectedDistrictId;

  final List<Map<String, dynamic>> sampleRegions = [
    {
      'id': 1,
      'name': 'Tashkent',
      'districts': [
        {'id': 1, 'name': 'Yangiyo\'l'},
        {'id': 2, 'name': 'Qibray'},
        {'id': 3, 'name': 'Chilonzor'},
        {'id': 4, 'name': 'Yunusobod'},
      ],
    },
    {
      'id': 2,
      'name': 'Samarkand',
      'districts': [
        {'id': 3, 'name': 'Samarkand Center'},
      ],
    },
  ];

  final List<Map<String, dynamic>> sampleStats = [
    {'regionId': 1, 'districtId': 1, 'debate': 'Yangiyo\'l', 'comers': 42},
    {'regionId': 1, 'districtId': 2, 'debate': 'Qibray', 'comers': 58},
    {
      'regionId': 1,
      'districtId': 3,
      'debate': 'Yoshlar Ijod Saroyi',
      'comers': 31,
    },
  ];

  List<Map<String, dynamic>> get filteredStats {
    return sampleStats.where((stat) {
      final regionMatches =
          selectedRegionId == null || stat['regionId'] == selectedRegionId;
      final districtMatches =
          selectedDistrictId == null ||
          stat['districtId'] == selectedDistrictId;
      return regionMatches && districtMatches;
    }).toList();
  }

  List<Map<String, dynamic>> get availableDistricts {
    final region = sampleRegions.firstWhere(
      (r) => r['id'] == selectedRegionId,
      orElse: () => {},
    );
    return region['districts'] ?? [];
  }

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
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dropdowns
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField2<int>(
                    value: selectedRegionId,
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
                    items: sampleRegions.map((region) {
                      return DropdownMenuItem<int>(
                        value: region['id'],
                        child: Text(
                          region['name'],
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        selectedRegionId = val;
                        selectedDistrictId = null;
                      });
                    },
                  ),
                ),

                SizedBox(width: 12.w),
                Expanded(
                  child: DropdownButtonFormField2<int>(
                    value: selectedDistrictId,
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
                      return DropdownMenuItem<int>(
                        value: district['id'],
                        child: Text(
                          district['name'],
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList(),
                    onChanged: selectedRegionId == null
                        ? null
                        : (val) {
                            setState(() {
                              selectedDistrictId = val;
                            });
                          },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),

            // Table or Empty Message
            Expanded(
              child: filteredStats.isEmpty
                  ? Center(
                      child: Text(
                        context.localized.statistics_not_available_yet,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : DataTable2(
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
                        DataColumn2(label: Text('Debate'), size: ColumnSize.L),
                        DataColumn2(label: Text('Comers'), size: ColumnSize.S),
                      ],
                      rows: filteredStats
                          .map(
                            (row) => DataRow(
                              cells: [
                                DataCell(Text(row['debate'])),
                                DataCell(Text('${row['comers']}')),
                              ],
                            ),
                          )
                          .toList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
