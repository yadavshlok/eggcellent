import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../controllers/farm_controller.dart';
import '../../routes/app_routes.dart';
import '../../utils/colors.dart';
import '../../utils/text_styles.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/primary_button.dart';
import '../utils/app_constants.dart';

class MyFarmsScreen extends StatelessWidget {
  const MyFarmsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FarmController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CommonAppBar(
        title: 'My Farms',
        showBackButton: true,
      ),
      body: Obx(
            () => Column(
          children: [
            // Add Farm Button
            Padding(
              padding: EdgeInsets.all(4.w),
              child: PrimaryButton(
                label: 'Add New Farm',
                onPressed: () => _showAddFarmDialog(context, controller),
              ),
            ),

            // Farms Grid
            Expanded(
              child: controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : controller.farms.isEmpty
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.agriculture,
                      size: 20.w,
                      color: AppColors.textGrey,
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'No farms added yet',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textGrey,
                      ),
                    ),
                  ],
                ),
              )
                  : GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 3.w,
                  mainAxisSpacing: 2.h,
                  childAspectRatio: 0.75,
                ),
                itemCount: controller.farms.length,
                itemBuilder: (context, index) {
                  final farm = controller.farms[index];
                  return _buildFarmCard(farm, controller);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFarmCard(FarmModel farm, FarmController controller) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: AppConstants.lightShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Farm Image with Verified Badge
          Container(
            height: 12.h,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(12.0),
              ),
            ),
            child: Stack(
              children: [
                Center(
                  child: Icon(
                    Icons.agriculture,
                    size: 10.w,
                    color: AppColors.primary,
                  ),
                ),
                if (farm.isVerified)
                  Positioned(
                    top: 1.h,
                    right: 2.w,
                    child: Container(
                      padding: EdgeInsets.all(1.5.w),
                      decoration: BoxDecoration(
                        color: AppColors.success,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.verified,
                        size: 4.w,
                        color: AppColors.white,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Farm Details
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(3.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    farm.name,
                    style: AppTextStyles.subheading2,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 0.5.h),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 3.5.w,
                        color: AppColors.textGrey,
                      ),
                      SizedBox(width: 1.w),
                      Expanded(
                        child: Text(
                          farm.location,
                          style: AppTextStyles.bodySmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 2.w,
                      vertical: 0.5.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.info.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      '${farm.type} • ${farm.birdCount} birds',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.info,
                      ),
                    ),
                  ),
                  const Spacer(),

                  // Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.inventory_2_outlined,
                          size: 5.w,
                        ),
                        onPressed: () => Get.toNamed(
                          AppRoutes.batches,
                          arguments: farm,
                        ),
                        color: AppColors.primary,
                        tooltip: 'View Batches',
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.edit_outlined,
                          size: 5.w,
                        ),
                        onPressed: () {},
                        color: AppColors.warning,
                        tooltip: 'Edit Farm',
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete_outline,
                          size: 5.w,
                        ),
                        onPressed: () => _showDeleteConfirmation(farm, controller),
                        color: AppColors.error,
                        tooltip: 'Delete Farm',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddFarmDialog(BuildContext context, FarmController controller) {
    final nameController = TextEditingController();
    final locationController = TextEditingController();
    final typeController = TextEditingController();
    final birdCountController = TextEditingController();

    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        title: Text('Add New Farm', style: AppTextStyles.headline4),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                controller: nameController,
                hintText: 'Farm Name',
                labelText: 'Name',
                prefixIcon: Icons.agriculture,
              ),
              SizedBox(height: 2.h),
              CustomTextField(
                controller: locationController,
                hintText: 'Location',
                labelText: 'Location',
                prefixIcon: Icons.location_on_outlined,
              ),
              SizedBox(height: 2.h),
              CustomTextField(
                controller: typeController,
                hintText: 'e.g., Organic, Free Range',
                labelText: 'Type',
                prefixIcon: Icons.category_outlined,
              ),
              SizedBox(height: 2.h),
              CustomTextField(
                controller: birdCountController,
                hintText: 'Number of Birds',
                labelText: 'Bird Count',
                prefixIcon: Icons.numbers,
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.textGrey,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty &&
                  locationController.text.isNotEmpty &&
                  typeController.text.isNotEmpty &&
                  birdCountController.text.isNotEmpty) {
                controller.addFarm(
                  nameController.text,
                  locationController.text,
                  typeController.text,
                  int.tryParse(birdCountController.text) ?? 0,
                );
                Get.back();
              } else {
                Get.snackbar(
                  'Error',
                  'Please fill all fields',
                  snackPosition: SnackPosition.BOTTOM,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: Text(
              'Save',
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(FarmModel farm, FarmController controller) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        title: Text('Delete Farm', style: AppTextStyles.headline4),
        content: Text(
          'Are you sure you want to delete "${farm.name}"?',
          style: AppTextStyles.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.textGrey,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              controller.deleteFarm(farm.id);
              Get.back();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: Text(
              'Delete',
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
