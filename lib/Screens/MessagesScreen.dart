import 'dart:developer';

import 'package:app_fliplaptop/Apiserrvices/Services.dart';
import 'package:app_fliplaptop/Apiserrvices/app_url.dart';
import 'package:app_fliplaptop/Apiserrvices/loader.dart';
import 'package:app_fliplaptop/Controller/chatController.dart';
import 'package:app_fliplaptop/Controller/dashBoardController.dart';
import 'package:app_fliplaptop/Controller/productController.dart';
import 'package:app_fliplaptop/Screens/ChatScreen.dart';
import 'package:app_fliplaptop/components/customNetworkImage.dart';
import 'package:app_fliplaptop/models/dashBoardModel.dart';
import 'package:app_fliplaptop/res/utils/utils.dart';
import 'package:app_fliplaptop/widgets/disallow_indicator_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../components/global.dart';

class MessageScreen extends StatefulWidget {
  MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  // @override
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isLoading = false;

  void initState() {
    // TODO: implement initState
    // ChatController chatController = Get.put(ChatController());
    // getUserData();
    // log("user ID lengths" + chatController.listOfUserIDs.length.toString());
    // Future.delayed(Duration(seconds: 2),(){
    //   setState(() {
    //   });
    // Future.delayed(Duration(seconds: 1), () {
    //   setState(() {});
    // });
    // Future.delayed(Duration(seconds: 2), () {
    //   setState(() {});
    // });
    // Future.delayed(Duration.zero, () {
    //   getUserData();
    //   setState(() {});
    // });
// setState(() {
//
// });
//     Future.delayed(Duration(seconds: 4), () {
//       setState(() {});
//     });
    // });
    // chatController.totalConvo.clear();
    super.initState();
  }

  // getUserData() async {
  //   // await FirebaseServices().getUniqueMembers();
  //   // ApiServices().getUsersData(chatController.listOfUserIDs).then((value) => value.forEach((element) {
  //   //   log("then"+element.id.toString());
  //   // }));
  //
  //   await ApiServices().getUsersData(chatController.listOfUserIDs);
  //   setState(() {});
  //
  //   // .then(
  //   //   (value) => setState(() {}),
  //   // );
  // }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   log("chat controller disposed");
  //   chatController.dispose();
  //   super.dispose();
  // }

  DateFormat zoneDateFormat = DateFormat('hh:mm a', 'en_US');

  // final List chatList = [
  //   chatDetail('John Smith', 'assets/Mask Group 9@3x.png',
  //       'Have a great experience', '10:20 PM', '3', true),
  //   chatDetail('Nola Sofyan', 'assets/Ellipse 137@3x.png', 'Nola is typing',
  //       '10:20 PM', '3', false),
  //   chatDetail('Johny', 'assets/Ellipse 100.png', 'Nola is typing', '10:20 PM',
  //       '3', false),
  //   chatDetail(
  //       'Evie', 'assets/Ellipse 85@3x.png', 'Typing', '10:20 PM', '3', false),
  //   chatDetail('Nola Sofyan', 'assets/Ellipse 82@3x.png', 'Nice Quality',
  //       '10:20 PM', '3', false),
  //   chatDetail(
  //       'Evie', 'assets/Ellipse 80@3x.png', 'Good Job', '10:20 PM', '3', false),
  //   chatDetail('John', 'assets/Ellipse 75-2@3x.png', 'Order Delievered',
  //       '10:20 PM', '3', false),
  //   chatDetail('Evie', 'assets/Ellipse 75@3x.png', 'Recommended', '10:20 PM',
  //       '3', false),
  //   chatDetail('Nola Sofyan', 'assets/Ellipse 74@3x.png', 'Amazing Service',
  //       '10:20 PM', '3', false),
  // ];

  ChatController chatController = Get.put(ChatController());

  List<String> stringList = <String>[];

