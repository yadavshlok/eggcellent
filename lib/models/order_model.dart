class OrderItem {
  final String id;
  final String productName;
  final int quantity;
  final double price;

  OrderItem({
    required this.id,
    required this.productName,
    required this.quantity,
    required this.price,
  });
}

class Order {
  final String id;
  final List<OrderItem> items;
  final double total;
  final String status;
  final DateTime createdAt;
  final String? farmName;
  final String? deliveryAddress;

  Order({
    required this.id,
    required this.items,
    required this.total,
    required this.status,
    required this.createdAt,
    this.farmName,
    this.deliveryAddress,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      items: (json['items'] as List)
          .map((item) => OrderItem(
        id: item['id'],
        productName: item['productName'],
        quantity: item['quantity'],
        price: item['price'].toDouble(),
      ))
          .toList(),
      total: json['total'].toDouble(),
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      farmName: json['farmName'],
      deliveryAddress: json['deliveryAddress'],
    );
  }
}
