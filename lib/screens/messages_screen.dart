import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../utils/colors.dart';
import '../../utils/text_styles.dart';
import '../../widgets/common_app_bar.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CommonAppBar(
        title: 'Messages',
        showBackButton: true,
      ),
      body: Row(
        children: [
          // Message List
          Expanded(
            flex: 2,
            child: Container(
              color: AppColors.white,
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.primary,
                      child: Text(
                        'F${index + 1}',
                        style: TextStyle(color: AppColors.white),
                      ),
                    ),
                    title: Text(
                      'Farm Name $index',
                      style: AppTextStyles.subheading2,
                    ),
                    subtitle: Text(
                      'Last message preview...',
                      style: AppTextStyles.caption,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('10:30 AM', style: AppTextStyles.caption),
                        if (index == 0)
                          Container(
                            margin: EdgeInsets.only(top: 4.h),
                            padding: EdgeInsets.all(4.w),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              '2',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 10.sp,
                              ),
                            ),
                          ),
                      ],
                    ),
                    onTap: () {},
                  );
                },
              ),
            ),
          ),
          // Chat Area
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(color: AppColors.border),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      border: Border(
                        bottom: BorderSide(color: AppColors.border),
                      ),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.primary,
                          child: Text(
                            'F',
                            style: TextStyle(color: AppColors.white),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Farm Name', style: AppTextStyles.subheading2),
                            Text('Online', style: AppTextStyles.caption),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: AppColors.grey100,
                      child: const Center(
                        child: Text('Select a conversation'),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      border: Border(
                        top: BorderSide(color: AppColors.border),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Type a message...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24.w),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 8.h,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        CircleAvatar(
                          backgroundColor: AppColors.primary,
                          child: IconButton(
                            icon: const Icon(Icons.send),
                            color: AppColors.white,
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
