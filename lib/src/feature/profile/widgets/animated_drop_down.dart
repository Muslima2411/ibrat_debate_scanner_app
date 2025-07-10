import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibrat_debate_scanner_app/src/common/utils/extensions/context_extensions.dart';

class AnimatedDropdown extends StatefulWidget {
  final String label;
  final IconData icon;
  final List<String> items;
  final String selectedValue;
  final ValueChanged<String> onChanged;

  const AnimatedDropdown({
    super.key,
    required this.label,
    required this.icon,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  State<AnimatedDropdown> createState() => _AnimatedDropdownState();
}

class _AnimatedDropdownState extends State<AnimatedDropdown>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_buildDropdownHeader(context), _buildDropdownItems(context)],
    );
  }

  Widget _buildDropdownHeader(BuildContext context) {
    return GestureDetector(
      onTap: _toggleDropdown,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(color: context.colorScheme.outline),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(widget.icon, color: context.colorScheme.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.label,
                    style: context.textTheme.bodySmall?.copyWith(
                      fontSize: 12.sp,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.selectedValue,
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: context.colorScheme.onSurface,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            AnimatedRotation(
              duration: const Duration(milliseconds: 300),
              turns: _isOpen ? 0.5 : 0,
              child: Icon(
                Icons.keyboard_arrow_down,
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownItems(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ClipRect(
          child: Align(
            alignment: Alignment.topCenter,
            heightFactor: _animation.value,
            child: Container(
              margin: const EdgeInsets.only(top: 4),
              decoration: BoxDecoration(
                color: context.colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: context.colorScheme.outline),
                boxShadow: [
                  BoxShadow(
                    color: context.colorScheme.shadow.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: widget.items
                    .map((item) => _buildDropdownItem(context, item))
                    .toList(),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDropdownItem(BuildContext context, String item) {
    final isSelected = item == widget.selectedValue;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _selectItem(item),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          decoration: BoxDecoration(
            color: isSelected
                ? context.colorScheme.primaryContainer.withOpacity(0.3)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              _buildSelectionIndicator(context, isSelected),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  item,
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: isSelected
                        ? context.colorScheme.primary
                        : context.colorScheme.onSurface,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
              if (isSelected) _buildSelectedBadge(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSelectionIndicator(BuildContext context, bool isSelected) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? context.colorScheme.primary : Colors.transparent,
        border: Border.all(
          color: isSelected
              ? context.colorScheme.primary
              : context.colorScheme.outline,
          width: 2,
        ),
      ),
      child: isSelected
          ? Icon(Icons.check, size: 14, color: context.colorScheme.onPrimary)
          : null,
    );
  }

  Widget _buildSelectedBadge(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: context.colorScheme.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        'Selected',
        style: context.textTheme.bodySmall?.copyWith(
          color: context.colorScheme.onPrimary,
          fontSize: 10.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  void _toggleDropdown() {
    setState(() => _isOpen = !_isOpen);
    _isOpen ? _animationController.forward() : _animationController.reverse();
  }

  void _selectItem(String item) {
    setState(() => _isOpen = false);
    _animationController.reverse();
    widget.onChanged(item);
  }
}
