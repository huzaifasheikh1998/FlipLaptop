class Conversation {
  final String conversationId;
  final List<String> members;
  final String lastMessage;
  final DateTime lastMessageTime;
  final int unreadMessagesCount;

  Conversation({
    required this.conversationId,
    required this.members,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.unreadMessagesCount,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      conversationId: json['conversationId'],
      members: json['members'].cast<String>(),
      lastMessage: json['lastMessage'],
      lastMessageTime: DateTime.parse(json['lastMessageTime']),
      unreadMessagesCount: json['unreadMessagesCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'conversationId': conversationId,
      'members': members,
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime.toIso8601String(),
      'unreadMessagesCount': unreadMessagesCount,
    };
  }
}
