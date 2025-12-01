class Farm {
  final String id;
  final String farmName;
  final String location;
  final String address;
  final String farmType;
  final int capacity;
  final String? description;
  final String? farmImage;
  final double averageRating;
  final int reviewCount;
  final bool isVerified;

  Farm({
    required this.id,
    required this.farmName,
    required this.location,
    required this.address,
    required this.farmType,
    required this.capacity,
    this.description,
    this.farmImage,
    this.averageRating = 0.0,
    this.reviewCount = 0,
    this.isVerified = false,
  });

  factory Farm.fromJson(Map<String, dynamic> json) {
    return Farm(
      id: json['id'],
      farmName: json['farmName'],
      location: json['location'],
      address: json['address'],
      farmType: json['farmType'],
      capacity: json['capacity'],
      description: json['description'],
      farmImage: json['farmImage'],
      averageRating: (json['averageRating'] ?? 0.0).toDouble(),
      reviewCount: json['reviewCount'] ?? 0,
      isVerified: json['isVerified'] ?? false,
    );
  }
}
