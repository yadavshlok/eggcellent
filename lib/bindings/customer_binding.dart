import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../controllers/farm_controller.dart';
import '../controllers/cart_controller.dart';
import '../controllers/profile_controller.dart';

class CustomerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<FarmController>(() => FarmController());
    Get.lazyPut<CartController>(() => CartController());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
