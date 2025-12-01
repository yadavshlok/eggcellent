import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../utils/app_constants.dart';
import '../utils/colors.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isOutlined;
  final Color? backgroundColor;
  final Widget? icon;

  const PrimaryButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
    this.backgroundColor,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 6.5.h,
      decoration: BoxDecoration(
        gradient: isOutlined
            ? null
            : (backgroundColor != null ? null : AppColors.primaryGradient),
        color: isOutlined ? Colors.transparent : backgroundColor,
        borderRadius: BorderRadius.circular(8.0),
        border: isOutlined
            ? Border.all(color: AppColors.primary, width: 1.5)
            : null,
        boxShadow: isOutlined ? null : AppConstants.cardShadow,
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: isLoading
            ? SizedBox(
          height: 2.5.h,
          width: 2.5.h,
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            valueColor: AlwaysStoppedAnimation<Color>(
              isOutlined ? AppColors.primary : Colors.white,
            ),
          ),
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              icon!,
              SizedBox(width: 2.w),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: isOutlined ? AppColors.primary : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
