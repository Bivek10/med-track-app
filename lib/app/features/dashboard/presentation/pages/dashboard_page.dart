import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/routes/route_path.dart';
import '../../../../core/config/theme/app_colors.dart';
import '../../../../injector.dart';
import '../bloc/dashboard_bloc.dart';
import '../bloc/dashboard_event.dart';
import '../bloc/dashboard_state.dart';
import '../widgets/adherence_card.dart';
import '../widgets/medicine_card.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late DashboardBloc _dashboardBloc;

  @override
  void initState() {
    super.initState();
    _dashboardBloc = inject<DashboardBloc>()..add(LoadDashboardData());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _dashboardBloc,
      child: Scaffold(
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
      body: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state is DashboardLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is DashboardError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Failed to load dashboard',
                    style: TextStyle(color: AppColors.slate600, fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<DashboardBloc>().add(LoadDashboardData());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is DashboardLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<DashboardBloc>().add(LoadDashboardData());
                await context.read<DashboardBloc>().stream.firstWhere((s) => s is! DashboardLoading);
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Adherence Card ──────────────────────────────
                  AdherenceCard(
                    takenCount: state.adherence.takenCount,
                    totalCount: state.adherence.totalCount,
                    message: state.adherence.message,
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

            const SizedBox(height: 16),

            // ── Medicine Cards ──────────────────────────────
            if (state.intakes.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Text(
                    "No medicines scheduled for today.",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              )
            else
              ...state.intakes.map((intake) {
                MedicineStatus status;
                switch (intake.status.toLowerCase()) {
                  case 'taken':
                    status = MedicineStatus.taken;
                    break;
                  case 'missed':
                    status = MedicineStatus.missed;
                    break;
                  case 'pending':
                  case 'snoozed':
                  default:
                    status = MedicineStatus.upcoming; // Simplification, could use 'later' based on time
                    break;
                }

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: MedicineCard(
                    time: intake.time,
                    name: intake.medicineName,
                    dosage: intake.dosage,
                    instruction: intake.instruction ?? 'No instruction',
                    status: status,
                    onTake: status == MedicineStatus.upcoming
                        ? () {
                            context
                                .read<DashboardBloc>()
                                .add(UpdateIntakeStatusEvent(id: intake.id, status: 'taken'));
                          }
                        : null,
                    onSkip: status == MedicineStatus.upcoming
                        ? () {
                            context
                                .read<DashboardBloc>()
                                .add(UpdateIntakeStatusEvent(id: intake.id, status: 'missed'));
                          }
                        : null,
                  ),
                );
              }),

            const SizedBox(height: 16),

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

    return const SizedBox();
  },
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
