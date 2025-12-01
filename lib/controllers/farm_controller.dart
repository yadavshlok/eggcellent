import 'package:get/get.dart';
import '../models/farm_model.dart';
import '../models/batch_model.dart';

class FarmController extends GetxController {
  final isLoading = false.obs;
  final myFarms = <Farm>[].obs;
  final farmBatches = <Batch>[].obs;
  Rx<Farm?> selectedFarm = Rx<Farm?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchMyFarms();
  }

  Future<void> fetchMyFarms() async {
    try {
      isLoading.value = true;
      // Fetch farms from API
      await Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchFarmDetails(String farmId) async {
    try {
      isLoading.value = true;
      // Fetch farm details and batches
      await Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
