class CreateFarmRequest {
  final int userId;
  final String farmName;
  final String description;
  final String address;
  final String city;
  final String farmType;
  final int capacity;
  final double? latitude;
  final double? longitude;

  CreateFarmRequest({
    required this.userId,
    required this.farmName,
    required this.description,
    required this.address,
    required this.city,
    required this.farmType,
    required this.capacity,
    this.latitude,
    this.longitude,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'farmName': farmName,
      'description': description,
      'address': address,
      'city': city,
      'latitude': latitude ?? 18.55,
      'longitude': longitude ?? 73.90,
      'farmType': farmType,
      'capacity': capacity,
      'isVerified': false,
      'rating': 0.0,
      'totalReviews': 0,
    };
  }
}
