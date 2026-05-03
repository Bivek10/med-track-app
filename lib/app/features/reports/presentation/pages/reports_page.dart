import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/config/routes/route_path.dart';
import '../../../../core/config/theme/app_colors.dart';
import '../../../../injector.dart';
import '../../domain/services/report_export_service.dart';
import '../bloc/reports_bloc.dart';
import '../bloc/reports_event.dart';
import '../bloc/reports_state.dart';
import '../widgets/adherence_stat_card.dart';
import '../widgets/missed_dose_tile.dart';
import '../widgets/weekly_progress_chart.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => inject<ReportsBloc>()..add(const LoadReportsEvent()),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Reports & Export"),
            actions: [
              IconButton(
                onPressed: () => _showPeriodPicker(context),
                icon: const Icon(Icons.calendar_today),
              ),
            ],
          ),
          body: BlocBuilder<ReportsBloc, ReportsState>(
            builder: (context, state) {
              if (state is ReportsLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is ReportsError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state.message,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          context
                              .read<ReportsBloc>()
                              .add(const LoadReportsEvent());
                        },
                        child: const Text("Retry"),
                      ),
                    ],
                  ),
                );
              }

              if (state is ReportsLoaded) {
                final report = state.adherenceReport;
                final missedDoses = state.missedDoses;

                return SingleChildScrollView(
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
                                Text(
                                  "${report.period.toUpperCase()} Adherence",
                                  style: const TextStyle(
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
                                    color:
                                        AppColors.primary.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Text(
                                    DateFormat('MMMM yyyy')
                                        .format(DateTime.now())
                                        .toUpperCase(),
                                    style: const TextStyle(
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
                            Row(
                              children: [
                                Expanded(
                                  child: AdherenceStatCard(
                                    label: "Adherence Rate",
                                    value:
                                        "${report.overallAdherencePercentage.toInt()}%",
                                    trendText: "Overall adherence",
                                    trendUp: report.overallAdherencePercentage >= 80,
                                    isPrimary: true,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: AdherenceStatCard(
                                    label: "Doses Taken",
                                    value:
                                        "${report.totalTaken}/${report.totalScheduled}",
                                    trendText: "${report.totalMissed} missed",
                                    trendUp: report.totalMissed == 0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // ── Weekly Progress Chart ────────────────────
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: WeeklyProgressChart(
                          weeklyValues: report.dailyBreakdown.map((e) {
                            final total = e.taken + e.missed;
                            return total > 0 ? e.taken / total : 0.0;
                          }).toList(),
                          currentStreak: _calculateStreak(report.dailyBreakdown),
                        ),
                      ),

                      // ── Recent Missed Doses ──────────────────────
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                if (missedDoses.isNotEmpty)
                                  GestureDetector(
                                    onTap: () {
                                      context.pushNamed(
                                        AppPage.missedDoses.toName,
                                        extra: missedDoses,
                                      );
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
                            if (missedDoses.isEmpty)
                              const Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  child: Text("No missed doses! Keep it up."),
                                ),
                              )
                            else
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    missedDoses.length > 3 ? 3 : missedDoses.length,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 12),
                                itemBuilder: (context, index) {
                                  final dose = missedDoses[index];
                                  return MissedDoseTile(
                                    medicineName: dose.medicineName,
                                    dateTime: DateFormat('MMM d, h:mm a')
                                        .format(dose.scheduledTime),
                                  );
                                },
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
                                  inject<ReportExportService>().exportAndShareReport(
                                    adherenceReport: report,
                                    missedDoses: missedDoses,
                                  );
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
                                      inject<ReportExportService>().exportAndShareReport(
                                        adherenceReport: report,
                                        missedDoses: missedDoses,
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: _ExportActionTile(
                                    icon: Icons.share,
                                    label: "Share Stats",
                                    onTap: () {
                                      inject<ReportExportService>().shareTextReport(report);
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
                );
              }

              return const SizedBox();
            },
          ),
        );
      }),
    );
  }

  void _showPeriodPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (bottomSheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Select Report Period",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.today),
                title: const Text("Daily"),
                onTap: () {
                  context
                      .read<ReportsBloc>()
                      .add(const LoadReportsEvent(period: 'daily'));
                  Navigator.pop(bottomSheetContext);
                },
              ),
              ListTile(
                leading: const Icon(Icons.calendar_view_week),
                title: const Text("Weekly"),
                onTap: () {
                  context
                      .read<ReportsBloc>()
                      .add(const LoadReportsEvent(period: 'weekly'));
                  Navigator.pop(bottomSheetContext);
                },
              ),
              ListTile(
                leading: const Icon(Icons.calendar_month),
                title: const Text("Monthly"),
                onTap: () {
                  context
                      .read<ReportsBloc>()
                      .add(const LoadReportsEvent(period: 'monthly'));
                  Navigator.pop(bottomSheetContext);
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  int _calculateStreak(List<dynamic> breakdown) {
    int streak = 0;
    // Simple streak calculation: consecutive days with 100% adherence ending today
    for (var i = breakdown.length - 1; i >= 0; i--) {
      final day = breakdown[i];
      if (day.taken > 0 && day.missed == 0) {
        streak++;
      } else if (day.taken == 0 && day.missed == 0) {
        // Skip days with no scheduled meds
        continue;
      } else {
        break;
      }
    }
    return streak;
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

