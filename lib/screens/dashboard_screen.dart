import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../controllers/farmer_controller.dart';
import '../../utils/colors.dart';
import '../../utils/text_styles.dart';

class FarmerDashboardScreen extends StatelessWidget {
  const FarmerDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FarmerController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: AppColors.primary,
      ),
      body: Obx(
            () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Overview', style: AppTextStyles.headline3),
                SizedBox(height: 16.h),
                if (controller.stats.value != null)
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 12.h,
                    crossAxisSpacing: 12.w,
                    childAspectRatio: 1.5,
                    children: [
                      _buildStatCard(
                        'Total Batches',
                        controller.stats.value!.totalBatches.toString(),
                        Icons.inventory,
                        AppColors.info,
                      ),
                      _buildStatCard(
                        'Total Earnings',
                        '₹${controller.stats.value!.totalEarnings.toStringAsFixed(0)}',
                        Icons.monetization_on,
                        AppColors.success,
                      ),
                      _buildStatCard(
                        'Active Orders',
                        controller.stats.value!.activeOrders.toString(),
                        Icons.shopping_bag,
                        AppColors.warning,
                      ),
                      _buildStatCard(
                        'Freshness Score',
                        '${controller.stats.value!.freshnessScore}%',
                        Icons.stars,
                        AppColors.primary,
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 32),
          SizedBox(height: 8.h),
          Text(value, style: AppTextStyles.headline3.copyWith(color: color)),
          Text(title, style: AppTextStyles.caption),
        ],
      ),
    );
  }
}
