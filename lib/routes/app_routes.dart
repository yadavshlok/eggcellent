import 'package:get/get.dart';
import '../bindings/auth_binding.dart';
import '../bindings/bindings.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String nearbyFarms = '/nearby-farms';
  static const String farmDetail = '/farm-detail';
  static const String cart = '/cart';
  static const String checkout = '/checkout';
  static const String farmerDashboard = '/farmer-dashboard';
  static const String myFarms = '/my-farms';
  static const String batches = '/batches';

  static final List<GetPage> pages = [
    GetPage(
      name: splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: login,
      page: () => const LoginScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: register,
      page: () => const RegisterScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: nearbyFarms,
      page: () => const NearbyFarmsScreen(),
      binding: FarmBinding(),
    ),
    GetPage(
      name: farmDetail,
      page: () => const FarmDetailScreen(),
      binding: FarmBinding(),
    ),
    GetPage(
      name: cart,
      page: () => const CartScreen(),
      binding: OrderBinding(),
    ),
    GetPage(
      name: checkout,
      page: () => const CheckoutScreen(),
      binding: OrderBinding(),
    ),
    GetPage(
      name: farmerDashboard,
      page: () => const FarmerDashboardScreen(),
      binding: FarmerBinding(),
    ),
  ];
}
