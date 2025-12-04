class Subscription {
  final String id;
  final String customerId;
  final String farmId;
  final String farmName;
  final String planType; // weekly, monthly
  final String eggType;
  final int quantity;
  final double pricePerDelivery;
  final DateTime startDate;
  final DateTime? endDate;
  final String status; // active, paused, cancelled
  final DateTime? nextDelivery;

  Subscription({
    required this.id,
    required this.customerId,
    required this.farmId,
    required this.farmName,
    required this.planType,
    required this.eggType,
    required this.quantity,
    required this.pricePerDelivery,
    required this.startDate,
    this.endDate,
    required this.status,
    this.nextDelivery,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      id: json['id'],
      customerId: json['customerId'],
      farmId: json['farmId'],
      farmName: json['farmName'],
      planType: json['planType'],
      eggType: json['eggType'],
      quantity: json['quantity'],
      pricePerDelivery: json['pricePerDelivery'].toDouble(),
      startDate: DateTime.parse(json['startDate']),
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      status: json['status'],
      nextDelivery: json['nextDelivery'] != null ? DateTime.parse(json['nextDelivery']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customerId': customerId,
      'farmId': farmId,
      'farmName': farmName,
      'planType': planType,
      'eggType': eggType,
      'quantity': quantity,
      'pricePerDelivery': pricePerDelivery,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'status': status,
      'nextDelivery': nextDelivery?.toIso8601String(),
    };
  }
}
