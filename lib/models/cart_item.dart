class CartItem {
  final String batchId;
  final String eggType;
  final double pricePerEgg;
  int quantity;
  final String farmName;

  CartItem({
    required this.batchId,
    required this.eggType,
    required this.pricePerEgg,
    required this.quantity,
    required this.farmName,
  });

  double get totalPrice => pricePerEgg * quantity;
}
