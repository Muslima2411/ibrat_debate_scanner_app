import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibrat_debate_scanner_app/src/common/utils/extensions/context_extensions.dart';
import '../../../../generated/assets.dart';
import '../../../common/widget/app_material_context.dart';
import '../../settings/model/language_type.dart';

class LanguageBottomSheet extends ConsumerWidget {
  const LanguageBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header Row
          Row(
            children: [
              Text(
                context.localized.chooseLanguage,
                style: textTheme.titleMedium?.copyWith(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              CircleAvatar(
                radius: 16,
                backgroundColor: colors.outline.withOpacity(0.6),
                child: IconButton(
                  iconSize: 18.sp,
                  icon: const Icon(Icons.close),
                  onPressed: () => context.router.pop(),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),

          // Uzbek Option
          _LanguageOption(
            title: "O'zbek tili",
            flag: Assets.imagesUzFlag,
            selected: localController.selectedLanguage == "uz",
            onTap: () {
              localController.changeLocal(LanguageType.uz);
            },
          ),
          // const SizedBox(height: 12),

          // Russian Option
          _LanguageOption(
            title: "Русский",
            flag: Assets.imagesRuFlag,
            selected: localController.selectedLanguage == "ru",
            onTap: () {
              localController.changeLocal(LanguageType.ru);
            },
          ),
          // const SizedBox(height: 12),

          // English Option
          _LanguageOption(
            title: "English",
            flag: Assets.imagesEnFlag,
            selected: localController.selectedLanguage == "en",
            onTap: () {
              localController.changeLocal(LanguageType.en);
            },
          ),
          const SizedBox(height: 10),

          // Confirm Button
          ElevatedButton(
            onPressed: () {
              context.router.pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.primary,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text(
              context.localized.select,
              style: textTheme.titleMedium?.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
                color: colors.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final String title;
  final String flag;
  final bool selected;
  final VoidCallback onTap;

  const _LanguageOption({
    required this.title,
    required this.flag,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Row(
        children: [
          Radio<bool>(
            value: true,
            groupValue: selected,
            onChanged: (_) => onTap(),
            activeColor: colors.primary,
          ),
          Expanded(child: Text(title, style: context.textTheme.bodyMedium)),
          Image.asset(flag, width: 24.w, height: 24.h),
        ],
      ),
    );
  }
}
