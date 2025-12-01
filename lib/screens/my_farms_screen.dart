import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../controllers/farm_controller.dart';
import '../../utils/colors.dart';
import '../../utils/text_styles.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/primary_button.dart';

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
            Padding(
              padding: EdgeInsets.all(16.w),
              child: PrimaryButton(
                label: 'Add New Farm',
                onPressed: () => _showAddFarmDialog(context),
              ),
            ),
            Expanded(
              child: controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.w,
                  mainAxisSpacing: 12.h,
                  childAspectRatio: 0.85,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12.w),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 100.h,
                          decoration: BoxDecoration(
                            color: AppColors.grey200,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(12.w),
                            ),
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: Icon(
                                  Icons.agriculture,
                                  size: 48,
                                  color: AppColors.grey400,
                                ),
                              ),
                              Positioned(
                                top: 8.h,
                                right: 8.w,
                                child: Container(
                                  padding: EdgeInsets.all(4.w),
                                  decoration: BoxDecoration(
                                    color: AppColors.success,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.verified,
                                    size: 16,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(12.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Farm Name $index',
                                style: AppTextStyles.subheading2,
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                'Location',
                                style: AppTextStyles.caption,
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                'Organic • 500 birds',
                                style: AppTextStyles.labelSmall,
                              ),
                              SizedBox(height: 8.h),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.inventory),
                                    onPressed: () {},
                                    iconSize: 20,
                                    color: AppColors.primary,
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {},
                                    iconSize: 20,
                                    color: AppColors.error,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
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

  void _showAddFarmDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        title: const Text('Add New Farm'),
        content: const Text('Add farm form will go here'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Get.back(),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
