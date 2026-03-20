import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/routes/route_path.dart';
import '../../../../core/config/theme/app_colors.dart';

class MedicineListPage extends StatelessWidget {
  const MedicineListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            icon: const Icon(Icons.notifications, color: AppColors.slate500),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: AppColors.slate500),
            onPressed: () {},
          ),
          SizedBox(width: 8.w),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchSection(),
              SizedBox(height: 24.h),
              _buildActiveMedicationsSection(),
              SizedBox(height: 24.h),
              _buildPastMedicationsSection(),
              SizedBox(height: 24.h),
              _buildAddNewMedicineButton(context),
              SizedBox(height: 80.h), // Padding for bottom nav & FAB
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => context.pushNamed(AppPage.addMedicine.toName),
      //   backgroundColor: AppColors.primary,
      //   foregroundColor: AppColors.white,
      //   elevation: 4,
      //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      //   child: const Icon(Icons.add, size: 28),
      // ),
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
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(0, 0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              'FILTER',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 12.sp,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveMedicationsSection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Active Medications',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.slate900,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: AppColors.primary[50], // primary-container
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Text(
                '3 ACTIVE',
                style: TextStyle(
                  color: AppColors.primary[800], // on-primary-container
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        _buildMedicationCard(
          name: 'Amoxicillin',
          description: 'Antibiotic • Infection',
          icon: Icons.medication,
          dosage: '500mg',
          form: 'Tablet',
          freq: '3x Daily',
          nextDoseInfo: 'Next dose in 2h 15m',
        ),
        SizedBox(height: 12.h),
        _buildMedicationCard(
          name: 'Lisinopril',
          description: 'BP Management',
          icon: Icons.medication_liquid,
          dosage: '10mg',
          form: 'Tablet',
          freq: '1x Daily',
        ),
        SizedBox(height: 12.h),
        _buildMedicationCard(
          name: 'Vitamin D3',
          description: 'Supplement',
          icon: Icons.star,
          dosage: '2000IU',
          form: 'Softgel',
          freq: '1x Daily',
        ),
      ],
    );
  }

  Widget _buildMedicationCard({
    required String name,
    required String description,
    required IconData icon,
    required String dosage,
    required String form,
    required String freq,
    String? nextDoseInfo,
  }) {
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
                  child: Icon(icon, color: AppColors.primary, size: 24.sp),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.slate900,
                      ),
                    ),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.slate500,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.more_vert, color: AppColors.slate400),
            ],
          ),
          SizedBox(height: 24.h),
          Row(
            children: [
              _buildInfoBox('DOSAGE', dosage),
              SizedBox(width: 8.w),
              _buildInfoBox('FORM', form),
              SizedBox(width: 8.w),
              _buildInfoBox('FREQ', freq),
            ],
          ),
          if (nextDoseInfo != null) ...[
            SizedBox(height: 16.h),
            Divider(color: AppColors.slate100),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.event_repeat, color: AppColors.error, size: 16.sp),
                    SizedBox(width: 8.w),
                    Text(
                      nextDoseInfo,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.slate500,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 96.w,
                  height: 6.h,
                  decoration: BoxDecoration(
                    color: AppColors.slate200,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: 0.66,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
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

  Widget _buildPastMedicationsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Completed / Past',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.slate900,
          ),
        ),
        SizedBox(height: 12.h),
        Opacity(
          opacity: 0.7,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            padding: EdgeInsets.all(16.r),
            child: Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: AppColors.slate100,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Center(
                    child: Icon(Icons.history, color: AppColors.slate500, size: 20.sp),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ibuprofen',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.slate900,
                        ),
                      ),
                      Text(
                        'Completed on Oct 12, 2023',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.slate500,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: AppColors.slate400),
              ],
            ),
          ),
        ),
      ],
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
            style: BorderStyle.solid, // Note: Flutter doesn't natively support dashed borders without custom painters/packages
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
              child: Center(
                child: Icon(Icons.add, color: AppColors.primary),
              ),
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
