// lib/routes/app_routes.dart

import 'package:get/get.dart';

// Bindings
import '../bindings/auth_binding.dart';
import '../bindings/bindings.dart';
import '../screens/batches_screen.dart';
import '../screens/cart_screen.dart';
import '../screens/checkout_screen.dart';
import '../screens/dashboard_screen.dart';
import '../screens/farm_detail_screen.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/messages_screen.dart';
import '../screens/my_farms_screen.dart';
import '../screens/my_orders_screen.dart';
import '../screens/my_subscriptions_screen.dart';
import '../screens/nearby_farms_screen.dart';
import '../screens/order_success_screen.dart';
import '../screens/orders_screen.dart';
import '../screens/register_screen.dart';
import '../screens/reviews_screen.dart';
import '../screens/splash_screen.dart';
import '../screens/subscriptions_screen.dart';
import '../screens/wallet_screen.dart';

class AppRoutes {
  // route names
  static const String splash = '/splash';
  static const String login = '/login';
  static const String register = '/register';

  // customer routes
  static const String home = '/home';
  static const String nearbyFarms = '/nearby-farms';
  static const String farmDetail = '/farm-detail';
  static const String cart = '/cart';
  static const String checkout = '/checkout';
  static const String orderSuccess = '/order-success';
  static const String myOrders = '/my-orders';
  static const String mySubscriptions = '/my-subscriptions';
  static const String customerMessages = '/customer-messages';

  // farmer routes
  static const String farmerDashboard = '/farmer-dashboard';
  static const String myFarms = '/my-farms';
  static const String batches = '/batches';
  static const String farmerOrders = '/farmer-orders';
  static const String farmerSubscriptions = '/farmer-subscriptions';
  static const String wallet = '/wallet';
  static const String reviews = '/reviews';
  static const String farmerMessages = '/farmer-messages';

  static final List<GetPage> pages = [
    // splash / auth
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

    // customer
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
      name: orderSuccess,
      page: () => const OrderSuccessScreen(),
      binding: OrderBinding(),
    ),
    GetPage(
      name: myOrders,
      page: () => const MyOrdersScreen(),
      binding: OrderBinding(),
    ),
    GetPage(
      name: mySubscriptions,
      page: () => const MySubscriptionsScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: customerMessages,
      page: () => const MessagesScreen(),
      binding: HomeBinding(),
    ),

    // farmer
    GetPage(
      name: farmerDashboard,
      page: () => const FarmerDashboardScreen(),
      binding: FarmerBinding(),
    ),
    GetPage(
      name: myFarms,
      page: () => const MyFarmsScreen(),
      binding: FarmerBinding(),
    ),
    GetPage(
      name: batches,
      page: () => const BatchesScreen(),
      binding: FarmerBinding(),
    ),
    GetPage(
      name: farmerOrders,
      page: () => const FarmerOrdersScreen(),
      binding: FarmerBinding(),
    ),
    GetPage(
      name: farmerSubscriptions,
      page: () => const FarmerSubscriptionsScreen(),
      binding: FarmerBinding(),
    ),
    GetPage(
      name: wallet,
      page: () => const WalletScreen(),
      binding: FarmerBinding(),
    ),
    GetPage(
      name: reviews,
      page: () => const ReviewsScreen(),
      binding: FarmerBinding(),
    ),
    // If you later create a dedicated farmer messages screen:
    // GetPage(
    //   name: farmerMessages,
    //   page: () => const FarmerMessagesScreen(),
    //   binding: FarmerBinding(),
    // ),
  ];
}
