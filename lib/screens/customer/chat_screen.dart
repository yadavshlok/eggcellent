import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../utils/colors.dart';

class CustomerChatScreen extends StatelessWidget {
  const CustomerChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // Gradient Header (from customer ChatScreen)
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
              child: Padding(
                padding: EdgeInsets.fromLTRB(4.w, 2.h, 4.w, 3.h),
                child: Row(
                  children: [
                    IconButton(
                      icon: Container(
                        padding: EdgeInsets.all(2.w),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.arrow_back,
                            color: Colors.white, size: 5.5.w),
                      ),
                      onPressed: () => Get.back(),
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      'Messages',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: EdgeInsets.all(2.5.w),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.search_rounded,
                          color: Colors.white, size: 5.5.w),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: 1.h),

          // Chat List (customer UI)
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              itemCount: 5,
              itemBuilder: (context, index) {
                final bool hasUnread = index < 2;
                final String farmName = 'Green Valley Farm ${index + 1}';

                return Container(
                  margin: EdgeInsets.symmetric(
                      vertical: 0.8.h, horizontal: 2.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: hasUnread
                          ? AppColors.primary.withOpacity(0.3)
                          : Colors.transparent,
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 3.w, vertical: 1.h),
                    leading: Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.all(2.5.w),
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.agriculture_rounded,
                              color: Colors.white, size: 6.w),
                        ),
                        if (hasUnread)
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              width: 3.w,
                              height: 3.w,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Colors.white, width: 2),
                              ),
                            ),
                          ),
                      ],
                    ),
                    title: Text(
                      farmName,
                      style: TextStyle(
                        fontSize: 13.5.sp,
                        fontWeight: hasUnread
                            ? FontWeight.bold
                            : FontWeight.w600,
                      ),
                    ),
                    subtitle: Padding(
                      padding: EdgeInsets.only(top: 0.5.h),
                      child: Text(
                        'Your order has been confirmed',
                        style: TextStyle(
                          fontSize: 12.2.sp,
                          color: hasUnread
                              ? AppColors.textDark
                              : AppColors.textGrey,
                          fontWeight: hasUnread
                              ? FontWeight.w500
                              : FontWeight.normal,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '12:30 PM',
                          style: TextStyle(
                            fontSize: 12.5.sp,
                            color: hasUnread
                                ? AppColors.primary
                                : AppColors.textGrey,
                            fontWeight: hasUnread
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                        if (hasUnread) ...[
                          SizedBox(height: 0.5.h),
                          Container(
                            padding: EdgeInsets.all(1.5.w),
                            decoration: BoxDecoration(
                              gradient: AppColors.primaryGradient,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    // farmer-style behavior: open detail chat
                    onTap: () {
                      Get.to(() => ChatDetailScreen(
                        title: farmName,
                        isFarmerSide: false,
                      ));
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Reusable chat detail screen used by both farmer and customer
class ChatDetailScreen extends StatelessWidget {
  final String title;
  final bool isFarmerSide; // just in case you want different bubbles later

  const ChatDetailScreen({
    Key? key,
    required this.title,
    this.isFarmerSide = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: AppColors.primaryGradient),
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.2),
              child: Icon(
                isFarmerSide ? Icons.person_rounded : Icons.agriculture_rounded,
                color: Colors.white,
                size: 5.w,
              ),
            ),
            SizedBox(width: 3.w),
            Text(title, style: TextStyle(fontSize: 16.sp)),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.call_rounded, size: 5.5.w),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(4.w),
              children: [
                _buildMessageBubble(
                  'When will my order be delivered?',
                  false,
                  '10:30 AM',
                ),
                _buildMessageBubble(
                  'Your order will be delivered tomorrow morning.',
                  true,
                  '10:32 AM',
                ),
                _buildMessageBubble(
                  'Great! Thank you.',
                  false,
                  '10:33 AM',
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: AppColors.background,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 5.w,
                          vertical: 1.5.h,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 2.w),
                  Container(
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.send_rounded,
                          color: Colors.white, size: 5.w),
                      onPressed: () {},
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

  Widget _buildMessageBubble(String message, bool isSender, String time) {
    return Align(
      alignment:
      isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: 1.5.h),
        padding:
        EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
        decoration: BoxDecoration(
          gradient: isSender ? AppColors.primaryGradient : null,
          color: isSender ? null : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        constraints: BoxConstraints(maxWidth: 70.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: TextStyle(
                color: isSender ? Colors.white : AppColors.textDark,
                fontSize: 12.sp,
              ),
            ),
            SizedBox(height: 0.5.h),
            Text(
              time,
              style: TextStyle(
                color: isSender
                    ? Colors.white.withOpacity(0.8)
                    : AppColors.textGrey,
                fontSize: 9.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
