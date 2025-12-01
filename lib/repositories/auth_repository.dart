import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user_model.dart';
import '../utils/app_constants.dart';

class AuthRepository {
  final String _baseUrl = AppConstants.baseUrl;
  String? _token;

  AuthRepository({String? token}) : _token = token;

  Future<AuthResponse> register({
    required String fullName,
    required String email,
    required String password,
    required String phoneNumber,
    required String role,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'fullName': fullName,
          'email': email,
          'password': password,
          'phoneNumber': phoneNumber,
          'role': role,
        }),
      );
      if (response.statusCode == 201) {
        final data = AuthResponse.fromJson(jsonDecode(response.body));
        _token = data.token;
        return data;
      }
      throw Exception('Registration failed');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );
      if (response.statusCode == 200) {
        final data = AuthResponse.fromJson(jsonDecode(response.body));
        _token = data.token;
        return data;
      }
      throw Exception('Login failed');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  void logout() {
    _token = null;
  }

  String? getToken() => _token;
}
