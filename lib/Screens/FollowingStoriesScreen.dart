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

List<FollowsData> followList = [
  FollowsData('assets/M2-MacBook-Air-2022-Feature0012.png', "Apple Store"),
  FollowsData('assets/andras-vas-Bd7gNnWJBkU-unsplash.png', "Apple Store"),
  FollowsData('assets/M2-MacBook-Air-2022-Feature0012(2).png', "Apple Store"),
  FollowsData('assets/alex-knight-j4uuKnN43_M-unsplash.png', "Apple Store"),
  FollowsData('assets/maxim-hopman-Hin-rzhOdWs-unsplash.png', "Apple Store"),
  FollowsData('assets/andras-vas-Bd7gNnWJBkU-unsplash.png', "Apple Store"),
  FollowsData('assets/M2-MacBook-Air-2022-Feature0012.png', "Apple Store"),
  FollowsData('assets/andras-vas-Bd7gNnWJBkU-unsplash.png', "Apple Store"),
  FollowsData('assets/M2-MacBook-Air-2022-Feature0012(2).png', "Apple Store"),
  FollowsData('assets/alex-knight-j4uuKnN43_M-unsplash.png', "Apple Store"),
  FollowsData('assets/maxim-hopman-Hin-rzhOdWs-unsplash.png', "Apple Store"),
  FollowsData('assets/andras-vas-Bd7gNnWJBkU-unsplash.png', "Apple Store"),
];

class FollowingStoriesScreen extends StatelessWidget {
  const FollowingStoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());
    // userController.getFollowedStores();

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
          'Following Stores',
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
              : userController.listOfFollowers.length == 0
                  ? Center(
                      child: Text("No Stores Followed Yet"),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.r, vertical: 10.r),
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: userController.listOfFollowers.length,
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
                                                    .listOfFollowers[index]
                                                    .image ==
                                                ""
                                            ? "NoImage"
                                            : ImageUrls.kStoreProfile +
                                                userController
                                                    .listOfFollowers[index]
                                                    .image
                                                    .toString(),
                                        placeholder: (context, url) =>
                                            Icon(Icons.image),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 2,
                                    right: 3,
                                    child: SvgPicture.asset(
                                      'assets/Group 967.svg',
                                      width: 15.r,
                                    ),
                                  ),
                                ],
                              ),
                              title: Text(
                                userController.listOfFollowers[index].name
                                    .toString(),
                                style: GoogleFonts.inter(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                              trailing: InkWell(
                                onTap: () async {
                                  String storeID = userController
                                      .listOfFollowers[index].id
                                      .toString();

                                  // following the store
                                  // userController.followStore(storeID);
                                  await userController
                                      .removeFromFollowers(storeID);

                                  // Get.toNamed('/StoreProfileScreen');
                                },
                                child: Container(
                                    width: 106.w,
                                    height: 35.h,
                                    padding:
                                        EdgeInsets.symmetric(vertical: 8.h),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Color(0xff1D1D1D),
                                        borderRadius:
                                            BorderRadius.circular(10.r)),
                                    child:
                                        // followList[index].followStatus
                                        //
                                        //     ?

                                        userController.isLoading.value
                                            ? SizedBox(
                                                height: 20.h,
                                                width: 20.w,
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.white,
                                                  strokeWidth: 2,
                                                ),
                                              )
                                            : Text(
                                                'Unfollow',
                                                style: GoogleFonts.inter(
                                                    fontSize: 13.sp,
                                                    color: Colors.white),
                                                textAlign: TextAlign.center,
                                              )
                                    // : Text(
                                    //     'Follow',
                                    //     style: GoogleFonts.inter(
                                    //         fontSize: 13.sp,
                                    //         color: Colors.white),
                                    //   )
                                    ),
                              ),
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
    );
  }
}

class FollowsData {
  String? img;
  String? name;
  bool followStatus = true;

  FollowsData(this.img, this.name);
}

class DrawDottedhorizontalline extends CustomPainter {
  late Paint _paint;

  DrawDottedhorizontalline() {
    _paint = Paint();

    _paint.color = Colors.black.withOpacity(0.5); //dots color
    _paint.strokeWidth = 1; //dots thickness
    _paint.strokeCap = StrokeCap.square;
    //dots corner edges
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (double i = -300; i < 300; i = i + 6) {
      // 15 is space between dots
      if (i % 3 == 0)
        canvas.drawLine(Offset(i, 0.0), Offset(i + 3, 0.0), _paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
