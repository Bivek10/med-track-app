import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../core/config/theme/app_colors.dart';
import '../../../../injector.dart';
import '../../../../shared/widgets/atoms/input_field.dart';
import '../../domain/entities/medicine_entity.dart';
import '../bloc/medicine_bloc.dart';
import '../widgets/frequency_selector.dart';
import '../widgets/reminder_time_chip.dart';

class AddMedicinePage extends StatefulWidget {
  final MedicineEntity? medicine;

  const AddMedicinePage({super.key, this.medicine});

  @override
  State<AddMedicinePage> createState() => _AddMedicinePageState();
}

class _AddMedicinePageState extends State<AddMedicinePage> {
  final _formKey = GlobalKey<FormBuilderState>();
  late String _selectedFrequency;

  late List<TimeOfDay> _reminderTimes;
  DateTime? _startDate;
  DateTime? _endDate;
  final List<int> _selectedDays = [];

  bool get isEditMode => widget.medicine != null;

  @override
  void initState() {
    super.initState();
    _selectedFrequency = _mapFrequencyToUI(widget.medicine?.frequencyType ?? "once_daily");
    
    _reminderTimes = widget.medicine?.reminderTimes
        .map((e) {
          final parts = e.split(':');
          return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
        })
        .toList() ??
        [const TimeOfDay(hour: 8, minute: 0)];

    if (widget.medicine?.daysOfWeek != null) {
      _selectedDays.addAll(widget.medicine!.daysOfWeek);
    }
  }

  String _mapFrequencyToUI(String apiFreq) {
    switch (apiFreq) {
      case "daily":
        return "Once daily";
      case "specific_days":
        return "Custom";
      case "as_needed":
        return "Custom";
      default:
        return "Once daily";
    }
  }

  String _mapFrequencyToApi(String uiFreq) {
    if (uiFreq == "Once daily") return "daily";
    if (uiFreq == "Twice daily") return "daily";
    if (uiFreq == "Custom") return "specific_days";
    return "daily";
  }

  String _formatTime(TimeOfDay t) {
    final hour = t.hourOfPeriod == 0 ? 12 : t.hourOfPeriod;
    final minute = t.minute.toString().padLeft(2, '0');
    final period = t.period == DayPeriod.am ? "AM" : "PM";
    return "$hour:$minute $period";
  }

  String _formatTimeApi(TimeOfDay t) {
    return "${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}";
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
    return BlocProvider(
      create: (context) => inject<MedicineBloc>(),
      child: BlocListener<MedicineBloc, MedicineState>(
        listener: (context, state) {
          if (state is MedicineActionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: Colors.green),
            );
            Navigator.pop(context, true);
          } else if (state is MedicineFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: Colors.red),
            );
          }
        },
        child: BlocBuilder<MedicineBloc, MedicineState>(
          builder: (context, state) {
            final isLoading = state is MedicineActionInProgress;

            return Scaffold(
              appBar: AppBar(title: Text(isEditMode ? "Edit Medicine" : "Add New Medicine")),
              body: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: FormBuilder(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppFormField(
                                name: "name",
                                label: "Medicine Name",
                                hintText: "e.g. Ibuprofen",
                                initialValue: widget.medicine?.name,
                                prefixIcon: Icons.medication_outlined,
                                textInputAction: TextInputAction.next,
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 4),
                                          child: Text(
                                            "Form",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.slate700,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        FormBuilderDropdown<String>(
                                          name: "form",
                                          initialValue: widget.medicine?.form ?? "Tablet",
                                          decoration: const InputDecoration(
                                            hintText: "Select type",
                                          ),
                                          items: const [
                                            DropdownMenuItem(value: "Tablet", child: Text("Tablet")),
                                            DropdownMenuItem(value: "Liquid", child: Text("Liquid")),
                                            DropdownMenuItem(value: "Capsule", child: Text("Capsule")),
                                            DropdownMenuItem(value: "Injection", child: Text("Injection")),
                                            DropdownMenuItem(value: "Topical", child: Text("Topical")),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: AppFormField(
                                      name: "dosage",
                                      label: "Dosage (value)",
                                      initialValue: widget.medicine?.dosage,
                                      hintText: "e.g. 500",
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.next,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              AppFormField(
                                name: "unit",
                                label: "Unit",
                                initialValue: widget.medicine?.unit ?? "mg",
                                hintText: "e.g. mg, ml, IU",
                                textInputAction: TextInputAction.next,
                              ),
                              const SizedBox(height: 24),
                              Divider(color: AppColors.slate100),
                              const SizedBox(height: 24),
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
                                onChanged: (v) => setState(() => _selectedFrequency = v),
                              ),
                              if (_selectedFrequency == "Custom") ...[
                                const SizedBox(height: 16),
                                Padding(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: Text(
                                    "Days of Week",
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
                                  children: [
                                    for (int i = 1; i <= 7; i++)
                                      FilterChip(
                                        label: Text(["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"][i - 1]),
                                        selected: _selectedDays.contains(i),
                                        onSelected: (selected) {
                                          setState(() {
                                            if (selected) {
                                              _selectedDays.add(i);
                                            } else {
                                              _selectedDays.remove(i);
                                            }
                                          });
                                        },
                                      ),
                                  ],
                                ),
                              ],
                              const SizedBox(height: 20),
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
                              const SizedBox(height: 24),
                              Divider(color: AppColors.slate100),
                              const SizedBox(height: 24),
                              AppFormField(
                                name: "instructions",
                                label: "Instructions",
                                initialValue: widget.medicine?.instructions,
                                hintText: "e.g. Take with breakfast",
                                maxLines: 3,
                              ),
                              const SizedBox(height: 24),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      border: Border(top: BorderSide(color: AppColors.slate100)),
                    ),
                    child: SafeArea(
                      top: false,
                      child: SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () {
                                  if (_formKey.currentState?.saveAndValidate() ?? false) {
                                    final values = _formKey.currentState!.value;
                                    final data = {
                                      "name": values['name'],
                                      "dosage": values['dosage'],
                                      "unit": values['unit'],
                                      "form": values['form'],
                                      "frequencyType":
                                          _mapFrequencyToApi(_selectedFrequency),
                                      "daysOfWeek": _selectedFrequency == "Custom"
                                          ? _selectedDays
                                          : [],
                                      "reminderTimes": _reminderTimes
                                          .map((e) => _formatTimeApi(e))
                                          .toList(),
                                      "instructions": values['instructions'],
                                    };

                                    if (isEditMode) {
                                      context.read<MedicineBloc>().add(UpdateMedicine(widget.medicine!.id, data));
                                    } else {
                                      context.read<MedicineBloc>().add(AddMedicine(data));
                                    }
                                  }
                                },
                          child: isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(color: AppColors.white, strokeWidth: 2),
                                )
                              : Text(
                                  isEditMode ? "Update Medicine" : "Save Medicine",
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                                ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

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
              value != null ? DateFormat('MMM d, yyyy').format(value!) : placeholder,
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
