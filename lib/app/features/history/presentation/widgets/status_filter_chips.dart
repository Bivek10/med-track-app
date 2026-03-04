import 'package:flutter/material.dart';

import '../../../../core/config/theme/app_colors.dart';

/// A horizontal list of filter chips for intake status.
class StatusFilterChips extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onChanged;

  const StatusFilterChips({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  static const _filters = ["All Statuses", "Taken", "Missed"];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _filters.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (_, i) {
          final label = _filters[i];
          final isActive = label == selected;

          return GestureDetector(
            onTap: () => onChanged(label),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: isActive ? AppColors.primary : AppColors.slate100,
                borderRadius: BorderRadius.circular(16),
                boxShadow: isActive
                    ? [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.2),
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ]
                    : null,
              ),
              child: Row(
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isActive ? AppColors.white : AppColors.slate700,
                    ),
                  ),
                  if (label == "All Statuses") ...[
                    const SizedBox(width: 4),
                    Icon(
                      Icons.expand_more,
                      size: 16,
                      color: isActive ? AppColors.white : AppColors.slate700,
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
