import 'dart:developer';

import 'package:app_fliplaptop/Apiserrvices/Services.dart';
import 'package:app_fliplaptop/Apiserrvices/app_url.dart';
import 'package:app_fliplaptop/Apiserrvices/firebaseServices.dart';
import 'package:app_fliplaptop/Apiserrvices/loader.dart';
import 'package:app_fliplaptop/Controller/chatController.dart';
import 'package:app_fliplaptop/components/customNetworkImage.dart';
import 'package:app_fliplaptop/res/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../components/global.dart';
import '../models/dashBoardModel.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen(
      {super.key,
      // required this.senderData,
      // required this.conversationID,
      required this.storeData,
      required this.fromBottomNav,
      required this.selectIndexOfIndividualChat});

  // final UserModel senderData;
  // final String conversationID;
  final User storeData;
  final bool fromBottomNav;
  final int selectIndexOfIndividualChat;
  final ScrollController scrollController = ScrollController();

  final TextEditingController msgType = TextEditingController();

  final argument = Get.arguments;
  DateFormat zoneDateFormat = DateFormat('hh:mm a', 'en_US');

  // final List<message> chatMessage = [
  //   message(
  //       true,
  //       'assets/alex-knight-j4uuKnN43_M-unsplash.png',
  //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna",
  //       '21:30'),
  //   message(
  //       false,
  //       'assets/alex-knight-j4uuKnN43_M-unsplash.png',
  //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna",
  //       '21:30'),
  //   message(
  //       false,
  //       'assets/alex-knight-j4uuKnN43_M-unsplash.png',
  //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna",
  //       '21:30'),
  //   message(
  //       true,
  //       'assets/alex-knight-j4uuKnN43_M-unsplash.png',
  //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna",
  //       '21:30'),
  //   message(
  //       false,
  //       'assets/alex-knight-j4uuKnN43_M-unsplash.png',
  //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna",
  //       '21:30'),
  //   message(
  //       false,
  //       'assets/alex-knight-j4uuKnN43_M-unsplash.png',
  //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna",
  //       '21:30'),
  //   message(
  //       false,
  //       'assets/alex-knight-j4uuKnN43_M-unsplash.png',
  //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna",
  //       '21:30'),
  //   message(
  //       false,
  //       'assets/alex-knight-j4uuKnN43_M-unsplash.png',
  //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna",
  //       '21:30'),
  //kljljlkjlkjlghbnvmnbmnghjkb,bnjhm,,.mn.jbjkbbnmn
  //   message(
  //       false,
  //       'assets/alex-knight-j4uuKnN43_M-unsplash.png',
  //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna",
  //       '21:30'),
  // ];

  final ChatController chatController = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    var stream = _firestore
        .collection('conversations')
        .doc(chatController.globalConversationID.value)
        // .doc(chatController.globalConversationID.value)
        .collection('messages')
        .orderBy('createdAt', descending: false)
        .snapshots();

    /// for checking th streams uncomment this and check the stream flow with timestamp
    // var dummy = _firestore
    //     .collection('conversations')
    //     .doc(chatController.globalConversationID.value)
    // // .doc(chatController.globalConversationID.value)
    //     .collection('messages')
    //     .orderBy('createdAt', descending: false).get()
    //     .then((QuerySnapshot querySnapshot) {
    //       querySnapshot.docs.forEach((element) {log("creared At "+element.get("createdAt")+" "+element.get("text"));});
    //   // Process querySnapshot data
    // });;
    // var subStream = _firestore
    //     .collection('conversations')
    //     .doc(chatController.globalConversationID.value)
    //     // .doc(chatController.globalConversationID.value)
    //     .collection('members')
    //     .snapshots();
    // Stream<List<Conversation>> _messsagestream = FirebaseServices()
    //     .fetchConversationsStream(
    //         userController.user.id ?? "", storeData.id.toString());
    // log(_messsagestream.toString());
    // _messsagestream.listen((event) {
    //   log("event is "+event.toString());
    // //   final source = (event.metadata.hasPendingWrites) ? "Local" : "Server";
    // // print("$source data: ${event.data()}");
    // });
    // var list = _messsagestream.toList();
    return Scaffold(
        backgroundColor: kPageBgColor,
        appBar: AppBar(
            // leadingWidth: 30.r,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
                onPressed: () => Get.back(),
                icon: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, gradient: kbtngradient),
                    child: SvgPicture.asset(
                      'assets/Path 11.svg',
                      width: 14,
                    ))),
            centerTitle: true,
            title: GestureDetector(
              onTap: () {
                DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

                log(dateFormat.format(DateTime.now()));
              },
              child: Text(
                storeData.name ?? "NaN",
                // '${argument}',
                style: GoogleFonts.inter(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            )),
        bottomSheet: storeData.name=="User not found"?Text("This user is not available",style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.w800,fontSize: 24.r),).paddingAll(10.r):Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 5.r),
              child: Row(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: Get.width * 0.75,
                    height: 55.h,
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.r, vertical: 16.r),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 244, 234, 245),
                            spreadRadius: 0,
                            blurRadius: 12,
                            offset: Offset(0, 3), // changes position of shadow
                          )
                        ],
                        borderRadius: BorderRadius.circular(15.r)),
                    child: Row(
                      children: [
                        // SvgPicture.asset('assets/Group 961.svg'),
                        // 10.horizontalSpace,
                        Expanded(
                            child: TextField(
                          onTap: () {
                            SchedulerBinding.instance.addPostFrameCallback((_) {
                              scrollController.animateTo(
                                scrollController.position.maxScrollExtent,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                            });
                          },
                          style: GoogleFonts.inter(fontSize: 13.sp),
                          controller: msgType,
                          decoration: InputDecoration(
                              isCollapsed: true,
                              isDense: true,
                              contentPadding: EdgeInsets.only(
                                  top: 0, bottom: 0, left: 0, right: 8.r),
                              border: InputBorder.none,
                              hintText: 'Type here...',
                              hintStyle: GoogleFonts.inter(
                                  color: Color(0xffABABAB), fontSize: 15.sp)),
                        )),
                        // Row(
                        //   mainAxisSize: MainAxisSize.min,
                        //   children: [
                        //     InkWell(
                        //       onTap: () {},
                        //       child: SvgPicture.asset('assets/Path 2967.svg'),
                        //     ),
                        //     10.horizontalSpace,
                        //     InkWell(
                        //       onTap: () {},
                        //       child: SvgPicture.asset(
                        //           'assets/Icon metro-attachment.svg'),
                        //     ),
                        //   ],
                        // )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      if (msgType.text == "") {
                        Utils.showSnack("Type the msg", context);
                      } else {
                        // DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
                        await FirebaseServices().sendMessage(
                            msgType.text,
                            fromBottomNav
                                ? chatController.globalConversationID.value
                                : storeData.id.toString());
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          scrollController.animateTo(
                            scrollController.position.maxScrollExtent,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        });
                        // _messsagestream.listen((event) {
                        //   // log("Eventtttttttttttttttttt" +
                        //   // event.length.toString());
                        // });
                        // await FirebaseServices().fetchConversationsStream(userController.user.id!, StoreID);
                        msgType.clear();
                      }
                    },
                    child: Container(
                      width: 50.r,
                      height: 50.r,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, gradient: kgradient),
                      child: SvgPicture.asset(
                        'assets/Icon material-send.svg',
                        width: 22.r,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            10.verticalSpace
          ],
        ),
        body: InkWell(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            controller: scrollController,
            child: Padding(
                padding: EdgeInsets.only(
                  left: 20.r,
                  right: 20.r,
                  bottom: 22.r,
                ),
                child:
                    // fromBottomNav
                    //     ?
                    StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: stream,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Padding(
                              padding: EdgeInsets.only(top: 0.35.sh),
                              child: Center(child: Loader.spinkit),
                            );
                          }
                          if (snapshot.hasData) {
                            log("hassssssssss data" +
                                snapshot.data!.docs[0].get("text"));
                            // FirebaseServices().gettingYourActiveConversations(userController.user.id!);
                            // chatController.totalConvo[selectIndexOfIndividualChat]
                            //     .listOfConversations
                            //     .sort((a, b) =>
                            //         a.lastMessageTime.compareTo(b.lastMessageTime));
                            // log("====================> snap shotttttttt " +
                            //     snapshot.data!.length.toString());
                            // chatController.listOfConversation.add(snapshot.data)
                            return Obx(() {
                              return chatController.isLoading.value
                                  ? Padding(
                                      padding: EdgeInsets.only(top: 0.35.sh),
                                      child: Center(child: Loader.spinkit),
                                    )
                                  : ListView.builder(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 0.05.sh),
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (context, index) {
                                        var snapShotData =
                                            snapshot.data!.docs[index].data();
                                        SchedulerBinding.instance
                                            .addPostFrameCallback((_) {
                                          scrollController.animateTo(
                                            scrollController
                                                .position.maxScrollExtent,
                                            duration:
                                                Duration(milliseconds: 500),
                                            curve: Curves.easeInOut,
                                          );
                                        });
                                        // snapShotData.values.toList().sort(
                                        // // log(a.toString());
                                        // );
                                        log("snapShotData" +
                                            snapShotData["text"]);
                                        // Conversation instance = snapshot.data![index];
                                        return Container(
                                          width: Get.width,
                                          padding: snapShotData["senderId"] ==
                                                  userController.user.value.id!
                                              ? null
                                              : EdgeInsets.only(
                                                  top: 6.r,
                                                  bottom: 6.r,
                                                ),
                                          margin:
                                              // chatController
                                              //             .totalConvo[
                                              //                 selectIndexOfIndividualChat]
                                              //             .listOfConversations[index]
                                              //             .members[0]
                                              snapShotData["senderId"] ==
                                                      userController.user.value.id
                                                  ? EdgeInsets.only(
                                                      right: 20.r, bottom: 20.r)
                                                  : EdgeInsets.only(
                                                      left: 20.r, bottom: 20.r),
                                          child:
                                              // chatController
                                              //             .totalConvo[
                                              //                 selectIndexOfIndividualChat]
                                              //             .listOfConversations[index]
                                              //             .members[0] !
                                              snapShotData["senderId"] !=
                                                      userController.user.value.id
                                                  ? Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          width: 38.r,
                                                          height: 38.r,
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            // image: DecorationImage(
                                                            //     image: AssetImage(
                                                            //         chatMessage[
                                                            //                 index]
                                                            //             .userImg
                                                            //             .toString()),
                                                            //     fit: BoxFit
                                                            //         .fill),
                                                          ),
                                                          child: ClipOval(
                                                            child: storeData.image ==
                                                                        "" ||
                                                                    storeData
                                                                            .image ==
                                                                        null
                                                                ? Image.asset(
                                                                    "assets/avatar.png",
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  )
                                                                : CustomNetworkImage(
                                                                    imageUrl: ImageUrls
                                                                            .kUserProfile +
                                                                        (storeData.image ??
                                                                            ""),
                                                                  ),
                                                          ),
                                                        ),
                                                        15.horizontalSpace,
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Container(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal: 20
                                                                            .r,
                                                                        vertical:
                                                                            19.r),
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10.r)),
                                                                child: Text(
                                                                  // chatController
                                                                  //     .totalConvo[
                                                                  //         selectIndexOfIndividualChat]
                                                                  //     .listOfConversations[
                                                                  //         index]
                                                                  //     .lastMessage
                                                                  snapShotData[
                                                                      "text"],
                                                                  style: GoogleFonts.inter(
                                                                      fontSize:
                                                                          14.sp,
                                                                      color: Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.6)),
                                                                ),
                                                              ),
                                                              9.verticalSpace,
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      // '${chatController.totalConvo[selectIndexOfIndividualChat].listOfConversations[index].lastMessageTime}'
                                                                      zoneDateFormat
                                                                          .format(DateTime.parse(snapShotData[
                                                                              "createdAt"]))
                                                                          .toString(),
                                                                      style: GoogleFonts.inter(
                                                                          fontSize: 14
                                                                              .sp,
                                                                          color:
                                                                              Colors.black))
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  : Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Container(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal: 20
                                                                            .r,
                                                                        vertical:
                                                                            19.r),
                                                                decoration: BoxDecoration(
                                                                    color: Color(
                                                                        0xff000000),
                                                                    borderRadius: BorderRadius.only(
                                                                        bottomLeft:
                                                                            Radius.circular(19
                                                                                .r),
                                                                        bottomRight:
                                                                            Radius.circular(35
                                                                                .r),
                                                                        topLeft:
                                                                            Radius.circular(19.r))),
                                                                child: Text(
                                                                  snapShotData[
                                                                      "text"],
                                                                  style: GoogleFonts.inter(
                                                                      fontSize:
                                                                          14.sp,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                              8.verticalSpace,
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  Text(
                                                                      zoneDateFormat
                                                                          .format(DateTime.parse(snapShotData[
                                                                              "createdAt"]))
                                                                          .toString(),
                                                                      style: GoogleFonts.inter(
                                                                          fontSize: 14
                                                                              .sp,
                                                                          color:
                                                                              Colors.black))
                                                                ],
                                                              ),
                                                              //        15.horizontalSpace,
                                                              //        Container(
                                                              //   width: 54.r,
                                                              //   height: 54.r,
                                                              //   decoration: BoxDecoration(
                                                              //       shape: BoxShape.circle,
                                                              //       image: DecorationImage(
                                                              //           image: AssetImage(chatMessage[index]
                                                              //               .userImg
                                                              //               .toString()),
                                                              //           fit: BoxFit.fill)),
                                                              // ),
                                                            ],
                                                          ),
                                                        ),
                                                        15.horizontalSpace,
                                                        // Text(userController
                                                        //     .user.value
                                                        //     .image.toString()),
                                                        Container(
                                                          width: 38.r,
                                                          height: 38.r,
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            // image: DecorationImage(
                                                            //     image: AssetImage(
                                                            //         chatMessage[index]
                                                            //             .userImg
                                                            //             .toString()),
                                                            //     fit: BoxFit.fill)
                                                          ),
                                                          child:ApiServices.myProfileDataList.first.data!.first!.image
                                                              .toString() == ""
                                                              ? ClipOval(
                                                                  child: Image
                                                                      .asset(
                                                                    "assets/avatar.png",
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                )
                                                              : ClipOval(
                                                                  child:
                                                                      CustomNetworkImage(
                                                                    imageUrl: ImageUrls
                                                                            .kUserProfile +
                                                                        (ApiServices.myProfileDataList.first.data!.first!.image

                                                                            .toString()),
                                                                  ),
                                                                ),
                                                        ),
                                                      ],
                                                    ),
                                        );
                                      },
                                    );
                            });
                          } else {
                            return Center(
                              child: Text("Error"),
                            );
                          }
                        })
                // : StreamBuilder<List<Conversation>>(
                //     stream: _messsagestream,
                //     builder: (context, snapshot) {
                //       if (snapshot.connectionState == ConnectionState.waiting) {
                //         return Padding(
                //           padding: EdgeInsets.only(top: 0.35.sh),
                //           child: Center(child: Loader.spinkit),
                //         );
                //       }
                //       if (snapshot.hasData) {
                //         // log("====================> snap shotttttttt " +
                //         //     snapshot.data!.length.toString());
                //         // chatController.listOfConversation.add(snapshot.data)
                //         return Obx(() {
                //           return chatController.isLoading.value
                //               ? Padding(
                //                   padding: EdgeInsets.only(top: 0.35.sh),
                //                   child: Center(child: Loader.spinkit),
                //                 )
                //               : ListView.builder(
                //                   physics: NeverScrollableScrollPhysics(),
                //                   shrinkWrap: true,
                //                   itemCount:
                //                       chatController.listOfConversation.length,
                //                   itemBuilder: (context, index) {
                //                     // Conversation instance = snapshot.data![index];
                //                     return Container(
                //                       width: Get.width,
                //                       padding: chatController
                //                                   .listOfConversation[index]
                //                                   .members[0] ==
                //                               userController.user.id!
                //                           ? null
                //                           : EdgeInsets.only(
                //                               top: 19.r,
                //                               bottom: 19.r,
                //                             ),
                //                       margin: chatController
                //                                   .listOfConversation[index]
                //                                   .members[0] ==
                //                               userController.user.id!
                //                           ? EdgeInsets.only(
                //                               right: 20.r, bottom: 20.r)
                //                           : EdgeInsets.only(
                //                               left: 20.r, bottom: 20.r),
                //                       child: chatController
                //                                   .listOfConversation[index]
                //                                   .members[0] !=
                //                               userController.user.id!
                //                           ? Row(
                //                               crossAxisAlignment:
                //                                   CrossAxisAlignment.start,
                //                               children: [
                //                                 Container(
                //                                   width: 38.r,
                //                                   height: 38.r,
                //                                   decoration: BoxDecoration(
                //                                       shape: BoxShape.circle,
                //                                       image: DecorationImage(
                //                                           image: AssetImage(
                //                                               chatMessage[index]
                //                                                   .userImg
                //                                                   .toString()),
                //                                           fit: BoxFit.fill)),
                //                                 ),
                //                                 15.horizontalSpace,
                //                                 Expanded(
                //                                   child: Column(
                //                                     crossAxisAlignment:
                //                                         CrossAxisAlignment
                //                                             .start,
                //                                     mainAxisAlignment:
                //                                         MainAxisAlignment
                //                                             .spaceBetween,
                //                                     children: [
                //                                       Container(
                //                                         padding: EdgeInsets
                //                                             .symmetric(
                //                                                 horizontal:
                //                                                     20.r,
                //                                                 vertical: 19.r),
                //                                         decoration: BoxDecoration(
                //                                             color: Colors.white,
                //                                             borderRadius:
                //                                                 BorderRadius
                //                                                     .circular(
                //                                                         10.r)),
                //                                         child: Text(
                //                                           chatController
                //                                               .listOfConversation[
                //                                                   index]
                //                                               .lastMessage,
                //                                           style: GoogleFonts.inter(
                //                                               fontSize: 14.sp,
                //                                               color: Colors
                //                                                   .black
                //                                                   .withOpacity(
                //                                                       0.6)),
                //                                         ),
                //                                       ),
                //                                       9.verticalSpace,
                //                                       Row(
                //                                         mainAxisAlignment:
                //                                             MainAxisAlignment
                //                                                 .end,
                //                                         children: [
                //                                           Text(
                //                                               '${chatMessage[index].time}',
                //                                               style: GoogleFonts
                //                                                   .inter(
                //                                                       fontSize:
                //                                                           14.sp,
                //                                                       color: Colors
                //                                                           .black))
                //                                         ],
                //                                       )
                //                                     ],
                //                                   ),
                //                                 )
                //                               ],
                //                             )
                //                           : Row(
                //                               crossAxisAlignment:
                //                                   CrossAxisAlignment.start,
                //                               children: [
                //                                 Expanded(
                //                                   child: Column(
                //                                     crossAxisAlignment:
                //                                         CrossAxisAlignment.end,
                //                                     mainAxisAlignment:
                //                                         MainAxisAlignment
                //                                             .spaceBetween,
                //                                     children: [
                //                                       Container(
                //                                         padding: EdgeInsets
                //                                             .symmetric(
                //                                                 horizontal:
                //                                                     20.r,
                //                                                 vertical: 19.r),
                //                                         decoration: BoxDecoration(
                //                                             color: Color(
                //                                                 0xff000000),
                //                                             borderRadius: BorderRadius.only(
                //                                                 bottomLeft: Radius
                //                                                     .circular(
                //                                                         19.r),
                //                                                 bottomRight: Radius
                //                                                     .circular(
                //                                                         35.r),
                //                                                 topLeft: Radius
                //                                                     .circular(
                //                                                         19.r))),
                //                                         child: Text(
                //                                           chatController
                //                                               .listOfConversation[
                //                                                   index]
                //                                               .lastMessage,
                //                                           style:
                //                                               GoogleFonts.inter(
                //                                                   fontSize:
                //                                                       14.sp,
                //                                                   color: Colors
                //                                                       .white),
                //                                         ),
                //                                       ),
                //                                       8.verticalSpace,
                //                                       Row(
                //                                         mainAxisAlignment:
                //                                             MainAxisAlignment
                //                                                 .end,
                //                                         children: [
                //                                           Text(
                //                                               zoneDateFormat
                //                                                   .format(chatController
                //                                                       .listOfConversation[
                //                                                           index]
                //                                                       .lastMessageTime)
                //                                                   .toString(),
                //                                               style: GoogleFonts
                //                                                   .inter(
                //                                                       fontSize:
                //                                                           14.sp,
                //                                                       color: Colors
                //                                                           .black))
                //                                         ],
                //                                       ),
                //                                       //        15.horizontalSpace,
                //                                       //        Container(
                //                                       //   width: 54.r,
                //                                       //   height: 54.r,
                //                                       //   decoration: BoxDecoration(
                //                                       //       shape: BoxShape.circle,
                //                                       //       image: DecorationImage(
                //                                       //           image: AssetImage(chatMessage[index]
                //                                       //               .userImg
                //                                       //               .toString()),
                //                                       //           fit: BoxFit.fill)),
                //                                       // ),
                //                                     ],
                //                                   ),
                //                                 ),
                //                                 15.horizontalSpace,
                //                                 Container(
                //                                   width: 38.r,
                //                                   height: 38.r,
                //                                   decoration: BoxDecoration(
                //                                     shape: BoxShape.circle,
                //                                     // image: DecorationImage(
                //                                     //     image: AssetImage(
                //                                     //         chatMessage[index]
                //                                     //             .userImg
                //                                     //             .toString()),
                //                                     //     fit: BoxFit.fill)
                //                                   ),
                //                                   child: CustomNetworkImage(
                //                                     imageUrl: ImageUrls
                //                                             .kUserProfile +
                //                                         ApiServices.profilePic,
                //                                   ),
                //                                 ),
                //                               ],
                //                             ),
                //                     );
                //                   },
                //                 );
                //         });
                //       } else {
                //         return Center(
                //           child: Text("Error"),
                //         );
                //       }
                //     }),
                ),
          ),
        ));
  }
}

class message {
  bool? user = false;
  String? userImg;
  String? msg;
  String? time;

  message(this.user, this.userImg, this.msg, this.time);
}
