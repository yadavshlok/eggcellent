import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../utils/app_constants.dart';
import '../utils/colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? labelText;
  final IconData? prefixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.labelText,
    this.prefixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          Text(
            labelText!,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          SizedBox(height: 0.8.h),
        ],
        Container(
          decoration: BoxDecoration(
            boxShadow: AppConstants.lightShadow,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            validator: validator,
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.textDark,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: AppColors.textGrey,
                fontSize: 12.sp,
              ),
              prefixIcon: prefixIcon != null
                  ? Icon(prefixIcon, color: AppColors.textGrey, size: 2.4.h)
                  : null,
              suffixIcon: suffixIcon,
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 4.w,
                vertical: 2.2.h,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: AppColors.borderGrey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: AppColors.borderGrey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: AppColors.primary, width: 1.5),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: AppColors.error),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
