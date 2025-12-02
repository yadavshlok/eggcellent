import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../utils/colors.dart';
import '../../utils/text_styles.dart';
import '../../widgets/common_app_bar.dart';
import '../controllers/farmer_subscription_controller.dart';
import '../utils/app_constants.dart';

class FarmerSubscriptionsScreen extends StatelessWidget {
  const FarmerSubscriptionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FarmerSubscriptionsController());

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CommonAppBar(
        title: 'Farm Subscriptions',
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
                'No subscriptions yet',
                style: AppTextStyles.headline4.copyWith(
                  color: AppColors.textGrey,
                ),
              ),
            ],
          ),
        )
            : RefreshIndicator(
          onRefresh: () async => controller.refreshSubscriptions(),
          child: GridView.builder(
            padding: EdgeInsets.all(4.w),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 3.w,
              mainAxisSpacing: 2.h,
              childAspectRatio: 0.7,
            ),
            itemCount: controller.subscriptions.length,
            itemBuilder: (context, index) {
              final subscription = controller.subscriptions[index];
              return Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border(
                    left: BorderSide(
                      color: _getStatusColor(subscription.status),
                      width: 4,
                    ),
                  ),
                  boxShadow: AppConstants.lightShadow,
                ),
                padding: EdgeInsets.all(3.w),
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
                            subscription.frequency.toUpperCase(),
                            style:
                            AppTextStyles.labelSmall.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 2.w,
                            vertical: 0.3.h,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor(
                                subscription.status)
                                .withOpacity(0.1),
                            borderRadius:
                            BorderRadius.circular(4.0),
                          ),
                          child: Text(
                            subscription.status,
                            style:
                            AppTextStyles.labelSmall.copyWith(
                              color:
                              _getStatusColor(subscription.status),
                              fontSize: 8.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),

                    // Customer Info
                    Text(
                      subscription.customerName,
                      style: AppTextStyles.bodyMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 0.3.h),
                    Text(
                      'ID: #${subscription.customerId}',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textGrey,
                      ),
                    ),
                    SizedBox(height: 1.h),

                    // Details
                    Text(
                      '${subscription.quantityPerDelivery} eggs',
                      style: AppTextStyles.subheading2,
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      'Next: ${_formatDate(subscription.nextDelivery)}',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textGrey,
                      ),
                    ),
                    SizedBox(height: 1.h),

                    // Price
                    Text(
                      '₹${subscription.pricePerOrder.toStringAsFixed(2)}',
                      style: AppTextStyles.headline4.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    const Spacer(),

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
                              padding: EdgeInsets.symmetric(
                                  vertical: 0.8.h),
                              side: BorderSide(
                                color: subscription.status ==
                                    'Paused'
                                    ? AppColors.border
                                    : AppColors.warning,
                              ),
                              foregroundColor: AppColors.warning,
                            ),
                            child: Text(
                              'Pause',
                              style: AppTextStyles.bodySmall.copyWith(
                                fontSize: 9.sp,
                                color: subscription.status ==
                                    'Paused'
                                    ? AppColors.textGrey
                                    : AppColors.warning,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 2.w),
                        IconButton(
                          icon: Icon(
                            Icons.close,
                            size: 5.w,
                          ),
                          onPressed: () => controller
                              .cancelSubscription(subscription.id),
                          color: AppColors.error,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
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
