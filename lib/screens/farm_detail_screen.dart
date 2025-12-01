import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../utils/colors.dart';
import '../../utils/text_styles.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/primary_button.dart';
import '../utils/app_constants.dart';

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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Farm Image
            Container(
              width: double.infinity,
              height: 25.h,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
              ),
              child: Icon(
                Icons.house_siding,
                size: 15.h,
                color: AppColors.primary,
              ),
            ),

            Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Farm Name
                  Text(
                    'Sunrise Organic Farm',
                    style: AppTextStyles.headline3,
                  ),
                  SizedBox(height: 0.5.h),

                  // Rating
                  Row(
                    children: [
                      Icon(Icons.star, color: AppColors.warning, size: 5.w),
                      SizedBox(width: 1.w),
                      Text(
                        '4.8 (324 reviews)',
                        style: AppTextStyles.bodyMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),

                  // About Section
                  Text(
                    'About',
                    style: AppTextStyles.headline4,
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    'Welcome to Sunrise Organic Farm - a family-owned farm dedicated to producing the freshest, highest-quality eggs for our valued customers. With over 15 years of experience, we maintain the highest standards of animal care and sustainable farming practices.',
                    style: AppTextStyles.bodyMedium,
                  ),
                  SizedBox(height: 2.h),

                  // Details Grid
                  Text(
                    'Farm Information',
                    style: AppTextStyles.headline4,
                  ),
                  SizedBox(height: 1.5.h),
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoBox(
                          'Location',
                          'Bangalore, KA',
                          Icons.location_on_outlined,
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Expanded(
                        child: _buildInfoBox(
                          'Members',
                          '12,450',
                          Icons.people_outline,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.5.h),
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoBox(
                          'Established',
                          '2009',
                          Icons.calendar_today,
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Expanded(
                        child: _buildInfoBox(
                          'Avg Rating',
                          '4.8/5.0',
                          Icons.star,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),

                  // Specialties Section
                  Text(
                    'Specialties',
                    style: AppTextStyles.headline4,
                  ),
                  SizedBox(height: 1.h),
                  Wrap(
                    spacing: 2.w,
                    runSpacing: 1.h,
                    children: [
                      _buildTag('Organic'),
                      _buildTag('Free Range'),
                      _buildTag('Farm Fresh'),
                      _buildTag('Natural Feed'),
                      _buildTag('Certified'),
                    ],
                  ),
                  SizedBox(height: 2.h),

                  // Products Section
                  Text(
                    'Our Products',
                    style: AppTextStyles.headline4,
                  ),
                  SizedBox(height: 1.5.h),
                  _buildProductCard(
                    'Brown Eggs',
                    '₹20/egg',
                    'Fresh brown eggs from free-range hens',
                  ),
                  SizedBox(height: 1.h),
                  _buildProductCard(
                    'White Eggs',
                    '₹18/egg',
                    'Premium quality white eggs',
                  ),
                  SizedBox(height: 1.h),
                  _buildProductCard(
                    'Desi Eggs',
                    '₹25/egg',
                    'Traditional desi eggs with superior nutrition',
                  ),
                  SizedBox(height: 2.h),

                  // Contact Section
                  Text(
                    'Contact Information',
                    style: AppTextStyles.headline4,
                  ),
                  SizedBox(height: 1.5.h),
                  Row(
                    children: [
                      Icon(Icons.phone_outlined, color: AppColors.primary),
                      SizedBox(width: 2.w),
                      Text(
                        '+91 98765 43210',
                        style: AppTextStyles.bodyMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    children: [
                      Icon(Icons.email_outlined, color: AppColors.primary),
                      SizedBox(width: 2.w),
                      Expanded(
                        child: Text(
                          'info@sunrisefarm.com',
                          style: AppTextStyles.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined, color: AppColors.primary),
                      SizedBox(width: 2.w),
                      Expanded(
                        child: Text(
                          'Whitefield, Bangalore, Karnataka 560066',
                          style: AppTextStyles.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3.h),

                  // Action Buttons
                  PrimaryButton(
                    label: 'Browse Products',
                    onPressed: () {},
                  ),
                  SizedBox(height: 1.5.h),
                  PrimaryButton(
                    label: 'Contact Farm',
                    onPressed: () {},
                    isOutlined: true,
                  ),
                  SizedBox(height: 2.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoBox(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: AppConstants.lightShadow,
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.primary, size: 6.w),
          SizedBox(height: 1.h),
          Text(
            value,
            style: AppTextStyles.subheading2.copyWith(
              color: AppColors.primary,
            ),
          ),
          Text(
            label,
            style: AppTextStyles.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Text(
        label,
        style: AppTextStyles.labelSmall.copyWith(
          color: AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildProductCard(String name, String price, String description) {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: AppConstants.lightShadow,
      ),
      child: Row(
        children: [
          Container(
            width: 14.w,
            height: 14.w,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Icon(Icons.egg, color: AppColors.primary, size: 7.w),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTextStyles.subheading2,
                ),
                Text(
                  description,
                  style: AppTextStyles.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: 2.w),
          Text(
            price,
            style: AppTextStyles.subheading2.copyWith(
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
