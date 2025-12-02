import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../controllers/farmer_orders_controller.dart';
import '../../utils/colors.dart';
import '../../utils/text_styles.dart';
import '../../widgets/common_app_bar.dart';
import '../utils/app_constants.dart';

class FarmerOrdersScreen extends StatelessWidget {
  const FarmerOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FarmerOrdersController());

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CommonAppBar(
        title: 'Incoming Orders',
        showBackButton: true,
      ),
      body: Obx(
            () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : controller.orders.isEmpty
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.inbox_outlined,
                size: 20.w,
                color: AppColors.textGrey,
              ),
              SizedBox(height: 2.h),
              Text(
                'No incoming orders',
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
            itemCount: controller.orders.length,
            itemBuilder: (context, index) {
              final order = controller.orders[index];
              return Container(
                margin: EdgeInsets.only(bottom: 2.h),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: AppConstants.lightShadow,
                ),
                child: ExpansionTile(
                  tilePadding: EdgeInsets.all(4.w),
                  childrenPadding: EdgeInsets.symmetric(
                    horizontal: 4.w,
                    vertical: 2.h,
                  ),
                  backgroundColor: AppColors.white,
                  collapsedBackgroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  collapsedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  title: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Order #${order.id}',
                              style: AppTextStyles.subheading2,
                            ),
                            SizedBox(height: 0.5.h),
                            Text(
                              order.customerName,
                              style: AppTextStyles.bodyMedium,
                            ),
                            SizedBox(height: 0.3.h),
                            Text(
                              _formatDate(order.orderDate),
                              style: AppTextStyles.bodySmall
                                  .copyWith(
                                color: AppColors.textGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '₹${order.total.toStringAsFixed(2)}',
                        style: AppTextStyles.headline4.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  children: [
                    Container(
                      padding: EdgeInsets.all(3.w),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order Details',
                            style: AppTextStyles.subheading2,
                          ),
                          SizedBox(height: 1.5.h),

                          // Items
                          ...order.items.map((item) => Padding(
                            padding:
                            EdgeInsets.only(bottom: 1.h),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,
                              children: [
                                Text(
                                  '${item.quantity}x ${item.productName}',
                                  style:
                                  AppTextStyles.bodyMedium,
                                ),
                                Text(
                                  '₹${(item.quantity * item.price).toStringAsFixed(2)}',
                                  style:
                                  AppTextStyles.bodyMedium,
                                ),
                              ],
                            ),
                          )),

                          Divider(height: 2.h),

                          // Customer Info
                          _buildInfoRow(
                            Icons.person_outline,
                            order.customerName,
                          ),
                          SizedBox(height: 1.h),
                          _buildInfoRow(
                            Icons.phone_outlined,
                            order.customerPhone,
                          ),
                          SizedBox(height: 1.h),
                          _buildInfoRow(
                            Icons.location_on_outlined,
                            order.deliveryAddress,
                          ),
                          SizedBox(height: 2.h),

                          // Action Buttons
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () => controller
                                      .acceptOrder(order.id),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                    AppColors.success,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 1.2.h),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(
                                          8.0),
                                    ),
                                  ),
                                  child: Text(
                                    'Accept',
                                    style: AppTextStyles
                                        .subheading2
                                        .copyWith(
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 3.w),
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () => controller
                                      .rejectOrder(order.id),
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                        color: AppColors.error),
                                    foregroundColor:
                                    AppColors.error,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 1.2.h),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(
                                          8.0),
                                    ),
                                  ),
                                  child: Text(
                                    'Reject',
                                    style: AppTextStyles
                                        .subheading2
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
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 5.w,
          color: AppColors.primary,
        ),
        SizedBox(width: 2.w),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.bodyMedium,
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
