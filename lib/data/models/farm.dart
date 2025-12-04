class Farm {
  final int id;
  final int userId;
  final String farmName;
  final String description;
  final String address;
  final String city;
  final double latitude;
  final double longitude;
  final String farmType;
  final int capacity;
  final bool isVerified;
  final double rating;
  final int totalReviews;
  final String? createdAt;

  Farm({
    required this.id,
    required this.userId,
    required this.farmName,
    required this.description,
    required this.address,
    required this.city,
    required this.latitude,
    required this.longitude,
    required this.farmType,
    required this.capacity,
    required this.isVerified,
    required this.rating,
    required this.totalReviews,
    this.createdAt,
  });

  // Computed property for location
  String get location => '$address, $city';

  factory Farm.fromJson(Map<String, dynamic> json) {
    return Farm(
      id: json['id'] != null ? (json['id'] as num).toInt() : 0,
      userId: json['userId'] != null ? (json['userId'] as num).toInt() : 0,
      farmName: json['farmName'] ?? '',
      description: json['description'] ?? '',
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      latitude: json['latitude'] != null ? (json['latitude'] as num).toDouble() : 0.0,
      longitude: json['longitude'] != null ? (json['longitude'] as num).toDouble() : 0.0,
      farmType: json['farmType'] ?? 'ORGANIC',
      capacity: json['capacity'] != null ? (json['capacity'] as num).toInt() : 0,
      isVerified: json['isVerified'] ?? false,
      rating: json['rating'] != null ? (json['rating'] as num).toDouble() : 0.0,
      totalReviews: json['totalReviews'] != null ? (json['totalReviews'] as num).toInt() : 0,
      createdAt: json['createdAt']?.toString(),
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'farmName': farmName,
      'description': description,
      'address': address,
      'city': city,
      'latitude': latitude,
      'longitude': longitude,
      'farmType': farmType,
      'capacity': capacity,
    };
  }
}
