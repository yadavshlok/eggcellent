// lib/data/models/batch.dart
class Batch {
  final int id;
  final int farmId;
  final String eggType;
  final int quantity;
  final double price;
  final String? laidAt;      // or harvestDate
  final String? expiryAt;
  final double? freshnessScore;
  final String? status;

  Batch({
    required this.id,
    required this.farmId,
    required this.eggType,
    required this.quantity,
    required this.price,
    this.laidAt,
    this.expiryAt,
    this.freshnessScore,
    this.status,
  });

  factory Batch.fromJson(Map<String, dynamic> json) {
    return Batch(
      id: json['id'] ?? 0,
      farmId: json['farm_id'] ?? json['farmId'] ?? 0,
      eggType: json['egg_type'] ?? json['name'] ?? '',
      quantity: json['quantity'] ?? 0,
      price: (json['price'] ?? json['pricePerUnit'] ?? 0).toDouble(),
      laidAt: json['laid_at']?.toString(),
      expiryAt: json['expiry_at'],
      freshnessScore:
      json['freshness_score'] != null ? (json['freshness_score'] as num).toDouble() : null,
      status: json['status'],
    );
  }
}
