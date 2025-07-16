import 'package:auto_route/annotations.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibrat_debate_scanner_app/src/common/utils/extensions/context_extensions.dart';

import '../../../data/entity/debate_models/debate_event_model.dart';
import '../../../data/entity/ticket_model/ticket_model.dart';
import '../../../data/entity/user_model/user_model.dart';

@RoutePage()
class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  int? selectedRegionId;
  int? selectedDistrictId;
  List<TicketModel> filteredTickets = [];
  List<TicketModel> allTickets = [];
  List<Region> regions = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      isLoading = true;
    });

    try {
      // TODO: Replace with your actual API calls
      await _loadRegions();
      await _loadTickets();

      setState(() {
        filteredTickets = allTickets
            .where((ticket) => ticket.isChecked)
            .toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // Handle error
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to load data: $e')));
    }
  }

  Future<void> _loadRegions() async {
    // TODO: Replace with your actual API call
    // Example: regions = await ApiService.getRegions();

    // Sample data for demonstration
    regions = [
      const Region(
        id: 1,
        name: 'Tashkent',
        createdAt: '2024-01-01',
        updatedAt: '2024-01-01',
        districts: [
          District(
            id: 1,
            name: 'Yunusabad',
            createdAt: '2024-01-01',
            updatedAt: '2024-01-01',
            telegramGroupLink: 'https://t.me/yunusabad',
            region: 1,
          ),
          District(
            id: 2,
            name: 'Chilanzar',
            createdAt: '2024-01-01',
            updatedAt: '2024-01-01',
            telegramGroupLink: 'https://t.me/chilanzar',
            region: 1,
          ),
        ],
      ),
      const Region(
        id: 2,
        name: 'Samarkand',
        createdAt: '2024-01-01',
        updatedAt: '2024-01-01',
        districts: [
          District(
            id: 3,
            name: 'Samarkand Center',
            createdAt: '2024-01-01',
            updatedAt: '2024-01-01',
            telegramGroupLink: 'https://t.me/samarkand_center',
            region: 2,
          ),
        ],
      ),
    ];
  }

  Future<void> _loadTickets() async {
    allTickets = [
      TicketModel(
        id: 'ticket_1',
        createdAt: '2025-07-10T08:00:00',
        updatedAt: '2025-07-10T09:00:00',
        qrCode: 'sample_qr.png',
        isChecked: true,
        user: UserModel(
          id: 'user_1',
          name: 'Test User',
          // firstName: 'Test',
          // lastName: 'User',
          username: 'test_user',
          phone: '998901234567',
          age: '18-24',
          region: null,
          district: null,
          englishLevel: 'B2',
          languageCode: 'uz',
        ),
        debate: DebateEvent(
          id: 100,
          createdAt: '2025-07-09T08:00:00',
          updatedAt: '2025-07-09T08:00:00',
          date: '2025-07-10',
          time: '10:00',
          isPassed: false,
          region: Region(
            id: 1,
            name: 'Tashkent',
            createdAt: '2024-01-01',
            updatedAt: '2024-01-01',
            districts: [
              District(
                id: 1,
                name: 'Yunusabad',
                createdAt: '2024-01-01',
                updatedAt: '2024-01-01',
                telegramGroupLink: '',
                region: 1,
              ),
            ],
          ),
          district: District(
            id: 1,
            name: 'Yunusabad',
            createdAt: '2024-01-01',
            updatedAt: '2024-01-01',
            telegramGroupLink: '',
            region: 1,
          ),
        ),
      ),
      TicketModel(
        id: 'ticket_1',
        createdAt: '2025-07-10T08:00:00',
        updatedAt: '2025-07-10T09:00:00',
        qrCode: 'sample_qr.png',
        isChecked: true,
        user: UserModel(
          id: 'user_1',
          name: 'Test User',
          // firstName: 'Test',
          // lastName: 'User',
          username: 'test_user',
          phone: '998901234567',
          age: '18-24',
          region: null,
          district: null,
          englishLevel: 'B2',
          languageCode: 'uz',
        ),
        debate: DebateEvent(
          id: 100,
          createdAt: '2025-07-09T08:00:00',
          updatedAt: '2025-07-09T08:00:00',
          date: '2025-07-10',
          time: '10:00',
          isPassed: false,
          region: Region(
            id: 1,
            name: 'Samarqand',
            createdAt: '2024-01-01',
            updatedAt: '2024-01-01',
            districts: [
              District(
                id: 1,
                name: 'Samarqand Center',
                createdAt: '2024-01-01',
                updatedAt: '2024-01-01',
                telegramGroupLink: '',
                region: 1,
              ),
            ],
          ),
          district: District(
            id: 1,
            name: 'Samarqand Center',
            createdAt: '2024-01-01',
            updatedAt: '2024-01-01',
            telegramGroupLink: '',
            region: 1,
          ),
        ),
      ),
    ];
  }

  List<District> get availableDistricts {
    if (selectedRegionId == null) return [];
    return regions
        .firstWhere((region) => region.id == selectedRegionId)
        .districts;
  }

  void _filterTickets() {
    print('Selected region: $selectedRegionId');
    print('Selected district: $selectedDistrictId');
    print('Total tickets: ${allTickets.length}');

    setState(() {
      filteredTickets = allTickets.where((ticket) {
        if (!ticket.isChecked) return false;

        final matchesRegion =
            selectedRegionId == null ||
            ticket.debate.region.id == selectedRegionId;

        final matchesDistrict =
            selectedDistrictId == null ||
            ticket.debate.district.id == selectedDistrictId;

        return matchesRegion && matchesDistrict;
      }).toList();

      print('Filtered tickets: ${filteredTickets.length}');
    });
  }

  void _onRegionChanged(int? regionId) {
    setState(() {
      selectedRegionId = regionId;
      selectedDistrictId = null; // Reset district when region changes
    });
    _filterTickets();
  }

  void _onDistrictChanged(int? districtId) {
    setState(() {
      selectedDistrictId = districtId;
    });
    _filterTickets();
  }

  void _clearFilters() {
    setState(() {
      selectedRegionId = null;
      selectedDistrictId = null;
    });
    _filterTickets();
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return dateString; // Return original if parsing fails
    }
  }

  @override
  Widget build(BuildContext context) {
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
          IconButton(icon: const Icon(Icons.refresh), onPressed: _loadData),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Filter Section
                Container(
                  padding: EdgeInsets.all(16.w),
                  color: context.colorScheme.surfaceVariant,
                  child: Column(
                    children: [
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
                                isDense:
                                    true, // This reduces the internal vertical space
                              ),
                              buttonStyleData: ButtonStyleData(
                                padding: EdgeInsets.symmetric(horizontal: 12.w),
                                height: 48.h,
                                decoration: BoxDecoration(
                                  // border: Border.all(
                                  //   color: Colors.grey.shade300,
                                  // ),
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
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              items: regions.map((region) {
                                return DropdownMenuItem<int>(
                                  value: region.id,
                                  child: Text(
                                    region.name,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                );
                              }).toList(),
                              onChanged: _onRegionChanged,
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
                                isDense:
                                    true, // This reduces the internal vertical space
                              ),
                              buttonStyleData: ButtonStyleData(
                                padding: EdgeInsets.symmetric(horizontal: 12.w),
                                height: 48.h,
                                decoration: BoxDecoration(
                                  // border: Border.all(
                                  //   color: Colors.grey.shade300,
                                  // ),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                              ),
                              dropdownStyleData: DropdownStyleData(
                                // padding: EdgeInsets.symmetric(horizontal: 25.w),
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
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              items: availableDistricts.map((district) {
                                return DropdownMenuItem<int>(
                                  value: district.id,
                                  child: Text(
                                    district.name,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                );
                              }).toList(),
                              onChanged: selectedRegionId == null
                                  ? null
                                  : _onDistrictChanged,
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
                              'Found ${filteredTickets.length} checked tickets',
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: context.colorScheme.onSurfaceVariant,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (selectedRegionId != null ||
                              selectedDistrictId != null)
                            Flexible(
                              child: TextButton(
                                onPressed: _clearFilters,
                                child: Text(
                                  context.localized.clear,
                                  style: context.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: context.colorScheme.primary,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Tickets List
                Expanded(
                  child: filteredTickets.isEmpty
                      ? Center(
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
                                selectedRegionId != null ||
                                        selectedDistrictId != null
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
                        )
                      : ListView.builder(
                          padding: EdgeInsets.all(16.w),
                          itemCount: filteredTickets.length,
                          itemBuilder: (context, index) {
                            final ticket = filteredTickets[index];

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
                                      overflow: TextOverflow.ellipsis,
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
                                            overflow: TextOverflow.ellipsis,
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
                                              overflow: TextOverflow.ellipsis,
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
                                            overflow: TextOverflow.ellipsis,
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
                ),
              ],
            ),
    );
  }
}
