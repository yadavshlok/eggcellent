class Batch {
  final String id;
  final String eggType;
  final DateTime laidAt;
  final DateTime expiryAt;
  final int quantity;
  final int packsLeft;
  final double pricePerEgg;
  final String stockStatus;
  final double freshnessScore;

  Batch({
    required this.id,
    required this.eggType,
    required this.laidAt,
    required this.expiryAt,
    required this.quantity,
    required this.packsLeft,
    required this.pricePerEgg,
    required this.stockStatus,
    required this.freshnessScore,
  });

  factory Batch.fromJson(Map<String, dynamic> json) {
    return Batch(
      id: json['id'],
      eggType: json['eggType'],
      laidAt: DateTime.parse(json['laidAt']),
      expiryAt: DateTime.parse(json['expiryAt']),
      quantity: json['quantity'],
      packsLeft: json['packsLeft'],
      pricePerEgg: (json['pricePerEgg'] ?? 0.0).toDouble(),
      stockStatus: json['stockStatus'],
      freshnessScore: (json['freshnessScore'] ?? 0.0).toDouble(),
    );
  }
}