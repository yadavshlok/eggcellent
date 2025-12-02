import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../utils/colors.dart';
import '../../utils/text_styles.dart';
import '../../widgets/common_app_bar.dart';
import '../utils/app_constants.dart';

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
            // Wallet Balance Card
            Container(
              margin: EdgeInsets.all(4.w),
              padding: EdgeInsets.all(5.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.warning],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: AppConstants.lightShadow,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Balance',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.white.withOpacity(0.9),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    '₹12,450.00',
                    style: AppTextStyles.headline1.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    '+12.5% this month',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.white.withOpacity(0.8),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.white,
                            foregroundColor: AppColors.primary,
                            padding: EdgeInsets.symmetric(vertical: 1.5.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Text(
                            'Withdraw',
                            style: AppTextStyles.subheading2.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: AppColors.white, width: 2),
                            foregroundColor: AppColors.white,
                            padding: EdgeInsets.symmetric(vertical: 1.5.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Text(
                            'Add Funds',
                            style: AppTextStyles.subheading2.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Stats Cards
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      'Total Income',
                      '₹45,200.00',
                      AppColors.success,
                    ),
                  ),
                  SizedBox(width: 3.w),
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
            SizedBox(height: 3.h),

            // Recent Transactions Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Recent Transactions', style: AppTextStyles.headline4),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'View All',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Transactions List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              itemCount: 5,
              itemBuilder: (context, index) {
                final isCredit = index % 2 == 0;
                return Container(
                  margin: EdgeInsets.only(bottom: 2.h),
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: AppConstants.lightShadow,
                  ),
                  child: Row(
                    children: [
                      // Icon
                      Container(
                        padding: EdgeInsets.all(3.w),
                        decoration: BoxDecoration(
                          color: isCredit
                              ? AppColors.success.withOpacity(0.1)
                              : AppColors.error.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Icon(
                          isCredit ? Icons.arrow_downward : Icons.arrow_upward,
                          color: isCredit ? AppColors.success : AppColors.error,
                          size: 6.w,
                        ),
                      ),
                      SizedBox(width: 3.w),

                      // Transaction Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isCredit
                                  ? 'Payment Received'
                                  : 'Withdrawal to Bank',
                              style: AppTextStyles.subheading2,
                            ),
                            SizedBox(height: 0.3.h),
                            Text(
                              'Nov ${30 - index}, 2025',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.textGrey,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Amount
                      Text(
                        '${isCredit ? '+' : '-'}₹${(index + 1) * 500}.00',
                        style: AppTextStyles.subheading2.copyWith(
                          color: isCredit ? AppColors.success : AppColors.error,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: AppConstants.lightShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textGrey,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            value,
            style: AppTextStyles.headline4.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
