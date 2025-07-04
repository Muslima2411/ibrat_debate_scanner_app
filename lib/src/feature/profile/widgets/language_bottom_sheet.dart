import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ibrat_debate_scanner_app/src/common/utils/extensions/context_extensions.dart';
import '../../settings/inherited/local_controller.dart';
import '../../settings/model/language_type.dart';

class LanguageBottomSheet extends ConsumerWidget {
  const LanguageBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localController = ref.watch(localVM);
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: colors.background,
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
                style: textTheme.titleMedium,
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Uzbek Option
          _LanguageOption(
            title: "O'zbek tili",
            flag: "🇺🇿",
            selected: localController.selectedLanguage == "uz",
            onTap: () {
              ref.read(localVM).changeLocal(LanguageType.uz);
            },
          ),
          const SizedBox(height: 12),

          // Russian Option
          _LanguageOption(
            title: "Русский",
            flag: "🇷🇺",
            selected: localController.selectedLanguage == "ru",
            onTap: () {
              ref.read(localVM).changeLocal(LanguageType.ru);
            },
          ),
          const SizedBox(height: 12),

          // English Option
          _LanguageOption(
            title: "English",
            flag: "🇬🇧",
            selected: localController.selectedLanguage == "en",
            onTap: () {
              ref.read(localVM).changeLocal(LanguageType.en);
            },
          ),
          const SizedBox(height: 24),

          // Confirm Button
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.primary,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              context.localized.select,
              style: textTheme.titleMedium?.copyWith(color: colors.onPrimary),
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
          Expanded(child: Text(title)),
          Text(flag, style: const TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}
