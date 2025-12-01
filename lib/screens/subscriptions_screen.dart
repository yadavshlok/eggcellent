import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../utils/colors.dart';
import '../../utils/text_styles.dart';
import '../../widgets/common_app_bar.dart';

class FarmerSubscriptionsScreen extends StatelessWidget {
  const FarmerSubscriptionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CommonAppBar(
        title: 'Farm Subscriptions',
        showBackButton: true,
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16.w),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 12.h,
          childAspectRatio: 0.75,
        ),
        itemCount: 6,
        itemBuilder: (context, index) {
          return Container(
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
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'WEEKLY',
                      style: AppTextStyles.labelLarge.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.success.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8.0),
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
                Text('Customer ID: #${1000 + index}',
                    style: AppTextStyles.caption),
                SizedBox(height: 8.h),
                Text('12 eggs', style: AppTextStyles.bodyMedium),
                SizedBox(height: 4.h),
                Text('Next: Dec 08, 2025', style: AppTextStyles.caption),
                SizedBox(height: 8.h),
                Text(
                  '₹240.00',
                  style: AppTextStyles.headline4.copyWith(
                    color: AppColors.primary,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 4.h),
                          side: BorderSide(color: AppColors.warning),
                          foregroundColor: AppColors.warning,
                        ),
                        child: Text('Pause', style: TextStyle(fontSize: 10.sp)),
                      ),
                    ),
                    SizedBox(width: 6.w),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {},
                      color: AppColors.error,
                      iconSize: 18,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
