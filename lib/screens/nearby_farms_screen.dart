import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../controllers/home_controller.dart';
import '../../routes/app_routes.dart';
import '../../utils/colors.dart';
import '../../utils/text_styles.dart';
import '../../widgets/common_app_bar.dart';
import '../utils/app_constants.dart';

class NearbyFarmsScreen extends StatefulWidget {
  const NearbyFarmsScreen({Key? key}) : super(key: key);

  @override
  State<NearbyFarmsScreen> createState() => _NearbyFarmsScreenState();
}

class _NearbyFarmsScreenState extends State<NearbyFarmsScreen> {
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
      appBar: const CommonAppBar(
        title: 'Nearby Farms',
        showBackButton: true,
      ),
      body: Obx(
            () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : Column(
          children: [
            // Search Bar
            Padding(
              padding: EdgeInsets.all(4.w),
              child: TextField(
                controller: searchController,
                onChanged: controller.searchFarms,
                decoration: InputDecoration(
                  hintText: 'Search farms...',
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColors.textGrey,
                  ),
                  suffixIcon: searchController.text.isNotEmpty
                      ? IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: AppColors.textGrey,
                    ),
                    onPressed: () {
                      searchController.clear();
                      controller.searchFarms('');
                    },
                  )
                      : null,
                  filled: true,
                  fillColor: AppColors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: AppColors.border),
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
            ),

            // Results Count
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${controller.filteredFarms.length} ${controller.filteredFarms.length == 1 ? "farm" : "farms"} found',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textGrey,
                  ),
                ),
              ),
            ),
            SizedBox(height: 1.h),

            // Farms Grid
            Expanded(
              child: controller.filteredFarms.isEmpty
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 20.w,
                      color: AppColors.textGrey,
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'No farms found',
                      style: AppTextStyles.headline4.copyWith(
                        color: AppColors.textGrey,
                      ),
                    ),
                  ],
                ),
              )
                  : GridView.builder(
                padding: EdgeInsets.all(4.w),
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 3.w,
                  mainAxisSpacing: 2.h,
                  childAspectRatio: 0.8,
                ),
                itemCount: controller.filteredFarms.length,
                itemBuilder: (context, index) {
                  final farm = controller.filteredFarms[index];
                  return GestureDetector(
                    onTap: () => Get.toNamed(
                      AppRoutes.farmDetail,
                      arguments: farm,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: AppConstants.lightShadow,
                      ),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          // Farm Image
                          Container(
                            height: 14.h,
                            decoration: BoxDecoration(
                              color: AppColors.primary
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(8.0),
                              ),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.agriculture,
                                size: 12.w,
                                color: AppColors.primary,
                              ),
                            ),
                          ),

                          // Farm Details
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(3.w),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        farm.name,
                                        style: AppTextStyles
                                            .subheading2,
                                        maxLines: 2,
                                        overflow:
                                        TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 0.5.h),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons
                                                .location_on_outlined,
                                            size: 3.5.w,
                                            color: AppColors
                                                .textGrey,
                                          ),
                                          SizedBox(width: 1.w),
                                          Expanded(
                                            child: Text(
                                              farm.location,
                                              style: AppTextStyles
                                                  .bodySmall,
                                              maxLines: 1,
                                              overflow: TextOverflow
                                                  .ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  // Rating
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 4.w,
                                        color: AppColors.warning,
                                      ),
                                      SizedBox(width: 1.w),
                                      Text(
                                        '${farm.rating}',
                                        style: AppTextStyles
                                            .labelSmall,
                                      ),
                                      SizedBox(width: 1.w),
                                      Text(
                                        '(${farm.reviewCount})',
                                        style: AppTextStyles
                                            .labelSmall
                                            .copyWith(
                                          color:
                                          AppColors.textGrey,
                                        ),
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
          ],
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
