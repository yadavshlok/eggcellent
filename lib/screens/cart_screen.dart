import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../controllers/cart_controller.dart';
import '../../routes/app_routes.dart';
import '../../utils/colors.dart';
import '../../utils/text_styles.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/primary_button.dart';
import '../utils/app_constants.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CartController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CommonAppBar(
        title: 'My Cart',
        showBackButton: true,
      ),
      body: Obx(
            () => controller.isEmpty
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.shopping_cart_outlined,
                size: 15.h,
                color: AppColors.grey400,
              ),
              SizedBox(height: 3.h),
              Text(
                'Your cart is empty',
                style: AppTextStyles.headline4.copyWith(
                  color: AppColors.grey600,
                ),
              ),
            ],
          ),
        )
            : Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(4.w),
                itemCount: controller.cart.length,
                itemBuilder: (context, index) {
                  final item = controller.cart[index];
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
                        Container(
                          width: 20.w,
                          height: 20.w,
                          decoration: BoxDecoration(
                            color: AppColors.grey100,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Icon(
                            Icons.egg,
                            color: AppColors.primary,
                            size: 10.w,
                          ),
                        ),
                        SizedBox(width: 3.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.eggType,
                                style: AppTextStyles.subheading2,
                              ),
                              Text(
                                item.farmName,
                                style: AppTextStyles.bodySmall,
                              ),
                              Text(
                                '₹${item.pricePerUnit.toStringAsFixed(2)} x ${item.quantity}',
                                style: AppTextStyles.labelLarge.copyWith(
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () =>
                              controller.removeFromCart(item.id),
                          color: AppColors.error,
                          iconSize: 5.w,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 8.0,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Subtotal',
                        style: AppTextStyles.bodyMedium,
                      ),
                      Obx(
                            () => Text(
                          '₹${controller.subtotal.value.toStringAsFixed(2)}',
                          style: AppTextStyles.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.5.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Delivery',
                        style: AppTextStyles.bodyMedium,
                      ),
                      Obx(
                            () => Text(
                          '₹${controller.deliveryFee.value.toStringAsFixed(2)}',
                          style: AppTextStyles.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                  Divider(height: 3.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: AppTextStyles.headline4,
                      ),
                      Obx(
                            () => Text(
                          '₹${controller.total.value.toStringAsFixed(2)}',
                          style: AppTextStyles.headline4.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  PrimaryButton(
                    label: 'Proceed to Checkout',
                    onPressed: () => Get.toNamed(AppRoutes.checkout),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
