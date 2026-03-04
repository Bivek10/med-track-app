import 'package:flutter/material.dart';

import '../../../../core/config/theme/app_colors.dart';

/// The status of a history log entry.
enum LogStatus { taken, missed, scheduled }

/// A single timeline log entry with a status icon circle, connector line,
/// and a card showing medicine details.
class HistoryLogItem extends StatelessWidget {
  final String medicineName;
  final String dosage;
  final String instruction;
  final LogStatus status;
  final String timeInfo;
  final String? scheduledTime;
  final bool showConnector;
  final VoidCallback? onLogNow;

  const HistoryLogItem({
    super.key,
    required this.medicineName,
    required this.dosage,
    required this.instruction,
    required this.status,
    required this.timeInfo,
    this.scheduledTime,
    this.showConnector = true,
    this.onLogNow,
  });

  Color get _statusColor {
    switch (status) {
      case LogStatus.taken:
        return const Color(0xFF10B981);
      case LogStatus.missed:
        return const Color(0xFFEF4444);
      case LogStatus.scheduled:
        return AppColors.primary;
    }
  }

  IconData get _statusIcon {
    switch (status) {
      case LogStatus.taken:
        return Icons.check;
      case LogStatus.missed:
        return Icons.close;
      case LogStatus.scheduled:
        return Icons.pending;
    }
  }

  String get _badgeText {
    switch (status) {
      case LogStatus.taken:
        return "TAKEN";
      case LogStatus.missed:
        return "MISSED";
      case LogStatus.scheduled:
        return "SCHEDULED";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Timeline column (circle + connector) ──────
        SizedBox(
          width: 40,
          child: Column(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: _statusColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.white, width: 2),
                ),
                child: Icon(_statusIcon, size: 20, color: _statusColor),
              ),
              if (showConnector)
                Container(
                  width: 2,
                  height: 56,
                  color: AppColors.slate200,
                ),
            ],
          ),
        ),
        const SizedBox(width: 16),

        // ── Card ──────────────────────────────────────
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.slate100),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withValues(alpha: 0.03),
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top row: name & badge
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            medicineName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "$dosage • $instruction",
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.slate500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: _statusColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Text(
                        _badgeText,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: _statusColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Bottom row: time info
                Row(
                  children: [
                    Icon(
                      status == LogStatus.missed
                          ? Icons.error_outline
                          : Icons.schedule,
                      size: 14,
                      color: status == LogStatus.missed
                          ? _statusColor
                          : AppColors.slate400,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      timeInfo,
                      style: TextStyle(
                        fontSize: 12,
                        color: status == LogStatus.missed
                            ? _statusColor
                            : AppColors.slate400,
                      ),
                    ),
                    if (scheduledTime != null) ...[
                      const Spacer(),
                      Text(
                        "(Scheduled: $scheduledTime)",
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.slate400.withValues(alpha: 0.5),
                        ),
                      ),
                    ],
                    if (status == LogStatus.missed && onLogNow != null) ...[
                      const Spacer(),
                      GestureDetector(
                        onTap: onLogNow,
                        child: const Text(
                          "Log Now",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
