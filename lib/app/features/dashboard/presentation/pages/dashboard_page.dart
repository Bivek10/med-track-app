import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/routes/route_path.dart';
import '../../../../core/config/theme/app_colors.dart';
import '../widgets/adherence_card.dart';
import '../widgets/medicine_card.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Icon(Icons.medication, color: AppColors.primary, size: 32),
            const SizedBox(width: 10),
            const Text("MedTrack"),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.slate100,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.notifications_outlined, size: 24),
              color: AppColors.slate900,
              onPressed: () {
                context.push(AppPage.reminder.toPath);
                // TODO: notifications
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Adherence Card ──────────────────────────────
            const AdherenceCard(
              takenCount: 3,
              totalCount: 4,
              message: "You're doing great! Only 1 pill left for today.",
            ),

            const SizedBox(height: 32),

            // ── Today's Schedule Header ─────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Today's Schedule",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  _formattedDate(),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // ── Medicine Cards ──────────────────────────────
            const MedicineCard(
              time: "08:00 AM",
              name: "Aspirin",
              dosage: "100mg",
              instruction: "After Meal",
              status: MedicineStatus.taken,
            ),
            const SizedBox(height: 16),

            const MedicineCard(
              time: "12:30 PM",
              name: "Metformin",
              dosage: "500mg",
              instruction: "With Meal",
              status: MedicineStatus.missed,
            ),
            const SizedBox(height: 16),

            MedicineCard(
              time: "06:00 PM",
              name: "Lisinopril",
              dosage: "10mg",
              instruction: "Before Meal",
              status: MedicineStatus.upcoming,
              onTake: () {
                // TODO: mark as taken
              },
              onSkip: () {
                // TODO: skip dose
              },
            ),
            const SizedBox(height: 16),

            const MedicineCard(
              time: "10:00 PM",
              name: "Atorvastatin",
              dosage: "20mg",
              instruction: "Before Bed",
              status: MedicineStatus.later,
            ),

            const SizedBox(height: 32),

            // ── Add New Medicine Button ─────────────────────
            SizedBox(
              width: double.infinity,
              height: 72,
              child: OutlinedButton.icon(
                onPressed: () {
                  context.pushNamed(AppPage.addMedicine.toName);
                },
                icon: Icon(
                  Icons.add_circle_outline,
                  color: AppColors.primary,
                  size: 28,
                ),
                label: const Text(
                  "Add New Medicine",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                  side: BorderSide(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  String _formattedDate() {
    final now = DateTime.now();
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December',
    ];
    return "${months[now.month - 1]} ${now.day}";
  }
}
