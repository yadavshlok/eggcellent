import 'package:get/get.dart';
import '../repositories/auth_repository.dart';
import '../models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();

  final isLoading = false.obs;
  final isLoggedIn = false.obs;
  Rx<User?> currentUser = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      isLoggedIn.value = true;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;
      final response = await _authRepository.login(
        email: email,
        password: password,
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', response.token);
      await prefs.setString('userId', response.user.id);

      currentUser.value = response.user;
      isLoggedIn.value = true;

      Get.snackbar('Success', 'Login successful');
    } catch (e) {
      Get.snackbar('Error', e.toString());
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
      final response = await _authRepository.register(
        fullName: fullName,
        email: email,
        password: password,
        phoneNumber: phoneNumber,
        role: role,
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', response.token);
      await prefs.setString('userId', response.user.id);

      currentUser.value = response.user;
      isLoggedIn.value = true;

      Get.snackbar('Success', 'Registration successful');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      await prefs.remove('userId');

      _authRepository.logout();
      currentUser.value = null;
      isLoggedIn.value = false;

      Get.snackbar('Success', 'Logged out successfully');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
