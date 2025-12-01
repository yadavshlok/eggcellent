import 'package:eggcellent/routes/app_routes.dart';
import 'package:eggcellent/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'bindings/auth_binding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, screenType) {
        return GetMaterialApp(
          title: 'Eggcellent',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: AppColors.primary,
            useMaterial3: true,
          ),
          initialRoute: AppRoutes.splash,
          getPages: AppRoutes.pages,
          initialBinding: AuthBinding(),
        );
      },
    );
  }
}