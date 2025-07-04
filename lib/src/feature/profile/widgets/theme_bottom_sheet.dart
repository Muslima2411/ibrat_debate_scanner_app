import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ibrat_debate_scanner_app/src/common/utils/extensions/context_extensions.dart';

import '../../settings/inherited/theme_controller.dart';

final themeControllerProvider = ChangeNotifierProvider<ThemeController>(
  (ref) => ThemeController(),
);

class ThemeBottomSheet extends ConsumerWidget {
  const ThemeBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeController = ref.watch(themeControllerProvider);
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
              Text(context.localized.chooseTheme, style: textTheme.titleMedium),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Light Option
          _ThemeOption(
            title: "Light",
            selected: themeController.isLight,
            onTap: () {
              if (!themeController.isLight) {
                themeController.switchTheme();
              }
            },
          ),
          const SizedBox(height: 12),

          // Dark Option
          _ThemeOption(
            title: "Dark",
            selected: themeController.isDark,
            onTap: () {
              if (!themeController.isDark) {
                themeController.switchTheme();
              }
            },
          ),
          const SizedBox(height: 24),

          // Confirm Button
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close bottom sheet
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

class _ThemeOption extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const _ThemeOption({
    required this.title,
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
        ],
      ),
    );
  }
}
