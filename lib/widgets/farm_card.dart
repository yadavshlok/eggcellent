import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../utils/colors.dart';
import '../utils/text_styles.dart';

class FarmCard extends StatelessWidget {
  final String farmName;
  final String location;
  final double rating;
  final VoidCallback onTap;

  const FarmCard({
    Key? key,
    required this.farmName,
    required this.location,
    required this.rating,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          children: [
            Container(
              width: 80.w,
              height: 80.h,
              decoration: BoxDecoration(
                color: AppColors.grey200,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Icon(Icons.agriculture, size: 40),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(farmName, style: AppTextStyles.subheading2),
                  SizedBox(height: 4.h),
                  Text(location, style: AppTextStyles.caption),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      const Icon(Icons.star, color: AppColors.warning, size: 16),
                      SizedBox(width: 4.w),
                      Text(rating.toString(), style: AppTextStyles.labelMedium),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
