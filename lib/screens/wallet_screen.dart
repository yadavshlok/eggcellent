import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../utils/colors.dart';
import '../../utils/text_styles.dart';
import '../../widgets/common_app_bar.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CommonAppBar(
        title: 'My Wallet',
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(16.w),
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.warning],
                ),
                borderRadius: BorderRadius.circular(16.h),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Balance',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    '₹12,450.00',
                    style: AppTextStyles.headline1.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '+12.5% this month',
                    style: AppTextStyles.labelMedium.copyWith(
                      color: AppColors.white.withOpacity(0.8),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.white,
                            foregroundColor: AppColors.primary,
                          ),
                          child: const Text('Withdraw'),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: AppColors.white),
                            foregroundColor: AppColors.white,
                          ),
                          child: const Text('Add Funds'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      'Total Income',
                      '₹45,200.00',
                      AppColors.success,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _buildStatCard(
                      'Total Withdrawn',
                      '₹32,750.00',
                      AppColors.info,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Recent Transactions', style: AppTextStyles.headline4),
                  TextButton(
                    onPressed: () {},
                    child: const Text('View All'),
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 12.h),
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12.h),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: index % 2 == 0
                              ? AppColors.success.withOpacity(0.1)
                              : AppColors.error.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8.h),
                        ),
                        child: Icon(
                          index % 2 == 0
                              ? Icons.arrow_downward
                              : Icons.arrow_upward,
                          color:
                          index % 2 == 0 ? AppColors.success : AppColors.error,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              index % 2 == 0
                                  ? 'Payment for Batch'
                                  : 'Withdrawal to Bank',
                              style: AppTextStyles.subheading2,
                            ),
                            Text(
                              'Nov ${30 - index}, 2025',
                              style: AppTextStyles.caption,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '${index % 2 == 0 ? '+' : '-'}₹${(index + 1) * 500}.00',
                        style: AppTextStyles.subheading2.copyWith(
                          color:
                          index % 2 == 0 ? AppColors.success : AppColors.error,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.h),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyles.labelMedium),
          SizedBox(height: 8.h),
          Text(
            value,
            style: AppTextStyles.headline4.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
