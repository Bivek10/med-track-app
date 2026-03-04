import 'package:flutter/material.dart';

import '../../../../core/config/theme/app_colors.dart';
import '../widgets/adherence_stat_card.dart';
import '../widgets/missed_dose_tile.dart';
import '../widgets/weekly_progress_chart.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reports & Export"),
        actions: [
          IconButton(
            onPressed: () {
              // TODO: date range picker
            },
            icon: const Icon(Icons.calendar_today),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Monthly Adherence Summary ────────────────
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Monthly Adherence",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const Text(
                          "OCTOBER 2023",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primary,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Stat cards
                  const Row(
                    children: [
                      Expanded(
                        child: AdherenceStatCard(
                          label: "Adherence Rate",
                          value: "92%",
                          trendText: "+5% from last month",
                          trendUp: true,
                          isPrimary: true,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: AdherenceStatCard(
                          label: "Doses Taken",
                          value: "124/135",
                          trendText: "-2% vs target",
                          trendUp: false,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ── Weekly Progress Chart ────────────────────
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: WeeklyProgressChart(
                weeklyValues: [0.85, 0.92, 0.78, 0.95],
                currentStreak: 12,
              ),
            ),

            // ── Recent Missed Doses ──────────────────────
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Recent Missed Doses",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // TODO: view all missed doses
                        },
                        child: const Text(
                          "View All",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const MissedDoseTile(
                    medicineName: "Lisinopril 10mg",
                    dateTime: "Yesterday, 8:00 AM",
                  ),
                  const SizedBox(height: 12),
                  const MissedDoseTile(
                    medicineName: "Atorvastatin 20mg",
                    dateTime: "Oct 24, 9:00 PM",
                  ),
                ],
              ),
            ),

            // ── Export Actions ────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  // PDF export
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // TODO: export PDF
                      },
                      icon: const Icon(
                        Icons.picture_as_pdf,
                        color: AppColors.white,
                      ),
                      label: const Text("Export as PDF Report"),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Email + Share
                  Row(
                    children: [
                      Expanded(
                        child: _ExportActionTile(
                          icon: Icons.mail_outline,
                          label: "Email Doctor",
                          onTap: () {
                            // TODO: email
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _ExportActionTile(
                          icon: Icons.link,
                          label: "Share Link",
                          onTap: () {
                            // TODO: share
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _ExportActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const _ExportActionTile({
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.slate200),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primary, size: 28),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
