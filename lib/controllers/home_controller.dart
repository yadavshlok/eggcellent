import 'package:get/get.dart';
import '../models/farm_model.dart';

class HomeController extends GetxController {
  final isLoading = false.obs;
  final nearbyFarms = <Farm>[].obs;
  final recentlyViewed = <Farm>[].obs;
  final stats = {
    'farms': 50,
    'customers': 2500,
    'rating': 4.8,
  }.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNearbyFarms();
  }

  Future<void> fetchNearbyFarms() async {
    try {
      isLoading.value = true;
      // Fetch farms from API
      await Future.delayed(const Duration(seconds: 1));
      // nearbyFarms.value = fetchedFarms;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void searchFarms(String query) {
    // Search logic
  }

  void addToRecentlyViewed(Farm farm) {
    if (!recentlyViewed.contains(farm)) {
      recentlyViewed.insert(0, farm);
      if (recentlyViewed.length > 10) {
        recentlyViewed.removeLast();
      }
    }
  }
}
