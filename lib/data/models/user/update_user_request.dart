// lib/data/models/user/update_user_request.dart
class UpdateUserRequest {
  final String? email;
  final String? password;
  final String? name;
  final String? phone;
  final String? address;
  final String? city;
  final double? latitude;
  final double? longitude;
  final bool? isActive;

  UpdateUserRequest({
    this.email,
    this.password,
    this.name,
    this.phone,
    this.address,
    this.city,
    this.latitude,
    this.longitude,
    this.isActive,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    if (email != null) data['email'] = email;
    if (password != null && password!.isNotEmpty) data['password'] = password;
    if (name != null) data['name'] = name;
    if (phone != null) data['phone'] = phone;
    if (address != null) data['address'] = address;
    if (city != null) data['city'] = city;
    if (latitude != null) data['latitude'] = latitude;
    if (longitude != null) data['longitude'] = longitude;
    if (isActive != null) data['isActive'] = isActive;

    return data;
  }
}
