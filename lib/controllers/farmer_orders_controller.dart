import 'package:get/get.dart';
import '../models/farmer_order.dart';
import '../utils/colors.dart';

class FarmerOrdersController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxList<FarmerOrder> orders = <FarmerOrder>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    try {
      isLoading.value = true;

      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Mock data
      orders.value = [
        FarmerOrder(
          id: '001',
          customerName: 'Rajesh Kumar',
          customerPhone: '+91 98765 43210',
          deliveryAddress: 'Whitefield, Bangalore',
          items: [
            FarmerOrderItem(
              productName: 'Brown Eggs',
              quantity: 12,
              price: 20.0,
            ),
          ],
          total: 240.0,
          orderDate: DateTime.now(),
          status: 'Pending',
        ),
        FarmerOrder(
          id: '002',
          customerName: 'Priya Sharma',
          customerPhone: '+91 98765 43211',
          deliveryAddress: 'Sarjapur, Bangalore',
          items: [
            FarmerOrderItem(
              productName: 'White Eggs',
              quantity: 24,
              price: 18.0,
            ),
          ],
          total: 432.0,
          orderDate: DateTime.now().subtract(const Duration(hours: 2)),
          status: 'Pending',
        ),
        FarmerOrder(
          id: '003',
          customerName: 'Amit Patel',
          customerPhone: '+91 98765 43212',
          deliveryAddress: 'Koramangala, Bangalore',
          items: [
            FarmerOrderItem(
              productName: 'Organic Eggs',
              quantity: 18,
              price: 25.0,
            ),
          ],
          total: 450.0,
          orderDate: DateTime.now().subtract(const Duration(hours: 5)),
          status: 'Pending',
        ),
      ];
    } catch (e) {
      print('Error fetching orders: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void acceptOrder(String orderId) {
    final index = orders.indexWhere((order) => order.id == orderId);
    if (index != -1) {
      Get.snackbar(
        'Success',
        'Order accepted successfully!',
        backgroundColor: AppColors.success,
        colorText: AppColors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      fetchOrders();
    }
  }

  void rejectOrder(String orderId) {
    Get.defaultDialog(
      title: 'Reject Order',
      middleText: 'Are you sure you want to reject this order?',
      textCancel: 'No',
      textConfirm: 'Yes, Reject',
      confirmTextColor: AppColors.white,
      buttonColor: AppColors.error,
      onConfirm: () {
        orders.removeWhere((order) => order.id == orderId);
        Get.back();
        Get.snackbar(
          'Rejected',
          'Order rejected',
          backgroundColor: AppColors.error,
          colorText: AppColors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      },
    );
  }

  void refreshOrders() {
    fetchOrders();
  }
}
