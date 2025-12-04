import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../controllers/farm_controller.dart';
import '../../routes/app_routes.dart';
import '../../utils/colors.dart';

class FarmerMyFarmsScreen extends StatelessWidget {
  const FarmerMyFarmsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              child: Padding(
                padding: EdgeInsets.fromLTRB(4.w, 2.h, 4.w, 3.h),
                child: Column(
                  children: [
                    // Header Row
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
                        Container(
                          padding: EdgeInsets.all(2.5.w),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(Icons.agriculture_rounded, color: Colors.white, size: 7.w),
                        ),
                        SizedBox(width: 3.w),
                        Expanded(
                          child: Text(
                            'My Farms',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Container(
                            padding: EdgeInsets.all(2.5.w),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.add_rounded, color: Colors.white, size: 6.w),
                          ),
                          onPressed: () => Get.toNamed(AppRoutes.farmerAddFarm),
                        ),
                      ],
                    ),

                    SizedBox(height: 2.h),

                    // Stats Card
                    Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Obx(() => _buildStatItem(
                            icon: Icons.agriculture_rounded,
                            label: 'Total Farms',
                            value: '${farmController.myFarms.length}',
                          )),
                          Container(height: 6.h, width: 1, color: Colors.white.withOpacity(0.3)),
                          _buildStatItem(
                            icon: Icons.verified_rounded,
                            label: 'Active',
                            value: 'All',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: 2.h),

          // Farms List
          Expanded(
            child: Obx(() {
              if (farmController.isLoading.value) {
                return Center(child: CircularProgressIndicator(color: AppColors.primary));
              }

              if (farmController.myFarms.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.agriculture_outlined, size: 100, color: AppColors.textGrey.withOpacity(0.5)),
                      SizedBox(height: 2.h),
                      Text(
                        'No Farms Yet',
                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: AppColors.textDark),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        'Add your first farm to get started',
                        style: TextStyle(fontSize: 12.sp, color: AppColors.textGrey),
                      ),
                      SizedBox(height: 3.h),
                      ElevatedButton.icon(
                        onPressed: () => Get.toNamed(AppRoutes.farmerAddFarm),
                        icon: Icon(Icons.add_rounded),
                        label: Text('Add Farm'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ],
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: () => farmController.refreshMyFarms(),
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  itemCount: farmController.myFarms.length,
                  itemBuilder: (context, index) {
                    final farm = farmController.myFarms[index];
                    return _buildFarmCard(farm.id, farm.farmName, farm.location, farm.farmType);
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({required IconData icon, required String label, required String value}) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 6.w),
        SizedBox(height: 1.h),
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
            fontSize: 12.2.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildFarmCard(int farmId, String name, String location, String farmType) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
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
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(4.w),
            child: Row(
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
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                      ),
                      SizedBox(height: 0.5.h),
                      Row(
                        children: [
                          Icon(Icons.location_on_rounded, color: AppColors.textGrey, size: 4.w),
                          SizedBox(width: 1.w),
                          Expanded(
                            child: Text(
                              location,
                              style: TextStyle(fontSize: 12.9.sp, color: AppColors.textGrey),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 0.5.h),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          farmType,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete_outline, color: Colors.red, size: 6.w),
                  onPressed: () => _showDeleteDialog(farmId, name),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(int farmId, String farmName) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.warning_rounded, color: Colors.red, size: 6.w),
            SizedBox(width: 2.w),
            Text('Delete Farm?', style: TextStyle(fontSize: 16.sp)),
          ],
        ),
        content: Text(
          'Are you sure you want to delete "$farmName"? This action cannot be undone.',
          style: TextStyle(fontSize: 13.sp, color: AppColors.textGrey),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel', style: TextStyle(color: AppColors.textGrey)),
          ),
          ElevatedButton(
            onPressed: () async {
              Get.back();
              final farmController = Get.find<FarmController>();
              await farmController.deleteFarm(farmId);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }
}
