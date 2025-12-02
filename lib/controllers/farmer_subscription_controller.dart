import 'package:get/get.dart';
import '../models/farmer_subscription.dart';
import '../utils/colors.dart';

class FarmerSubscriptionsController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxList<FarmerSubscription> subscriptions = <FarmerSubscription>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchSubscriptions();
  }

  Future<void> fetchSubscriptions() async {
    try {
      isLoading.value = true;

      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Mock data
      subscriptions.value = [
        FarmerSubscription(
          id: '1',
          customerId: '1001',
          customerName: 'Rajesh Kumar',
          frequency: 'Weekly',
          quantityPerDelivery: 12,
          pricePerOrder: 240.0,
          nextDelivery: DateTime.now().add(const Duration(days: 6)),
          status: 'Active',
        ),
        FarmerSubscription(
          id: '2',
          customerId: '1002',
          customerName: 'Priya Sharma',
          frequency: 'Bi-Weekly',
          quantityPerDelivery: 24,
          pricePerOrder: 480.0,
          nextDelivery: DateTime.now().add(const Duration(days: 10)),
          status: 'Active',
        ),
        FarmerSubscription(
          id: '3',
          customerId: '1003',
          customerName: 'Amit Patel',
          frequency: 'Weekly',
          quantityPerDelivery: 12,
          pricePerOrder: 240.0,
          nextDelivery: DateTime.now().add(const Duration(days: 5)),
          status: 'Paused',
        ),
        FarmerSubscription(
          id: '4',
          customerId: '1004',
          customerName: 'Sneha Reddy',
          frequency: 'Monthly',
          quantityPerDelivery: 30,
          pricePerOrder: 600.0,
          nextDelivery: DateTime.now().add(const Duration(days: 20)),
          status: 'Active',
        ),
      ];
    } catch (e) {
      print('Error fetching subscriptions: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void pauseSubscription(String subscriptionId) {
    Get.snackbar(
      'Success',
      'Subscription paused',
      backgroundColor: AppColors.warning,
      colorText: AppColors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
    fetchSubscriptions();
  }

  void cancelSubscription(String subscriptionId) {
    Get.defaultDialog(
      title: 'Cancel Subscription',
      middleText: 'Are you sure you want to cancel this subscription?',
      textCancel: 'No',
      textConfirm: 'Yes, Cancel',
      confirmTextColor: AppColors.white,
      buttonColor: AppColors.error,
      onConfirm: () {
        subscriptions.removeWhere((s) => s.id == subscriptionId);
        Get.back();
        Get.snackbar(
          'Cancelled',
          'Subscription cancelled',
          backgroundColor: AppColors.error,
          colorText: AppColors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      },
    );
  }

  void refreshSubscriptions() {
    fetchSubscriptions();
  }
}
