import 'package:get/get.dart';

class FarmModel {
  final String id;
  final String name;
  final String location;
  final String type;
  final int birdCount;
  final bool isVerified;

  FarmModel({
    required this.id,
    required this.name,
    required this.location,
    required this.type,
    required this.birdCount,
    this.isVerified = false,
  });
}

class FarmController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxList<FarmModel> farms = <FarmModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchFarms();
  }

  Future<void> fetchFarms() async {
    try {
      isLoading.value = true;

      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Mock data
      farms.value = [
        FarmModel(
          id: '1',
          name: 'Sunrise Organic Farm',
          location: 'Whitefield, Bangalore',
          type: 'Organic',
          birdCount: 500,
          isVerified: true,
        ),
        FarmModel(
          id: '2',
          name: 'Green Valley Farms',
          location: 'Sarjapur Road',
          type: 'Free Range',
          birdCount: 350,
          isVerified: true,
        ),
        FarmModel(
          id: '3',
          name: 'Happy Hens Farm',
          location: 'Koramangala',
          type: 'Organic',
          birdCount: 420,
          isVerified: false,
        ),
        FarmModel(
          id: '4',
          name: 'Rural Retreat',
          location: 'Devanahalli',
          type: 'Traditional',
          birdCount: 280,
          isVerified: true,
        ),
      ];
    } catch (e) {
      print('Error fetching farms: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void addFarm(String name, String location, String type, int birdCount) {
    final newFarm = FarmModel(
      id: DateTime.now().toString(),
      name: name,
      location: location,
      type: type,
      birdCount: birdCount,
      isVerified: false,
    );
    farms.add(newFarm);

    Get.snackbar(
      'Success',
      'Farm added successfully!',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void deleteFarm(String farmId) {
    farms.removeWhere((farm) => farm.id == farmId);

    Get.snackbar(
      'Success',
      'Farm deleted successfully!',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void refreshFarms() {
    fetchFarms();
  }
}
