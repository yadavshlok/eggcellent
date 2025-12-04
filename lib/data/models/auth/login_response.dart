import '../user.dart';

class LoginResponse {
  final User user;

  LoginResponse({required this.user});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      user: User.fromJson(json['user'] ?? json), // Handle both formats
    );
  }
}
