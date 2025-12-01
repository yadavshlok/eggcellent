import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../controllers/order_controller.dart';
import '../../utils/colors.dart';
import '../../utils/text_styles.dart';
import '../../widgets/common_app_bar.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OrderController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CommonAppBar(
        title: 'My Orders',
        showBackButton: true,
      ),
      body: Obx(
            () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : controller.myOrders.isEmpty
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.shopping_bag_outlined,
                size: 80,
                color: AppColors.grey400,
              ),
              SizedBox(height: 16.h),
              Text(
                'No orders yet',
                style: AppTextStyles.headline4.copyWith(
                  color: AppColors.grey600,
                ),
              ),
            ],
          ),
        )
            : ListView.builder(
          padding: EdgeInsets.all(16.w),
          itemCount: controller.myOrders.length,
          itemBuilder: (context, index) {
            final order = controller.myOrders[index];
            return Container(
              margin: EdgeInsets.only(bottom: 12.h),
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12.w),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Order #${order.id}',
                        style: AppTextStyles.subheading2,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(order.status),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Text(
                          order.status,
                          style: AppTextStyles.labelSmall.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    order.createdAt.toString().split(' ')[0],
                    style: AppTextStyles.caption,
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${order.items.length} items',
                        style: AppTextStyles.bodyMedium,
                      ),
                      Text(
                        '₹${order.total.toStringAsFixed(2)}',
                        style: AppTextStyles.subheading2.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return AppColors.warning;
      case 'confirmed':
        return AppColors.info;
      case 'delivered':
        return AppColors.success;
      case 'cancelled':
        return AppColors.error;
      default:
        return AppColors.grey500;
    }
  }
}
