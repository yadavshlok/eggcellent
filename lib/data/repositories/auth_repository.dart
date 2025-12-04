import '../../utils/api_constants.dart';
import '../models/auth/login_request.dart';
import '../models/auth/login_response.dart';
import '../models/auth/register_request.dart';
import '../models/auth/register_response.dart';
import '../services/api_service.dart';

class AuthRepository {
  final ApiService _apiService = ApiService();

  // Login
  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await _apiService.post(
        ApiConstants.login,
        request.toJson(),
      );
      return LoginResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  // Register
  Future<RegisterResponse> register(RegisterRequest request) async {
    try {
      final response = await _apiService.post(
        ApiConstants.register,
        request.toJson(),
      );
      return RegisterResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
