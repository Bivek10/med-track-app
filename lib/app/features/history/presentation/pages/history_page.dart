import 'package:flutter/material.dart';

import '../../../../core/config/theme/app_colors.dart';
import '../widgets/history_log_item.dart';
import '../widgets/intake_calendar.dart';
import '../widgets/status_filter_chips.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late DateTime _displayedMonth;
  late DateTime _selectedDate;
  String _statusFilter = "All Statuses";
  final _searchController = TextEditingController();

  // Sample data – replace with real data from state management
  final Map<int, DayStatus> _dayStatuses = {
    1: DayStatus.allTaken,
    2: DayStatus.allTaken,
    3: DayStatus.allMissed,
    4: DayStatus.someMissed,
    5: DayStatus.someMissed,
  };

  @override
  void initState() {
    super.initState();
    _displayedMonth = DateTime(2023, 10);
    _selectedDate = DateTime(2023, 10, 5);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _goToPreviousMonth() {
    setState(() {
      _displayedMonth = DateTime(
        _displayedMonth.year,
        _displayedMonth.month - 1,
      );
    });
  }

  void _goToNextMonth() {
    setState(() {
      _displayedMonth = DateTime(
        _displayedMonth.year,
        _displayedMonth.month + 1,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Intake History"),
        actions: [
          IconButton(
            onPressed: () {
              // TODO: date picker shortcut
            },
            icon: const Icon(Icons.calendar_today),
          ),
        ],
      ),
      body: Column(
        children: [
          // ── Calendar ───────────────────────────────────
          IntakeCalendar(
            displayedMonth: _displayedMonth,
            selectedDate: _selectedDate,
            dayStatuses: _dayStatuses,
            onDayTap: (date) => setState(() => _selectedDate = date),
            onPreviousMonth: _goToPreviousMonth,
            onNextMonth: _goToNextMonth,
          ),

          // ── Search + Filters ───────────────────────────
          Container(
            color: AppColors.white,
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: Column(
              children: [
                // Search bar
                Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.slate100,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 16),
                      Icon(Icons.search, size: 20, color: AppColors.slate400),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: "Search medicines",
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                            isDense: true,
                            hintStyle: TextStyle(
                              fontSize: 14,
                              color: AppColors.slate400,
                            ),
                          ),
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // Filter chips
                StatusFilterChips(
                  selected: _statusFilter,
                  onChanged: (v) => setState(() => _statusFilter = v),
                ),
              ],
            ),
          ),

          // ── Daily Logs ─────────────────────────────────
          Expanded(
            child: Container(
              color: AppColors.backgroundLight,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Day header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "THURSDAY, OCT 5",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.slate500,
                            letterSpacing: 1,
                          ),
                        ),
                        Text(
                          "3 Doses Scheduled",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.slate400,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Log items
                    const HistoryLogItem(
                      medicineName: "Amoxicillin",
                      dosage: "500mg",
                      instruction: "After food",
                      status: LogStatus.taken,
                      timeInfo: "Taken at 8:05 AM",
                      scheduledTime: "8:00 AM",
                    ),
                    const HistoryLogItem(
                      medicineName: "Lisinopril",
                      dosage: "10mg",
                      instruction: "Morning",
                      status: LogStatus.missed,
                      timeInfo: "Missed at 2:00 PM",
                    ),
                    const HistoryLogItem(
                      medicineName: "Vitamin D3",
                      dosage: "2000 IU",
                      instruction: "With dinner",
                      status: LogStatus.scheduled,
                      timeInfo: "Upcoming: 8:00 PM",
                      showConnector: false,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
