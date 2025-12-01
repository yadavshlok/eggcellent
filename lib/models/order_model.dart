class OrderItem {
  final String batchId;
  final String eggType;
  final int quantity;
  final double pricePerUnit;

  OrderItem({
    required this.batchId,
    required this.eggType,
    required this.quantity,
    required this.pricePerUnit,
  });
}

class Order {
  final String id;
  final String farmId;
  final List<OrderItem> items;
  final String status;
  final String deliveryAddress;
  final String city;
  final String phoneNumber;
  final String paymentMethod;
  final double subtotal;
  final double deliveryFee;
  final double total;
  final DateTime createdAt;

  Order({
    required this.id,
    required this.farmId,
    required this.items,
    required this.status,
    required this.deliveryAddress,
    required this.city,
    required this.phoneNumber,
    required this.paymentMethod,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
    required this.createdAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      farmId: json['farmId'],
      items: (json['items'] as List).map((e) => OrderItem(
        batchId: e['batchId'],
        eggType: e['eggType'],
        quantity: e['quantity'],
        pricePerUnit: (e['pricePerUnit'] ?? 0.0).toDouble(),
      )).toList(),
      status: json['status'],
      deliveryAddress: json['deliveryAddress'],
      city: json['city'],
      phoneNumber: json['phoneNumber'],
      paymentMethod: json['paymentMethod'],
      subtotal: (json['subtotal'] ?? 0.0).toDouble(),
      deliveryFee: (json['deliveryFee'] ?? 0.0).toDouble(),
      total: (json['total'] ?? 0.0).toDouble(),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
