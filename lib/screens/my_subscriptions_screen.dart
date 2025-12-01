import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../utils/colors.dart';
import '../../utils/text_styles.dart';
import '../../widgets/common_app_bar.dart';

class MySubscriptionsScreen extends StatelessWidget {
  const MySubscriptionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CommonAppBar(
        title: 'My Subscriptions',
        showBackButton: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.w),
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(bottom: 16.h),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12.0),
              border: Border(
                left: BorderSide(
                  color: AppColors.success,
                  width: 4,
                ),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Sunny Acres Farm',
                        style: AppTextStyles.subheading2,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.success.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Text(
                          'Active',
                          style: AppTextStyles.labelSmall.copyWith(
                            color: AppColors.success,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  _buildInfoRow('Frequency', 'WEEKLY'),
                  SizedBox(height: 8.h),
                  _buildInfoRow('Eggs per delivery', '12 eggs'),
                  SizedBox(height: 8.h),
                  _buildInfoRow('Next delivery', 'Dec 08, 2025'),
                  SizedBox(height: 8.h),
                  _buildInfoRow('Price per order', '₹240.00'),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: AppColors.warning),
                            foregroundColor: AppColors.warning,
                          ),
                          child: const Text('Pause'),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: AppColors.error),
                            foregroundColor: AppColors.error,
                          ),
                          child: const Text('Cancel'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyles.bodyMedium),
        Text(
          value,
          style: AppTextStyles.labelLarge,
        ),
      ],
    );
  }
}
