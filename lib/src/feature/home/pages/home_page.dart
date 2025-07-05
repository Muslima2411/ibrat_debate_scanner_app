import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibrat_debate_scanner_app/src/common/utils/extensions/context_extensions.dart';
import 'package:ibrat_debate_scanner_app/src/feature/main/widgets/scanner_button.dart';

import '../../../../generated/assets.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<DebateEvent> _debates = [
    DebateEvent(
      id: '1',
      title: 'Toshkent',
      date: '15.06.2025',
      time: '14:00',
      location: 'Yoshlar ijod Saroyi',
      topic: 'Should school uniforms be mandatory?',
      // status: DebateStatus.upcoming,
    ),
    DebateEvent(
      id: '2',
      title: 'Toshkent',
      date: '15.06.2025',
      time: '16:00',
      location: 'Yoshlar ijod Saroyi',
      topic: 'Is social media harmful to teenagers?',
      // status: DebateStatus.upcoming,
    ),
    DebateEvent(
      id: '3',
      title: 'Toshkent',
      date: '15.06.2025',
      time: '18:00',
      location: 'Yoshlar ijod Saroyi',
      topic: 'Should artificial intelligence replace human teachers?',
      // status: DebateStatus.completed,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
        child: SafeArea(
          child: Column(
            spacing: 20.h,
            children: [
              _buildHeader(context),
              Divider(
                color: context.colorScheme.onSurface.withOpacity(0.1),
                thickness: 1,
              ),
              Expanded(child: _buildDebatesSection(context)),
            ],
          ),
        ),
      ),
      floatingActionButton: ScannerButton(),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.localized.welcome,
              style: context.textTheme.headlineSmall?.copyWith(
                color: context.colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'John Doe',
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.colorScheme.onSurface,
              ),
            ),
          ],
        ),
        Image.asset(Assets.imagesIbratFLogo),
      ],
    );
  }

  Widget _buildDebatesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.localized.debates,
          style: context.textTheme.headlineSmall?.copyWith(
            color: context.colorScheme.onBackground,
            fontWeight: FontWeight.w500,
            fontSize: 22.sp,
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.separated(
            itemCount: _debates.length,
            separatorBuilder: (context, index) => SizedBox(height: 16.h),
            itemBuilder: (context, index) {
              final debate = _debates[index];
              return _buildDebateCard(context, debate);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDebateCard(BuildContext context, DebateEvent debate) {
    return Container(
      // margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.onSurface.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          childrenPadding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
          backgroundColor: context.colorScheme.surface,
          collapsedBackgroundColor: context.colorScheme.surface,
          collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          controlAffinity: ListTileControlAffinity.trailing,
          title: Text(
            debate.title,
            style: context.textTheme.titleMedium?.copyWith(
              color: context.colorScheme.onSurface,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Row(
            children: [
              Icon(
                Icons.calendar_today_rounded,
                size: 14,
                color: context.colorScheme.onSurface.withOpacity(0.6),
              ),
              const SizedBox(width: 4),
              Text(
                debate.date,
                style: context.textTheme.bodySmall?.copyWith(
                  fontSize: 12.sp,
                  color: context.colorScheme.onSurface,
                ),
              ),
            ],
          ),
          trailing: Icon(
            size: 22,
            Icons.arrow_forward_ios_rounded,
            color: context.colorScheme.onSurface.withOpacity(0.5),
          ),
          children: [
            Container(
              width: double.infinity,
              child: Column(
                spacing: 8.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow(
                    context,
                    Icons.access_time_rounded,
                    debate.time,
                  ),
                  _buildDetailRow(
                    context,
                    Icons.location_on_rounded,
                    debate.location,
                  ),
                  Text(
                    '"${debate.topic}"',
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, size: 16, color: context.colorScheme.onSurface),
        SizedBox(width: 4.w),
        Text(
          value,
          style: context.textTheme.bodySmall?.copyWith(
            fontSize: 12.sp,
            color: context.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  void _viewDetails(BuildContext context, DebateEvent debate) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Viewing details: ${debate.title}'),
        backgroundColor: context.colorScheme.primary,
      ),
    );
  }
}

// Models
class DebateEvent {
  final String id;
  final String title;
  final String date;
  final String time;
  final String location;
  final String topic;

  DebateEvent({
    required this.id,
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.topic,
    // required this.status,
  });
}
