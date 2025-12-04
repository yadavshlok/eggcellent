import 'package:get/get.dart';
import '../models/batch_model.dart';
import '../models/cart_item.dart';

class CartController extends GetxController {
  final RxList<CartItem> items = <CartItem>[].obs;
  final RxBool isDrawerOpen = false.obs;

  double get totalAmount => items.fold(0, (sum, item) => sum + item.totalPrice);
  int get itemCount => items.length;

  void addToCart(Batch batch, String farmName) {
    final existingIndex = items.indexWhere((item) => item.batchId == batch.id);

    if (existingIndex != -1) {
      items[existingIndex].quantity++;
      items.refresh();
    } else {
      items.add(CartItem(
        batchId: batch.id,
        eggType: batch.eggType,
        pricePerEgg: batch.pricePerEgg,
        quantity: 1,
        farmName: farmName,
      ));
    }

    Get.snackbar(
      'Added to Cart',
      '${batch.eggType} added successfully',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  void removeFromCart(String batchId) {
    items.removeWhere((item) => item.batchId == batchId);
  }

  void updateQuantity(String batchId, int quantity) {
    final index = items.indexWhere((item) => item.batchId == batchId);
    if (index != -1) {
      if (quantity > 0) {
        items[index].quantity = quantity;
        items.refresh();
      } else {
        removeFromCart(batchId);
      }
    }
  }

  void toggleDrawer() {
    isDrawerOpen.value = !isDrawerOpen.value;
  }

  void clearCart() {
    items.clear();
  }
}
