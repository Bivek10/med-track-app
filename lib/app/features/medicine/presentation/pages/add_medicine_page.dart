import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

import '../../../../core/config/theme/app_colors.dart';
import '../../../../shared/widgets/atoms/input_field.dart';
import '../widgets/frequency_selector.dart';
import '../widgets/reminder_time_chip.dart';

class AddMedicinePage extends StatefulWidget {
  const AddMedicinePage({super.key});

  @override
  State<AddMedicinePage> createState() => _AddMedicinePageState();
}

class _AddMedicinePageState extends State<AddMedicinePage> {
  final _formKey = GlobalKey<FormBuilderState>();
  String _selectedFrequency = "Once daily";
  final List<TimeOfDay> _reminderTimes = [const TimeOfDay(hour: 8, minute: 0)];
  DateTime? _startDate;
  DateTime? _endDate;

  String _formatTime(TimeOfDay t) {
    final hour = t.hourOfPeriod == 0 ? 12 : t.hourOfPeriod;
    final minute = t.minute.toString().padLeft(2, '0');
    final period = t.period == DayPeriod.am ? "AM" : "PM";
    return "$hour:$minute $period";
  }

  void _addReminderTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 12, minute: 0),
    );
    if (picked != null) {
      setState(() => _reminderTimes.add(picked));
    }
  }

  void _removeReminderTime(int index) {
    setState(() => _reminderTimes.removeAt(index));
  }

  Future<void> _pickDate({required bool isStart}) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add New Medicine")),
      body: Column(
        children: [
          // ── Scrollable Form ───────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              child: FormBuilder(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── Basic Info ─────────────────────────
                      AppFormField(
                        name: "medicine_name",
                        label: "Medicine Name",
                        hintText: "e.g. Ibuprofen",
                        prefixIcon: Icons.medication_outlined,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 16),

                      // Type + Dosage side by side
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: Text(
                                    "Type",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.slate700,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                FormBuilderDropdown<String>(
                                  name: "medicine_type",
                                  initialValue: "Tablet",
                                  decoration: const InputDecoration(
                                    hintText: "Select type",
                                  ),
                                  items: const [
                                    DropdownMenuItem(
                                        value: "Tablet",
                                        child: Text("Tablet")),
                                    DropdownMenuItem(
                                        value: "Liquid",
                                        child: Text("Liquid")),
                                    DropdownMenuItem(
                                        value: "Capsule",
                                        child: Text("Capsule")),
                                    DropdownMenuItem(
                                        value: "Injection",
                                        child: Text("Injection")),
                                    DropdownMenuItem(
                                        value: "Topical",
                                        child: Text("Topical")),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: AppFormField(
                              name: "dosage",
                              label: "Dosage",
                              hintText: "e.g. 200mg",
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),
                      Divider(color: AppColors.slate100),
                      const SizedBox(height: 24),

                      // ── Schedule Section ───────────────────
                      Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Text(
                          "SCHEDULE",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.5,
                            color: AppColors.slate400,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Frequency
                      Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Text(
                          "Frequency",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.slate700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      FrequencySelector(
                        selected: _selectedFrequency,
                        onChanged: (v) =>
                            setState(() => _selectedFrequency = v),
                      ),
                      const SizedBox(height: 20),

                      // Reminder Times
                      Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Text(
                          "Reminder Times",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.slate700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          for (int i = 0; i < _reminderTimes.length; i++)
                            ReminderTimeChip(
                              time: _formatTime(_reminderTimes[i]),
                              onRemove: () => _removeReminderTime(i),
                            ),
                          AddTimeButton(onTap: _addReminderTime),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Start / End Date
                      Row(
                        children: [
                          Expanded(
                            child: _DateField(
                              label: "Start Date",
                              value: _startDate,
                              placeholder: "Select date",
                              onTap: () => _pickDate(isStart: true),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _DateField(
                              label: "End Date",
                              value: _endDate,
                              placeholder: "Ongoing",
                              onTap: () => _pickDate(isStart: false),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),
                      Divider(color: AppColors.slate100),
                      const SizedBox(height: 24),

                      // ── Notes ──────────────────────────────
                      AppFormField(
                        name: "notes",
                        label: "Notes",
                        hintText:
                            "Take after food. Avoid dairy products...",
                        maxLines: 3,
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ── Fixed Save Button ─────────────────────────────
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border(
                top: BorderSide(color: AppColors.slate100),
              ),
            ),
            child: SafeArea(
              top: false,
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState?.saveAndValidate() ?? false) {
                      // TODO: save medicine
                      Navigator.pop(context);
                    }
                  },
                  icon: const Icon(Icons.save, color: AppColors.white),
                  label: const Text(
                    "Save Medicine",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A tappable date field that shows a label and formatted date.
class _DateField extends StatelessWidget {
  final String label;
  final DateTime? value;
  final String placeholder;
  final VoidCallback onTap;

  const _DateField({
    required this.label,
    required this.value,
    required this.placeholder,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.slate700,
            ),
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.slate50,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.slate200),
            ),
            child: Text(
              value != null
                  ? DateFormat('MMM d, yyyy').format(value!)
                  : placeholder,
              style: TextStyle(
                fontSize: 16,
                color: value != null ? AppColors.slate900 : AppColors.slate400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
