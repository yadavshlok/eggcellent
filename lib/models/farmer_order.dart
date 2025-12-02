class FarmerOrderItem {
  final String productName;
  final int quantity;
  final double price;

  FarmerOrderItem({
    required this.productName,
    required this.quantity,
    required this.price,
  });
}

class FarmerOrder {
  final String id;
  final String customerName;
  final String customerPhone;
  final String deliveryAddress;
  final List<FarmerOrderItem> items;
  final double total;
  final DateTime orderDate;
  final String status;

  FarmerOrder({
    required this.id,
    required this.customerName,
    required this.customerPhone,
    required this.deliveryAddress,
    required this.items,
    required this.total,
    required this.orderDate,
    required this.status,
  });

  factory FarmerOrder.fromJson(Map<String, dynamic> json) {
    return FarmerOrder(
      id: json['id'],
      customerName: json['customerName'],
      customerPhone: json['customerPhone'],
      deliveryAddress: json['deliveryAddress'],
      items: (json['items'] as List)
          .map((item) => FarmerOrderItem(
        productName: item['productName'],
        quantity: item['quantity'],
        price: item['price'].toDouble(),
      ))
          .toList(),
      total: json['total'].toDouble(),
      orderDate: DateTime.parse(json['orderDate']),
      status: json['status'],
    );
  }
}
