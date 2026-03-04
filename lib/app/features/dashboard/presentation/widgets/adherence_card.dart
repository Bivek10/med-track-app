import 'package:flutter/material.dart';

import '../../../../core/config/theme/app_colors.dart';

/// Displays today's medication adherence as a percentage with a progress bar.
class AdherenceCard extends StatelessWidget {
  final int takenCount;
  final int totalCount;
  final String? message;

  const AdherenceCard({
    super.key,
    required this.takenCount,
    required this.totalCount,
    this.message,
  });

  double get _progress =>
      totalCount > 0 ? (takenCount / totalCount).clamp(0.0, 1.0) : 0.0;

  int get _percentage => (_progress * 100).round();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
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
          const Text(
            "Today's Adherence",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 16),

          // Percentage + doses text
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$_percentage%",
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primary,
                ),
              ),
              Text(
                "$takenCount of $totalCount doses taken",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.slate500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: LinearProgressIndicator(
              value: _progress,
              minHeight: 16,
              backgroundColor: AppColors.slate100,
              valueColor:
                  const AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
          ),

          // Message
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(
              message!,
              style: TextStyle(
                fontSize: 16,
                color: AppColors.slate600,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
