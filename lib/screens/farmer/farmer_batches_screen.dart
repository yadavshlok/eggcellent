import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/farmer_controller.dart';
import '../../controllers/batch_controller.dart';
import '../../utils/colors.dart';
import '../../data/models/batch.dart';

class FarmerBatchesScreen extends StatelessWidget {
  const FarmerBatchesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final farmerController = Get.find<FarmerController>();
    final batchController = Get.find<BatchController>();

    // Adjust this: either pass farmId via Get.arguments or read from another controller
    //final int farmId = Get.arguments is int ? Get.arguments as int : 0;
    final int farmId = 15; // or from arguments

    batchController.loadBatchesForFarm(farmId);


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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Container(
                            padding: EdgeInsets.all(2.w),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 5.5.w,
                            ),
                          ),
                          onPressed: () => Get.back(),
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          'My Batches',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
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
                        Icons.filter_list_rounded,
                        color: Colors.white,
                        size: 5.5.w,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: 2.h),

          // Batches List
          Expanded(
            child: Obx(() {
              final batches = batchController.batches;
              if (batchController.isLoading.value && batches.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              if (batches.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.egg_outlined,
                        size: 80,
                        color: AppColors.textGrey.withOpacity(0.5),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'No batches yet',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDark,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        'Tap the Add button to create your first batch.',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.textGrey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                itemCount: batches.length,
                itemBuilder: (context, index) {
                  final Batch b = batches[index];
                  return _buildBatchCard(
                    farmName: 'My Farm', // replace with real farm name if available
                    eggType: b.eggType,
                    quantity: b.quantity,
                    pricePerEgg: b.price,
                    freshnessScore: 100,
                    onEdit: () => _showEditBatchDialog(context, b),
                    onDelete: () => batchController.deleteBatch(b.id), dateAdded: '',
                  );
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddBatchDialog(context, farmId),
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add),
        label: const Text('Add Batch'),
      ),
      // bottomNavigationBar: _buildFarmerBottomNav(2),
    );
  }

  Widget _buildBatchCard({
    required String farmName,
    required String eggType,
    required int quantity,
    required double pricePerEgg,
    required int freshnessScore,
    required String dateAdded,
    required VoidCallback onEdit,
    required VoidCallback onDelete,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
          // Header
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withOpacity(0.1),
                  AppColors.primary.withOpacity(0.05),
                ],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.egg_rounded, color: AppColors.primary, size: 6.w),
                    SizedBox(width: 2.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          eggType,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          farmName,
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: AppColors.textGrey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding:
                  EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.8.h),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.success,
                        AppColors.success.withOpacity(0.8),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.verified_rounded,
                          color: Colors.white, size: 3.5.w),
                      SizedBox(width: 1.w),
                      Text(
                        '$freshnessScore% Fresh',
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Content
          Padding(
            padding: EdgeInsets.all(4.w),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoTile(
                        icon: Icons.inventory_2_rounded,
                        label: 'Quantity',
                        value: '$quantity eggs',
                        color: AppColors.primary,
                      ),
                    ),
                    Expanded(
                      child: _buildInfoTile(
                        icon: Icons.payments_rounded,
                        label: 'Price/Egg',
                        value: '₹${pricePerEgg.toStringAsFixed(2)}',
                        color: AppColors.success,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Row(
                  children: [
                    Icon(Icons.calendar_today_rounded,
                        color: AppColors.textGrey, size: 4.w),
                    SizedBox(width: 2.w),
                    Text(
                      'Added on $dateAdded',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: AppColors.textGrey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: onEdit,
                        icon: Icon(Icons.edit_outlined, size: 4.5.w),
                        label: const Text('Edit'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primary,
                          side: BorderSide(color: AppColors.primary),
                          padding: EdgeInsets.symmetric(vertical: 1.5.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: onDelete,
                        icon: Icon(Icons.delete_outline, size: 4.5.w),
                        label: const Text('Delete'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.error,
                          side: BorderSide(color: AppColors.error),
                          padding: EdgeInsets.symmetric(vertical: 1.5.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
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

  Widget _buildInfoTile({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 5.w),
          SizedBox(height: 0.8.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 10.sp,
              color: AppColors.textGrey,
            ),
          ),
        ],
      ),
    );
  }

  void _showAddBatchDialog(BuildContext context, int farmId) {
    final batchController = Get.find<BatchController>();

    final nameCtrl = TextEditingController();
    final qtyCtrl = TextEditingController();
    final priceCtrl = TextEditingController();
    DateTime? selectedDate;

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: EdgeInsets.all(5.w),
          child: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Add New Batch',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  TextField(
                    controller: nameCtrl,
                    decoration: InputDecoration(
                      labelText: 'Batch Name / Egg Type',
                      prefixIcon: const Icon(Icons.egg_rounded),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  TextField(
                    controller: qtyCtrl,
                    decoration: InputDecoration(
                      labelText: 'Quantity',
                      prefixIcon: const Icon(Icons.inventory_2_rounded),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 2.h),
                  TextField(
                    controller: priceCtrl,
                    decoration: InputDecoration(
                      labelText: 'Price per Egg',
                      prefixIcon:
                      const Icon(Icons.currency_rupee_rounded),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 2.h),
                  InkWell(
                    onTap: () async {
                      final now = DateTime.now();
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: now,
                        firstDate: DateTime(now.year - 1),
                        lastDate: DateTime(now.year + 1),
                      );
                      if (picked != null) {
                        setState(() => selectedDate = picked);
                      }
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_today),
                        SizedBox(width: 2.w),
                        Text(
                          selectedDate == null
                              ? 'Select harvest date'
                              : selectedDate!
                              .toLocal()
                              .toString()
                              .split(' ')
                              .first,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Get.back(),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.textGrey,
                            padding: EdgeInsets.symmetric(vertical: 1.8.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Cancel'),
                        ),
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Obx(
                                () => ElevatedButton(
                              onPressed: batchController.isLoading.value
                                  ? null
                                  : () {
                                if (nameCtrl.text.trim().isEmpty ||
                                    qtyCtrl.text.trim().isEmpty ||
                                    priceCtrl.text.trim().isEmpty ||
                                    selectedDate == null) {
                                  Get.snackbar(
                                    'Error',
                                    'Please fill all fields and select a date',
                                    snackPosition:
                                    SnackPosition.BOTTOM,
                                  );
                                  return;
                                }
                                batchController.createBatch(
                                  farmId: farmId,
                                  name: nameCtrl.text.trim(),
                                  quantity:
                                  int.parse(qtyCtrl.text.trim()),
                                  pricePerUnit: double.parse(
                                      priceCtrl.text.trim()),
                                  harvestDate: selectedDate!
                                      .toIso8601String(),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                padding: EdgeInsets.symmetric(
                                    vertical: 1.8.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: batchController.isLoading.value
                                  ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                                  : const Text(
                                'Add',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _showEditBatchDialog(BuildContext context, Batch batch) {
    final batchController = Get.find<BatchController>();

    final nameCtrl = TextEditingController(text: batch.eggType);
    final qtyCtrl =
    TextEditingController(text: batch.quantity.toString());
    final priceCtrl =
    TextEditingController(text: batch.price.toString());

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: EdgeInsets.all(5.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Edit Batch',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 3.h),
              TextField(
                controller: nameCtrl,
                decoration: InputDecoration(
                  labelText: 'Batch Name / Egg Type',
                  prefixIcon: const Icon(Icons.egg_rounded),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              TextField(
                controller: qtyCtrl,
                decoration: InputDecoration(
                  labelText: 'Quantity',
                  prefixIcon: const Icon(Icons.inventory_2_rounded),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 2.h),
              TextField(
                controller: priceCtrl,
                decoration: InputDecoration(
                  labelText: 'Price per Egg',
                  prefixIcon:
                  const Icon(Icons.currency_rupee_rounded),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 3.h),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.textGrey,
                        padding: EdgeInsets.symmetric(vertical: 1.8.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Obx(
                            () => ElevatedButton(
                          onPressed: batchController.isLoading.value
                              ? null
                              : () {
                            if (nameCtrl.text.trim().isEmpty ||
                                qtyCtrl.text.trim().isEmpty ||
                                priceCtrl.text.trim().isEmpty) {
                              Get.snackbar(
                                'Error',
                                'Please fill all fields',
                                snackPosition: SnackPosition.BOTTOM,
                              );
                              return;
                            }
                            batchController.updateBatch(
                              batch.id,
                              eggType: nameCtrl.text.trim(),
                              quantity:
                              int.parse(qtyCtrl.text.trim()),
                              price: double.parse(
                                  priceCtrl.text.trim()),
                            );
                            Get.back();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            padding:
                            EdgeInsets.symmetric(vertical: 1.8.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: batchController.isLoading.value
                              ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                              : const Text(
                            'Save',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
