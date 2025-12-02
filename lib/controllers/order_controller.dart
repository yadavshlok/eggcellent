import 'package:get/get.dart';
import '../models/order_model.dart';

class OrderController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxList<Order> myOrders = <Order>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchMyOrders();
  }

  Future<void> fetchMyOrders() async {
    try {
      isLoading.value = true;

      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Mock data
      myOrders.value = [
        Order(
          id: '001',
          items: [
            OrderItem(
              id: '1',
              productName: 'Brown Eggs',
              quantity: 12,
              price: 20.0,
            ),
            OrderItem(
              id: '2',
              productName: 'White Eggs',
              quantity: 6,
              price: 18.0,
            ),
          ],
          total: 348.0,
          status: 'Delivered',
          createdAt: DateTime.now().subtract(const Duration(days: 2)),
          farmName: 'Sunrise Organic Farm',
          deliveryAddress: 'Whitefield, Bangalore',
        ),
        Order(
          id: '002',
          items: [
            OrderItem(
              id: '3',
              productName: 'Desi Eggs',
              quantity: 10,
              price: 25.0,
            ),
          ],
          total: 250.0,
          status: 'Confirmed',
          createdAt: DateTime.now().subtract(const Duration(days: 1)),
          farmName: 'Green Valley Farms',
          deliveryAddress: 'Sarjapur, Bangalore',
        ),
        Order(
          id: '003',
          items: [
            OrderItem(
              id: '4',
              productName: 'Organic Eggs',
              quantity: 18,
              price: 22.0,
            ),
          ],
          total: 396.0,
          status: 'Pending',
          createdAt: DateTime.now(),
          farmName: 'Happy Hens Farm',
          deliveryAddress: 'Koramangala, Bangalore',
        ),
      ];
    } catch (e) {
      print('Error fetching orders: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void refreshOrders() {
    fetchMyOrders();
  }
}
