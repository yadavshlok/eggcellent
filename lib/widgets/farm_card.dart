import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../utils/app_constants.dart';
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
        margin: EdgeInsets.only(bottom: 2.h),
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: AppConstants.lightShadow,
        ),
        child: Row(
          children: [
            // Farm Image/Icon
            Container(
              width: 20.w,
              height: 20.w,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(
                Icons.agriculture,
                size: 10.w,
                color: AppColors.primary,
              ),
            ),
            SizedBox(width: 4.w),

            // Farm Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    farmName,
                    style: AppTextStyles.subheading2,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 0.5.h),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 4.w,
                        color: AppColors.textGrey,
                      ),
                      SizedBox(width: 1.w),
                      Expanded(
                        child: Text(
                          location,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textGrey,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 0.5.h),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: AppColors.warning,
                        size: 4.w,
                      ),
                      SizedBox(width: 1.w),
                      Text(
                        rating.toStringAsFixed(1),
                        style: AppTextStyles.bodyMedium,
                      ),
                      SizedBox(width: 1.w),
                      Text(
                        '(${(rating * 10).toInt()} reviews)',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textGrey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Arrow Icon
            Icon(
              Icons.arrow_forward_ios,
              size: 4.w,
              color: AppColors.textGrey,
            ),
          ],
        ),
      ),
    );
  }
}
