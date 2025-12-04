import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../controllers/farm_controller.dart';
import '../../controllers/cart_controller.dart';
import '../../routes/app_routes.dart';
import '../../utils/colors.dart';
import '../../utils/text_styles.dart';
import '../../widgets/cart_drawer.dart';

class CustomerHomeScreen extends StatelessWidget {
  const CustomerHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final farmController = Get.put(FarmController());
    final cartController = Get.put(CartController());

    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.background,
          body: Column(
            children: [
              // Clean Top Header with Gradient
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
                                Container(
                                  padding: EdgeInsets.all(2.5.w),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(Icons.egg, color: Colors.white, size: 7.w),
                                ),
                                SizedBox(width: 3.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Eggcellent',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Farm Fresh Delivered',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.9),
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ],
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

                      // Search Bar
                      Padding(
                        padding: EdgeInsets.fromLTRB(4.w, 1.h, 4.w, 3.h),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 15,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: TextField(
                            onChanged: (value) {
                              // Simple local search - filter by name or location
                              if (value.isEmpty) {
                                farmController.fetchAllFarms();
                              }
                            },
                            decoration: InputDecoration(
                              hintText: 'Search farms near you...',
                              hintStyle: TextStyle(color: AppColors.textGrey.withOpacity(0.6), fontSize: 13.3.sp),
                              prefixIcon: Icon(Icons.search_rounded, color: AppColors.primary, size: 6.w),
                              suffixIcon: Icon(Icons.tune_rounded, color: AppColors.primary, size: 5.w),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.8.h),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 2.h),

              // Quick Stats Cards
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Row(
                  children: [
                    Expanded(
                      child: Obx(() => _buildStatCard(
                        icon: Icons.agriculture_rounded,
                        label: 'Farms',
                        value: '${farmController.allFarms.length}+',
                        gradient: LinearGradient(
                          colors: [Color(0xFFFFB74D), Color(0xFFFF9800)],
                        ),
                      )),
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: _buildStatCard(
                        icon: Icons.local_shipping_rounded,
                        label: 'Delivery',
                        value: 'Fast',
                        gradient: LinearGradient(
                          colors: [Color(0xFF66BB6A), Color(0xFF43A047)],
                        ),
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: _buildStatCard(
                        icon: Icons.verified_rounded,
                        label: 'Quality',
                        value: '100%',
                        gradient: LinearGradient(
                          colors: [Color(0xFF42A5F5), Color(0xFF1E88E5)],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 2.h),

              // Section Header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Nearby Farms', style: AppTextStyles.headline4),
                    TextButton(
                      onPressed: () => Get.toNamed(AppRoutes.farmsList),
                      child: Text(
                        'View All',
                        style: TextStyle(color: AppColors.primary, fontSize: 13.sp, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 1.h),

              // Farms List
              Expanded(
                child: Obx(() {
                  if (farmController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final farms = farmController.allFarms;

                  if (farms.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.agriculture_rounded, size: 80, color: AppColors.textGrey.withOpacity(0.5)),
                          SizedBox(height: 2.h),
                          Text('No farms found', style: AppTextStyles.headline4),
                          SizedBox(height: 1.h),
                          Text(
                            'Check back soon for fresh eggs!',
                            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textGrey),
                          ),
                        ],
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () => farmController.fetchAllFarms(),
                    child: ListView.builder(
                      padding: EdgeInsets.fromLTRB(4.w, 0, 4.w, 10.h),
                      itemCount: farms.length,
                      itemBuilder: (context, index) {
                        final farm = farms[index];
                        return _buildFarmCard(
                          farmName: farm.farmName,
                          location: farm.location,
                          farmId: farm.id,
                        );
                      },
                    ),
                  );
                }),
              ),
            ],
          ),
          bottomNavigationBar: _buildModernBottomNav(),
        ),

        // Cart Drawer Overlay
        Obx(() => cartController.isDrawerOpen.value ? const CartDrawer() : const SizedBox()),
      ],
    );
  }

  Widget _buildFarmCard({
    required String farmName,
    required String location,
    required int farmId,
  }) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.farmDetail, arguments: farmId),
      child: Container(
        margin: EdgeInsets.only(bottom: 2.h),
        padding: EdgeInsets.all(3.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 18.w,
              height: 18.w,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.agriculture_rounded, color: Colors.white, size: 9.w),
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    farmName,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  Row(
                    children: [
                      Icon(Icons.location_on_rounded, color: AppColors.textGrey, size: 3.5.w),
                      SizedBox(width: 1.w),
                      Expanded(
                        child: Text(
                          location,
                          style: TextStyle(fontSize: 11.sp, color: AppColors.textGrey),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 0.5.h),
                  Row(
                    children: [
                      Icon(Icons.star_rounded, color: Colors.amber, size: 3.5.w),
                      SizedBox(width: 1.w),
                      Text('4.5', style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w600)),
                      SizedBox(width: 2.w),
                      Icon(Icons.egg, color: AppColors.primary, size: 3.5.w),
                      SizedBox(width: 1.w),
                      Text('Fresh Eggs', style: TextStyle(fontSize: 11.sp, color: AppColors.primary)),
                    ],
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, color: AppColors.textGrey, size: 4.w),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    required Gradient gradient,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 6.w),
          SizedBox(height: 0.8.h),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.2.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 11.8.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.2.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home_rounded, 'Home', true, () {}),
              _buildNavItem(Icons.agriculture_rounded, 'Farms', false, () => Get.toNamed(AppRoutes.farmsList)),
              _buildNavItem(Icons.card_membership_rounded, 'Plans', false, () => Get.toNamed(AppRoutes.subscriptions)),
              _buildNavItem(Icons.chat_bubble_rounded, 'Chat', false, () => Get.toNamed(AppRoutes.chat)),
              _buildNavItem(Icons.person_rounded, 'Profile', false, () => Get.toNamed(AppRoutes.profile)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: isActive ? 4.w : 3.w, vertical: 1.h),
        decoration: BoxDecoration(
          gradient: isActive ? AppColors.primaryGradient : null,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive ? Colors.white : AppColors.textGrey,
              size: 5.2.w,
            ),
            SizedBox(height: 0.3.h),
            Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.white : AppColors.textGrey,
                fontSize: 11.5.sp,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
