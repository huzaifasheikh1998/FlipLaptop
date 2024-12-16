import 'package:app_fliplaptop/components/global.dart';
import 'package:app_fliplaptop/widgets/disallow_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});
  final List notificationListImage = [
    'assets/NoPath - Copy (25).png',
    'assets/NoPath - Copy (28)@3x.png',
    'assets/NoPath - Copy (29)@3x.png',
    'assets/NoPath - Copy (30).png',
    'assets/maxim-hopman-Hin-rzhOdWs-unsplash.png',
    'assets/nubelson-fernandes-c48WlKnfsQ0-unsplash.png',
    'assets/maxim-hopman-Hin-rzhOdWs-unsplash.png',
    'assets/NoPath - Copy (17)@3x.png',
    'assets/NoPath - Copy (19)@3x.png',
    'assets/NoPath - Copy (20)@2x.png',
    'assets/maxim-hopman-Hin-rzhOdWs-unsplash.png',
    'assets/nubelson-fernandes-c48WlKnfsQ0-unsplash.png',
    'assets/NoPath - Copy (16)Toshiba.png',
    'assets/NoPath - Copy (17)Toshiba.png',
    'assets/NoPath - Copy (19)Toshiba.png',
    'assets/NoPath - Copy (20)Toshiba.png',
    'assets/maxim-hopman-Hin-rzhOdWs-unsplash.png',
    'assets/nubelson-fernandes-c48WlKnfsQ0-unsplash.png',
  ];
  @override
  Widget build(BuildContext context) {
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
        title: Text(
          'Notifications',
          style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
      body: DisAllowIndicatorWidget(
        child: ListView.builder(
          itemCount: notificationListImage.length,
          padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 10.r),
          itemBuilder: (context, index) =>
              chatItem(notificationListImage[index]),
        ),
      ),
    );
  }

  chatItem(img) {
    return InkWell(
        // onTap: () => Get.toNamed('/OpenChatScreen'),
        child: Container(
      height: 90.h,
      padding: EdgeInsets.symmetric(
        horizontal: 20.r,
        vertical: 10.97,
      ),
      margin: EdgeInsets.only(bottom: 15.r),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 6,
                spreadRadius: 1)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 62.r,
            height: 62.r,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image:
                    DecorationImage(image: AssetImage(img), fit: BoxFit.cover)),
          ),
          15.w.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Grab The Offer',
                  style: GoogleFonts.inter(
                    color: Color(0xff3B3B3B),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                5.verticalSpace,
                Text(
                  '20% Off Offer',
                  style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      color: Color(0xff3B3B3B).withOpacity(0.5)),
                )
              ],
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: kgradient,
              ),
              child: SvgPicture.asset(
                  'assets/Icon ionic-ios-notifications-outline.svg'),
            ),
          )
        ],
      ),
    ));
  }
}
