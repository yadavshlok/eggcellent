import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../utils/api_constants.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  final http.Client _client = http.Client();

  // POST Request
  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> body) async {
    try {
      final url = Uri.parse('${ApiConstants.baseUrl}$endpoint');

      print('🔵 API Request: POST $url');
      print('📤 Body: ${jsonEncode(body)}');

      final response = await _client.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      ).timeout(ApiConstants.connectionTimeout);

      print('📥 Response Status: ${response.statusCode}');
      print('📥 Response Body: ${response.body}');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(response.body);
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['message'] ?? 'Something went wrong');
      }
    } catch (e) {
      print('❌ API Error: $e');
      rethrow;
    }
  }

  // GET Request
  Future<dynamic> get(String endpoint, {String? token}) async {
    try {
      final url = Uri.parse('${ApiConstants.baseUrl}$endpoint');

      print('🔵 API Request: GET $url');

      final response = await _client.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      ).timeout(ApiConstants.receiveTimeout);

      print('📥 Response Status: ${response.statusCode}');
      print('📥 Response Body: ${response.body}');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(response.body);
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['message'] ?? 'Something went wrong');
      }
    } catch (e) {
      print('❌ API Error: $e');
      rethrow;
    }
  }

  // DELETE Request
  Future<void> delete(String endpoint, {String? token}) async {
    try {
      final url = Uri.parse('${ApiConstants.baseUrl}$endpoint');

      print('🔵 API Request: DELETE $url');

      final response = await _client.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      ).timeout(ApiConstants.connectionTimeout);

      print('📥 Response Status: ${response.statusCode}');
      print('📥 Response Body: ${response.body}');

      if (response.statusCode < 200 || response.statusCode >= 300) {
        if (response.body.isNotEmpty) {
          final error = jsonDecode(response.body);
          throw Exception(error['message'] ?? 'Failed to delete');
        } else {
          throw Exception('Failed to delete');
        }
      }
    } catch (e) {
      print('❌ API Error: $e');
      rethrow;
    }
  }

  // PUT Request
  Future<Map<String, dynamic>> put(String endpoint, Map<String, dynamic> body) async {
    try {
      final url = Uri.parse('${ApiConstants.baseUrl}$endpoint');
      print('🔵 API Request: PUT $url');
      print('📤 Body: ${jsonEncode(body)}');

      final response = await _client.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      ).timeout(ApiConstants.connectionTimeout);

      print('📥 Response Status: ${response.statusCode}');
      print('📥 Response Body: ${response.body}');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(response.body);
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['message'] ?? 'Something went wrong');
      }
    } catch (e) {
      print('❌ API Error: $e');
      rethrow;
    }
  }

}
