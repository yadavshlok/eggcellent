import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../utils/colors.dart';
import '../../utils/text_styles.dart';
import '../../widgets/common_app_bar.dart';
import '../utils/app_constants.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Mock data
    final double averageRating = 4.3;
    final int totalReviews = 24;
    final Map<int, int> ratingCounts = {
      5: 15,
      4: 5,
      3: 2,
      2: 1,
      1: 1,
    };

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CommonAppBar(
        title: 'Reviews',
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Rating Summary Card
            Container(
              margin: EdgeInsets.all(4.w),
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: AppConstants.lightShadow,
              ),
              child: Column(
                children: [
                  // Average Rating
                  Text(
                    averageRating.toStringAsFixed(1),
                    style: AppTextStyles.headline1.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: 1.h),

                  // Star Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      5,
                          (index) => Icon(
                        index < averageRating.floor()
                            ? Icons.star
                            : Icons.star_border,
                        color: AppColors.warning,
                        size: 6.w,
                      ),
                    ),
                  ),
                  SizedBox(height: 1.h),

                  // Review Count
                  Text(
                    'Based on $totalReviews reviews',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textGrey,
                    ),
                  ),
                  SizedBox(height: 3.h),

                  // Rating Breakdown
                  ...List.generate(5, (index) {
                    final star = 5 - index;
                    final count = ratingCounts[star] ?? 0;
                    final percentage = count / totalReviews;

                    return Padding(
                      padding: EdgeInsets.only(bottom: 1.h),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10.w,
                            child: Text(
                              '$star★',
                              style: AppTextStyles.bodyMedium,
                            ),
                          ),
                          SizedBox(width: 2.w),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4.0),
                              child: LinearProgressIndicator(
                                value: percentage,
                                minHeight: 1.h,
                                backgroundColor: AppColors.border,
                                color: AppColors.warning,
                              ),
                            ),
                          ),
                          SizedBox(width: 2.w),
                          SizedBox(
                            width: 10.w,
                            child: Text(
                              '$count',
                              style: AppTextStyles.bodyMedium,
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),

            // Reviews List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              itemCount: 6,
              itemBuilder: (context, index) {
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
                      // Review Header
                      Row(
                        children: [
                          // Avatar
                          CircleAvatar(
                            backgroundColor: AppColors.primary,
                            radius: 5.w,
                            child: Text(
                              'U${index + 1}',
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.white,
                              ),
                            ),
                          ),
                          SizedBox(width: 3.w),

                          // User Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'User Name ${index + 1}',
                                  style: AppTextStyles.subheading2,
                                ),
                                SizedBox(height: 0.3.h),
                                Row(
                                  children: List.generate(
                                    5,
                                        (i) => Icon(
                                      i < (5 - index % 3)
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: AppColors.warning,
                                      size: 4.w,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Date
                          Text(
                            'Nov ${30 - index}',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.textGrey,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 1.5.h),

                      // Review Text
                      Text(
                        'Great quality eggs! Fresh and delivered on time. Highly recommended for anyone looking for farm-fresh produce.',
                        style: AppTextStyles.bodyMedium,
                      ),
                      SizedBox(height: 1.5.h),

                      // Action Buttons
                      Row(
                        children: [
                          TextButton.icon(
                            onPressed: () {},
                            icon: Icon(
                              Icons.thumb_up_outlined,
                              size: 4.w,
                              color: AppColors.primary,
                            ),
                            label: Text(
                              'Helpful (${index + 2})',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: 2.w,
                                vertical: 0.5.h,
                              ),
                            ),
                          ),
                          SizedBox(width: 2.w),
                          TextButton.icon(
                            onPressed: () {},
                            icon: Icon(
                              Icons.reply,
                              size: 4.w,
                              color: AppColors.textGrey,
                            ),
                            label: Text(
                              'Reply',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.textGrey,
                              ),
                            ),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: 2.w,
                                vertical: 0.5.h,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }
}
