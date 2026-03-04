import 'package:flutter/material.dart';

import '../../../../core/config/theme/app_colors.dart';

/// The status of a scheduled medicine dose.
enum MedicineStatus { taken, missed, upcoming, later }

/// A single medicine schedule card with coloured left border and status badge.
class MedicineCard extends StatelessWidget {
  final String time;
  final String name;
  final String dosage;
  final String instruction;
  final MedicineStatus status;
  final VoidCallback? onTake;
  final VoidCallback? onSkip;

  const MedicineCard({
    super.key,
    required this.time,
    required this.name,
    required this.dosage,
    required this.instruction,
    required this.status,
    this.onTake,
    this.onSkip,
  });

  Color get _borderColor {
    switch (status) {
      case MedicineStatus.taken:
        return const Color(0xFF22C55E);
      case MedicineStatus.missed:
        return const Color(0xFFEF4444);
      case MedicineStatus.upcoming:
        return AppColors.primary;
      case MedicineStatus.later:
        return AppColors.slate300;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isUpcoming = status == MedicineStatus.upcoming;
    final isLater = status == MedicineStatus.later;

    return Opacity(
      opacity: isLater ? 0.6 : 1.0,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: isUpcoming
              ? Border.all(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  width: 2,
                )
              : null,
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.03),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left colour bar
            Container(
              width: 6,
              height: isUpcoming ? 120 : 72,
              decoration: BoxDecoration(
                color: _borderColor,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            const SizedBox(width: 16),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top row: time + status badge
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        time,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1,
                          color: isUpcoming
                              ? AppColors.primary
                              : AppColors.slate500,
                        ),
                      ),
                      if (!isLater) _StatusBadge(status: status),
                    ],
                  ),
                  const SizedBox(height: 4),

                  // Medicine name
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),

                  // Dosage & instruction
                  Text(
                    "$dosage • $instruction",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.slate600,
                    ),
                  ),

                  // Take / Skip buttons (only for upcoming)
                  if (isUpcoming) ...[
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 52,
                            child: ElevatedButton.icon(
                              onPressed: onTake,
                              icon: const Icon(Icons.done,
                                  color: AppColors.white),
                              label: const Text(
                                "Take",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF22C55E),
                                foregroundColor: AppColors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 0,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: SizedBox(
                            height: 52,
                            child: OutlinedButton.icon(
                              onPressed: onSkip,
                              icon: Icon(Icons.close,
                                  color: AppColors.slate600),
                              label: Text(
                                "Skip",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.slate600,
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                backgroundColor: AppColors.slate100,
                                side: BorderSide.none,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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
}

/// A small pill-shaped status badge.
class _StatusBadge extends StatelessWidget {
  final MedicineStatus status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    late final Color bgColor;
    late final Color textColor;
    late final String label;
    late final IconData icon;

    switch (status) {
      case MedicineStatus.taken:
        bgColor = const Color(0xFF22C55E).withValues(alpha: 0.1);
        textColor = const Color(0xFF22C55E);
        label = "TAKEN";
        icon = Icons.check_circle;
      case MedicineStatus.missed:
        bgColor = const Color(0xFFEF4444).withValues(alpha: 0.1);
        textColor = const Color(0xFFEF4444);
        label = "MISSED";
        icon = Icons.error;
      case MedicineStatus.upcoming:
        bgColor = AppColors.slate100;
        textColor = AppColors.slate500;
        label = "UPCOMING";
        icon = Icons.schedule;
      case MedicineStatus.later:
        return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: textColor),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
