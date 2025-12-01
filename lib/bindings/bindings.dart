import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../controllers/farm_controller.dart';
import '../controllers/cart_controller.dart';
import '../controllers/order_controller.dart';
import '../controllers/farmer_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<FarmController>(() => FarmController(), fenix: true);
    Get.lazyPut<CartController>(() => CartController(), fenix: true);
  }
}

class FarmBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FarmController>(() => FarmController(), fenix: true);
    Get.lazyPut<CartController>(() => CartController(), fenix: true);
  }
}

class OrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderController>(() => OrderController(), fenix: true);
    Get.lazyPut<CartController>(() => CartController(), fenix: true);
  }
}

class FarmerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FarmerController>(() => FarmerController(), fenix: true);
  }
}
