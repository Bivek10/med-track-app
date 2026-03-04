import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/config/theme/app_colors.dart';

/// Status indicator for a calendar day.
enum DayStatus { allTaken, someMissed, allMissed, none }

/// A monthly calendar grid with coloured status dots for each day.
class IntakeCalendar extends StatelessWidget {
  final DateTime displayedMonth;
  final DateTime selectedDate;
  final Map<int, DayStatus> dayStatuses;
  final ValueChanged<DateTime> onDayTap;
  final VoidCallback onPreviousMonth;
  final VoidCallback onNextMonth;

  const IntakeCalendar({
    super.key,
    required this.displayedMonth,
    required this.selectedDate,
    required this.dayStatuses,
    required this.onDayTap,
    required this.onPreviousMonth,
    required this.onNextMonth,
  });

  static const _weekDays = ["S", "M", "T", "W", "T", "F", "S"];

  Color _dotColor(DayStatus status) {
    switch (status) {
      case DayStatus.allTaken:
        return const Color(0xFF10B981);
      case DayStatus.someMissed:
        return const Color(0xFFF59E0B);
      case DayStatus.allMissed:
        return const Color(0xFFEF4444);
      case DayStatus.none:
        return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    final year = displayedMonth.year;
    final month = displayedMonth.month;
    final daysInMonth = DateUtils.getDaysInMonth(year, month);
    final firstWeekday = DateTime(year, month, 1).weekday % 7; // Sun = 0

    final monthLabel = DateFormat('MMMM yyyy').format(displayedMonth);

    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Month nav row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: onPreviousMonth,
                icon: const Icon(Icons.chevron_left),
              ),
              Text(
                monthLabel,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              IconButton(
                onPressed: onNextMonth,
                icon: const Icon(Icons.chevron_right),
              ),
            ],
          ),
          const SizedBox(height: 4),

          // Weekday labels
          Row(
            children: _weekDays
                .map(
                  (d) => Expanded(
                    child: Center(
                      child: Text(
                        d,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: AppColors.slate400,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 4),

          // Calendar grid
          GridView.count(
            crossAxisCount: 7,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              // Leading empty cells for days before month starts
              for (int i = 0; i < firstWeekday; i++)
                const SizedBox.shrink(),

              // Actual days
              for (int day = 1; day <= daysInMonth; day++)
                _DayCell(
                  day: day,
                  isSelected: selectedDate.year == year &&
                      selectedDate.month == month &&
                      selectedDate.day == day,
                  status: dayStatuses[day] ?? DayStatus.none,
                  dotColor: _dotColor(dayStatuses[day] ?? DayStatus.none),
                  onTap: () => onDayTap(DateTime(year, month, day)),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DayCell extends StatelessWidget {
  final int day;
  final bool isSelected;
  final DayStatus status;
  final Color dotColor;
  final VoidCallback onTap;

  const _DayCell({
    required this.day,
    required this.isSelected,
    required this.status,
    required this.dotColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: isSelected
            ? BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              )
            : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$day",
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? AppColors.primary : null,
              ),
            ),
            const SizedBox(height: 3),
            if (status != DayStatus.none)
              Container(
                width: isSelected ? 6 : 4,
                height: isSelected ? 6 : 4,
                decoration: BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                ),
              )
            else
              SizedBox(height: isSelected ? 6 : 4),
          ],
        ),
      ),
    );
  }
}
