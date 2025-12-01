import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../routes/app_routes.dart';
import '../../utils/colors.dart';
import '../../utils/text_styles.dart';
import '../../widgets/primary_button.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderId = Get.arguments?['orderId'] ?? 'N/A';
    final total = Get.arguments?['total'] ?? 0.0;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120.w,
                height: 120.h,
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle,
                  size: 80,
                  color: AppColors.success,
                ),
              ),
              SizedBox(height: 32.h),
              Text(
                'Order Placed Successfully!',
                style: AppTextStyles.headline2,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h),
              Text(
                'Your order has been confirmed',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.grey600,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40.h),
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Order ID:', style: AppTextStyles.bodyMedium),
                        Text(
                          orderId,
                          style: AppTextStyles.subheading2,
                        ),
                      ],
                    ),
                    Divider(height: 24.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total Amount:', style: AppTextStyles.bodyMedium),
                        Text(
                          '₹${total.toStringAsFixed(2)}',
                          style: AppTextStyles.headline4.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    Divider(height: 24.h),
                    Row(
                      children: [
                        Icon(
                          Icons.local_shipping_outlined,
                          color: AppColors.primary,
                          size: 24,
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Estimated Delivery',
                                style: AppTextStyles.labelMedium,
                              ),
                              Text(
                                '2-3 business days',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: AppColors.grey600,
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
              SizedBox(height: 40.h),
              PrimaryButton(
                label: 'Go Home',
                onPressed: () => Get.offAllNamed(AppRoutes.home),
              ),
              SizedBox(height: 12.h),
              TextButton(
                onPressed: () => Get.toNamed(AppRoutes.nearbyFarms),
                child: Text(
                  'Continue Shopping',
                  style: AppTextStyles.labelLarge.copyWith(
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
