import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../routes/app_routes.dart';
import '../../utils/colors.dart';
import '../../utils/text_styles.dart';
import '../../widgets/primary_button.dart';
import '../utils/app_constants.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderId = Get.arguments?['orderId'] ?? '#001';
    final total = Get.arguments?['total'] ?? 0.0;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(4.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Success Icon
              Container(
                width: 30.w,
                height: 30.w,
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle,
                  size: 20.w,
                  color: AppColors.success,
                ),
              ),
              SizedBox(height: 4.h),

              // Success Title
              Text(
                'Order Placed Successfully!',
                style: AppTextStyles.headline2,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 1.5.h),

              // Success Subtitle
              Text(
                'Your order has been confirmed',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textGrey,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4.h),

              // Order Details Card
              Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: AppConstants.lightShadow,
                ),
                child: Column(
                  children: [
                    // Order ID
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Order ID:',
                          style: AppTextStyles.bodyMedium,
                        ),
                        Text(
                          orderId,
                          style: AppTextStyles.subheading2,
                        ),
                      ],
                    ),
                    Divider(height: 3.h),

                    // Total Amount
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Amount:',
                          style: AppTextStyles.bodyMedium,
                        ),
                        Text(
                          '₹${total.toStringAsFixed(2)}',
                          style: AppTextStyles.headline4.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    Divider(height: 3.h),

                    // Estimated Delivery
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(2.w),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Icon(
                            Icons.local_shipping_outlined,
                            color: AppColors.primary,
                            size: 6.w,
                          ),
                        ),
                        SizedBox(width: 3.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Estimated Delivery',
                                style: AppTextStyles.subheading2,
                              ),
                              SizedBox(height: 0.3.h),
                              Text(
                                '2-3 business days',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: AppColors.textGrey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 4.h),

              // Track Order Info
              Container(
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  color: AppColors.info.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: AppColors.info,
                      size: 5.w,
                    ),
                    SizedBox(width: 2.w),
                    Expanded(
                      child: Text(
                        'You can track your order in "My Orders" section',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.info,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 4.h),

              // Go Home Button
              PrimaryButton(
                label: 'Go Home',
                onPressed: () => Get.offAllNamed(AppRoutes.home),
              ),
              SizedBox(height: 1.5.h),

              // Continue Shopping Button
              TextButton(
                onPressed: () => Get.offAllNamed(AppRoutes.nearbyFarms),
                child: Text(
                  'Continue Shopping',
                  style: AppTextStyles.subheading2.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
