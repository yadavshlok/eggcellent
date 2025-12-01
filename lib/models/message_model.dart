class Message {
  final String id;
  final String senderId;
  final String receiverId;
  final String content;
  final String? attachmentUrl;
  final bool isRead;
  final DateTime timestamp;

  Message({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.content,
    this.attachmentUrl,
    this.isRead = false,
    required this.timestamp,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      content: json['content'],
      attachmentUrl: json['attachmentUrl'],
      isRead: json['isRead'] ?? false,
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}

class Chat {
  final String id;
  final String userId;
  final String userName;
  final String? lastMessage;
  final DateTime? lastMessageTime;
  final int unreadCount;

  Chat({
    required this.id,
    required this.userId,
    required this.userName,
    this.lastMessage,
    this.lastMessageTime,
    this.unreadCount = 0,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      id: json['id'],
      userId: json['userId'],
      userName: json['userName'],
      lastMessage: json['lastMessage'],
      lastMessageTime: json['lastMessageTime'] != null ? DateTime.parse(json['lastMessageTime']) : null,
      unreadCount: json['unreadCount'] ?? 0,
    );
  }
}
