import 'package:app_fliplaptop/Apiserrvices/app_url.dart';
import 'package:app_fliplaptop/Apiserrvices/loader.dart';
import 'package:app_fliplaptop/Controller/UserController.dart';
import 'package:app_fliplaptop/widgets/disallow_indicator_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/global.dart';

List<FollowerUserData> followList = [
  FollowerUserData(
      'assets/Mask Group 9@3x.png', 'William Roy', 'United States'),
  FollowerUserData('assets/Ellipse 137@3x.png', 'William Roy', 'United States'),
  FollowerUserData('assets/Ellipse 100.png', 'William Roy', 'United States'),
  FollowerUserData('assets/Ellipse 85@3x.png', 'William Roy', 'United States'),
  FollowerUserData('assets/Ellipse 82@3x.png', 'William Roy', 'United States'),
  FollowerUserData('assets/Ellipse 80@3x.png', 'William Roy', 'United States'),
  FollowerUserData(
      'assets/Ellipse 75-2@3x.png', 'William Roy', 'United States'),
  FollowerUserData('assets/Ellipse 75@3x.png', 'William Roy', 'United States'),
  FollowerUserData('assets/Ellipse 74@3x.png', 'William Roy', 'United States'),
];

class FollowerUserScreen extends StatelessWidget {
  const FollowerUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());

    return Scaffold(
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
          'Followers',
          style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
      body: Obx(() {
        return DisAllowIndicatorWidget(
          child: userController.isLoading.value
              ? Center(child: Loader.spinkit)
              : userController.listOfFollowedUsers.length == 0
                  ? Center(
                      child: Text("No Stores Followed Yet"),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.r, vertical: 10.r),
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: userController.listOfFollowedUsers.length,
                      itemBuilder: (context, index) {
                        print(" ========>Check following list");
                        return Column(
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: Stack(
                                children: [
                                  Container(
                                    width: 62.r,
                                    height: 62.r,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color.fromARGB(255, 184, 184, 184),
                                      // image: followList[index].img! != ''
                                      //     ? DecorationImage(
                                      //         image: AssetImage(
                                      //             followList[index]
                                      //                 .img!
                                      //                 .toString()),
                                      //         fit: BoxFit.cover)
                                      //     : null,
                                    ),
                                    child: ClipOval(
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl: userController
                                                    .listOfFollowedUsers[index]
                                                    .image ==
                                                ""
                                            ? "NoImage"
                                            : ImageUrls.kUserProfile +
                                                userController
                                                    .listOfFollowedUsers[index]
                                                    .image
                                                    .toString(),
                                        placeholder: (context, url) =>
                                            Icon(Icons.image),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                  // Positioned(
                                  //   bottom: 2,
                                  //   right: 3,
                                  //   child: SvgPicture.asset(
                                  //     'assets/Group 967.svg',
                                  //     width: 15.r,
                                  //   ),
                                  // ),
                                ],
                              ),
                              title: Text(
                                userController.listOfFollowedUsers[index].name
                                    .toString(),
                                style: GoogleFonts.inter(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              // trailing: InkWell(
                              //   onTap: () async {
                              //     String storeID = userController
                              //         .listOfFollowedUsers[index].id
                              //         .toString();
                              //
                              //     // following the store
                              //     // userController.followStore(storeID);
                              //     await userController
                              //         .removeFromFollowers(storeID);
                              //
                              //     // Get.toNamed('/StoreProfileScreen');
                              //   },
                              //   child: Container(
                              //       width: 106.w,
                              //       height: 35.h,
                              //       padding:
                              //           EdgeInsets.symmetric(vertical: 8.h),
                              //       alignment: Alignment.center,
                              //       decoration: BoxDecoration(
                              //           color: Color(0xff1D1D1D),
                              //           borderRadius:
                              //               BorderRadius.circular(10.r)),
                              //       child:
                              //           // followList[index].followStatus
                              //           //
                              //           //     ?
                              //
                              //           userController.isLoading.value
                              //               ? SizedBox(
                              //                   height: 20.h,
                              //                   width: 20.w,
                              //                   child:
                              //                       CircularProgressIndicator(
                              //                     color: Colors.white,
                              //                     strokeWidth: 2,
                              //                   ),
                              //                 )
                              //               : Text(
                              //                   'Unfollow',
                              //                   style: GoogleFonts.inter(
                              //                       fontSize: 13.sp,
                              //                       color: Colors.white),
                              //                   textAlign: TextAlign.center,
                              //                 )
                              //       // : Text(
                              //       //     'Follow',
                              //       //     style: GoogleFonts.inter(
                              //       //         fontSize: 13.sp,
                              //       //         color: Colors.white),
                              //       //   )
                              //       ),
                              // ),
                            ),
                            10.verticalSpace,
                            DottedLine(
                              dashColor: Colors.black.withOpacity(0.7),
                              dashGapLength: 1.4,
                              lineThickness: 0.2,
                            ),
                            10.verticalSpace
                          ],
                        );
                      }),
        );
      }),
      // body: DisAllowIndicatorWidget(
      //   child: ListView(
      //     children: [
      //       ListView.builder(
      //           padding: EdgeInsets.symmetric(horizontal: 30.r, vertical: 10.r),
      //           shrinkWrap: true,
      //           physics: NeverScrollableScrollPhysics(),
      //           itemCount: followList.length,
      //           itemBuilder: (context, index) => Column(
      //                 children: [
      //                   ListTile(
      //                     contentPadding: EdgeInsets.zero,
      //                     leading: Container(
      //                       width: 62.r,
      //                       height: 62.r,
      //                       decoration: BoxDecoration(
      //                           shape: BoxShape.circle,
      //                           color: Color.fromARGB(255, 184, 184, 184),
      //                           image: followList[index].img! != ''
      //                               ? DecorationImage(
      //                                   image: AssetImage(
      //                                       followList[index].img!.toString()),
      //                                   fit: BoxFit.cover)
      //                               : null),
      //                     ),
      //                     title: Text(
      //                       followList[index].name!.toString(),
      //                       style: GoogleFonts.inter(
      //                           fontSize: 18.sp,
      //                           fontWeight: FontWeight.w600,
      //                           color: Colors.black),
      //                     ),
      //                     subtitle: Text(
      //                       followList[index].country!.toString(),
      //                       style: GoogleFonts.inter(
      //                           fontSize: 13.sp, color: Colors.black),
      //                     ),
      //                   ),
      //                   5.verticalSpace,
      //                   DottedLine(
      //                     dashColor: Colors.black.withOpacity(0.7),
      //                     dashGapLength: 1.4,
      //                     lineThickness: 0.2,
      //                   ),
      //                   5.verticalSpace
      //                 ],
      //               ))
      //     ],
      //   ),
      // ),
    );
  }
}

class FollowerUserData {
  String? img;
  String? name;
  String? country;

  FollowerUserData(this.img, this.name, this.country);
}
