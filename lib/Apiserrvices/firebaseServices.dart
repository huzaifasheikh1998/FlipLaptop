import 'dart:developer';

import 'package:app_fliplaptop/Apiserrvices/Services.dart';
import 'package:app_fliplaptop/Controller/chatController.dart';
import 'package:app_fliplaptop/Controller/dashBoardController.dart';
import 'package:app_fliplaptop/Screens/ChatScreen.dart';
import 'package:app_fliplaptop/models/chatConversationModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../models/dashBoardModel.dart' as dash;
import '../models/loginmodel.dart';

class FirebaseServices {
  final ChatController chatController = Get.put(ChatController());
  final dashBoardController = Get.put(DashBoardController());

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // String? globalConversationID;

  void startConversation(String loggedInUser, dash.User secondUser) async {
    chatController.isLoading.value = true;
    chatController.globalConversationID.value = "";
    log("convo started between $loggedInUser and ${secondUser.id}");
    UserModel? senderData;
    String conversationId = "";
    // Step 0: Check if a conversation between user1 and user2 already exists
    final QuerySnapshot existingConversations =
        await firestore.collection('conversations').where('members', whereIn: [
      [loggedInUser, secondUser.id],
      [secondUser.id, loggedInUser],
    ]).get();
    log(existingConversations.toString());
    log(existingConversations.docs.toString());

    if (existingConversations.docs.isNotEmpty) {
      DocumentSnapshot conversationSnapshot = existingConversations.docs[0];

      // Access the 'conversationId' field from the document data
      conversationId = conversationSnapshot.id;
      chatController.globalConversationID.value = conversationId;
      print(
          "Conversation already exists between $loggedInUser and ${secondUser.id}.");
      // DocumentSnapshot docSnap = await firestore_get("user", secondUser);

      // if (docSnap.data() != null) {
      //   senderData = UserModel.fromMap(docSnap.data() as Map<String, dynamic>);
      // }
      // globalConversationID = conversationId;

      Get.to(
          () => ChatScreen(
                // senderData: senderData ?? UserModel(),
                // conversationID: conversationId,
                storeData: secondUser,
                fromBottomNav: false,
                selectIndexOfIndividualChat: 0,
              ),
          arguments: userController.user.value.name);

      // return;
    } else {
      // Step 1: Create a new conversation document in the 'conversations' collection
      final CollectionReference conversationsRef =
          firestore.collection('conversations');
      final newConversation = await conversationsRef.add({
        'members': [loggedInUser, secondUser.id],
        // Combine both user IDs in an array
      });
      // Step 2: Add the user IDs of the participants to the conversation document
      conversationId = newConversation.id;
      chatController.globalConversationID.value = conversationId.toString();
      final CollectionReference messagesRef =
          newConversation.collection('messages');
      const String initialMessage =
          'Hello!'; // The initial message to start the conversation
      // Step 3: Start the conversation by sending the initial message
      DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

      await messagesRef.add({
        'senderId': loggedInUser,
        'text': initialMessage,
        'createdAt': dateFormat.format(DateTime.now().toUtc()),
        // Add the server timestamp for sorting messages
        'msgType': 'text',
        'isRead': false
      });
      log("Convo ID" + conversationId.toString());

      // globalConversationID = conversationId;
      Get.to(
          () => ChatScreen(
                // senderData: senderData ?? UserModel(),
                // conversationID: conversationId,
                storeData: secondUser,
                fromBottomNav: false,
                selectIndexOfIndividualChat: 0,
              ),
          arguments: secondUser.name);
      chatController.isLoading.value = false;

      // DocumentSnapshot docSnap = await firestore_get("user", secondUser);
      // if (docSnap.data() != null) {
      //   senderData = UserModel.fromMap(docSnap.data() as Map<String, dynamic>);
      //   Get.to(() => ChatScreen(
      //         senderData: senderData,
      //         conversationID: conversationId,
      //       ));
      // }

      // Get.to(() => ChatScreen(
      //     senderData: senderData,
      //     conversationID: conversationId,
      //   ));

      // DocumentSnapshot docSnap =
      //     await FirebaseFirestore.instance.collection("users").doc(uid).get();

      // After starting the conversation, you can navigate to the chat screen or do other actions.
    }
  }

  // static List<Conversation>? conversations;

