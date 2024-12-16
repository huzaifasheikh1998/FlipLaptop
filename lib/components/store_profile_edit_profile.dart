import 'package:app_fliplaptop/Apiserrvices/app_url.dart';
import 'package:app_fliplaptop/components/global.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Screens/EditStoreProfile.dart';

class StoreProfileEditProfile extends StatelessWidget {
  String storeProfilePic;
  String profileName;
  String followingCount;
  String followersCount;
  String products;
  String storeWebsiteLink;
  String shippingAddress;
  String storeLocation;
  String description;
  String taxValue;
  StoreProfileEditProfile({
    super.key,
    required this.storeProfilePic,
    required this.profileName,
    required this.followingCount,
    required this.followersCount,
    required this.products,
    required this.storeWebsiteLink,
    required this.shippingAddress,
    required this.storeLocation,
    required this.description,
    required this.taxValue,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Container(
                  width: 91.r,
                  height: 91.r,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.3.r, color: highlightedText),
                    shape: BoxShape.circle,
                    color: Color.fromARGB(255, 184, 184, 184),
                    // image: DecorationImage(
                    //     image: AssetImage('assets/Ellipse 100.png'),
                    //     fit: BoxFit.cover)
                  ),
                  child: ClipOval(
                    clipBehavior: Clip.hardEdge,
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: storeProfilePic.toString() == ""
                          ? "NoImage"
                          :
                          //  iterations.productImage == "[]"?
                          //  "https://fliplaptop.thesuitchstaging.com/assets/images/products/thumbnails/1691623416450.jpg"

                          ImageUrls.kStoreProfile + storeProfilePic.toString(),
                      placeholder: (context, url) => Icon(Icons.image),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 5,
                  right: 3,
                  child: SvgPicture.asset(
                    'assets/Group 967.svg',
                    width: 15.r,
                  ),
                ),
              ],
            ),
            9.verticalSpace,
            SizedBox(
              width: 100.w,
              child: Text(
                profileName,
                overflow: TextOverflow.clip,
                textAlign: TextAlign.center,
                // textDirection: TextDirection.rtl,
                // maxLines: 4,
                style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
        24.horizontalSpace,
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              30.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  20.w.horizontalSpace,
                  // InkWell(
                  //   onTap: () {
                  //     Get.toNamed('/FollowingStoriesScreen');
                  //   },
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: [
                  //       Text(
                  //         followingCount,
                  //         style: TextStyle(
                  //             fontSize: 15.sp, color: highlightedText),
                  //       ),
                  //       Text(
                  //         'Following',
                  //         style: TextStyle(
                  //             fontSize: 15.sp, color: Color(0xff1D1D1D)),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  InkWell(
                    onTap: () {
                      Get.toNamed('/FollowerUserScreen');
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          followersCount,
                          style: TextStyle(
                              fontSize: 15.sp, color: highlightedText),
                        ),
                        Text(
                          'Followers',
                          style: TextStyle(
                              fontSize: 15.sp, color: Color(0xff1D1D1D)),
                        )
                      ],
                    ),
                  ),
                  80.w.horizontalSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        products,
                        style:
                            TextStyle(fontSize: 15.sp, color: highlightedText),
                      ),
                      Text(
                        'Products',
                        style: TextStyle(
                            fontSize: 15.sp, color: Color(0xff1D1D1D)),
                      )
                    ],
                  )
                ],
              ),
              20.verticalSpace,
              InkWell(
                onTap: () {
                  Get.to(() => EditStoreProfileScreen(
                        storeProfilePic: ImageUrls.kStoreProfile +
                            storeProfilePic.toString(),
                        storeName: profileName,
                        storeWebsiteLink: storeWebsiteLink,
                        storeLocation: storeLocation,
                        storeShippingAddress: shippingAddress,
                        storeDescription: description,
                        taxValue: taxValue,
                      ));
                },
                child: Container(
                  width: Get.width * 0.7,
                  alignment: Alignment.center,
                  height: 35.h,
                  decoration: BoxDecoration(
                      gradient: kbtngradient,
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Text(
                    'Edit Profile',
                    style:
                        GoogleFonts.inter(color: Colors.white, fontSize: 13.sp),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
