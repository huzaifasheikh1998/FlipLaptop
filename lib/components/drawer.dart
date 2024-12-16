import 'dart:math';

import 'package:app_fliplaptop/Apiserrvices/Services.dart';
import 'package:app_fliplaptop/Apiserrvices/app_url.dart';
import 'package:app_fliplaptop/components/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

final bottomcontroller = Get.put(BottomController());
DrawerMenu(BuildContext context) {
  return GetBuilder(
      init: bottomcontroller,
      builder: (cont) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40.r),
                  bottomRight: Radius.circular(40.r)),
              gradient: LinearGradient(
                  begin: Alignment(0, -0.8),
                  end: Alignment(0, 0.8),
                  transform: GradientRotation(168 * pi / 180),
                  colors: [Color(0xff121314), Color(0xff4C5157)])),
          child: Drawer(
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40.r),
                  bottomRight: Radius.circular(40.r)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(children: [
                  15.verticalSpace,
                  Align(
                    alignment: Alignment.topRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                        20.horizontalSpace
                      ],
                    ),
                  ),
                  30.verticalSpace,
                  Container(
                    width: Get.width,
                    padding: EdgeInsets.only(
                        bottom: 47.r, top: 0.r, left: 0, right: 0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.only(topRight: Radius.circular(30.r))),
                    child: Column(
                      children: [
                        // Container(
                        //   width: 151.r,
                        //   height: 151.r,
                        //   margin: EdgeInsets.only(top: 10.r),
                        //   decoration: BoxDecoration(
                        //       shape: BoxShape.circle,
                        //       image: DecorationImage(
                        //         image: AssetImage(
                        //           'assets/Ellipse 100.png',
                        //         ),
                        //         fit: BoxFit.cover,
                        //       ),
                        //       color: kprimaryColor,
                        //       border:
                        //           Border.all(width: 0.3, color: kprimaryColor)),
                        // ),
                        Container(
                          width: 151.r,
                          height: 151.r,
                          margin: EdgeInsets.only(top: 10.r),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image:  ApiServices.myProfileDataList.first.data!.first!.image
                                .toString() != ""
                                ? DecorationImage(
                                    image: NetworkImage(
                                      ImageUrls.kUserProfile+ApiServices.myProfileDataList.first.data!.first!.image,
                                    ),
                                    fit: BoxFit.cover,
                                  )
                                : DecorationImage(
                                    image: NetworkImage(
                                      // "assets/Path 523.svg",
                                      'assets/profile.png',
                                    ),
                                    fit: BoxFit.contain,
                                  ),
                            color: Colors.white,
                            border:
                                Border.all(width: 0.3, color: kprimaryColor),
                          ),
                        ),
                        30.verticalSpace,
                        Text(
                          ApiServices.myProfileDataList.first.data!.first!.name
                              .toString(),
                          // ApiServices.profileName,
                          style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          ApiServices.myProfileDataList.first.data!.first!.email
                              .toString(),
                          // ApiServices.profileEmail,
                          style:
                              TextStyle(fontSize: 15.sp, color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  10.h.verticalSpace,
                  InkWell(
                      onTap: () {
                        bottomcontroller.navBarChange(0);
                        bottomcontroller.chkInvert(0);
                        Get.toNamed('/StartAppScreen');
                      },
                      child: ListMenu('Home', 'assets/Path 518(2).svg',
                          bottomcontroller.chk[0])),
                  // if (!createStore) ...[
                       if (ApiServices.storeId.toString() == "") ...[
                    20.h.verticalSpace,
                    InkWell(
                      onTap: () {
                        if (ApiServices.storeId.toString() == "") {
                          Get.toNamed('/CreateStoreScreen');
                          bottomcontroller.chkInvert(1);
                        } 
                        //else {
                          // Utils.showSnack("Already Created a Store", context);
                        // }
                      },
                      child: ListMenu('Create Store', 'assets/Path 3020.svg',
                          bottomcontroller.chk[1]),
                    ),
                  ],

                  20.h.verticalSpace,

                  InkWell(
                    onTap: () {
                      bottomcontroller.chkInvert(3);
                      Get.toNamed('/NotificationScreen');
                    },
                    child: ListMenu(
                        'Notifications',
                        'assets/Icon ionic-ios-notifications-outline.svg',
                        bottomcontroller.chk[3]),
                  ),
                  20.verticalSpace,
                  // InkWell(
                  // onTap: () => Get.toNamed('/SelectBankScreen',
                  // arguments: ['SAVE', () => Get.back()]),
                  //   onTap: () {
                  //     bottomcontroller.chkInvert(4);
                  //     Get.toNamed('/SelectTemplateScreen');
                  //   },
                  //   child: ListMenu('Add Hot Deals', 'assets/Path 2969.svg',
                  //       bottomcontroller.chk[4]),
                  // ),
                  // 20.h.verticalSpace,
                  // InkWell(
                  //   onTap: () {
                  //     bottomcontroller.chkInvert(5);
                  //     Get.toNamed('/PrivacynPolicyScreen');
                  //   },
                  //   child: ListMenu('Privacy Policy',
                  //       'assets/Path 2979.svg', bottomcontroller.chk[5]),
                  // ),
                  // 20.h.verticalSpace,
                  InkWell(
                    onTap: () {
                      bottomcontroller.chkInvert(4);

                      Get.toNamed('/SettingScreen');
                    },
                    child: ListMenu(
                        'Settings',
                        'assets/Icon feather-settings.svg',
                        bottomcontroller.chk[6]),
                  ),
                  // 10.verticalSpace,
                ]),
                InkWell(
                  onTap: () {
                    // Get.toNamed('/LoginScreen');
                    LogoutPopup(context);
                  },
                  child: Container(
                    width: Get.width,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 32.r),
                    height: 81.h,
                    decoration: BoxDecoration(
                      color: Color(0xff302E2E),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(40.r),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          'assets/Group 965.svg',
                          width: 30.r,
                        ),
                        15.horizontalSpace,
                        Text(
                          'Logout',
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      });
}

ListMenu(String txt, img, chk) {
  return Container(
      margin: txt == 'Home' ? EdgeInsets.only(right: 140.r) : null,
      decoration: txt == 'Home'
          ? BoxDecoration(
              borderRadius:
                  BorderRadius.horizontal(right: Radius.circular(30.r)),
              color: Colors.white)
          : null,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 30.r, vertical: 15.r),

      // height: 64.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // mainAxisSize: MainAxisSize.min,
        children: [
          15.horizontalSpace,
          SvgPicture.asset(
            img,
            color: txt != 'Home' ? Colors.white : Colors.black,
          ),
          10.horizontalSpace,
          Expanded(
            child: Text(
              txt,
              style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: txt != 'Home' ? Colors.white : highlightedText),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ));
}
