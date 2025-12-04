class AppRoutes {
  // Auth Routes
  static const splash = '/';
  static const login = '/login';
  static const register = '/register';

  // Customer Routes
  static const customerHome = '/customer/home';
  static const farmDetail = '/customer/farm-detail';
  static const farmsList = '/customer/farms-list';
  static const subscriptions = '/customer/subscriptions';
  static const chat = '/customer/chat';
  static const checkout = '/customer/checkout';

  // Farmer Routes
  static const farmerDashboard = '/farmer/dashboard';
  static const farmerOrders = '/farmer/orders';
  static const farmerBatches = '/farmer/batches';
  static const farmerSubscriptions = '/farmer/subscriptions';
  static const farmerReviews = '/farmer/reviews';
  static const farmerMessages = '/farmer/messages';
  static const farmerProfile = '/farmer/profile';
  static const farmerFarms = '/farmer-farms';  // ADD THIS
  static const farmerAddFarm = '/farmer-add-farm';
  static const profile = '/profile';
  static const editProfile = '/edit-profile';
}
