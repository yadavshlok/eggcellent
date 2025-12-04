// lib/data/repositories/user_repository.dart
import '../models/user.dart';
import '../models/user/update_user_request.dart';
import '../services/api_service.dart';

class UserRepository {
  final ApiService _apiService = ApiService();

  Future<User> getUserById(int userId) async {
    final response = await _apiService.get('/users/$userId');
    return User.fromJson(response);
  }

  // Future<User> updateUser(int userId, UpdateUserRequest request) async {
  //   final response = await _apiService.put('/users/$userId', request.toJson());
  //   return User.fromJson(response);
  // }
}