  Stream<List<Conversation>> fetchConversationsStream(
      String loggedInUser, String secondUser) {
    log("global convo ID in fetch is" +
        chatController.globalConversationID.value);

    chatController.isLoading.value = true;

    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final conversationsCollection = firestore.collection('conversations');

    // Stream of conversation documents
    final conversationDocsStream = conversationsCollection
        .where('members', arrayContains: loggedInUser.toString())
        .snapshots(); // Share the stream to avoid multiple subscriptions

    // Stream of conversations with the last message, last message time, and unread message count
    final conversationsStream = conversationDocsStream.asyncMap((_) async {
      chatController.listOfConversation.value = [];
      var res = await firestore
          .collection('conversations')
          .doc(chatController.globalConversationID.value)
          .collection('messages')
          .get();
      // var res = await conversationsCollection.doc(chatController.globalConversationID.value).get();
      log("============= res" + res.size.toString());
      // log("============= query snapshot" + querySnapshot.docs.toString());

      for (final conversationDoc in res.docs) {
        final conversationId = conversationDoc.id;
        final members = [loggedInUser, secondUser];

        // Fetch the last message and last message time for each conversation
        // final messagesRef = await convertPointerToConversation(conversationDoc);
        // final messagesRefs = conversationDoc.reference.collection('messages').limit(4);
        final messagesRef = FirebaseFirestore.instance
            .collection('conversations')
            .doc(chatController.globalConversationID.value)
            .collection('messages');
        final lastMessageSnapshot = await messagesRef
            .orderBy('createdAt', descending: true)
            .limit(1)
            .get();

        String? lastMessage;
        DateTime? lastMessageTime; // Use DateTime type instead of Timestamp

        if (lastMessageSnapshot.docs.isNotEmpty) {
          final lastMessageData = lastMessageSnapshot.docs.first.data();
          lastMessage = conversationDoc.get("text");
          final timestamp = DateTime.parse(conversationDoc.get("createdAt"));
          lastMessageTime = timestamp; // Convert Timestamp to DateTime
        }
        // Calculate the unread message count for this conversation
        // final recipientId = loggedInUser;
        // final querySnapshot = await messagesRef
        //     .where('isRead', isEqualTo: false)
        //     .where('senderId', isNotEqualTo: recipientId)
        //     .get();

        // final unreadMessagesCount = querySnapshot.size;

        // Create a Conversation object with the data
        final conversation = Conversation(
          conversationId: conversationId,
          members: members,
          lastMessage: lastMessage!,
          lastMessageTime: lastMessageTime!,
          unreadMessagesCount: 0,
        );

        log("reciever" + members[1]);
        log("sender" + members[0]);
        log("The origional conversation list length is" +
            conversation.lastMessage);
        // Add the conversation to the list
        // for (var i =0; i<)
        log("second user is" + secondUser);
        chatController.listOfConversation.add(conversation);
        // chatController.listOfConversation.removeWhere((element) => element.members[0]!=userController.user.id);
      }
      log("The conversation list length is" +
          chatController.listOfConversation.length.toString());
      chatController.listOfConversation
          .sort((a, b) => a.lastMessageTime.compareTo(b.lastMessageTime));

      return chatController.listOfConversation;
    });
    chatController.isLoading.value = false;

    return conversationsStream;
  }

// Iterate over the results of the query and convert each conversation document to a Conversation object.
  Future<List<int>> getUniqueMembers() async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    final stream = _firestore
        .collection('conversations')
        .where("members", arrayContains: userController.user.value.id!)
        .snapshots();
    log("User ID from firebase"+userController.user.value.id.toString());
    // log("stream value"+await stream.length.toString());

// Create a new list to store the unique members.
//     final uniqueMembers = <String>[];

// Iterate over the stream of conversations.
    await for (final conversationSnapshot in stream) {
      // Get the list of documents in the query result.
      final documents = conversationSnapshot.docs;

      // Iterate over the list of documents and call the 'data' method on each document to get the data for that document.
      for (final document in documents) {
        // Get the members list for the current document.
        final members = document.data()['members'];
        // log("members from home"+members[0]);
        // log("members from total"+members.toString());
        // log("members from home"+members[1]);
        int recieverID = int.parse(members[1]);
        int senderID = int.parse(members[0]);
        log("in firebaswe unique"+recieverID.toString());
        // if (!chatController.listOfUserIDs.contains(recieverID)) {
          chatController.listOfUserIDs.add(recieverID);
          chatController.update();
          // chatController.saveUserIDsList(chatController.listOfUserIDs.value);

        // }
        // else if (!chatController.listOfUserIDs.contains(senderID)) {
          chatController.listOfUserIDs.add(senderID);
          chatController.update();
          // chatController.saveUserIDsList(chatController.listOfUserIDs.value);
        // }
        chatController.listOfUserIDs.removeWhere((element) => element.toString()==userController.user.value.id.toString());
        log("list of user IDs is "+chatController.listOfUserIDs.value.toString());
        // chatController.update();

        // Add each member to the new list, if it is not already in the list.
        // for (final member in members) {
        //   if (!uniqueMembers.contains(member)) {
        //     uniqueMembers.add(member);
        //   }
        // }
      }
    }
    // log("uniqur"+uniqueMembers.toString());

// Return the new list of unique members.
    return chatController.listOfUserIDs.value;
  }
  sendMessage(String messageText, String storeID) {
    chatController.isLoading.value = true;

    log("=====================> Conversation global" +
        chatController.globalConversationID.value.toString());
    final conversationId = chatController.globalConversationID.value;
    ;

    if (conversationId != null) {
      DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
      var map = {
        'senderId': userController.user.value.id,
        'text': messageText,
        'createdAt': dateFormat.format(DateTime.now().toUtc()),
        'msgType': 'text',
        'isRead': false
      };
      log("map is" + map.toString());
      firestore
          .collection('conversations')
          .doc(conversationId)
          .collection('messages')
          .add(map);
    }
    chatController.isLoading.value = false;
  }

  getLastMsg(String convoID) async {
    // chatController.lastMsgOfEachConversation.clear();
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    var stream = await firestore
        .collection('conversations')
        .doc(convoID)
        .collection("messages")
        .orderBy("createdAt", descending: false)
        .get();
    int streamLength = stream.docs.length;
    log("stream Doc" + streamLength.toString());
    log("stream last" + stream.docs.last.get("text"));
    // chatController.lastMsgOfEachConversation.clear();
    // for(var )
    // chatController.lastMsgOfEachConversation.refresh();



    // log("stream sdadas" +
    // (stream.docs.forEach((element) {
    //   log("for each"+element.get("text"));
    // }));
    return stream.docs.last.get("text");
    // return stream.docs.last.get("text");
    // for (var i = 0; i < stream.docs.length; i++) {
    //   // if(i==stream.docs.length-1){
    //   log("stream lastMsg" + stream.docs[i].get("text"));
    //   // }
    // }
    // chatController.lastMessageOnChatScreen.value =
    //     stream.docs.last.get("text");
    //
    // // for (final i in stream.docs){
    // //   // log("createdAt"i.);
    // //   log("stream lastMsg"+i.data()["text"]);
  }

  // Future<List<List<Conversation>>?> gettingYourActiveConversations(
  //     String userID) async {
  //   chatController.isLoading.value = true;
  //   chatController.totalConvo.clear();
  //
  //   // chatController.lastMsgOfEachConversation.clear();
  //   final FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   final conversationsCollection = firestore.collection('conversations');
  //
  //   // Stream of conversation documents
  //   final conversationDocsStream = conversationsCollection
  //       .where('members', isEqualTo: userID.toString())
  //       .snapshots();
  //   final QuerySnapshot existingConversations = await firestore
  //       .collection('conversations')
  //       .where('members', arrayContains: userID)
  //       .get();
  //   chatController.totalConvo.clear();
  //   chatController.lastMsgOfEachConversation.clear();
  //
  //   for (final i in existingConversations.docs) {
  //     log("----------> refs     " + i.reference.id);
  //     log("----------> refs     " + i.toString());
  //     log("----------> conversationID" + i.id);
  //     var memberList =
  //         List<String>.from((i.data() as Map<String, dynamic>)['members']);
  //     var isProductPresent =
  //         dashBoardController.moreProductList.indexWhere((element) {
  //       return element.user!.id.toString() == memberList[1].toString()
  //           || element.user!.id.toString() == memberList[0].toString()
  //       ;
  //     });
  //
  //     String userName;
  //     String userImage;
  //     log("preset" + isProductPresent.toString());
  //     if (isProductPresent != -1) {
  //       userName =
  //           dashBoardController.moreProductList[isProductPresent].storeName ??
  //               "";
  //       userImage =
  //           dashBoardController.moreProductList[isProductPresent].storeImage ??
  //               "";
  //     } else {
  //       userName = "";
  //       userImage = "";
  //     }
  //     var messages = await firestore
  //         .collection('conversations')
  //         .doc(i.id)
  //         .collection('messages')
  //         .get();
  //     chatController.convoList.clear();
  //     chatController.SingleConvo.clear();
  //     for (final msg in messages.docs) {
  //       log("----------> last msg" + msg.get("text"));
  //       chatController.SingleConvo.add(Conversation(
  //           conversationId: i.reference.id,
  //           members: memberList,
  //           lastMessage: msg.get("text"),
  //           lastMessageTime: DateTime.parse(msg.get("createdAt")),
  //           unreadMessagesCount: 0));
  //     }
  //     List<Conversation> LoC = [];
  //     for (var s = 0; s < chatController.SingleConvo.length; s++) {
  //       if (chatController.SingleConvo[s].conversationId == i.id) ;
  //       log("index" + s.toString());
  //       // return ;
  //     }
  //     var indexes = chatController.SingleConvo.indexWhere(
  //         (element) => element.conversationId == i.id);
  //     log("indexes" + indexes.toString());
  //     var abc =
  //         chatController.SingleConvo.where((p0) => p0.conversationId == i.id)
  //             .toList()
  //             .sort((a, b) => b.lastMessageTime.compareTo(a.lastMessageTime));
  //     chatController.totalConvo.add(
  //       TextMessage(
  //           conversationID: i.id,
  //           userID: memberList[1],
  //           lastMessage: messages.docs.last.get("text"),
  //           lastMessageTime:
  //               DateTime.parse(messages.docs.last.get("createdAt")),
  //           userImage: userImage,
  //           userName: userName,
  //           listOfConversations: chatController.SingleConvo.where(
  //               (p0) => p0.conversationId == i.id).toList()),
  //     );
  //     chatController.totalConvo
  //         .sort((a, b) => b.lastMessageTime.compareTo(a.lastMessageTime));
  //
  //     final conversationReference =
  //         FirebaseFirestore.instance.collection('conversations').doc(i.id);
  //     final messagesCollection = conversationReference.collection('messages');
  //     final querySnapshot = await messagesCollection.get();
  //     log("----------> memberList" + (memberList.toString()));
  //     chatController.convoList.add(chatController.SingleConvo);
  //     log("---------->  convo");
  //     chatController.SingleConvo.forEach((element) {
  //       log("Convo Id from single" + element.conversationId);
  //     });
  //     chatController.totalConvo.forEach((element) {
  //       log("Convo Id from total" + element.conversationID);
  //     });
  //   }
  //   log("-------> Convo List" + chatController.convoList.toString());
  //   chatController.isLoading.value = false;
  //   // await getLastMsg(convoID);
  //
  //   return chatController.convoList;
  // }
}

// Future<void> markMessagesAsRead(String conversationId) async {
//   // Get the collection of messages for the given conversation.
//   CollectionReference messagesCollection = FirebaseFirestore.instance
//       .collection('conversations')
//       .doc(conversationId)
//       .collection('messages');
//
//   // Query the messages collection to find all messages that have not been read.
//   Query query = messagesCollection.where('isRead', isEqualTo: false);
//
//   // Get the results of the query.
//   QuerySnapshot querySnapshot = await query.get();
//
//   // Iterate over the results of the query and mark each message as read.
//   for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
//     // Get the message data.
//     Map<String, dynamic> messageData =
//         documentSnapshot.data() as Map<String, dynamic>;
//
//     // Update the message data to mark it as read.
//     messageData['isRead'] = true;
//
//     // Update the message in the database.
//     await documentSnapshot.reference.update(messageData);
//   }
// }
//
// void _fetchMessages() {
//   log("ConvoIDDDD : $conversationId");
//   var _messagesStream = _firestore
//       .collection('conversations')
//       .doc(conversationId)
//       .collection('messages')
//       .orderBy('createdAt', descending: true)
//       .snapshots();
// }
