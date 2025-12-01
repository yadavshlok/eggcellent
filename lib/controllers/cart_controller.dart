import 'package:get/get.dart';

class CartItem {
  final String id;
  final String eggType;
  final String farmName;
  final double pricePerUnit;
  final int quantity;

  CartItem({
    required this.id,
    required this.eggType,
    required this.farmName,
    required this.pricePerUnit,
    required this.quantity,
  });
}

class CartController extends GetxController {
  final RxList<CartItem> cart = <CartItem>[].obs;
  final RxDouble subtotal = 0.0.obs;
  final RxDouble deliveryFee = 40.0.obs;
  final RxDouble total = 0.0.obs;

  bool get isEmpty => cart.isEmpty;

  void addToCart({
    required String id,
    required String eggType,
    required String farmName,
    required double pricePerUnit,
    required int quantity,
  }) {
    // Check if item already exists
    final existingIndex = cart.indexWhere((item) => item.id == id);

    if (existingIndex >= 0) {
      // Update quantity
      final existingItem = cart[existingIndex];
      cart[existingIndex] = CartItem(
        id: existingItem.id,
        eggType: existingItem.eggType,
        farmName: existingItem.farmName,
        pricePerUnit: existingItem.pricePerUnit,
        quantity: existingItem.quantity + quantity,
      );
    } else {
      // Add new item
      cart.add(CartItem(
        id: id,
        eggType: eggType,
        farmName: farmName,
        pricePerUnit: pricePerUnit,
        quantity: quantity,
      ));
    }
    _calculateTotals();
  }

  void removeFromCart(String id) {
    cart.removeWhere((item) => item.id == id);
    _calculateTotals();
  }

  void clearCart() {
    cart.clear();
    _calculateTotals();
  }

  void _calculateTotals() {
    double sum = 0.0;
    for (var item in cart) {
      sum += item.pricePerUnit * item.quantity;
    }
    subtotal.value = sum;
    total.value = sum + deliveryFee.value;
  }

  void updateDeliveryFee(double fee) {
    deliveryFee.value = fee;
    total.value = subtotal.value + deliveryFee.value;
  }
}
