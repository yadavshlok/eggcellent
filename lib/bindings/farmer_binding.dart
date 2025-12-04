import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../controllers/batch_controller.dart';
import '../controllers/farmer_controller.dart';

class FarmerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<FarmerController>(() => FarmerController(), fenix: true);
    Get.lazyPut<BatchController>(() => BatchController(), fenix: true);
  }
}
