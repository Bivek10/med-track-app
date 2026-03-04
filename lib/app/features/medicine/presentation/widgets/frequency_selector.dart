import 'package:flutter/material.dart';

import '../../../../core/config/theme/app_colors.dart';

/// A row of selectable frequency chips (Once daily, Twice daily, Custom).
class FrequencySelector extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onChanged;
  final List<String> options;

  const FrequencySelector({
    super.key,
    required this.selected,
    required this.onChanged,
    this.options = const ["Once daily", "Twice daily", "Custom"],
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: options.map((option) {
        final isSelected = option == selected;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              right: option != options.last ? 8 : 0,
            ),
            child: GestureDetector(
              onTap: () => onChanged(option),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary.withValues(alpha: 0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.slate200,
                    width: 2,
                  ),
                ),
                child: Text(
                  option,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.slate600,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
