import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/models/auth/login_request.dart';
import '../data/models/auth/login_response.dart';
import '../data/models/auth/register_request.dart';
import '../data/models/auth/register_response.dart';
import '../data/repositories/auth_repository.dart';
import '../routes/app_routes.dart';

class AuthController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();

  var isLoading = false.obs;
  var isLoggedIn = false.obs;
  var userName = ''.obs;
  var userEmail = ''.obs;
  var userRole = ''.obs;
  var userId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  // Check if user is already logged in (using userId instead of token)
  Future<void> checkLoginStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('userId');
      final role = prefs.getString('userRole');
      final name = prefs.getString('userName');
      final email = prefs.getString('userEmail');

      print('🔍 Checking login status...');
      print('UserId: $userId');
      print('Role: $role');

      // Check if userId exists (instead of token)
      if (userId != null && userId.isNotEmpty && userId != '0') {
        isLoggedIn.value = true;
        userRole.value = role ?? 'CUSTOMER';
        userName.value = name ?? '';
        userEmail.value = email ?? '';
        this.userId.value = userId;
        print('✅ User is logged in!');
      } else {
        print('❌ No user session found');
      }
    } catch (e) {
      print('Error checking login status: $e');
    }
  }

  // Login
  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;

      final request = LoginRequest(email: email, password: password);
      final response = await _authRepository.login(request);

      // Save to SharedPreferences (no token needed!)
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userId', response.user.id.toString());
      await prefs.setString('userName', response.user.name);
      await prefs.setString('userEmail', response.user.email);
      await prefs.setString('userRole', response.user.role);
      await prefs.setBool('isLoggedIn', true); // Simple flag

      // Update controller state
      isLoggedIn.value = true;
      userName.value = response.user.name;
      userEmail.value = response.user.email;
      userRole.value = response.user.role;
      userId.value = response.user.id.toString();

      print('🟢 Login successful! Saved data:');
      print('UserId: ${response.user.id}');
      print('Role: ${response.user.role}');
      print('Name: ${response.user.name}');

      // Navigate based on role
      if (response.user.role == 'FARMER') {
        Get.offAllNamed(AppRoutes.farmerDashboard);
      } else {
        Get.offAllNamed(AppRoutes.customerHome);
      }

      Get.snackbar(
        'Success',
        'Welcome back, ${response.user.name}!',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Login Failed',
        e.toString().replaceAll('Exception: ', ''),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Register
  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String role,
  }) async {
    try {
      isLoading.value = true;

      final request = RegisterRequest(
        name: name,
        email: email,
        password: password,
        role: role,
      );

      final response = await _authRepository.register(request);

      // Save to SharedPreferences (no token needed!)
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userId', response.user.id.toString());
      await prefs.setString('userName', response.user.name);
      await prefs.setString('userEmail', response.user.email);
      await prefs.setString('userRole', response.user.role);
      await prefs.setBool('isLoggedIn', true);

      // Update controller state
      isLoggedIn.value = true;
      userName.value = response.user.name;
      userEmail.value = response.user.email;
      userRole.value = response.user.role;
      userId.value = response.user.id.toString();

      print('🟢 Registration successful! Saved data:');
      print('UserId: ${response.user.id}');
      print('Role: ${response.user.role}');

      // Navigate based on role
      if (response.user.role == 'FARMER') {
        Get.offAllNamed(AppRoutes.farmerDashboard);
      } else {
        Get.offAllNamed(AppRoutes.customerHome);
      }

      Get.snackbar(
        'Success',
        'Account created successfully!',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Registration Failed',
        e.toString().replaceAll('Exception: ', ''),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      // Reset controller state
      isLoggedIn.value = false;
      userName.value = '';
      userEmail.value = '';
      userRole.value = '';
      userId.value = '';

      Get.offAllNamed(AppRoutes.login);

      Get.snackbar(
        'Logged Out',
        'You have been logged out successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      print('Error during logout: $e');
    }
  }
}
