import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../controllers/farm_controller.dart';
import '../../controllers/farmer_controller.dart';
import '../../routes/app_routes.dart';
import '../../utils/colors.dart';

class FarmerDashboardScreen extends StatelessWidget {
  const FarmerDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final farmerController = Get.put(FarmerController());
    final farmController = Get.find<FarmController>();

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
                              child: Icon(
                                Icons.agriculture_rounded,
                                color: Colors.white,
                                size: 7.w,
                              ),
                            ),
                            SizedBox(width: 3.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Dashboard',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Obx(
                                      () => Text(
                                    farmerController.farmerName.value,
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.9),
                                      fontSize: 11.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(2.5.w),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.notifications_rounded,
                            color: Colors.white,
                            size: 5.5.w,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Stats Overview Cards
                  Padding(
                    padding: EdgeInsets.fromLTRB(4.w, 1.h, 4.w, 3.h),
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildHeaderStatCard(
                            icon: Icons.shopping_bag_rounded,
                            label: 'Orders',
                            value: '24',
                            subtext: 'Today',
                          ),
                        ),
                        SizedBox(width: 3.w),
                        Expanded(
                          child: _buildHeaderStatCard(
                            icon: Icons.attach_money_rounded,
                            label: 'Revenue',
                            value: '₹12.5k',
                            subtext: 'This week',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 2.h),

          // Quick Actions Grid
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quick Actions',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 1.5.h),

                  Row(
                    children: [
                      Expanded(
                        child: _buildActionCard(
                          icon: Icons.agriculture_rounded,
                          title: 'My Farms',
                          subtitle: '3 Active',
                          gradient: const LinearGradient(
                            colors: [Color(0xFF66BB6A), Color(0xFF43A047)],
                          ),
                          onTap: () => Get.toNamed(AppRoutes.farmerFarms),
                        ),
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: _buildActionCard(
                          icon: Icons.inventory_2_rounded,
                          title: 'Batches',
                          subtitle: '12 Active',
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFFB74D), Color(0xFFFF9800)],
                          ),
                          onTap: () {
                            // final farms = farmController.myFarms;
                            // if (farms.isEmpty) {
                            //   Get.snackbar(
                            //     'Error',
                            //     'Create a farm first before adding batches',
                            //     snackPosition: SnackPosition.BOTTOM,
                            //   );
                            //   return;
                            // }
                            // final farmId = farms.first.id;
                            Get.toNamed(
                              AppRoutes.farmerBatches,
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 2.h),

                  Row(
                    children: [
                      Expanded(
                        child: _buildActionCard(
                          icon: Icons.card_membership_rounded,
                          title: 'Subscriptions',
                          subtitle: '8 Active',
                          gradient: const LinearGradient(
                            colors: [Color(0xFF42A5F5), Color(0xFF1E88E5)],
                          ),
                          onTap: () =>
                              Get.toNamed(AppRoutes.farmerSubscriptions),
                        ),
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: _buildActionCard(
                          icon: Icons.star_rounded,
                          title: 'Reviews',
                          subtitle: '4.5 Rating',
                          gradient: const LinearGradient(
                            colors: [Color(0xFFAB47BC), Color(0xFF8E24AA)],
                          ),
                          onTap: () => Get.toNamed(AppRoutes.farmerReviews),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 3.h),

                  // Recent Orders Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recent Orders',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () =>
                            Get.toNamed(AppRoutes.farmerOrders),
                        child: Text(
                          'View All',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 1.h),

                  ...List.generate(
                    3,
                        (index) => _buildOrderCard(
                      orderId: '#ORD${1000 + index}',
                      customerName: 'Customer ${index + 1}',
                      items: '${12 + index * 6} eggs',
                      amount: '₹${240 + index * 120}',
                      status: index == 0 ? 'Pending' : 'Confirmed',
                    ),
                  ),

                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildFarmerBottomNav(0),
    );
  }

  Widget _buildHeaderStatCard({
    required IconData icon,
    required String label,
    required String value,
    required String subtext,
  }) {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 6.w),
          SizedBox(height: 0.8.h),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 10.sp,
            ),
          ),
          Text(
            subtext,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 9.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Gradient gradient,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: gradient.colors.first.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(2.5.w),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.white, size: 7.w),
            ),
            SizedBox(height: 2.h),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 0.3.h),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 11.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCard({
    required String orderId,
    required String customerName,
    required String items,
    required String amount,
    required String status,
  }) {
    final bool isPending = status == 'Pending';

    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      padding: EdgeInsets.all(4.w),
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
            padding: EdgeInsets.all(2.5.w),
            decoration: BoxDecoration(
              color: (isPending ? AppColors.warning : AppColors.success)
                  .withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.shopping_bag_rounded,
              color: isPending ? AppColors.warning : AppColors.success,
              size: 6.w,
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      orderId,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 2.5.w,
                        vertical: 0.5.h,
                      ),
                      decoration: BoxDecoration(
                        color: (isPending
                            ? AppColors.warning
                            : AppColors.success)
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: isPending
                              ? AppColors.warning
                              : AppColors.success,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 0.5.h),
                Text(
                  customerName,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: AppColors.textGrey,
                  ),
                ),
                SizedBox(height: 0.3.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      items,
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: AppColors.textGrey,
                      ),
                    ),
                    Text(
                      amount,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
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
  }

  Widget _buildFarmerBottomNav(int currentIndex) {
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
              _buildNavItem(
                Icons.dashboard_rounded,
                'Dashboard',
                currentIndex == 0,
                    () {},
              ),
              _buildNavItem(
                Icons.shopping_bag_rounded,
                'Orders',
                currentIndex == 1,
                    () => Get.toNamed(AppRoutes.farmerOrders),
              ),
              _buildNavItem(
                Icons.inventory_2_rounded,
                'Batches',
                currentIndex == 2,
                    () {
                  // final farmController = Get.find<FarmController>();
                  // final farms = farmController.myFarms;
                  // if (farms.isEmpty) {
                  //   Get.snackbar(
                  //     'Error',
                  //     'Create a farm first before adding batches',
                  //     snackPosition: SnackPosition.BOTTOM,
                  //   );
                  //   return;
                  // }
                  // final farmId = farms.first.id;
                  Get.toNamed(AppRoutes.farmerBatches);
                },
              ),
              _buildNavItem(
                Icons.chat_bubble_rounded,
                'Messages',
                currentIndex == 3,
                    () => Get.toNamed(AppRoutes.farmerMessages),
              ),
              _buildNavItem(
                Icons.person_rounded,
                'Profile',
                currentIndex == 4,
                    () => Get.toNamed(AppRoutes.farmerProfile),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
      IconData icon,
      String label,
      bool isActive,
      VoidCallback onTap,
      ) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: isActive ? 4.w : 3.w,
          vertical: 1.h,
        ),
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
                fontSize: 11.1.sp,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
