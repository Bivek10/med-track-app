import 'package:flutter/material.dart';

import '../../../../core/config/theme/app_colors.dart';

/// A pill-shaped chip showing a reminder time with a remove button.
class ReminderTimeChip extends StatelessWidget {
  final String time;
  final VoidCallback? onRemove;

  const ReminderTimeChip({
    super.key,
    required this.time,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.05),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.2),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.schedule, size: 18, color: AppColors.primary),
          const SizedBox(width: 8),
          Text(
            time,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.primary,
            ),
          ),
          if (onRemove != null) ...[
            const SizedBox(width: 8),
            GestureDetector(
              onTap: onRemove,
              child: Icon(Icons.close, size: 16, color: AppColors.primary),
            ),
          ],
        ],
      ),
    );
  }
}

/// A dashed "Add time" button.
class AddTimeButton extends StatelessWidget {
  final VoidCallback? onTap;

  const AddTimeButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.slate300,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add, size: 18, color: AppColors.slate500),
            const SizedBox(width: 8),
            Text(
              "Add time",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.slate500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
