import '../user.dart';

class RegisterResponse {
  final User user;

  RegisterResponse({required this.user});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      user: User.fromJson(json['user'] ?? json), // Handle both formats
    );
  }
}
