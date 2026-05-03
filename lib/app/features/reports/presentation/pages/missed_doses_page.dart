import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/missed_dose_tile.dart';

class MissedDosesPage extends StatelessWidget {
  final List<dynamic> missedDoses;

  const MissedDosesPage({
    super.key,
    required this.missedDoses,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Missed Doses History"),
      ),
      body: missedDoses.isEmpty
          ? const Center(
              child: Text("No missed doses found."),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: missedDoses.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final dose = missedDoses[index];
                return MissedDoseTile(
                  medicineName: dose.medicineName,
                  dateTime: DateFormat('MMM d, yyyy - h:mm a').format(dose.scheduledTime),
                );
              },
            ),
    );
  }
}
