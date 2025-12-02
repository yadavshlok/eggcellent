import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../controllers/order_controller.dart';
import '../../utils/colors.dart';
import '../../utils/text_styles.dart';
import '../../widgets/common_app_bar.dart';
import '../models/order_model.dart';
import '../utils/app_constants.dart';

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
                size: 20.w,
                color: AppColors.textGrey,
              ),
              SizedBox(height: 2.h),
              Text(
                'No orders yet',
                style: AppTextStyles.headline4.copyWith(
                  color: AppColors.textGrey,
                ),
              ),
            ],
          ),
        )
            : RefreshIndicator(
          onRefresh: () async => controller.refreshOrders(),
          child: ListView.builder(
            padding: EdgeInsets.all(4.w),
            itemCount: controller.myOrders.length,
            itemBuilder: (context, index) {
              final order = controller.myOrders[index];
              return GestureDetector(
                onTap: () => _showOrderDetails(order),
                child: Container(
                  margin: EdgeInsets.only(bottom: 2.h),
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: AppConstants.lightShadow,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Order Header
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Order #${order.id}',
                            style: AppTextStyles.subheading2,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 3.w,
                              vertical: 0.5.h,
                            ),
                            decoration: BoxDecoration(
                              color: _getStatusColor(order.status),
                              borderRadius:
                              BorderRadius.circular(12.0),
                            ),
                            child: Text(
                              order.status,
                              style: AppTextStyles.labelSmall
                                  .copyWith(
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 1.h),

                      // Farm Name
                      if (order.farmName != null)
                        Text(
                          order.farmName!,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textGrey,
                          ),
                        ),
                      SizedBox(height: 0.5.h),

                      // Order Date
                      Text(
                        _formatDate(order.createdAt),
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textGrey,
                        ),
                      ),

                      Divider(height: 2.h),

                      // Items Summary
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${order.items.length} ${order.items.length == 1 ? "item" : "items"}',
                            style: AppTextStyles.bodyMedium,
                          ),
                          Text(
                            '₹${order.total.toStringAsFixed(2)}',
                            style:
                            AppTextStyles.subheading2.copyWith(
                              color: AppColors.primary,
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
        return AppColors.textGrey;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  void _showOrderDetails(Order order) {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
        ),
        padding: EdgeInsets.all(4.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 10.w,
                  height: 0.5.h,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              Text('Order Details', style: AppTextStyles.headline4),
              SizedBox(height: 2.h),
              Text('Order ID: #${order.id}', style: AppTextStyles.bodyMedium),
              SizedBox(height: 1.h),
              Text('Date: ${_formatDate(order.createdAt)}',
                  style: AppTextStyles.bodyMedium),
              if (order.farmName != null) ...[
                SizedBox(height: 1.h),
                Text('Farm: ${order.farmName}',
                    style: AppTextStyles.bodyMedium),
              ],
              if (order.deliveryAddress != null) ...[
                SizedBox(height: 1.h),
                Text('Delivery: ${order.deliveryAddress}',
                    style: AppTextStyles.bodyMedium),
              ],
              SizedBox(height: 2.h),
              Text('Items:', style: AppTextStyles.subheading2),
              SizedBox(height: 1.h),
              ...order.items.map((item) => Padding(
                padding: EdgeInsets.only(bottom: 1.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${item.productName} x ${item.quantity}',
                      style: AppTextStyles.bodyMedium,
                    ),
                    Text(
                      '₹${(item.price * item.quantity).toStringAsFixed(2)}',
                      style: AppTextStyles.bodyMedium,
                    ),
                  ],
                ),
              )),
              Divider(height: 2.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total:', style: AppTextStyles.subheading2),
                  Text(
                    '₹${order.total.toStringAsFixed(2)}',
                    style: AppTextStyles.subheading2.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }
}
