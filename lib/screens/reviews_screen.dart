import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../utils/colors.dart';
import '../../utils/text_styles.dart';
import '../../widgets/common_app_bar.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CommonAppBar(
        title: 'Reviews',
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(16.w),
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                children: [
                  Text(
                    '3.3',
                    style: AppTextStyles.headline1.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      5,
                          (index) => Icon(
                        index < 3 ? Icons.star : Icons.star_border,
                        color: AppColors.warning,
                        size: 24,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Based on 6 reviews',
                    style: AppTextStyles.caption,
                  ),
                  SizedBox(height: 24.h),
                  ...List.generate(5, (index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: Row(
                        children: [
                          Text('${5 - index}★', style: AppTextStyles.labelMedium),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: LinearProgressIndicator(
                              value: (5 - index) * 0.15,
                              backgroundColor: AppColors.grey200,
                              color: AppColors.primary,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Text('${index + 1}', style: AppTextStyles.labelMedium),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: 6,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 12.h),
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: AppColors.primary,
                            child: Text(
                              'U${index + 1}',
                              style: TextStyle(color: AppColors.white),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'User Name ${index + 1}',
                                  style: AppTextStyles.subheading2,
                                ),
                                Row(
                                  children: List.generate(
                                    5,
                                        (i) => Icon(
                                      i < (5 - index % 3)
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: AppColors.warning,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'Nov ${30 - index}',
                            style: AppTextStyles.caption,
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        'Great quality eggs! Fresh and delivered on time. Highly recommended.',
                        style: AppTextStyles.bodyMedium,
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        children: [
                          TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.thumb_up_outlined, size: 16),
                            label: const Text('Helpful'),
                          ),
                          TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.reply, size: 16),
                            label: const Text('Reply'),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
