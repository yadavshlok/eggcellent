import 'package:get/get.dart';
import '../routes/app_routes.dart';
import '../utils/colors.dart';

class AuthController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxBool _isLoggedIn = false.obs;
  final RxBool _isPasswordVisible = false.obs;  // ✅ Add this

  bool get isLoggedIn => _isLoggedIn.value;
  RxBool get isPasswordVisible => _isPasswordVisible;  // ✅ Add this getter

  @override
  void onInit() {
    super.onInit();
    _checkLoginStatus();
  }

  void _checkLoginStatus() {
    _isLoggedIn.value = false;
  }

  // ✅ Toggle password visibility
  void togglePasswordVisibility() {
    _isPasswordVisible.value = !_isPasswordVisible.value;
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;

      await Future.delayed(const Duration(seconds: 2));

      _isLoggedIn.value = true;

      Get.snackbar(
        'Success',
        'Login successful!',
        backgroundColor: AppColors.success,
        colorText: AppColors.white,
        snackPosition: SnackPosition.BOTTOM,
      );

      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Login failed: ${e.toString()}',
        backgroundColor: AppColors.error,
        colorText: AppColors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register({
    required String fullName,
    required String email,
    required String password,
    required String phoneNumber,
    required String role,
  }) async {
    try {
      isLoading.value = true;

      await Future.delayed(const Duration(seconds: 2));

      _isLoggedIn.value = true;

      Get.snackbar(
        'Success',
        'Registration successful!',
        backgroundColor: AppColors.success,
        colorText: AppColors.white,
        snackPosition: SnackPosition.BOTTOM,
      );

      if (role == 'customer') {
        Get.offAllNamed(AppRoutes.home);
      } else {
        Get.offAllNamed(AppRoutes.farmerDashboard);
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Registration failed: ${e.toString()}',
        backgroundColor: AppColors.error,
        colorText: AppColors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void logout() {
    _isLoggedIn.value = false;
    Get.offAllNamed(AppRoutes.login);

    Get.snackbar(
      'Logged Out',
      'You have been logged out successfully',
      backgroundColor: AppColors.info,
      colorText: AppColors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
