import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../controllers/cart_controller.dart';
import '../../routes/app_routes.dart';
import '../../utils/colors.dart';
import '../../utils/text_styles.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/primary_button.dart';
import '../utils/app_constants.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final CartController cartController = Get.find<CartController>();
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController addressController;
  late TextEditingController cityController;
  late TextEditingController postalCodeController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    addressController = TextEditingController();
    cityController = TextEditingController();
    postalCodeController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CommonAppBar(
        title: 'Checkout',
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(4.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Delivery Address Section
              Text(
                'Delivery Address',
                style: AppTextStyles.headline4,
              ),
              SizedBox(height: 2.h),
              CustomTextField(
                controller: nameController,
                hintText: 'Full Name',
                labelText: 'Name',
                prefixIcon: Icons.person_outline,
              ),
              SizedBox(height: 1.5.h),
              CustomTextField(
                controller: phoneController,
                hintText: '+91 98765 43210',
                labelText: 'Phone Number',
                prefixIcon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 1.5.h),
              CustomTextField(
                controller: addressController,
                hintText: 'Street Address',
                labelText: 'Address',
                prefixIcon: Icons.location_on_outlined,
              ),
              SizedBox(height: 1.5.h),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: cityController,
                      hintText: 'City',
                      labelText: 'City',
                      prefixIcon: Icons.location_city,
                    ),
                  ),
                  SizedBox(width: 2.w),
                  Expanded(
                    child: CustomTextField(
                      controller: postalCodeController,
                      hintText: '560001',
                      labelText: 'Postal Code',
                      prefixIcon: Icons.mail_outline,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 3.h),

              // Payment Method Section
              Text(
                'Payment Method',
                style: AppTextStyles.headline4,
              ),
              SizedBox(height: 1.5.h),
              Container(
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: AppColors.border),
                  boxShadow: AppConstants.lightShadow,
                ),
                child: Row(
                  children: [
                    Icon(Icons.payment, color: AppColors.primary),
                    SizedBox(width: 2.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pay on Delivery',
                            style: AppTextStyles.subheading2,
                          ),
                          Text(
                            'Cash payment at your doorstep',
                            style: AppTextStyles.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.check_circle, color: AppColors.success),
                  ],
                ),
              ),
              SizedBox(height: 3.h),

              // Order Summary Section
              Text(
                'Order Summary',
                style: AppTextStyles.headline4,
              ),
              SizedBox(height: 1.5.h),
              Container(
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: AppConstants.lightShadow,
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
                            '₹${cartController.subtotal.value.toStringAsFixed(2)}',
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
                          'Delivery Charge',
                          style: AppTextStyles.bodyMedium,
                        ),
                        Obx(
                              () => Text(
                            '₹${cartController.deliveryFee.value.toStringAsFixed(2)}',
                            style: AppTextStyles.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                    Divider(height: 2.5.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Amount',
                          style: AppTextStyles.headline4,
                        ),
                        Obx(
                              () => Text(
                            '₹${cartController.total.value.toStringAsFixed(2)}',
                            style: AppTextStyles.headline4.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 3.h),

              // Place Order Button
              PrimaryButton(
                label: 'Place Order',
                onPressed: () {
                  _placeOrder();
                },
              ),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      ),
    );
  }

  void _placeOrder() {
    // Validation
    if (nameController.text.isEmpty ||
        phoneController.text.isEmpty ||
        addressController.text.isEmpty ||
        cityController.text.isEmpty ||
        postalCodeController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill all address fields',
        backgroundColor: AppColors.error,
        colorText: AppColors.white,
        duration: const Duration(seconds: 2),
      );
      return;
    }

    if (phoneController.text.length < 10) {
      Get.snackbar(
        'Error',
        'Please enter valid phone number',
        backgroundColor: AppColors.error,
        colorText: AppColors.white,
        duration: const Duration(seconds: 2),
      );
      return;
    }

    // Order placed successfully
    Get.snackbar(
      'Success',
      'Order placed successfully!',
      backgroundColor: AppColors.success,
      colorText: AppColors.white,
      duration: const Duration(seconds: 2),
    );

    // Clear cart and navigate to home
    cartController.clearCart();
    Future.delayed(const Duration(seconds: 1), () {
      Get.offAllNamed(AppRoutes.home);
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    cityController.dispose();
    postalCodeController.dispose();
    super.dispose();
  }
}
