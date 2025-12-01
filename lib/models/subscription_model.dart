class Subscription {
  final String id;
  final String farmId;
  final String frequency;
  final int eggsPerDelivery;
  final String status;
  final DateTime nextDeliveryDate;
  final double pricePerDelivery;

  Subscription({
    required this.id,
    required this.farmId,
    required this.frequency,
    required this.eggsPerDelivery,
    required this.status,
    required this.nextDeliveryDate,
    required this.pricePerDelivery,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      id: json['id'],
      farmId: json['farmId'],
      frequency: json['frequency'],
      eggsPerDelivery: json['eggsPerDelivery'],
      status: json['status'],
      nextDeliveryDate: DateTime.parse(json['nextDeliveryDate']),
      pricePerDelivery: (json['pricePerDelivery'] ?? 0.0).toDouble(),
    );
  }
}
