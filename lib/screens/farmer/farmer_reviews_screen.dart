import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../utils/colors.dart';

class FarmerReviewsScreen extends StatelessWidget {
  const FarmerReviewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // Gradient Header
          Container(
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(4.w, 2.h, 4.w, 2.h),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Container(
                            padding: EdgeInsets.all(2.w),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.arrow_back, color: Colors.white, size: 5.5.w),
                          ),
                          onPressed: () => Get.back(),
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          'Reviews & Ratings',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Rating Overview
                  Padding(
                    padding: EdgeInsets.fromLTRB(4.w, 1.h, 4.w, 3.h),
                    child: Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  '4.5',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 32.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    5,
                                        (index) => Icon(
                                      Icons.star_rounded,
                                      color: Colors.white,
                                      size: 5.w,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 0.5.h),
                                Text(
                                  '124 Reviews',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.9),
                                    fontSize: 11.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 0.5.w,
                            height: 12.h,
                            color: Colors.white.withOpacity(0.3),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                _buildRatingBar(5, 0.8),
                                _buildRatingBar(4, 0.6),
                                _buildRatingBar(3, 0.3),
                                _buildRatingBar(2, 0.1),
                                _buildRatingBar(1, 0.05),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 2.h),

          // Reviews List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              itemCount: 8,
              itemBuilder: (context, index) {
                return _buildReviewCard(
                  customerName: 'Customer ${index + 1}',
                  rating: 5 - (index % 3),
                  comment: 'Great quality eggs! Fresh and delivered on time. Highly recommended.',
                  date: 'Dec ${3 - (index % 3)}, 2025',
                  farmName: 'Green Valley Farm',
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingBar(int stars, double percentage) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      child: Row(
        children: [
          Text(
            '$stars',
            style: TextStyle(color: Colors.white, fontSize: 10.sp),
          ),
          SizedBox(width: 2.w),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: percentage,
                backgroundColor: Colors.white.withOpacity(0.2),
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                minHeight: 0.8.h,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard({
    required String customerName,
    required int rating,
    required String comment,
    required String date,
    required String farmName,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.primary.withOpacity(0.1),
                child: Icon(Icons.person_rounded, color: AppColors.primary, size: 5.w),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      customerName,
                      style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 0.3.h),
                    Row(
                      children: [
                        ...List.generate(
                          5,
                              (index) => Icon(
                            index < rating ? Icons.star_rounded : Icons.star_outline_rounded,
                            color: AppColors.warning,
                            size: 4.w,
                          ),
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          date,
                          style: TextStyle(fontSize: 10.sp, color: AppColors.textGrey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 1.5.h),
          Text(
            comment,
            style: TextStyle(fontSize: 12.sp, color: AppColors.textGrey, height: 1.5),
          ),
          SizedBox(height: 1.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.8.h),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              farmName,
              style: TextStyle(fontSize: 10.sp, color: AppColors.primary, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
