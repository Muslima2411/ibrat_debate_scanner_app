import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibrat_debate_scanner_app/src/common/utils/extensions/context_extensions.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../data/entity/ticket_model/ticket_model.dart';
import '../view_models/history_view_model.dart';

class TicketDetailDialog extends StatelessWidget {
  final TicketModel ticket;
  final WidgetRef ref;

  const TicketDetailDialog({
    super.key,
    required this.ticket,
    required this.ref,
  });

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year}';
    } catch (_) {
      return dateString;
    }
  }

  String _formatPhone(String phone) {
    if (phone.isEmpty) return '';
    return phone.startsWith('+') ? phone : '+$phone';
  }

  Future<void> _launchPhone(String phone) async {
    final formattedPhone = _formatPhone(phone);
    final uri = Uri.parse('tel:$formattedPhone');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _launchTelegram(String username) async {
    final cleanUsername = username.startsWith('@')
        ? username.substring(1)
        : username;
    final uri = Uri.parse('https://t.me/$cleanUsername');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      contentPadding: EdgeInsets.zero,
      content: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              context.colorScheme.surface,
              context.colorScheme.surface.withOpacity(0.8),
            ],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 12.h),
              decoration: BoxDecoration(
                color: context.colorScheme.primaryContainer,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ticket.user.name ?? context.localized.unknown_user,
                    style: context.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 20.sp,
                      color: context.colorScheme.onPrimaryContainer,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: ticket.isChecked
                              ? Colors.green.withOpacity(0.2)
                              : Colors.orange.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: ticket.isChecked
                                ? Colors.green
                                : Colors.orange,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          ticket.isChecked
                              ? context.localized.checked
                              : context.localized.pending,
                          style: context.textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 10.sp,
                            color: ticket.isChecked
                                ? Colors.green
                                : Colors.orange,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Content
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 0),
              child: Column(
                children: [
                  _buildSectionHeader(
                    context,
                    context.localized.contact_info,
                    Icons.contact_phone,
                  ),
                  SizedBox(height: 12.h),
                  if (ticket.user.username.isNotEmpty)
                    _buildTappableRow(
                      context,
                      icon: Icons.alternate_email,
                      label: context.localized.telegram,
                      value: '@${ticket.user.username}',
                      onTap: () => _launchTelegram(ticket.user.username),
                      color: const Color(0xFF0088CC),
                    ),
                  if (ticket.user.phone?.isNotEmpty == true)
                    _buildTappableRow(
                      context,
                      icon: Icons.phone,
                      label: context.localized.phone,
                      value: _formatPhone(ticket.user.phone!),
                      onTap: () => _launchPhone(ticket.user.phone!),
                      color: Colors.green,
                    ),
                  SizedBox(height: 20.h),
                  _buildSectionHeader(
                    context,
                    context.localized.event_info,
                    Icons.event,
                  ),
                  SizedBox(height: 12.h),
                  _buildInfoRow(
                    context,
                    Icons.location_on,
                    context.localized.region,
                    ticket.debate.region.name,
                  ),
                  _buildInfoRow(
                    context,
                    Icons.location_city,
                    context.localized.district,
                    ticket.debate.district.name,
                  ),
                  if (ticket.debate.date != null)
                    _buildInfoRow(
                      context,
                      Icons.calendar_today,
                      context.localized.date,
                      _formatDate(ticket.debate.date!),
                    ),
                  if (ticket.debate.time != null)
                    _buildInfoRow(
                      context,
                      Icons.access_time,
                      context.localized.time,
                      ticket.debate.time!,
                    ),
                  _buildInfoRow(
                    context,
                    Icons.history,
                    ticket.isChecked
                        ? context.localized.checked_at
                        : context.localized.created_at,
                    _formatDate(
                      ticket.isChecked
                          ? ticket.updatedAt
                          : (ticket.createdAt ?? ticket.updatedAt),
                    ),
                  ),
                ],
              ),
            ),

            // Actions
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: context.colorScheme.surfaceVariant.withOpacity(0.3),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.r),
                  bottomRight: Radius.circular(20.r),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.close, size: 18.w),
                    label: Text(
                      context.localized.close,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: context.colorScheme.primary,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                    ),
                  ),
                  if (ticket.isChecked) ...[
                    SizedBox(width: 12.w),
                    GestureDetector(
                      onTap: () => _showCancelConfirmation(context),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.cancel_outlined,
                            size: 18.w,
                            color: context.colorScheme.error,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            context.localized.cancel_ticket,
                            style: TextStyle(
                              color: context.colorScheme.error,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    String title,
    IconData icon,
  ) {
    return Row(
      children: [
        Icon(icon, size: 20.w, color: context.colorScheme.primary),
        SizedBox(width: 8.w),
        Text(
          title,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 18.sp,
            color: context.colorScheme.primary,
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            margin: EdgeInsets.only(left: 12.w),
            color: context.colorScheme.outline.withOpacity(0.3),
          ),
        ),
      ],
    );
  }

  Widget _buildTappableRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onTap,
    required Color color,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: color.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: color.withOpacity(0.2), width: 1),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(icon, size: 18.w, color: color),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: context.textTheme.labelMedium?.copyWith(
                        color: context.colorScheme.onSurface.withOpacity(0.7),
                        fontWeight: FontWeight.w400,
                        fontSize: 10.sp,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      value,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: color,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.open_in_new,
                size: 16.w,
                color: color.withOpacity(0.7),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(6.w),
            decoration: BoxDecoration(
              color: context.colorScheme.primaryContainer.withOpacity(0.3),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Icon(
              icon,
              size: 16.w,
              color: context.colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurface.withOpacity(0.7),
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: context.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  void _showCancelConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        icon: Icon(
          Icons.warning_amber_rounded,
          color: context.colorScheme.error,
          size: 32.w,
        ),
        title: Text(
          context.localized.cancel_ticket_title,
          textAlign: TextAlign.center,
        ),
        content: Text(
          context.localized.cancel_ticket_confirmation,
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(context.localized.keep_ticket),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              ref
                  .read(historyViewModelProvider.notifier)
                  .cancelTicket(ticket.id);
            },
            style: FilledButton.styleFrom(
              backgroundColor: context.colorScheme.error,
            ),
            child: Text(context.localized.cancel_ticket),
          ),
        ],
      ),
    );
  }
}
