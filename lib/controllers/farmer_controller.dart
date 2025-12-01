import 'package:get/get.dart';
import '../models/dashboard_model.dart';
import '../models/order_model.dart';

class FarmerController extends GetxController {
  final isLoading = false.obs;
  Rx<DashboardStats?> stats = Rx<DashboardStats?>(null);
  final earningTrends = <EarningTrend>[].obs;
  final incomingOrders = <Order>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchDashboardData();
  }

  Future<void> fetchDashboardData() async {
    try {
      isLoading.value = true;
      // Fetch dashboard data from API
      await Future.delayed(const Duration(seconds: 1));

      // Mock data
      stats.value = DashboardStats(
        totalBatches: 25,
        totalEarnings: 125000,
        activeOrders: 8,
        freshnessScore: 95.5,
      );

      earningTrends.value = [
        EarningTrend(date: 'Mon', amount: 5000),
        EarningTrend(date: 'Tue', amount: 7500),
        EarningTrend(date: 'Wed', amount: 6200),
        EarningTrend(date: 'Thu', amount: 8100),
        EarningTrend(date: 'Fri', amount: 9500),
        EarningTrend(date: 'Sat', amount: 12000),
        EarningTrend(date: 'Sun', amount: 10500),
      ];
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
