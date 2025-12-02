import 'package:get/get.dart';

class Conversation {
  final String id;
  final String farmName;
  final String lastMessage;
  final String lastMessageTime;
  final int unreadCount;

  Conversation({
    required this.id,
    required this.farmName,
    required this.lastMessage,
    required this.lastMessageTime,
    this.unreadCount = 0,
  });
}

class Message {
  final String id;
  final String text;
  final String time;
  final bool isMe;

  Message({
    required this.id,
    required this.text,
    required this.time,
    required this.isMe,
  });
}

class MessagesController extends GetxController {
  final RxList<Conversation> conversations = <Conversation>[].obs;
  final Rx<Conversation?> selectedConversation = Rx<Conversation?>(null);
  final RxList<Message> messages = <Message>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadConversations();
  }

  void loadConversations() {
    // Mock data
    conversations.value = [
      Conversation(
        id: '1',
        farmName: 'Sunrise Organic Farm',
        lastMessage: 'Your order is ready for pickup!',
        lastMessageTime: '10:30 AM',
        unreadCount: 2,
      ),
      Conversation(
        id: '2',
        farmName: 'Green Valley Farms',
        lastMessage: 'Thank you for your order',
        lastMessageTime: '9:15 AM',
        unreadCount: 0,
      ),
      Conversation(
        id: '3',
        farmName: 'Happy Hens Farm',
        lastMessage: 'We have fresh eggs available',
        lastMessageTime: 'Yesterday',
        unreadCount: 1,
      ),
      Conversation(
        id: '4',
        farmName: 'Rural Retreat Farms',
        lastMessage: 'Delivery scheduled for tomorrow',
        lastMessageTime: 'Yesterday',
        unreadCount: 0,
      ),
      Conversation(
        id: '5',
        farmName: 'Organic Dreams Farm',
        lastMessage: 'How can I help you?',
        lastMessageTime: '2 days ago',
        unreadCount: 0,
      ),
    ];
  }

  void selectConversation(Conversation conversation) {
    selectedConversation.value = conversation;
    loadMessages(conversation.id);
  }

  void clearSelection() {
    selectedConversation.value = null;
    messages.clear();
  }

  void loadMessages(String conversationId) {
    // Mock messages
    messages.value = [
      Message(
        id: '1',
        text: 'Hi! Do you have fresh brown eggs available?',
        time: '10:20 AM',
        isMe: true,
      ),
      Message(
        id: '2',
        text: 'Yes, we have plenty in stock!',
        time: '10:25 AM',
        isMe: false,
      ),
      Message(
        id: '3',
        text: 'Your order is ready for pickup!',
        time: '10:30 AM',
        isMe: false,
      ),
    ];
  }

  void sendMessage(String text) {
    final newMessage = Message(
      id: DateTime.now().toString(),
      text: text,
      time: _formatTime(DateTime.now()),
      isMe: true,
    );
    messages.add(newMessage);
  }

  String _formatTime(DateTime time) {
    final hour = time.hour > 12 ? time.hour - 12 : time.hour;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }
}
