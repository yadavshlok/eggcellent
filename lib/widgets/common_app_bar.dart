import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../utils/colors.dart';
import '../utils/text_styles.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;

  const CommonAppBar({
    Key? key,
    required this.title,
    this.showBackButton = false,
    this.actions,
    this.bottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      centerTitle: false,
      automaticallyImplyLeading: false,
      leadingWidth: showBackButton ? 60.w : 0,
      leading: showBackButton
          ? IconButton(
        icon: Icon(Icons.arrow_back, color: AppColors.textDark),
        onPressed: () => Get.back(),
      )
          : null,
      title: Text(
        title,
        style: AppTextStyles.headline3,
      ),
      actions: actions,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
    56.h + (bottom?.preferredSize.height ?? 0),
  );
}
