import 'package:get/get.dart';
import '../bindings/customer_binding.dart';
import '../bindings/farmer_binding.dart';
import '../screens/edit_profile_screen.dart';
import '../screens/farmer/farmer_add_farm_screen.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import '../screens/splash_screen.dart';

// Customer Screens
import '../screens/customer/customer_home_screen.dart';
import '../screens/customer/farm_detail_screen.dart';
import '../screens/customer/farms_list_screen.dart';
import '../screens/customer/subscriptions_screen.dart';
import '../screens/customer/chat_screen.dart';
import '../screens/customer/profile_screen.dart';
import '../screens/checkout_screen.dart';

// Farmer Screens
import '../screens/farmer/farmer_dashboard_screen.dart';
import '../screens/farmer/farmer_orders_screen.dart';
import '../screens/farmer/farmer_batches_screen.dart';
import '../screens/farmer/farmer_my_farms_screen.dart';
import '../screens/farmer/farmer_subscriptions_screen.dart';
import '../screens/farmer/farmer_reviews_screen.dart';
import '../screens/farmer/farmer_messages_screen.dart';
import '../screens/farmer/farmer_profile_screen.dart';

import '../bindings/auth_binding.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    // Auth Pages
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.farmerFarms,
      page: () => const FarmerMyFarmsScreen(),
    ),
    GetPage(
      name: AppRoutes.farmerAddFarm,
      page: () => const FarmerAddFarmScreen(),
    ),

    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileScreen(),
      binding: CustomerBinding(),
    ),

    GetPage(
      name: AppRoutes.editProfile,
      page: () => const EditProfileScreen(),
    ),
    // Customer Pages
    GetPage(
      name: AppRoutes.customerHome,
      page: () => const CustomerHomeScreen(),
      binding: CustomerBinding(),
    ),
    GetPage(
      name: AppRoutes.farmDetail,
      page: () => const FarmDetailScreen(),
      binding: CustomerBinding(),
    ),
    GetPage(
      name: AppRoutes.farmsList,
      page: () => const FarmsListScreen(),
      binding: CustomerBinding(),
    ),
    GetPage(
      name: AppRoutes.subscriptions,
      page: () => const SubscriptionsScreen(),
      binding: CustomerBinding(),
    ),
    GetPage(
      name: AppRoutes.chat,
      page: () => const ChatScreen(),
      binding: CustomerBinding(),
    ),
    GetPage(
      name: AppRoutes.checkout,
      page: () => const CheckoutScreen(),
      binding: CustomerBinding(),
    ),

    // Farmer Pages
    GetPage(
      name: AppRoutes.farmerDashboard,
      page: () => const FarmerDashboardScreen(),
      binding: FarmerBinding(),
    ),
    GetPage(
      name: AppRoutes.farmerOrders,
      page: () => const FarmerOrdersScreen(),
      binding: FarmerBinding(),
    ),
    GetPage(
      name: AppRoutes.farmerBatches,
      page: () => const FarmerBatchesScreen(),
      binding: FarmerBinding(),
    ),
    GetPage(
      name: AppRoutes.farmerFarms,
      page: () => const FarmerMyFarmsScreen(),
      binding: FarmerBinding(),
    ),
    GetPage(
      name: AppRoutes.farmerSubscriptions,
      page: () => const FarmerSubscriptionsScreen(),
      binding: FarmerBinding(),
    ),
    GetPage(
      name: AppRoutes.farmerReviews,
      page: () => const FarmerReviewsScreen(),
      binding: FarmerBinding(),
    ),
    GetPage(
      name: AppRoutes.farmerMessages,
      page: () => const FarmerMessagesScreen(),
      binding: FarmerBinding(),
    ),
    GetPage(
    name: AppRoutes.farmerProfile,
    page: () => const FarmerProfileScreen(),
    binding: FarmerBinding(),
    )
  ];
}
