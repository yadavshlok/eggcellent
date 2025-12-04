import '../../utils/api_constants.dart';
import '../models/farm.dart';
import '../models/farm/create_farm_request.dart';
import '../services/api_service.dart';

class FarmRepository {
  final ApiService _apiService = ApiService();

  // Get all farms
  Future<List<Farm>> getAllFarms() async {
    try {
      final response = await _apiService.get(ApiConstants.farms);

      if (response is List) {
        return response.map((farm) => Farm.fromJson(farm)).toList();
      } else {
        throw Exception('Invalid response format');
      }
    } catch (e) {
      rethrow;
    }
  }

  // Get farm by ID
  Future<Farm> getFarmById(int id) async {
    try {
      final response = await _apiService.get(ApiConstants.farmById(id));
      return Farm.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  // Get farms by user ID
  Future<List<Farm>> getFarmsByUserId(int userId) async {
    try {
      final response = await _apiService.get(ApiConstants.farmsByUserId(userId));

      if (response is List) {
        return response.map((farm) => Farm.fromJson(farm)).toList();
      } else {
        throw Exception('Invalid response format');
      }
    } catch (e) {
      rethrow;
    }
  }
  Future<List<Farm>> getMyFarms() async {
    final res = await _apiService.get('/farms/mine');
    return (res as List).map((e) => Farm.fromJson(e)).toList();
  }

  // Create farm
  Future<Farm> createFarm(CreateFarmRequest request) async {
    try {
      print('📤 Creating farm: ${request.toJson()}');

      final response = await _apiService.post(
        ApiConstants.farms,
        request.toJson(),
      );

      print('📥 Backend response: $response'); // ✅ IMPORTANT - check this

      return Farm.fromJson(response);
    } catch (e) {
      print('Repository error: $e');
      rethrow;
    }
  }


// Delete farm
  Future<void> deleteFarm(int farmId) async {
    try {
      print('🗑️ Deleting farm with ID: $farmId');

      await _apiService.delete('${ApiConstants.farms}/$farmId');

      print('✅ Farm deleted successfully');
    } catch (e) {
      print('❌ Repository delete error: $e');
      rethrow;
    }
  }

}
