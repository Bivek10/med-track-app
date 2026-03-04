import 'package:flutter/material.dart';

import '../../../../core/config/theme/app_colors.dart';
import '../widgets/snooze_duration_selector.dart';

class ReminderPage extends StatefulWidget {
  final String medicineName;
  final String dosage;
  final String scheduledTime;
  final String instruction;
  final int currentDose;
  final int totalDoses;

  const ReminderPage({
    super.key,
    this.medicineName = "Atorvastatin",
    this.dosage = "40mg",
    this.scheduledTime = "9:00 AM",
    this.instruction = "Take with a glass of water",
    this.currentDose = 1,
    this.totalDoses = 4,
  });

  @override
  State<ReminderPage> createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  String _snoozeDuration = "10m";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.maybePop(context),
          icon: const Icon(Icons.close, size: 28),
        ),
        title: const Text("MedTrack Alert"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              // ── Scrollable Content ──────────────────────
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 32),

                      // ── Medication Icon ─────────────────
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.primary,
                                width: 4,
                              ),
                            ),
                            child: const Icon(
                              Icons.medication,
                              size: 64,
                              color: AppColors.primary,
                            ),
                          ),
                          Positioned(
                            bottom: -8,
                            right: -8,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.black
                                        .withValues(alpha: 0.1),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.alarm,
                                size: 24,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // ── Medicine Name + Schedule ────────
                      Text(
                        "${widget.medicineName} ${widget.dosage}",
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Scheduled: ${widget.scheduledTime}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // ── Instruction ─────────────────────
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.slate100,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.slate200),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.restaurant,
                              size: 24,
                              color: AppColors.slate600,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              widget.instruction,
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.slate600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),

                      // ── Snooze Duration ─────────────────
                      Text(
                        "SNOOZE DURATION",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 2,
                          color: AppColors.slate500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      SnoozeDurationSelector(
                        selected: _snoozeDuration,
                        onChanged: (v) =>
                            setState(() => _snoozeDuration = v),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),

              // ── Action Buttons ──────────────────────────
              Column(
                children: [
                  // Primary: I've Taken It
                  SizedBox(
                    width: double.infinity,
                    height: 80,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // TODO: mark as taken
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.check_circle,
                          size: 36, color: AppColors.white),
                      label: const Text(
                        "I'VE TAKEN IT",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 4,
                        shadowColor:
                            AppColors.primary.withValues(alpha: 0.3),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Secondary: Snooze + Skip
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 70,
                          child: OutlinedButton.icon(
                            onPressed: () {
                              // TODO: snooze with _snoozeDuration
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.snooze, size: 24),
                            label: const Text(
                              "Snooze",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              backgroundColor: AppColors.slate200,
                              foregroundColor: AppColors.slate900,
                              side: BorderSide(color: AppColors.slate300),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: SizedBox(
                          height: 70,
                          child: OutlinedButton.icon(
                            onPressed: () {
                              // TODO: skip dose
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.block,
                                size: 24,
                                color: Color(0xFFEF4444)),
                            label: Text(
                              "Skip Dose",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: AppColors.slate500,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              backgroundColor: AppColors.white,
                              side: BorderSide(
                                color: AppColors.slate200,
                                width: 2,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // ── Progress Indicator ──────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0; i < widget.totalDoses; i++) ...[
                        if (i > 0) const SizedBox(width: 4),
                        Container(
                          width: 32,
                          height: 6,
                          decoration: BoxDecoration(
                            color: i < widget.currentDose
                                ? AppColors.primary
                                : AppColors.slate200,
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ],
                      const SizedBox(width: 12),
                      Text(
                        "${widget.currentDose} OF ${widget.totalDoses} TODAY",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: AppColors.slate400,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
