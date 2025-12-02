class FarmerSubscription {
  final String id;
  final String customerId;
  final String customerName;
  final String frequency;
  final int quantityPerDelivery;
  final double pricePerOrder;
  final DateTime nextDelivery;
  final String status;

  FarmerSubscription({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.frequency,
    required this.quantityPerDelivery,
    required this.pricePerOrder,
    required this.nextDelivery,
    required this.status,
  });

  factory FarmerSubscription.fromJson(Map<String, dynamic> json) {
    return FarmerSubscription(
      id: json['id'],
      customerId: json['customerId'],
      customerName: json['customerName'],
      frequency: json['frequency'],
      quantityPerDelivery: json['quantityPerDelivery'],
      pricePerOrder: json['pricePerOrder'].toDouble(),
      nextDelivery: DateTime.parse(json['nextDelivery']),
      status: json['status'],
    );
  }
}
