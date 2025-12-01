import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
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
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 60.w,
                height: 60.h,
                decoration: BoxDecoration(
                  color: AppColors.grey200,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Icon(Icons.egg),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(eggType, style: AppTextStyles.subheading2),
                    Text(
                      '₹$price per egg',
                      style: AppTextStyles.labelMedium.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: onAddToCart,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
                child: const Text('Add'),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Text('Freshness: ${freshnessScore.toStringAsFixed(1)}%',
                  style: AppTextStyles.caption),
              SizedBox(width: 16.w),
              Text('Qty: $quantity', style: AppTextStyles.caption),
            ],
          ),
        ],
      ),
    );
  }
}
