import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../controllers/home_controller.dart';
import '../../routes/app_routes.dart';
import '../../utils/colors.dart';
import '../../utils/text_styles.dart';
import '../utils/app_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController controller = Get.find<HomeController>();
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Eggcellent',
          style: AppTextStyles.headline3.copyWith(color: Colors.white),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart, size: 6.w),
            onPressed: () => Get.toNamed(AppRoutes.cart),
          ),
          SizedBox(width: 2.w),
        ],
      ),
      body: Obx(
            () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
          onRefresh: () async => controller.refreshFarms(),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 1.h),

                  // Title
                  Text(
                    'Find Fresh Eggs',
                    style: AppTextStyles.headline2,
                  ),
                  SizedBox(height: 2.h),

                  // Search Bar
                  TextField(
                    controller: searchController,
                    onChanged: controller.searchFarms,
                    decoration: InputDecoration(
                      hintText: 'Search for farms...',
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppColors.textGrey,
                      ),
                      filled: true,
                      fillColor: AppColors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: AppColors.border,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: AppColors.border,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: AppColors.primary,
                          width: 1.5,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 3.w,
                        vertical: 1.5.h,
                      ),
                    ),
                  ),
                  SizedBox(height: 3.h),

                  // Nearby Farms Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Nearby Farms',
                        style: AppTextStyles.headline4,
                      ),
                      TextButton(
                        onPressed: () =>
                            Get.toNamed(AppRoutes.nearbyFarms),
                        child: Text(
                          'See All',
                          style: AppTextStyles.labelSmall.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.5.h),

                  // Farms Horizontal List
                  Obx(
                        () => SizedBox(
                      height: 24.h,
                      child: controller.filteredFarms.isEmpty
                          ? Center(
                        child: Text(
                          'No farms found',
                          style: AppTextStyles.bodyMedium,
                        ),
                      )
                          : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.filteredFarms.length,
                        itemBuilder: (context, index) {
                          final farm =
                          controller.filteredFarms[index];
                          return GestureDetector(
                            onTap: () => Get.toNamed(
                              AppRoutes.farmDetail,
                              arguments: farm,
                            ),
                            child: Container(
                              width: 42.w,
                              margin: EdgeInsets.only(right: 3.w),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius:
                                BorderRadius.circular(8.0),
                                boxShadow:
                                AppConstants.lightShadow,
                              ),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  // Farm Image
                                  Container(
                                    height: 12.h,
                                    decoration: BoxDecoration(
                                      color: AppColors.primary
                                          .withOpacity(0.1),
                                      borderRadius:
                                      BorderRadius.vertical(
                                        top: Radius.circular(8.0),
                                      ),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.agriculture,
                                        size: 8.w,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ),

                                  // Farm Info
                                  Expanded(
                                    child: Padding(
                                      padding:
                                      EdgeInsets.all(2.w),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceEvenly,
                                        children: [
                                          Text(
                                            farm.name,
                                            style: AppTextStyles
                                                .subheading2,
                                            maxLines: 1,
                                            overflow: TextOverflow
                                                .ellipsis,
                                          ),
                                          Text(
                                            farm.location,
                                            style: AppTextStyles
                                                .bodySmall,
                                            maxLines: 1,
                                            overflow: TextOverflow
                                                .ellipsis,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                size: 3.w,
                                                color: AppColors
                                                    .warning,
                                              ),
                                              SizedBox(width: 1.w),
                                              Text(
                                                '${farm.rating} (${farm.reviewCount})',
                                                style: AppTextStyles
                                                    .labelSmall,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 3.h),

                  // Featured Section
                  Text(
                    'Featured Today',
                    style: AppTextStyles.headline4,
                  ),
                  SizedBox(height: 1.5.h),
                  Container(
                    padding: EdgeInsets.all(3.w),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.local_offer_outlined,
                          color: AppColors.primary,
                          size: 8.w,
                        ),
                        SizedBox(width: 2.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Special Offer',
                                style:
                                AppTextStyles.subheading2.copyWith(
                                  color: AppColors.primary,
                                ),
                              ),
                              Text(
                                'Get 20% off on bulk orders',
                                style: AppTextStyles.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 4.w,
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 2.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
