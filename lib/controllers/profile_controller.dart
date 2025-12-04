// lib/controllers/profile_controller.dart
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/models/user.dart';
import '../data/models/user/update_user_request.dart';
import '../data/repositories/user_repository.dart';
import '../routes/app_routes.dart';

class ProfileController extends GetxController {
  final UserRepository _userRepository = UserRepository();

  var isLoading = false.obs;
  Rx<User?> currentUser = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    loadUserProfile();
  }

  // Load user profile from SharedPreferences (no API call)
  Future<void> loadUserProfile() async {
    try {
      isLoading.value = true;

      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId');
      final name = prefs.getString('userName');
      final email = prefs.getString('userEmail');
      final role = prefs.getString('role');
      print('userId=${prefs.getString('userId')} '
          'name=${prefs.getString('userName')} '
          'email=${prefs.getString('userEmail')} '
          'role=${prefs.getString('role')}');


      if (userId == null || name == null || email == null) {
        Get.snackbar(
          'Error',
          'User not found. Please login again.',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      // Create User object from stored data
      currentUser.value = User(
        id: int.parse(userId),
        email: email,
        name: name,
        phone: '',  // Not stored during login, will be empty
        role: '',
        address: null,
        city: null,
        latitude: null,
        longitude: null,
        isActive: true,
      );

    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load profile: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Update user profile - keeping this for when backend adds the endpoint
  // lib/controllers/profile_controller.dart

  Future<void> updateProfile({
    String? name,
    String? email,
    String? phone,
    String? address,
    String? city,
    String? password,
  }) async {
    print('➡️ updateProfile called');      // <--- debug

    try {
      isLoading.value = true;

      final prefs = await SharedPreferences.getInstance();

      if (name != null) await prefs.setString('userName', name);
      if (email != null) await prefs.setString('userEmail', email);
      if (phone != null) await prefs.setString('userPhone', phone);
      if (address != null) await prefs.setString('userAddress', address);
      if (city != null) await prefs.setString('userCity', city);

      final existing = currentUser.value;
      if (existing != null) {
        currentUser.value = User(
          id: existing.id,
          email: email ?? existing.email,
          name: name ?? existing.name,
          phone: phone ?? existing.phone,
          role: existing.role,
          address: address ?? existing.address,
          city: city ?? existing.city,
          latitude: existing.latitude,
          longitude: existing.longitude,
          isActive: existing.isActive,
        );
      }

      Get.snackbar(
        'Success',
        'Profile updated successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.primary,
        colorText: Get.theme.colorScheme.onPrimary,
      );
      print('✅ about to close edit screen');

      // inside updateProfile, after snackbar
      Get.offNamed(AppRoutes.profile);

    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update profile: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    } finally {
      isLoading.value = false;
    }
  }


  // Refresh profile
  void refreshProfile() {
    loadUserProfile();
  }
}
