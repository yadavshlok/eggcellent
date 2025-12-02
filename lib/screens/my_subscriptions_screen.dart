import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../controllers/subscription_controller.dart';
import '../../utils/colors.dart';
import '../../utils/text_styles.dart';
import '../../widgets/common_app_bar.dart';
import '../utils/app_constants.dart';

class MySubscriptionsScreen extends StatelessWidget {
  const MySubscriptionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SubscriptionController());

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CommonAppBar(
        title: 'My Subscriptions',
        showBackButton: true,
      ),
      body: Obx(
            () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : controller.subscriptions.isEmpty
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.subscriptions_outlined,
                size: 20.w,
                color: AppColors.textGrey,
              ),
              SizedBox(height: 2.h),
              Text(
                'No active subscriptions',
                style: AppTextStyles.headline4.copyWith(
                  color: AppColors.textGrey,
                ),
              ),
            ],
          ),
        )
            : RefreshIndicator(
          onRefresh: () async => controller.refreshSubscriptions(),
          child: ListView.builder(
            padding: EdgeInsets.all(4.w),
            itemCount: controller.subscriptions.length,
            itemBuilder: (context, index) {
              final subscription = controller.subscriptions[index];
              return Container(
                margin: EdgeInsets.only(bottom: 2.h),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border(
                    left: BorderSide(
                      color: _getStatusBorderColor(
                          subscription.status),
                      width: 4,
                    ),
                  ),
                  boxShadow: AppConstants.lightShadow,
                ),
                child: Padding(
                  padding: EdgeInsets.all(4.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              subscription.farmName,
                              style: AppTextStyles.subheading2,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 3.w,
                              vertical: 0.5.h,
                            ),
                            decoration: BoxDecoration(
                              color: _getStatusColor(
                                  subscription.status)
                                  .withOpacity(0.1),
                              borderRadius:
                              BorderRadius.circular(12.0),
                            ),
                            child: Text(
                              subscription.status,
                              style: AppTextStyles.labelSmall
                                  .copyWith(
                                color: _getStatusColor(
                                    subscription.status),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.h),

                      // Subscription Details
                      _buildInfoRow('Frequency',
                          subscription.frequency.toUpperCase()),
                      SizedBox(height: 1.h),
                      _buildInfoRow('Eggs per delivery',
                          '${subscription.quantityPerDelivery} eggs'),
                      SizedBox(height: 1.h),
                      _buildInfoRow('Next delivery',
                          _formatDate(subscription.nextDelivery)),
                      SizedBox(height: 1.h),
                      _buildInfoRow('Price per order',
                          '₹${subscription.pricePerOrder.toStringAsFixed(2)}'),
                      SizedBox(height: 2.h),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: subscription.status ==
                                  'Paused'
                                  ? null
                                  : () => controller.pauseSubscription(
                                  subscription.id),
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                    color: AppColors.warning),
                                foregroundColor: AppColors.warning,
                                padding: EdgeInsets.symmetric(
                                    vertical: 1.2.h),
                              ),
                              child: Text(
                                'Pause',
                                style: AppTextStyles.bodyMedium
                                    .copyWith(
                                  color: subscription.status ==
                                      'Paused'
                                      ? AppColors.textGrey
                                      : AppColors.warning,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 3.w),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => controller
                                  .cancelSubscription(
                                  subscription.id),
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                    color: AppColors.error),
                                foregroundColor: AppColors.error,
                                padding: EdgeInsets.symmetric(
                                    vertical: 1.2.h),
                              ),
                              child: Text(
                                'Cancel',
                                style: AppTextStyles.bodyMedium
                                    .copyWith(
                                  color: AppColors.error,
                                ),
                              ),
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
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textGrey,
          ),
        ),
        Text(
          value,
          style: AppTextStyles.subheading2,
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return AppColors.success;
      case 'paused':
        return AppColors.warning;
      case 'cancelled':
        return AppColors.error;
      default:
        return AppColors.textGrey;
    }
  }

  Color _getStatusBorderColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return AppColors.success;
      case 'paused':
        return AppColors.warning;
      case 'cancelled':
        return AppColors.error;
      default:
        return AppColors.border;
    }
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}
