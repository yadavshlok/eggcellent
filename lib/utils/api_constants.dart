class ApiConstants {
  // Base URL - Change this to your server IP when testing on device
  static const String baseUrl = 'http://10.0.2.2:8084/api';

  // Auth Endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';

  static const String farms = '/farms';
  static String farmById(int id) => '/farms/$id';
  static String farmsByUserId(int userId) => '/farms/user/$userId';
  static String deleteFarm(int id) => '/farms/$id';

  // Timeouts
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}
