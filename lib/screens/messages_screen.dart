import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../controllers/messages_controller.dart';
import '../../utils/colors.dart';
import '../../utils/text_styles.dart';
import '../../widgets/common_app_bar.dart';
import '../utils/app_constants.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final MessagesController controller = Get.put(MessagesController());
  late TextEditingController messageController;

  @override
  void initState() {
    super.initState();
    messageController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CommonAppBar(
        title: 'Messages',
        showBackButton: true,
      ),
      body: Obx(
            () => controller.selectedConversation.value == null
            ? _buildConversationsList()
            : _buildChatView(),
      ),
    );
  }

  Widget _buildConversationsList() {
    return Container(
      color: AppColors.white,
      child: Obx(
            () => ListView.builder(
          itemCount: controller.conversations.length,
          itemBuilder: (context, index) {
            final conversation = controller.conversations[index];
            return InkWell(
              onTap: () => controller.selectConversation(conversation),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.border,
                      width: 0.5,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    // Avatar
                    CircleAvatar(
                      backgroundColor: AppColors.primary,
                      radius: 6.w,
                      child: Text(
                        conversation.farmName[0].toUpperCase(),
                        style: AppTextStyles.subheading2.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: 3.w),

                    // Message Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  conversation.farmName,
                                  style: AppTextStyles.subheading2,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                conversation.lastMessageTime,
                                style: AppTextStyles.labelSmall.copyWith(
                                  color: AppColors.textGrey,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 0.5.h),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  conversation.lastMessage,
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: AppColors.textGrey,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (conversation.unreadCount > 0)
                                Container(
                                  margin: EdgeInsets.only(left: 2.w),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 2.w,
                                    vertical: 0.3.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Text(
                                    '${conversation.unreadCount}',
                                    style: AppTextStyles.labelSmall.copyWith(
                                      color: AppColors.white,
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildChatView() {
    final conversation = controller.selectedConversation.value!;

    return Column(
      children: [
        // Chat Header
        Container(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
          decoration: BoxDecoration(
            color: AppColors.white,
            border: Border(
              bottom: BorderSide(color: AppColors.border),
            ),
            boxShadow: AppConstants.lightShadow,
          ),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back, size: 6.w),
                onPressed: () => controller.clearSelection(),
              ),
              CircleAvatar(
                backgroundColor: AppColors.primary,
                radius: 5.w,
                child: Text(
                  conversation.farmName[0].toUpperCase(),
                  style: AppTextStyles.subheading2.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      conversation.farmName,
                      style: AppTextStyles.subheading2,
                    ),
                    Text(
                      'Online',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.success,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.more_vert, size: 6.w),
                onPressed: () {},
              ),
            ],
          ),
        ),

        // Messages Area
        Expanded(
          child: Container(
            color: AppColors.background,
            child: Obx(
                  () => ListView.builder(
                reverse: true,
                padding: EdgeInsets.all(4.w),
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final message = controller.messages[
                  controller.messages.length - 1 - index];
                  return _buildMessageBubble(message);
                },
              ),
            ),
          ),
        ),

        // Input Area
        Container(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
          decoration: BoxDecoration(
            color: AppColors.white,
            border: Border(
              top: BorderSide(color: AppColors.border),
            ),
          ),
          child: SafeArea(
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      hintStyle: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textGrey,
                      ),
                      filled: true,
                      fillColor: AppColors.background,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 4.w,
                        vertical: 1.2.h,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 2.w),
                GestureDetector(
                  onTap: () {
                    if (messageController.text.trim().isNotEmpty) {
                      controller.sendMessage(messageController.text.trim());
                      messageController.clear();
                    }
                  },
                  child: CircleAvatar(
                    backgroundColor: AppColors.primary,
                    radius: 6.w,
                    child: Icon(
                      Icons.send,
                      color: AppColors.white,
                      size: 5.w,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMessageBubble(Message message) {
    final isMe = message.isMe;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: 1.5.h),
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
        constraints: BoxConstraints(maxWidth: 75.w),
        decoration: BoxDecoration(
          color: isMe ? AppColors.primary : AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
            bottomLeft: Radius.circular(isMe ? 12.0 : 0),
            bottomRight: Radius.circular(isMe ? 0 : 12.0),
          ),
          boxShadow: AppConstants.lightShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.text,
              style: AppTextStyles.bodyMedium.copyWith(
                color: isMe ? AppColors.white : AppColors.textDark,
              ),
            ),
            SizedBox(height: 0.3.h),
            Text(
              message.time,
              style: AppTextStyles.labelSmall.copyWith(
                color: isMe
                    ? AppColors.white.withOpacity(0.8)
                    : AppColors.textGrey,
                fontSize: 9.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }
}
