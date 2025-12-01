import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../utils/colors.dart';
import '../../utils/text_styles.dart';
import '../../widgets/common_app_bar.dart';

class FarmerOrdersScreen extends StatelessWidget {
  const FarmerOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CommonAppBar(
        title: 'Incoming Orders',
        showBackButton: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.w),
        itemCount: 5,
        itemBuilder: (context, index) {
          return ExpansionTile(
            tilePadding: EdgeInsets.zero,
            childrenPadding: EdgeInsets.all(12.w),
            collapsedBackgroundColor: AppColors.white,
            backgroundColor: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            collapsedShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            title: Container(
              padding: EdgeInsets.all(12.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order #${8 - index}',
                        style: AppTextStyles.subheading2,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '11/30/2025 - Customer Name',
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                  Text(
                    '₹${(index + 1) * 240}.00',
                    style: AppTextStyles.headline4.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            children: [
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: AppColors.grey100,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Order Details', style: AppTextStyles.labelLarge),
                    SizedBox(height: 8.h),
                    Text('12 Brown Eggs', style: AppTextStyles.bodyMedium),
                    SizedBox(height: 4.h),
                    Text(
                      'Delivery: 123 Street, City',
                      style: AppTextStyles.caption,
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.success,
                            ),
                            child: const Text('Accept'),
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
                            child: const Text('Reject'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
