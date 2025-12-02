import 'package:get/get.dart';
import '../models/subscription_model.dart';
import '../utils/colors.dart';

class SubscriptionController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxList<Subscription> subscriptions = <Subscription>[].obs;

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
        Subscription(
          id: '1',
          farmName: 'Sunny Acres Farm',
          frequency: 'Weekly',
          quantityPerDelivery: 12,
          pricePerOrder: 240.0,
          nextDelivery: DateTime.now().add(const Duration(days: 6)),
          status: 'Active',
        ),
        Subscription(
          id: '2',
          farmName: 'Green Valley Organic',
          frequency: 'Bi-Weekly',
          quantityPerDelivery: 24,
          pricePerOrder: 480.0,
          nextDelivery: DateTime.now().add(const Duration(days: 10)),
          status: 'Active',
        ),
        Subscription(
          id: '3',
          farmName: 'Happy Hens Farm',
          frequency: 'Monthly',
          quantityPerDelivery: 30,
          pricePerOrder: 600.0,
          nextDelivery: DateTime.now().add(const Duration(days: 20)),
          status: 'Paused',
        ),
      ];
    } catch (e) {
      print('Error fetching subscriptions: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void pauseSubscription(String subscriptionId) {
    final index = subscriptions.indexWhere((s) => s.id == subscriptionId);
    if (index != -1) {
      // Update subscription status
      Get.snackbar(
        'Success',
        'Subscription paused successfully',
        backgroundColor: AppColors.warning,
        colorText: AppColors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      fetchSubscriptions();
    }
  }

  void cancelSubscription(String subscriptionId) {
    Get.defaultDialog(
      title: 'Cancel Subscription',
      middleText: 'Are you sure you want to cancel this subscription?',
      textCancel: 'No',
      textConfirm: 'Yes, Cancel',
      confirmTextColor: AppColors.white,
      onConfirm: () {
        subscriptions.removeWhere((s) => s.id == subscriptionId);
        Get.back();
        Get.snackbar(
          'Success',
          'Subscription cancelled successfully',
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
