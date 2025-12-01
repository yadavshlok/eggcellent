// lib/controllers/auth_controller.dart

import 'package:get/get.dart';

class AuthController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxBool isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    try {
      // API call here
      await Future.delayed(const Duration(seconds: 2));
      // On success navigate to home
      print('Login successful: $email');
    } catch (e) {
      print('Login error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register(String email, String password) async {
    isLoading.value = true;
    try {
      // API call here
      await Future.delayed(const Duration(seconds: 2));
      print('Registration successful: $email');
    } catch (e) {
      print('Registration error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void logout() {
    isPasswordVisible.value = false;
    print('Logged out');
  }
}
