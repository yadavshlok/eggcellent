import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as _apiService;
import '../data/models/farm.dart';
import '../data/models/farm/create_farm_request.dart';
import '../data/repositories/farm_repository.dart';
import '../utils/api_constants.dart';
import 'auth_controller.dart';

class FarmController extends GetxController {
  final FarmRepository _farmRepository = FarmRepository();

  var allFarms = <Farm>[].obs;
  var myFarms = <Farm>[].obs;
  var selectedFarm = Rx<Farm?>(null);  // Add this for selected farm
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllFarms();
    fetchMyFarms();
    loadMyFarms();
  }

  // Fetch all farms
  Future<void> fetchAllFarms() async {
    try {
      isLoading.value = true;
      allFarms.value = await _farmRepository.getAllFarms();
    } catch (e) {
      print('Error fetching farms: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Fetch my farms
  Future<void> fetchMyFarms() async {
    try {
      final authController = Get.find<AuthController>();
      final userId = int.parse(authController.userId.value);

      myFarms.value = await _farmRepository.getFarmsByUserId(userId);
    } catch (e) {
      print('Error fetching my farms: $e');
    }
  }

  // Load farm by ID - THIS IS THE MISSING METHOD
  Future<void> loadFarmById(int farmId) async {
    try {
      isLoading.value = true;
      selectedFarm.value = await _farmRepository.getFarmById(farmId);
    } catch (e) {
      print('Error loading farm: $e');
      Get.snackbar(
        'Error',
        'Failed to load farm details',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Refresh my farms
  Future<void> refreshMyFarms() async {
    try {
      isLoading.value = true;
      await fetchMyFarms();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createFarm({
    required String farmName,
    required String description,
    required String address,
    required String city,
    required String farmType,
    required int capacity,
  }) async {
    try {
      isLoading.value = true;

      final authController = Get.find<AuthController>();
      final userId = int.parse(authController.userId.value);

      final request = CreateFarmRequest(
        userId: userId,
        farmName: farmName,
        description: description,
        address: address,
        city: city,
        farmType: farmType,
        capacity: capacity,
      );

      print('Sending: ${request.toJson()}');

      final farm = await _farmRepository.createFarm(request);

      print('✅ Created farm: ID=${farm.id}, Name=${farm.farmName}'); // Debug print

      myFarms.add(farm);
      allFarms.add(farm); // ✅ Also add to allFarms

      Get.back();
      Get.snackbar('Success', 'Farm created!', snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      print('Error creating farm: $e');
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMyFarms() async {
    isLoading.value = true;
    try {
      final data = await _farmRepository.getMyFarms(); // GET /api/farms/mine
      myFarms.value = data;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshFarms() => loadMyFarms();

// Delete farm
  Future<void> deleteFarm(int farmId) async {
    try {
      isLoading.value = true;

      await _farmRepository.deleteFarm(farmId);

      // Remove from myFarms list
      myFarms.removeWhere((farm) => farm.id == farmId);

      // Also remove from allFarms if it exists there
      allFarms.removeWhere((farm) => farm.id == farmId);

      Get.snackbar(
        'Success',
        'Farm deleted successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        icon: Icon(Icons.check_circle, color: Colors.white),
        duration: Duration(seconds: 2),
      );
    } catch (e) {
      print('❌ Error deleting farm: $e');
      Get.snackbar(
        'Error',
        'Failed to delete farm: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        icon: Icon(Icons.error, color: Colors.white),
        duration: Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false;
    }
  }


}
