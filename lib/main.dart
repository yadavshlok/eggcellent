import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'controllers/auth_controller.dart';
import 'controllers/cart_controller.dart';
import 'controllers/farm_controller.dart';
import 'controllers/farmer_controller.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'utils/colors.dart';

void main() {

  Get.put(AuthController());
  Get.put(FarmerController());
  Get.put(FarmController()); // ADD THIS LINE
  Get.put(CartController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          title: 'Eggcellent',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: AppColors.primary,
            scaffoldBackgroundColor: AppColors.background,
            fontFamily: 'Poppins',
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          ),
          initialRoute: AppRoutes.splash,
          getPages: AppPages.pages,
        );
      },
    );
  }
}
