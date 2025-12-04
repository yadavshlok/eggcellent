import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../controllers/cart_controller.dart';
import '../utils/colors.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // Gradient Header
          Container(
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: EdgeInsets.fromLTRB(4.w, 2.h, 4.w, 3.h),
                child: Row(
                  children: [
                    IconButton(
                      icon: Container(
                        padding: EdgeInsets.all(2.w),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.arrow_back, color: Colors.white, size: 5.5.w),
                      ),
                      onPressed: () => Get.back(),
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      'Checkout',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: 2.h),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Order Summary
                  _buildSectionHeader(Icons.receipt_long_rounded, 'Order Summary'),
                  SizedBox(height: 1.h),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Obx(() => Column(
                      children: cartController.items.asMap().entries.map((entry) {
                        final index = entry.key;
                        final item = entry.value;
                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(4.w),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(2.w),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(Icons.egg_rounded, color: AppColors.primary, size: 5.w),
                                  ),
                                  SizedBox(width: 3.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.eggType,
                                          style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          '${item.quantity}x @ ₹${item.pricePerEgg.toStringAsFixed(2)}',
                                          style: TextStyle(fontSize: 11.sp, color: AppColors.textGrey),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    '₹${item.totalPrice.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textDark,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (index < cartController.items.length - 1)
                              Divider(height: 0, indent: 4.w, endIndent: 4.w, color: AppColors.border.withOpacity(0.3)),
                          ],
                        );
                      }).toList(),
                    )),
                  ),

                  SizedBox(height: 3.h),

                  // Delivery Address
                  _buildSectionHeader(Icons.location_on_rounded, 'Delivery Address'),
                  SizedBox(height: 1.h),
                  Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(2.w),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(Icons.home_rounded, color: AppColors.primary, size: 5.w),
                            ),
                            SizedBox(width: 3.w),
                            Text(
                              'Home',
                              style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(height: 1.5.h),
                        Text(
                          'John Doe',
                          style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 0.5.h),
                        Text(
                          '123 Main Street, Apartment 4B\nMumbai, Maharashtra - 400001',
                          style: TextStyle(fontSize: 12.sp, color: AppColors.textGrey, height: 1.5),
                        ),
                        SizedBox(height: 1.5.h),
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.primary,
                            side: BorderSide(color: AppColors.primary),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text('Change Address'),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 3.h),

                  // Payment Method
                  _buildSectionHeader(Icons.payment_rounded, 'Payment Method'),
                  SizedBox(height: 1.h),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        RadioListTile(
                          title: Row(
                            children: [
                              Icon(Icons.money_rounded, color: AppColors.success, size: 5.w),
                              SizedBox(width: 2.w),
                              const Text('Cash on Delivery'),
                            ],
                          ),
                          value: 'cod',
                          groupValue: 'cod',
                          onChanged: (val) {},
                          activeColor: AppColors.primary,
                        ),
                        Divider(height: 0, indent: 4.w, endIndent: 4.w, color: AppColors.border.withOpacity(0.3)),
                        RadioListTile(
                          title: Row(
                            children: [
                              Icon(Icons.credit_card_rounded, color: AppColors.primary, size: 5.w),
                              SizedBox(width: 2.w),
                              const Text('Online Payment'),
                            ],
                          ),
                          value: 'online',
                          groupValue: 'cod',
                          onChanged: (val) {},
                          activeColor: AppColors.primary,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ),

          // Bottom Total & Place Order
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 15,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: Padding(
                padding: EdgeInsets.all(5.w),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total Amount',
                              style: TextStyle(fontSize: 12.sp, color: AppColors.textGrey),
                            ),
                            Obx(() => Text(
                              '₹${cartController.totalAmount.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            )),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Get.defaultDialog(
                            title: '',
                            titlePadding: EdgeInsets.zero,
                            content: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(4.w),
                                  decoration: BoxDecoration(
                                    color: AppColors.success.withOpacity(0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(Icons.check_circle_rounded, color: AppColors.success, size: 60),
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  'Order Placed!',
                                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 1.h),
                                Text(
                                  'Your order has been placed successfully',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 12.sp, color: AppColors.textGrey),
                                ),
                              ],
                            ),
                            confirm: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                gradient: AppColors.primaryGradient,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  cartController.clearCart();
                                  Get.back();
                                  Get.back();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                                child: const Text('OK', style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          padding: EdgeInsets.symmetric(vertical: 2.h),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.check_circle_rounded, color: Colors.white, size: 5.w),
                            SizedBox(width: 2.w),
                            Text(
                              'Place Order',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 6.w),
        SizedBox(width: 2.w),
        Text(
          title,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
