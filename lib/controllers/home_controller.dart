import 'package:get/get.dart';

class Farm {
  final String id;
  final String name;
  final String location;
  final double rating;
  final int reviewCount;

  Farm({
    required this.id,
    required this.name,
    required this.location,
    required this.rating,
    required this.reviewCount,
  });
}

class HomeController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxList<Farm> farms = <Farm>[].obs;
  final RxList<Farm> filteredFarms = <Farm>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchNearbyFarms();
  }

  Future<void> fetchNearbyFarms() async {
    try {
      isLoading.value = true;

      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Mock data
      farms.value = [
        Farm(
          id: '1',
          name: 'Sunrise Organic Farm',
          location: 'Whitefield, Bangalore',
          rating: 4.8,
          reviewCount: 324,
        ),
        Farm(
          id: '2',
          name: 'Green Valley Farms',
          location: 'Sarjapur, Bangalore',
          rating: 4.6,
          reviewCount: 189,
        ),
        Farm(
          id: '3',
          name: 'Happy Hens Farm',
          location: 'Koramangala, Bangalore',
          rating: 4.9,
          reviewCount: 456,
        ),
        Farm(
          id: '4',
          name: 'Rural Retreat Farms',
          location: 'Devanahalli, Bangalore',
          rating: 4.5,
          reviewCount: 276,
        ),
        Farm(
          id: '5',
          name: 'Organic Dreams Farm',
          location: 'Yeshwanthpur, Bangalore',
          rating: 4.7,
          reviewCount: 198,
        ),
      ];

      filteredFarms.value = farms;
    } catch (e) {
      print('Error fetching farms: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void searchFarms(String query) {
    if (query.isEmpty) {
      filteredFarms.value = farms;
    } else {
      filteredFarms.value = farms
          .where((farm) =>
      farm.name.toLowerCase().contains(query.toLowerCase()) ||
          farm.location.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  void refreshFarms() {
    fetchNearbyFarms();
  }
}
