import 'package:get/get.dart';
import '../models/order_model.dart';

class OrderController extends GetxController {
  final isLoading = false.obs;
  final myOrders = <Order>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchMyOrders();
  }

  Future<void> fetchMyOrders() async {
    try {
      isLoading.value = true;
      // Fetch orders from API
      await Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createOrder({
    required String farmId,
    required List<Map<String, dynamic>> items,
    required String deliveryAddress,
    required String city,
    required String phoneNumber,
    required String paymentMethod,
  }) async {
    try {
      isLoading.value = true;
      // Create order via API
      await Future.delayed(const Duration(seconds: 1));
      Get.snackbar('Success', 'Order placed successfully');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
