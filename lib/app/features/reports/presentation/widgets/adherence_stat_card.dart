import 'package:flutter/material.dart';

import '../../../../core/config/theme/app_colors.dart';

/// A stat card showing a metric label, value, and trend indicator.
class AdherenceStatCard extends StatelessWidget {
  final String label;
  final String value;
  final String trendText;
  final bool trendUp;
  final bool isPrimary;

  const AdherenceStatCard({
    super.key,
    required this.label,
    required this.value,
    required this.trendText,
    this.trendUp = true,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isPrimary
            ? AppColors.primary.withValues(alpha: 0.05)
            : AppColors.slate50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isPrimary
              ? AppColors.primary.withValues(alpha: 0.1)
              : AppColors.slate100,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.slate500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: isPrimary ? AppColors.primary : AppColors.slate900,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                trendUp ? Icons.trending_up : Icons.trending_down,
                size: 16,
                color: trendUp
                    ? const Color(0xFF16A34A)
                    : const Color(0xFFF43F5E),
              ),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  trendText,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: trendUp
                        ? const Color(0xFF16A34A)
                        : const Color(0xFFF43F5E),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
