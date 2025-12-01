import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../utils/colors.dart';
import '../../utils/text_styles.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/primary_button.dart';
import '../utils/app_constants.dart';

class BatchesScreen extends StatelessWidget {
  const BatchesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CommonAppBar(
        title: 'Batches',
        showBackButton: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(4.w),
            child: PrimaryButton(
              label: 'Add New Batch',
              onPressed: () {},
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 2.h),
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: AppConstants.lightShadow,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Organic Brown Eggs',
                            style: AppTextStyles.subheading2,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 3.w,
                              vertical: 0.8.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.success.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              '92% Fresh',
                              style: AppTextStyles.labelSmall.copyWith(
                                color: AppColors.success,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.h),
                      Row(
                        children: [
                          _buildInfoChip('Laid: Nov 28', Icons.calendar_today),
                          SizedBox(width: 3.w),
                          _buildInfoChip('150 eggs left', Icons.egg),
                        ],
                      ),
                      SizedBox(height: 2.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '₹20/egg',
                            style: AppTextStyles.headline4.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {},
                                color: AppColors.primary,
                                iconSize: 5.w,
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {},
                                color: AppColors.error,
                                iconSize: 5.w,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(String label, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.2.h),
      decoration: BoxDecoration(
        color: AppColors.grey100,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 4.w, color: AppColors.grey600),
          SizedBox(width: 1.5.w),
          Text(
            label,
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.grey600,
            ),
          ),
        ],
      ),
    );
  }
}
