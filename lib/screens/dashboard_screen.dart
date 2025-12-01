import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../utils/colors.dart';
import '../../utils/text_styles.dart';
import '../../widgets/primary_button.dart';
import '../utils/app_constants.dart';

class FarmerDashboardScreen extends StatelessWidget {
  const FarmerDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: AppTextStyles.headline3.copyWith(color: Colors.white),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(4.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 1.h),
              Text(
                'Recent Activity',
                style: AppTextStyles.headline3,
              ),
              SizedBox(height: 2.h),

              // Activity Item 1
              _buildActivityCard(
                'Batch A-001',
                'Brown Eggs',
                'Completed',
                AppColors.success,
                '120 eggs',
                '₹2,400',
              ),
              SizedBox(height: 1.5.h),

              // Activity Item 2
              _buildActivityCard(
                'Batch A-002',
                'White Eggs',
                'In Progress',
                AppColors.warning,
                '150 eggs',
                '₹2,850',
              ),
              SizedBox(height: 1.5.h),

              // Activity Item 3
              _buildActivityCard(
                'Batch A-003',
                'Organic Eggs',
                'Pending',
                AppColors.info,
                '100 eggs',
                '₹2,500',
              ),
              SizedBox(height: 1.5.h),

              // Activity Item 4
              _buildActivityCard(
                'Batch A-004',
                'Desi Eggs',
                'Delivered',
                AppColors.success,
                '180 eggs',
                '₹3,240',
              ),
              SizedBox(height: 1.5.h),

              // Activity Item 5
              _buildActivityCard(
                'Batch A-005',
                'Free Range Eggs',
                'Ready to Ship',
                AppColors.warning,
                '200 eggs',
                '₹4,000',
              ),
              SizedBox(height: 3.h),

              // Quick Actions
              Text(
                'Quick Actions',
                style: AppTextStyles.headline4,
              ),
              SizedBox(height: 1.5.h),

              Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      label: 'Add Batch',
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(width: 2.w),
                  Expanded(
                    child: PrimaryButton(
                      label: 'View Orders',
                      onPressed: () {},
                      isOutlined: true,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivityCard(
      String batchId,
      String type,
      String status,
      Color statusColor,
      String quantity,
      String price,
      ) {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: AppConstants.lightShadow,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 12.w,
                height: 12.w,
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Icon(Icons.egg, color: statusColor, size: 6.w),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      batchId,
                      style: AppTextStyles.subheading2,
                    ),
                    Text(
                      type,
                      style: AppTextStyles.bodySmall,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2.5.w, vertical: 0.6.h),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  status,
                  style: AppTextStyles.labelSmall.copyWith(color: statusColor),
                ),
              ),
            ],
          ),
          Divider(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                quantity,
                style: AppTextStyles.bodyMedium,
              ),
              Text(
                price,
                style: AppTextStyles.subheading2.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
