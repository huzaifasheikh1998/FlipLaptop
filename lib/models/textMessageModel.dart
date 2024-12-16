import 'package:app_fliplaptop/models/chatConversationModel.dart';

class TextMessage {
  final String conversationID;
  final String userID;
  final String lastMessage;
  final String userName;
  final String userImage;
  final DateTime lastMessageTime;
  final List<Conversation> listOfConversations;


  TextMessage({
    required this.conversationID,
    required this.userID,
    required this.lastMessage,
    required this.userImage,
    required this.userName,
    required this.lastMessageTime,
    required this.listOfConversations
  });
}
