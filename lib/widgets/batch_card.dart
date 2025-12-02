import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../utils/app_constants.dart';
import '../utils/colors.dart';
import '../utils/text_styles.dart';

class BatchCard extends StatelessWidget {
  final String eggType;
  final double price;
  final int quantity;
  final double freshnessScore;
  final VoidCallback onAddToCart;

  const BatchCard({
    Key? key,
    required this.eggType,
    required this.price,
    required this.quantity,
    required this.freshnessScore,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: AppConstants.lightShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Egg Image/Icon
              Container(
                width: 15.w,
                height: 15.w,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Icon(
                  Icons.egg,
                  color: AppColors.primary,
                  size: 8.w,
                ),
              ),
              SizedBox(width: 3.w),

              // Egg Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(eggType, style: AppTextStyles.subheading2),
                    SizedBox(height: 0.3.h),
                    Text(
                      '₹${price.toStringAsFixed(2)} per egg',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),

              // Add to Cart Button
              ElevatedButton(
                onPressed: onAddToCart,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: EdgeInsets.symmetric(
                    horizontal: 4.w,
                    vertical: 1.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  'Add',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 1.5.h),

          // Freshness and Quantity Info
          Row(
            children: [
              // Freshness Indicator
              Icon(
                Icons.verified,
                size: 4.w,
                color: _getFreshnessColor(freshnessScore),
              ),
              SizedBox(width: 1.w),
              Text(
                'Freshness: ${freshnessScore.toStringAsFixed(1)}%',
                style: AppTextStyles.bodySmall.copyWith(
                  color: _getFreshnessColor(freshnessScore),
                ),
              ),
              SizedBox(width: 4.w),

              // Quantity
              Icon(
                Icons.inventory_2_outlined,
                size: 4.w,
                color: AppColors.textGrey,
              ),
              SizedBox(width: 1.w),
              Text(
                'Qty: $quantity',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textGrey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getFreshnessColor(double score) {
    if (score >= 90) {
      return AppColors.success;
    } else if (score >= 70) {
      return AppColors.warning;
    } else {
      return AppColors.error;
    }
  }
}
