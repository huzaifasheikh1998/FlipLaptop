import 'dart:developer';

import 'package:app_fliplaptop/Apiserrvices/Services.dart';
import 'package:app_fliplaptop/Apiserrvices/localStorage.dart';
import 'package:app_fliplaptop/Controller/settingController.dart';
import 'package:app_fliplaptop/Screens/stripeConnect.dart';
import 'package:app_fliplaptop/components/global.dart';
import 'package:app_fliplaptop/res/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

bool chk = false;
String stripeStatus = "";

class _SettingScreenState extends State<SettingScreen> {
  @override
  void initState() {
    getStripeStatusFromLocal();
    super.initState();
  }

  getStripeStatusFromLocal() async {
    stripeStatus =
        await LocalStorage.readJson(key: LocalStorageKeys.stripeConnected);
    setState(() {});
    // log("stripe status"+stripeStatus);
  }

  final SettingController settingController = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    String stripePresents = "";
    ApiServices.myStoreProfileDataList.isNotEmpty
        ? stripePresents = ApiServices
            .myStoreProfileDataList.first.data!.stripeAccountId
            .toString()
        : stripePresents = "";
    log("stripe presents" + stripePresents);

    log("stripe status" + stripeStatus);
    return Scaffold(
      backgroundColor: kPageBgColor,
      appBar: AppBar(
        // leadingWidth: 30.r,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, gradient: kbtngradient),
                child: SvgPicture.asset(
                  'assets/Path 11.svg',
                  width: 14,
                ))),
        centerTitle: true,
        title: Text(
          'Settings',
          style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
      // bottomNavigationBar: Padding(
      //     padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 20.r),
      //     child: InkWell(
      //         onTap: () {
      //           LogoutPopup(context);
      //         },
      //         child: Container(
      //           width: Get.width,
      //           height: 59.h,
      //           alignment: Alignment.center,
      //           padding: EdgeInsets.symmetric(horizontal: 20.r),
      //           decoration: BoxDecoration(
      //               gradient: kgradient,
      //               borderRadius: BorderRadius.horizontal(
      //                   left: Radius.circular(35.r),
      //                   right: Radius.circular(35.r))),
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               Text(
      //                 'Logout',
      //                 style: TextStyle(
      //                     color: Colors.white,
      //                     fontSize: 20.sp,
      //                     fontWeight: FontWeight.bold),
      //               ),
      //               SvgPicture.asset('assets/Group 992.svg')
      //             ],
      //           ),
      //         ))),
      body: ListView(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 20.r),
        children: [
          SettingItem(
              'assets/Icon ionic-ios-notifications.svg', 'Notification', () {}),
          20.verticalSpace,
          SettingItem('assets/Icon metro-question.svg', 'FAQ', () {
            Get.toNamed('/FaqScreen');
          }),
          20.verticalSpace,
          SettingItem(
              'assets/Icon awesome-clipboard-list.svg', 'Terms & Conditions',
              () {
            Get.toNamed('/TermsnConditionsScreen');
          }),
          20.verticalSpace,
          SettingItem(
              'assets/Icon awesome-clipboard-list.svg', 'Privacy Policy', () {
            Get.toNamed('/PrivacynPolicyScreen');
          }),
          20.verticalSpace,
          SettingItem(
              stripeStatus == "true"
                  ? 'assets/checkIcon.svg'
                  : 'assets/Icon awesome-clipboard-list.svg',
              stripeStatus == "true" ? "Stripe Connected" : 'Connect Stripe',
              stripeStatus == "true"
                  ? null
                  : () {
                      if (ApiServices.storeId == "") {
                        Utils.showFloatingAlertSnack(
                            "Your must have a store to connect stripe");
                      } else {
                        // settingController.isStripeConnected.value = true;
                        Get.to(() => StripeConnect());
                      }
                    }),
          20.verticalSpace,
          DeleteSettingItem(Icons.delete, 'Delete Account', () {
            // Get.toNamed('/PrivacynPolicyScreen');
            ConfirmationPopup(
              context,
              "Delete",
              "Are you Sure you want to Delete Your Account?",
              "Delete",
              "Cancel",
              () {
                Get.back();
                settingController.deleteAccount();
                // print("Called delete on product ID" +
                //     productData.id.toString());

                // _setState(() {
                //   ApiServices().deleteProduct(context,
                //       int.parse(productData.id), storeId);
                // });
              },
              () {
                Get.back();
              },
            );
          }),
        ],
      ),
    );
  }

  SettingItem(icon, title, fun) {
    return InkWell(
      onTap: fun,
      child: Container(
        height: 60.h,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 10.r),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  blurRadius: 18,
                  offset: Offset(0, 2),
                  color: Color.fromARGB(194, 241, 203, 216).withOpacity(0.15))
            ],
            borderRadius: BorderRadius.circular(30.r)),
        child: Row(
          children: [
            Container(
              width: 35.r,
              height: 35.r,
              padding: EdgeInsets.all(10.r),
              decoration:
                  BoxDecoration(color: Colors.black, shape: BoxShape.circle),
              child: SvgPicture.asset(
                icon,
                // width: 3.r,
              ),
            ),
            20.horizontalSpace,
            Text(
              title,
              style: TextStyle(color: Colors.black, fontSize: 18.sp),
            ),
            Spacer(),
            title == 'Notification'
                ? Transform.scale(
                    scale: 0.5,
                    child: CupertinoSwitch(
                      value: chk,
                      onChanged: (bool value) {
                        setState(() {
                          chk = value;
                          ApiServices().changeNotificationStatus(chk, context);
                        });
                      },
                      activeColor: highlightedText,
                      thumbColor: Colors.white,
                      trackColor: chk == false
                          ? Color.fromARGB(255, 210, 211, 207)
                          : highlightedText,
                    ))
                : Container()
          ],
        ),
      ),
    );
  }

  DeleteSettingItem(icon, title, fun) {
    return InkWell(
      onTap: fun,
      child: Container(
        height: 60.h,
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.symmetric(horizontal: 10.r),
        decoration: BoxDecoration(
            color: Colors.white,
            // gradient: kgradient,
            boxShadow: [
              BoxShadow(
                  blurRadius: 18,
                  offset: Offset(0, 2),
                  color: Color.fromARGB(194, 241, 203, 216).withOpacity(0.15))
            ],
            borderRadius: BorderRadius.circular(30.r)),
        child: Row(
          children: [
            Obx(() {
              return Container(
                width: 35.r,
                height: 35.r,
                padding: EdgeInsets.all(5.r),
                decoration:
                    BoxDecoration(color: Colors.black, shape: BoxShape.circle),
                child: settingController.isLoading.value
                    ? CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : Icon(
                        icon,
                        color: Colors.white,
                        size: 16.r,
                        // width: 3.r,
                      ),
              );
            }),
            20.horizontalSpace,
            Text(
              title,
              style: TextStyle(color: Colors.black, fontSize: 18.sp),
            ),
            Spacer(),
            title == 'Notification'
                ? Transform.scale(
                    scale: 0.5,
                    child: CupertinoSwitch(
                      value: chk,
                      onChanged: (bool value) {
                        setState(() {
                          chk = value;
                          ApiServices().changeNotificationStatus(chk, context);
                        });
                      },
                      activeColor: highlightedText,
                      thumbColor: Colors.white,
                      trackColor: chk == false
                          ? Color.fromARGB(255, 210, 211, 207)
                          : highlightedText,
                    ))
                : Container()
          ],
        ),
      ),
    );
  }
}
