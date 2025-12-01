import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/colors.dart';
import '../../widgets/common_app_bar.dart';

class FarmDetailScreen extends StatelessWidget {
  const FarmDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CommonAppBar(
        title: 'Farm Details',
        showBackButton: true,
      ),
      body: const Center(
        child: Text('Farm Detail Screen'),
      ),
    );
  }
}
