import 'package:app_fliplaptop/Apiserrvices/Services.dart';
import 'package:app_fliplaptop/Apiserrvices/firebaseServices.dart';
import 'package:app_fliplaptop/Controller/UserController.dart';
import 'package:app_fliplaptop/components/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../models/dashBoardModel.dart';

class ChatWithStoreIcon extends StatelessWidget {
  const ChatWithStoreIcon({super.key, required this.storeUser, required this.isSeller});
  final User? storeUser;
  final bool isSeller;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final getUserController = Get.put(UserController());
        // Get.to(
        //     () => ChatScreen(
        //         senderData: userController.user,
        //         conversationID: userController.user.id ??
        //             "" + storeID.toString(),),
        //     arguments: 'John Smith');
        FirebaseServices().startConversation(
            userController.user.value.id ?? "",
            storeUser!);
        FirebaseServices().fetchConversationsStream(
            userController.user.value.id ?? "",
            storeUser!.id ?? "");
      },
      child: Align(
        alignment: Alignment.topRight,

        child: Container(
          width: 187.r,
          height: 47.r,
          // alignment: Alignment.topRight,

          decoration: BoxDecoration(
            color: Colors.white,
            // border: Border.all(
            //   color: kprimaryColor,
            //   width: 2.w,
            // ),
            boxShadow: [
              BoxShadow(
                  blurRadius: 5,
                  offset: Offset(0, 3),
                  color:Colors.grey)
            ],

            borderRadius: BorderRadius.all(
              Radius.circular(25.r),
            ),
            // shape: BoxShape.circle,
            // gradient: kbtngradient,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: Text(
                  isSeller?"Chat with User":"Chat with Store",
                  style: TextStyle(
                    fontSize: 15.r,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Container(
                width: 47.r,
                height: 47.r,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: kbtngradient,
                ),
                child: SvgPicture.asset(
                  'assets/Group 11.svg',
                  width: 20.r,
                ),
              ),
            ],
          ),
          // child: SvgPicture.asset(
          //   'assets/Group 11.svg',
          //   width: 20.r,
          // ),
        ),
      ),
    );
  }
}
