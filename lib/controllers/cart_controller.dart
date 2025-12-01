import 'package:get/get.dart';
import '../models/cart_model.dart';

class CartController extends GetxController {
  final cart = <CartItem>[].obs;
  final subtotal = 0.0.obs;
  final deliveryFee = 50.0.obs;
  final total = 0.0.obs;

  bool get isEmpty => cart.isEmpty;

  void addToCart(CartItem item) {
    final existingIndex = cart.indexWhere((i) => i.batchId == item.batchId);
    if (existingIndex >= 0) {
      cart[existingIndex].quantity += item.quantity;
    } else {
      cart.add(item);
    }
    calculateTotal();
    Get.snackbar('Success', 'Item added to cart');
  }

  void removeFromCart(String itemId) {
    cart.removeWhere((item) => item.id == itemId);
    calculateTotal();
  }

  void updateQuantity(String itemId, int quantity) {
    final index = cart.indexWhere((item) => item.id == itemId);
    if (index >= 0) {
      cart[index].quantity = quantity;
      calculateTotal();
    }
  }

  void calculateTotal() {
    subtotal.value = cart.fold(0.0, (sum, item) => sum + item.totalPrice);
    total.value = subtotal.value + deliveryFee.value;
  }

  void clearCart() {
    cart.clear();
    calculateTotal();
  }
}
