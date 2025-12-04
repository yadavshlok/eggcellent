import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../controllers/farm_controller.dart';
import '../../controllers/cart_controller.dart';
import '../../utils/colors.dart';
import '../../widgets/cart_drawer.dart';

class FarmDetailScreen extends StatelessWidget {
  const FarmDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int farmId = Get.arguments as int;
    final farmController = Get.find<FarmController>();
    final cartController = Get.find<CartController>();

    // Load farm details
    farmController.loadFarmById(farmId);

    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.background,
          body: Obx(() {
            if (farmController.isLoading.value) {
              return Center(child: CircularProgressIndicator(color: AppColors.primary));
            }

            final farm = farmController.selectedFarm.value;
            if (farm == null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 80, color: AppColors.textGrey),
                    SizedBox(height: 2.h),
                    Text('Farm not found', style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600)),
                  ],
                ),
              );
            }

            return Column(
              children: [
                // Gradient Header with Farm Info
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
                    child: Column(
                      children: [
                        // App Bar
                        Padding(
                          padding: EdgeInsets.fromLTRB(4.w, 2.h, 4.w, 2.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
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
                                    farm.farmName,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Stack(
                                children: [
                                  IconButton(
                                    icon: Container(
                                      padding: EdgeInsets.all(2.5.w),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(Icons.shopping_cart_outlined, color: Colors.white, size: 5.5.w),
                                    ),
                                    onPressed: () => cartController.toggleDrawer(),
                                  ),
                                  Obx(() => cartController.itemCount > 0
                                      ? Positioned(
                                    right: 8,
                                    top: 8,
                                    child: Container(
                                      padding: EdgeInsets.all(1.2.w),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.white, width: 2),
                                      ),
                                      constraints: BoxConstraints(minWidth: 5.w, minHeight: 5.w),
                                      child: Center(
                                        child: Text(
                                          '${cartController.itemCount}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 8.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                      : const SizedBox()),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Farm Info Card
                        Padding(
                          padding: EdgeInsets.fromLTRB(4.w, 1.h, 4.w, 3.h),
                          child: Container(
                            padding: EdgeInsets.all(4.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(3.w),
                                      decoration: BoxDecoration(
                                        gradient: AppColors.primaryGradient,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Icon(Icons.agriculture_rounded, color: Colors.white, size: 8.w),
                                    ),
                                    SizedBox(width: 3.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.location_on, color: AppColors.textGrey, size: 4.5.w),
                                              SizedBox(width: 1.w),
                                              Expanded(
                                                child: Text(
                                                  farm.location,
                                                  style: TextStyle(fontSize: 12.sp, color: AppColors.textGrey),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 0.5.h),
                                          Row(
                                            children: [
                                              Icon(Icons.star_rounded, color: AppColors.warning, size: 4.5.w),
                                              SizedBox(width: 1.w),
                                              Text(
                                                '4.5 Rating',
                                                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  'Premium quality farm providing fresh eggs daily. Committed to sustainable farming practices and animal welfare.',
                                  style: TextStyle(fontSize: 12.sp, color: AppColors.textGrey, height: 1.5),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 2.h),

                // Available Batches Header
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Row(
                    children: [
                      Icon(Icons.egg_rounded, color: AppColors.primary, size: 6.w),
                      SizedBox(width: 2.w),
                      Text(
                        'Available Batches',
                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 1.h),

                // Batches List - Coming Soon Placeholder
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.egg_outlined, size: 80, color: AppColors.textGrey.withOpacity(0.5)),
                        SizedBox(height: 2.h),
                        Text(
                          'No batches available',
                          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          'Check back later for fresh eggs',
                          style: TextStyle(fontSize: 12.sp, color: AppColors.textGrey),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        ),

        // Cart Drawer
        Obx(() => cartController.isDrawerOpen.value ? const CartDrawer() : const SizedBox()),
      ],
    );
  }
}
