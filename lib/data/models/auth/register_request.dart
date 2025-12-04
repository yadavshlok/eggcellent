class RegisterRequest {
  final String email;
  final String password;
  final String name;
  final String role;

  RegisterRequest({
    required this.email,
    required this.password,
    required this.name,
    required this.role,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'name': name,
      'phone': '0000000000', // Default placeholder
      'role': role.toUpperCase(), // CUSTOMER or FARMER
      'address': 'Not specified',
      'city': 'Not specified',
      'latitude': 0.0,
      'longitude': 0.0,
      'isActive': true,
    };
  }
}