  // getlast(int index) async {
  //   chatController.isLoading.value = true;
  //   String abc = await FirebaseServices()
  //       .getLastMsg(chatController.totalConvo[index].conversationID);
  //   // for(var i =0; i< chatController.totalConvo.length;i++){
  //   // chatController.lastMsgOfEachConversation.add(abc);
  //   // }
  //   // stringList.add(abc);
  //   chatController.lastMsgOfEachConversation.value.add(abc);
  //   chatController.updateLastMsgOfEachConversationList(
  //       chatController.lastMsgOfEachConversation.value);
  //
  //   chatController.lastMsgOfEachConversation.refresh();
  //   log("controller lits from get" + abc);
  //   chatController.lastMsgOfEachConversation.forEach((element) {
  //     log("controller lits" + element);
  //   });
  //
  //   log("from func" + abc);
  //   chatController.isLoading.value = false;
  // }
  // getDoc(String docID) async {
  //   var chatData = await _firestore
  //       .collection('conversations')
  //       .doc(docID)
  //       // .doc(chatController.globalConversationID.value)
  //       .collection('messages')
  //       .orderBy('createdAt', descending: false)
  //       .snapshots();
  //   // var snapShotData =
  //   log("Chat Data" + chatData.toString());
  // }
  // sortSnapShot(AsyncSnapshot<QuerySnapshot<Object?>> snap) async {
  //  await snap.data!.docs.first.reference.collection("messages").orderBy('createdAt', descending: false).get();
  // }
  @override
  Widget build(BuildContext context) {
    log("userID" + userController.user.value.id.toString());
    // log("userID" + ApiSer);
    ;

    // chatController.listOfUsers.clear();

    // Stream<QuerySnapshot> getStream(String userID){
    //   var stream = _firestore
    //       .collection('conversations')
    //   // .doc(chatController.globalConversationID.value)
    //   // .doc(chatController.globalConversationID.value)
    //   //     .collection('messages')
    //       .where("members", arrayContains: userID)
    //   // .orderBy('createdAt', descending: false)
    //       .snapshots();
    //   final conversationsStream = stream.asyncMap((querySnapshot) async {
    //     // final List<Conversation> conversations = [];
    //
    //     for (final conversationDoc in querySnapshot.docs) {
    //       // final conversationId = conversationDoc.id;
    //       // final members = List<String>.from((conversationDoc.data() as Map<String, dynamic>)['members']);
    //
    //       // Fetch the last message and last message time for each conversation
    //       final messagesRef = conversationDoc.reference.collection('messages');
    //       final lastMessageSnapshot = await messagesRef.orderBy('createdAt', descending: true).get();
    //       return lastMessageSnapshot.docs.first.sn;
    //     }
    //     // return conversations;
    //   });
    //
    //   return conversationsStream;
    // }
    var stream = _firestore
        .collection('conversations')
        // .doc(chatController.globalConversationID.value)
        // .doc(chatController.globalConversationID.value)
        //     .collection('messages')
        .where("members", arrayContains: userController.user.value.id)
        .
        // .orderBy('createdAt', descending: false)
        snapshots();

    // chatController.lastMsgOfEachConversation.clear();
    final dashBoardController = Get.put(DashBoardController());
    final ProductController productController = Get.put(ProductController());

    // final productController = Get.put(ProductController());

    // .doc(chatController.globalConversationID.value)
    // .doc(chatController.globalConversationID.value)
    //     .collection('messages')
    //     .orderBy('createdAt', descending: false)
    //     .snapshots();
    // FirebaseServices().gettingYourActiveConversations(userController.user.id!);
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        // leadingWidth: 30.r,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              final bottomcontroller = Get.put(BottomController());
              bottomcontroller.navBarChange(0);
              Get.toNamed('/StartAppScreen');
            },
            icon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, gradient: kbtngradient),
                child: SvgPicture.asset(
                  'assets/Path 11.svg',
                  width: 14,
                ))),
        centerTitle: true,
        title: GestureDetector(
          onTap: () {
            // FirebaseServices()
            //     .gettingYourActiveConversations(userController.user.id!);
          },
          child: Text(
            "Messages",
            style: GoogleFonts.inter(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
        ),
      ),
      body: FutureBuilder(
        future: ApiServices().getUsersData(chatController.listOfUserIDs),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loader.spinkit;
          } else {
            chatController.listOfUsers.removeWhere((element) =>
                element.id.toString() == userController.user.value.id);
            return StreamBuilder<QuerySnapshot>(
              stream: stream,
              builder: (context, snapshot) {
                // return FutureBuilder(
                //   future: FirebaseServices()
                //       .gettingYourActiveConversations(userController.user.id!),
                //   builder:
                //   (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Loader.spinkit;
                }
                if (!snapshot.hasData) {
                  return Center(
                    child: Text("No Recent Chats"),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text("No Recent Chats"),
                  );
                }
                // if (snapshot.hasError) {
                //   return Center(
                //     child: Text("No Chats"),
                //   );
                // }
                else {
                  for (final i in snapshot.data!.docs) {
                    i.reference
                        .collection("messages")
                        .orderBy('createdAt', descending: true);
                  }
                  // snapshot.data!.docs.first.reference.collection("messages").orderBy('createdAt', descending: false);
                  // var map = snapshot.data!.docs.first.reference.collection("messages").doc().get();
                  // log("map"+map.toString());

                  // map.values.toList().sort((a, b) {
                  //   return a['timestamp'].compareTo(b['timestamp']);
                  //   // also not work return b['timestamp'].compareTo(a['timestamp']);
                  // });
                  // log("data get to sort"+ snap.toString());
                  // snapshot.data.docs[index]
                  // snapshot.data!.docs.sort((a, b) => a.reference.collection("messages").doc().compareTo(b.lastMessageTime))
                  // log("snapshot data" + snapshot.data!.size.toString());
                  return DisAllowIndicatorWidget(
                      child:
                          // chatController.isLoading.value
                          //     ? Center(
                          //         child: Loader.spinkit,
                          //       )
                          //         :

                          snapshot.data!.docs.isEmpty
                              ? Center(
                                  child: Text("No Active Chats"),
                                )
                              : ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.r, vertical: 10.r),
                                  itemBuilder: (context, index) {
                                    // snapshot.data!.docs.first.reference.collection("messages").orderBy('createdAt', descending: false);
                                    // getlast(index);
                                    // getDoc(snapshot.data!.docs[index].id);
                                    // snapshot.data.doc
                                    var snapShotData =
                                        snapshot.data!.docs[index].id;
                                    var recieverID = List<String>.from((snapshot
                                        .data!.docs[index]
                                        .get("members")))[1];
                                    var senderID = List<String>.from((snapshot
                                        .data!.docs[index]
                                        .get("members")))[0];

                                    log("senderID" + senderID);
                                    log("recieverID" + recieverID);
                                    String? userName="User not found";
                                    String? userImage;
                                    String storeName = "";
                                    for (var i = 0;
                                        i < chatController.listOfUsers.length;
                                        i++) {
                                      log("userIDs in list of users" +
                                          chatController.listOfUsers[i].id
                                              .toString());
                                      if (chatController.listOfUsers[i].id ==
                                              recieverID ||
                                          chatController.listOfUsers[i].id ==
                                              senderID) {
                                        userName =
                                            chatController.listOfUsers[i].name;
                                        userImage =
                                            chatController.listOfUsers[i].image;
                                        log("user Name" + userName.toString());
                                      }
                                      // int indexInLOU = chatController
                                      //     .listOfUsers
                                      //     .indexWhere((element) =>
                                      // element.id == recieverID ||
                                      //     element.id == senderID);
                                      // log("index in LOU" +
                                      //     indexInLOU.toString());
                                      // snapshot.data!.docs.sort(
                                      //   (a, b) => a.get("createdAt").compareTo(
                                      //         b.get("createdAt"),
                                      //       ),
                                      // );
                                      // if (indexInLOU != -1) {
                                      //
                                      // }
                                    }
                                    for (final i
                                        in dashBoardController.storeList) {
                                      if (i.product != null) {
                                        for (final j in i.product!) {
                                          if (j.user!.id == recieverID ||
                                              j.user!.id == senderID) {
                                            storeName = j.storeName ?? "";
                                            log("storeName" + storeName);
                                            // userName = j.user!.name;
                                            // userImage = j.user!.image;
                                            log(j.user!.id.toString());
                                          }
                                        }
                                      }
                                    }

                                    // log("member 1 "+members);
                                    // getDoc(snapShotData);
                                    // log("messages"+snapshot.data!.docs[index].get("messages"));
                                    // });
                                    // String? lastMessage;
                                    // log("from controller"+chatController.lastMessageOnChatScreen.value);
                                    // lastMessage=chatController.lastMessageOnChatScreen.value;
                                    // for (var i = 0;
                                    //     i < chatController.totalConvo.length;
                                    //     i++) {
                                    // chatController.lastMsgOfEachConversation.clear();

                                    // }
                                    // for(final at in stream.docs)
                                    // for (final i in stream.docs){
                                    //
                                    // }
                                    // chatController
                                    //     .totalConvo[index].listOfConversations
                                    //     .sort((a, b) => a.lastMessageTime
                                    //         .compareTo(b.lastMessageTime));
                                    log("createdAt" +
                                        snapshot.data!.docs[index].toString());

                                    return StreamBuilder<
                                            QuerySnapshot<
                                                Map<String, dynamic>>>(
                                        stream: _firestore
                                            .collection('conversations')
                                            .doc(snapShotData)
                                            // .doc(chatController.globalConversationID.value)
                                            .collection('messages')
                                            .orderBy('createdAt',
                                                descending: false)
                                            .snapshots(),
                                        builder: (context, Subsnapshot) {
                                          // snapShotData.data

                                          //   // else{
                                          //   // }
                                          // }
                                          // int isUserFound = dashBoardController
                                          //     .moreProductList
                                          //     .indexWhere((element) =>
                                          //         element.user!.id == recieverID ||
                                          //         element.user!.id == senderID);
                                          //
                                          // int isUserFoundInNewArrival =
                                          //     dashBoardController
                                          //         .newArrival.value.data!
                                          //         .indexWhere((element) =>
                                          //             element.user!.id ==
                                          //                 recieverID ||
                                          //             element.user!.id == senderID);
                                          // if (isUserFound != -1) {
                                          //   userName = dashBoardController
                                          //       .moreProductList[isUserFound]
                                          //       .user!
                                          //       .name;
                                          //   userImage = dashBoardController
                                          //       .moreProductList[isUserFound]
                                          //       .user!
                                          //       .image!;
                                          // } else if (isUserFoundInNewArrival !=
                                          //     -1) {
                                          //   userName = dashBoardController
                                          //       .newArrival
                                          //       .value
                                          //       .data![isUserFoundInNewArrival]
                                          //       .user!
                                          //       .name;
                                          //   userImage = dashBoardController
                                          //       .newArrival
                                          //       .value
                                          //       .data![isUserFoundInNewArrival]
                                          //       .user!
                                          //       .image!;
                                          // }
                                          // log("is user found at stores  index"+isUserFoundInStores.toString());

                                          // int isUserFoundInProductList =
                                          //     productController
                                          //         .productListingDataList.first.data!
                                          //         .indexWhere((element) =>
                                          //             element.user!.id == recieverID ||
                                          //             element.user!.id ==
                                          //                 userController.user.id);

                                          // if (isUserFound != -1) {
                                          //   userName = dashBoardController
                                          //       .moreProductList[isUserFound]
                                          //       .user!
                                          //       .name;
                                          //   userImage = dashBoardController
                                          //       .moreProductList[isUserFound]
                                          //       .storeImage!;
                                          // }
                                          // int isUserFoundInStores =  dashBoardController.storeList.indexWhere((element) => element.id==recieverID || element.id==senderID);

                                          //  if (isUserFoundInStores != -1) {
                                          //   userName = dashBoardController
                                          //       .storeList.first.product![isUserFoundInStores]
                                          //       .name;
                                          //   userImage = dashBoardController
                                          //       .storeList[isUserFoundInStores]
                                          //       .image!;
                                          // }
                                          // // else if (isUserFoundInProductList != -1) {
                                          // //   userName = productController
                                          // //       .productListingDataList
                                          // //       .first
                                          // //       .data![isUserFoundInProductList]
                                          // //       .user!
                                          // //       .name;
                                          // //   userImage = productController
                                          // //       .productListingDataList
                                          // //       .first
                                          // //       .data![isUserFoundInProductList]
                                          // //       .storeImage!;
                                          // // }
                                          // else {
                                          //   userName = "NaN";
                                          //   userImage = "userImage";
                                          // }
                                          // int isUserFoundInNew = dashBoardController
                                          //     .completeData.value.data!.newArrivalProduct.data!
                                          //     .indexWhere((element) =>
                                          // element.user!.id == recieverID ||
                                          //     element.user!.id ==
                                          //         userController.user.id);
                                          // // String? userNameFromNew;
                                          // // String? userImage;
                                          // if (isUserFoundInNew != -1) {
                                          //   userName = dashBoardController
                                          //       .completeData.value.data!.newArrivalProduct.data![isUserFound]
                                          //       .user!
                                          //       .name;
                                          //   userImage = dashBoardController
                                          //       .completeData.value.data!.newArrivalProduct.data![isUserFound]
                                          //       .storeImage!;
                                          // } else {
                                          //   userName = "NaN";
                                          //   userImage = "userImage";
                                          // }
                                          if (Subsnapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return Center(
                                              child: SizedBox(
                                                height: 0.05.sh,
                                                width: 0.05.sw,
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.transparent,
                                                  // strokeWidth: 2.w,
                                                ),
                                              ),
                                            );
                                          } else {
                                            // snapshot.data!.docs.sort((a, b) => a.reference.collection("message").doc().get()/.compareTo(b.lastMessageTime));
                                            log("path" +
                                                snapshot
                                                    .data!.docs[index].reference
                                                    .collection("messages")
                                                    .doc()
                                                    .toString());
                                            // Future<DateTime> getCreatedAtValue() async {
                                            //   DocumentSnapshot messageDocumentSnapshot = await  FirebaseFirestore.instance.;
                                            //
                                            //   // Get the createdAt value from the document.
                                            //   DateTime createdAt = messageDocumentSnapshot.get('createdAt');
                                            //   log("createdAt"+createdAt.toString());
                                            //
                                            //   return createdAt;
                                            // }
                                            // getCreatedAtValue();
                                            // var SubSnapShotData =
                                            // Subsnapshot.data!.docs[index];
                                            return Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    // if( userName=="User not found"){
                                                    //   Utils.showSnack("This chat room is not available", context);
                                                    // }
                                                    // else {
                                                      // FirebaseServices()
                                                      //     .fetchConversationsStream(
                                                      //         userController.user.id ?? "",
                                                      //         chatController
                                                      //             .totalConvo[index].userID
                                                      //             .toString());
                                                      // log("userID of store" +
                                                      //     chatController
                                                      //         .totalConvo[index].userID);
                                                      chatController.isLoading
                                                          .value = false;
                                                      log("User ID is " +
                                                          List<String>.from(
                                                              (snapshot
                                                                  .data!
                                                                  .docs[index]
                                                                  .get(
                                                                  "members")))[1]);
                                                      Get.to(
                                                            () =>
                                                            ChatScreen(
                                                              // senderData: ,
                                                              // conversationID: Subsnapshot.data!.docs[index].id,
                                                              storeData: User(
                                                                  id: List<
                                                                      String>.from(
                                                                      (snapshot
                                                                          .data!
                                                                          .docs[index]
                                                                          .get(
                                                                          "members")))[1],
                                                                  name: userName,
                                                                  image: userImage),
                                                              fromBottomNav: true,
                                                              selectIndexOfIndividualChat:
                                                              index,
                                                            ),
                                                      );
                                                      chatController
                                                          .globalConversationID
                                                          .value =
                                                          snapshot.data!
                                                              .docs[index].id;
                                                    // }
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20.r,
                                                            vertical: 19.r),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.r),
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.3),
                                                              blurRadius: 6,
                                                              offset:
                                                                  Offset(0, 0))
                                                        ]),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Container(
                                                              width: 62.r,
                                                              height: 62.r,
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        184,
                                                                        184,
                                                                        184),
                                                                // image: chatList[index].userImage! != ''
                                                                //     ? DecorationImage(
                                                                //         image: AssetImage(chatList[index]
                                                                //             .userImage!
                                                                //             .toString()),
                                                                //         fit: BoxFit.cover)
                                                                //     : null
                                                              ),
                                                              child: ClipOval(
                                                                child: userImage ==
                                                                            "" ||
                                                                        userImage ==
                                                                            null
                                                                    ? Image
                                                                        .asset(
                                                                        "assets/avatar.png",
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      )
                                                                    : CustomNetworkImage(
                                                                        imageUrl:
                                                                            ImageUrls.kUserProfile +
                                                                                (userImage)
                                                                        // +
                                                                        // chatController
                                                                        //     .totalConvo[index]
                                                                        //     .userImage
                                                                        ,
                                                                      ),
                                                              ),
                                                            ),
                                                            Visibility(
                                                              visible: false,
                                                              child: Positioned(
                                                                bottom: 4,
                                                                right: 3,
                                                                child:
                                                                    Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              4),
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      color: Color(
                                                                          0xff52B36F)),
                                                                ),
                                                              ),
                                                            ),
                                                            10.horizontalSpace,
                                                            Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    SizedBox(
                                                                      width: userName!.length >
                                                                              10
                                                                          ? 0.2
                                                                              .sw
                                                                          : 0.14
                                                                              .sw,
                                                                      child:
                                                                          Text(
                                                                        userName ??
                                                                            ""
                                                                        //     "sasafsafsafsafsasafsasafasfsa"
                                                                        // Subsnapshot
                                                                        //     .data!.docs.last
                                                                        //     .get("text")
                                                                        ,
                                                                        style: GoogleFonts.inter(
                                                                            fontSize:
                                                                                12.r,
                                                                            fontWeight: userName=="User not found"?FontWeight.w800:FontWeight.w600,
                                                                          fontStyle: userName=="User not found"?FontStyle.italic:FontStyle.normal

                                                                        ),
                                                                      ),
                                                                    ),
                                                                    // storeName ==
                                                                    //         ""
                                                                    //     ? SizedBox()
                                                                    //     : Row(
                                                                    //         children: [
                                                                    //           VerticalDivider(
                                                                    //             color: Colors.black,
                                                                    //             thickness: 2,
                                                                    //             indent: 5,
                                                                    //             endIndent: 5,
                                                                    //           ),
                                                                    //           Text(
                                                                    //             "| (${storeName})"
                                                                    //             // Subsnapshot
                                                                    //             //     .data!.docs.last
                                                                    //             //     .get("text")
                                                                    //             ,
                                                                    //             style: GoogleFonts.inter(fontSize: 12.r, fontWeight: FontWeight.w400),
                                                                    //           ),
                                                                    //         ],
                                                                    //       ),
                                                                  ],
                                                                ),
                                                                6.verticalSpace,
                                                                GetBuilder<
                                                                    ChatController>(
                                                                  builder:
                                                                      (controller) {
                                                                    return
                                                                        // controller
                                                                        //       .isLoading.value
                                                                        //   ? SizedBox(
                                                                        //       height: 10.h,
                                                                        //       width: 10.w,
                                                                        //       child:
                                                                        //           CircularProgressIndicator(
                                                                        //         color:
                                                                        //             kprimaryColor,
                                                                        //         strokeWidth:
                                                                        //             2.w,
                                                                        //       ))
                                                                        //   :
                                                                        Text(
                                                                      Subsnapshot
                                                                          .data!
                                                                          .docs
                                                                          .last
                                                                          .get(
                                                                              "text")
                                                                          .toString(),
                                                                      style: GoogleFonts.inter(
                                                                          fontSize: 13
                                                                              .sp,
                                                                          color:
                                                                              Color(0xff3B3B3B).withOpacity(0.5)),
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    );
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                zoneDateFormat
                                                                    .format(DateTime.parse(Subsnapshot
                                                                        .data!
                                                                        .docs
                                                                        .last
                                                                        .get(
                                                                            "createdAt")))
                                                                    .toString()

                                                                // chatController.convoList[index].last.lastMessageTime.toString()
                                                                ,
                                                                style: GoogleFonts.inter(
                                                                    fontSize:
                                                                        13.r,
                                                                    color: Color(
                                                                        0xff1E1E1E)),
                                                              ),
                                                              5.verticalSpace,
                                                              // Container(
                                                              //   padding: EdgeInsets.all(5.r),
                                                              //   decoration: BoxDecoration(
                                                              //       gradient: kgradient,
                                                              //       shape: BoxShape.circle),
                                                              //   child: Text(
                                                              //     chatList[index]
                                                              //         .msgCount
                                                              //         .toString(),
                                                              //     style: GoogleFonts.inter(
                                                              //         color: Colors.white,
                                                              //         fontSize: 13.sp),
                                                              //   ),
                                                              // )
                                                            ])
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                20.verticalSpace,
                                              ],
                                            );
                                          }
                                        });
                                  }));
                }
              },
              // );
              // }
            );
          }
        },
      ),
    );
  }
}

class chatDetail {
  String? userName;
  String? userImage;
  String? lastMsg;
  String? time;
  String? msgCount;
  bool isOnline = false;

  chatDetail(this.userName, this.userImage, this.lastMsg, this.time,
      this.msgCount, this.isOnline);
}
