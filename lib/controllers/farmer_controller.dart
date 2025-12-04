import 'package:get/get.dart';
import '../data/models/farm.dart';

class FarmerController extends GetxController {
  var farmerName = 'John Farmer'.obs;
  var farmerEmail = 'john@farm.com'.obs;

  var isLoading = false.obs;
  var todayOrders = 24.obs;
  var weeklyRevenue = 12500.0.obs;
  var activeSubscriptions = 8.obs;
  var averageRating = 4.5.obs;

  @override
  void onInit() {
    super.onInit();
    loadDashboardData();
  }

  void loadDashboardData() {
    isLoading.value = true;

    // Mock stats - Replace with actual API calls when available
    todayOrders.value = 24;
    weeklyRevenue.value = 12500.0;
    activeSubscriptions.value = 8;
    averageRating.value = 4.5;

    isLoading.value = false;
  }

  void updateDashboardStats() {
    // Fetch fresh dashboard stats from API
    loadDashboardData();
  }

  void refreshDashboard() {
    loadDashboardData();
  }
}
