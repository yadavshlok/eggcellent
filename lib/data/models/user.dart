// lib/data/models/user.dart
class User {
  final int id;
  final String email;
  final String name;
  final String phone;
  final String role;
  final String? address;
  final String? city;
  final double? latitude;
  final double? longitude;
  final bool? isActive;
  final String? createdAt;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    required this.role,
    this.address,
    this.city,
    this.latitude,
    this.longitude,
    this.isActive,
    this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: (json['id'] ?? 0) as int,
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      role: json['role'] ?? 'CUSTOMER',
      address: json['address'],
      city: json['city'],
      latitude: json['latitude'] != null ? (json['latitude'] as num).toDouble() : null,
      longitude: json['longitude'] != null ? (json['longitude'] as num).toDouble() : null,
      isActive: json['isActive'] as bool? ?? true,
      createdAt: json['createdAt']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phone': phone,
      'role': role,
      'address': address,
      'city': city,
      'latitude': latitude,
      'longitude': longitude,
      'isActive': isActive,
    };
  }
}
