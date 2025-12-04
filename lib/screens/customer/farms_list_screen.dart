import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/farm_controller.dart';
import '../../data/models/farm.dart';
import '../../utils/colors.dart';
import '../customer/farm_detail_screen.dart';

class FarmsListScreen extends StatelessWidget {
  const FarmsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final farmController = Get.find<FarmController>();

    return Scaffold(
      body: Stack(
        children: [
          // Gradient Header
          Container(
            height: 20.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.primaryDark],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(Icons.arrow_back,
                          color: Colors.white, size: 24.sp),
                    ),
                    SizedBox(width: 2.w),
                    Icon(Icons.agriculture,
                        color: Colors.white, size: 28.sp),
                    SizedBox(width: 3.w),
                    Text(
                      'All Farms',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Farm List Content
          Padding(
            padding: EdgeInsets.only(top: 16.h),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Obx(() {
                if (farmController.isLoading.value) {
                  return Center(
                    child:
                    CircularProgressIndicator(color: AppColors.primary),
                  );
                }

                final farms = farmController.allFarms;

                if (farms.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.agriculture_outlined,
                          size: 80,
                          color: Colors.grey[400],
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          'No farms available',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          'Check back later for new farms',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () => farmController.fetchAllFarms(),
                  child: ListView.builder(
                    padding: EdgeInsets.all(4.w),
                    itemCount: farms.length,
                    itemBuilder: (context, index) {
                      final Farm farm = farms[index];
                      return _buildFarmCard(farm);
                    },
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFarmCard(Farm farm) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const FarmDetailScreen(), arguments: farm.id);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 2.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Simple colored header
            Container(
              height: 8.h,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary.withOpacity(0.9),
                    AppColors.primaryDark.withOpacity(0.9),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(2.w),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child:
                      const Icon(Icons.agriculture, color: Colors.white),
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      farm.farmName, // real API field
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Farm Info
            Padding(
              padding: EdgeInsets.all(3.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Location
                  Row(
                    children: [
                      Icon(Icons.location_on,
                          size: 14.sp, color: Colors.grey[600]),
                      SizedBox(width: 1.w),
                      Expanded(
                        child: Text(
                          farm.location, // real API field
                          style: TextStyle(
                            fontSize: 12.5.sp,
                            color: Colors.grey[600],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),

                  // Hardcoded farm type & rating row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 3.w, vertical: 0.5.h),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          farm.farmType, // real API field, or fallback
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star,
                              color: Colors.amber, size: 18),
                          SizedBox(width: 1.w),
                          Text(
                            '4.5 (0)', // hardcoded
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 1.h),

                  // Hardcoded description
                  Text(
                    'Fresh farm eggs from ${farm.location}',
                    style: TextStyle(
                      fontSize: 12.2.sp,
                      color: Colors.grey[600],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
