import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../controllers/farm_controller.dart';
import '../../utils/colors.dart';

class FarmerAddFarmScreen extends StatefulWidget {
  const FarmerAddFarmScreen({Key? key}) : super(key: key);

  @override
  State<FarmerAddFarmScreen> createState() => _FarmerAddFarmScreenState();
}

class _FarmerAddFarmScreenState extends State<FarmerAddFarmScreen> {
  final farmController = Get.find<FarmController>();

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final capacityController = TextEditingController();

  String selectedFarmType = 'ORGANIC';
  final List<String> farmTypes = ['ORGANIC', 'FREE_RANGE', 'CONVENTIONAL', 'CAGE_FREE'];

  @override
  void initState() {
    super.initState();
    // Clear form when screen is opened
    _clearForm();
  }

  void _clearForm() {
    nameController.clear();
    descriptionController.clear();
    addressController.clear();
    cityController.clear();
    capacityController.clear();
    selectedFarmType = 'ORGANIC';
  }


  Future<void> _saveFarm() async {
    // Validation
    if (nameController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter farm name', backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
    if (descriptionController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter description', backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
    if (addressController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter address', backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
    if (cityController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter city', backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
    if (capacityController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter capacity', backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    // Parse capacity
    final capacity = int.tryParse(capacityController.text.trim());

    if (capacity == null) {
      Get.snackbar('Error', 'Invalid capacity number', backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    // Call the controller method
    await farmController.createFarm(
      farmName: nameController.text.trim(),
      description: descriptionController.text.trim(),
      address: addressController.text.trim(),
      city: cityController.text.trim(),
      farmType: selectedFarmType,
      capacity: capacity,
    );
  }

  @override
  Widget build(BuildContext context) {
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
              borderRadius: BorderRadius.only(
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
                      icon: Icon(Icons.arrow_back, color: Colors.white, size: 24.sp),
                    ),
                    SizedBox(width: 2.w),
                    Icon(Icons.add_business, color: Colors.white, size: 28.sp),
                    SizedBox(width: 3.w),
                    Text(
                      'Add New Farm',
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
          // Form Content
          Padding(
            padding: EdgeInsets.only(top: 16.h),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.all(4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 2.h),

                    // Farm Name
                    _buildLabel('Farm Name', required: true),
                    _buildTextField(
                      controller: nameController,
                      hint: 'brand',
                      icon: Icons.agriculture,
                    ),
                    SizedBox(height: 2.h),

                    // Address and City
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel('Address', required: true),
                              _buildTextField(
                                controller: addressController,
                                hint: 'katraj',
                                icon: Icons.location_on,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 3.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel('City', required: true),
                              _buildTextField(
                                controller: cityController,
                                hint: 'pune',
                                icon: Icons.location_city,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),

                    // Farm Type and Capacity
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel('Farm Type', required: true),
                              _buildDropdown(),
                            ],
                          ),
                        ),
                        SizedBox(width: 3.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel('Capacity (Birds)', required: true),
                              _buildTextField(
                                controller: capacityController,
                                hint: '1212',
                                icon: Icons.numbers,
                                keyboardType: TextInputType.number,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),

                    // Description
                    _buildLabel('Description', required: true),
                    _buildTextField(
                      controller: descriptionController,
                      hint: 'unique',
                      icon: Icons.description,
                      maxLines: 3,
                    ),
                    SizedBox(height: 4.h),

                    // Save Button
                    Obx(() => SizedBox(
                      width: double.infinity,
                      height: 6.h,
                      child: ElevatedButton(
                        onPressed: farmController.isLoading.value ? null : _saveFarm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: farmController.isLoading.value
                            ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                            : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.save, color: Colors.white),
                            SizedBox(width: 2.w),
                            Text(
                              'Save Farm',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                    SizedBox(height: 2.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text, {required bool required}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.h),
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
          if (required)
            Text(
              ' *',
              style: TextStyle(color: Colors.red, fontSize: 12.sp),
            ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon, color: AppColors.primary, size: 20.sp),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
        ),
      ),
    );
  }

  Widget _buildDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedFarmType,
          isExpanded: true,
          icon: Icon(Icons.arrow_drop_down, color: AppColors.primary),
          items: farmTypes.map((String type) {
            return DropdownMenuItem<String>(
              value: type,
              child: Text(type),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                selectedFarmType = newValue;
              });
            }
          },
        ),
      ),
    );
  }
}
