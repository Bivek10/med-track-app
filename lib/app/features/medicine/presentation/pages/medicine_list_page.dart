import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';


import '../../../../core/config/routes/route_path.dart';
import '../../../../core/config/theme/app_colors.dart';
import '../../../../injector.dart';
import '../../domain/entities/medicine_entity.dart';
import '../bloc/medicine_bloc.dart';

class MedicineListPage extends StatefulWidget {
  const MedicineListPage({super.key});

  @override
  State<MedicineListPage> createState() => _MedicineListPageState();
}

class _MedicineListPageState extends State<MedicineListPage> {
  final ScrollController _scrollController = ScrollController();
  late MedicineBloc _medicineBloc;

  @override
  void initState() {
    super.initState();
    _medicineBloc = inject<MedicineBloc>()..add(const FetchMedicines(refresh: true));
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      _medicineBloc.add(const FetchMedicines());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _medicineBloc,
      child: Scaffold(
        backgroundColor: AppColors.backgroundLight,
        appBar: AppBar(
          backgroundColor: AppColors.white.withOpacity(0.9),
          elevation: 0,
          scrolledUnderElevation: 0,
          title: Row(
            children: [
              Icon(Icons.medical_services, color: AppColors.primary, size: 24.sp),
              SizedBox(width: 8.w),
              Text(
                'MedTrack',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings, color: AppColors.slate500),
              onPressed: () {
                context.pushNamed(AppPage.reminder.toName);
              },
            ),
            SizedBox(width: 8.w),
          ],
        ),
        body: SafeArea(
          child: RefreshIndicator(
         
          onRefresh: () async { _medicineBloc.add(const FetchMedicines(refresh: true)); },
            child: BlocBuilder<MedicineBloc, MedicineState>(
              builder: (context, state) {
                if (state is MedicineLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is MedicineFailure && state is! MedicineLoaded) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Error: ${state.message}"),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () =>
                              _medicineBloc.add(const FetchMedicines(refresh: true)),
                          child: const Text("Retry"),
                        ),
                      ],
                    ),
                  );
                }

                final medicines = state is MedicineLoaded
                    ? state.medicines
                    : <MedicineEntity>[];

                if (medicines.isEmpty && state is MedicineLoaded) {
                   return _buildEmptyState();
                }

                return ListView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  itemCount: state is MedicineLoaded && state.hasMore
                      ? medicines.length + 1
                      : medicines.length + 1, // +1 for search and headers or loader
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSearchSection(),
                          SizedBox(height: 24.h),
                          Text(
                            'Active Medications',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.slate900,
                            ),
                          ),
                          SizedBox(height: 16.h),
                        ],
                      );
                    }
                    
                    final medIndex = index - 1;
                    if (medIndex < medicines.length) {
                      final medicine = medicines[medIndex];
                      return Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: _buildMedicationCard(
                          context,
                          medicine: medicine,
                        ),
                      );
                    } else if (state is MedicineLoaded && state.hasMore) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    } else {
                       return Column(
                         children: [
                           SizedBox(height: 24.h),
                           _buildAddNewMedicineButton(context),
                            SizedBox(height: 80.h), 
                         ],
                       );
                    }
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
     return Center(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
            Icon(Icons.medication_outlined, size: 64.sp, color: AppColors.slate300),
            SizedBox(height: 16.h),
            Text(
              "No medicines added yet",
              style: TextStyle(fontSize: 16.sp, color: AppColors.slate500, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 24.h),
            _buildAddNewMedicineButton(context),
         ],
       ),
     );
  }

  Widget _buildSearchSection() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.slate200),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      child: Row(
        children: [
          Icon(Icons.search, color: AppColors.slate500, size: 20.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search your medications...',
                hintStyle: TextStyle(
                  color: AppColors.slate500,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicationCard(BuildContext context, {required MedicineEntity medicine}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.slate200.withOpacity(0.5),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.all(20.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: AppColors.primary[50],
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Center(
                  child: Icon(Icons.medication, color: AppColors.primary, size: 24.sp),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      medicine.name,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.slate900,
                      ),
                    ),
                    Text(
                      medicine.instructions ?? "No instructions",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.slate500,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'edit') {
                    context.pushNamed(AppPage.addMedicine.toName, extra: medicine);
                  } else if (value == 'delete') {
                     _medicineBloc.add(DeleteMedicine(medicine.id));
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(value: 'edit', child: Text("Edit")),
                  const PopupMenuItem(value: 'delete', child: Text("Delete")),
                ],
                icon: Icon(Icons.more_vert, color: AppColors.slate400),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          Row(
            children: [
              _buildInfoBox('DOSAGE', "${medicine.dosage}${medicine.unit}"),
              SizedBox(width: 8.w),
              _buildInfoBox('FORM', medicine.form),
              SizedBox(width: 8.w),
              _buildInfoBox('FREQ', _formatFrequency(medicine)),
            ],
          ),
        ],
      ),
    );
  }

  String _formatFrequency(MedicineEntity med) {
    if (med.frequencyType == 'once_daily') return "1x Daily";
    if (med.frequencyType == 'twice_daily') return "2x Daily";
    if (med.frequencyType == 'specific_days') return "${med.daysOfWeek.length} Target Days";
    return med.frequencyType;
  }

  Widget _buildInfoBox(String label, String value) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: AppColors.slate50,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.slate500,
                letterSpacing: 1,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              value,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.slate900,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddNewMedicineButton(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pushNamed(AppPage.addMedicine.toName),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 20.h),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.primary.withOpacity(0.3),
            width: 2,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          children: [
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: AppColors.primary[50],
                shape: BoxShape.circle,
              ),
              child: Center(child: Icon(Icons.add, color: AppColors.primary)),
            ),
            SizedBox(height: 8.h),
            Text(
              'ADD NEW MEDICINE',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
