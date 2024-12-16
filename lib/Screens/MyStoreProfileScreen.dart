// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:app_fliplaptop/Apiserrvices/Services.dart';
import 'package:app_fliplaptop/Apiserrvices/loader.dart';
import 'package:app_fliplaptop/Apiserrvices/localStorage.dart';
import 'package:app_fliplaptop/Controller/dashBoardController.dart';
import 'package:app_fliplaptop/Controller/productController.dart';
import 'package:app_fliplaptop/Controller/wishListController.dart';
import 'package:app_fliplaptop/Screens/AddProductScreen.dart';
import 'package:app_fliplaptop/Screens/stripeConnect.dart';
import 'package:app_fliplaptop/components/myStoreNewArrivalProductList.dart';
import 'package:app_fliplaptop/components/store_profile_edit_profile.dart';
import 'package:app_fliplaptop/components/store_profile_features.dart';
import 'package:app_fliplaptop/res/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/global.dart';

List laptopImage = [
  'assets/maxim-hopman-Hin-rzhOdWs-unsplash.png',
  'assets/nubelson-fernandes-c48WlKnfsQ0-unsplash.png',
  'assets/maxim-hopman-Hin-rzhOdWs-unsplash.png',
  'assets/nubelson-fernandes-c48WlKnfsQ0-unsplash.png',
  'assets/maxim-hopman-Hin-rzhOdWs-unsplash.png',
  'assets/nubelson-fernandes-c48WlKnfsQ0-unsplash.png',
];

class MyStoreProfileScreen extends StatefulWidget {
  String? storeId;

  MyStoreProfileScreen({super.key, this.storeId});

  @override
  State<MyStoreProfileScreen> createState() =>
      _MyStoreProfileScreenState(storeID: storeId!);
}

String stripeStatus = "";

class _MyStoreProfileScreenState extends State<MyStoreProfileScreen> {
  final String storeID;
  final ProductController productController = Get.put(ProductController());
  final dashBoardController = Get.put(DashBoardController());
  final wishListController = Get.put(WishListController());

  _MyStoreProfileScreenState({required this.storeID});

  Future<dynamic> OpenYourStore(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return Center(
              child: Material(
            type: MaterialType.transparency,
            child: Container(
              height: 430.h,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.r),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: Colors.white),
                      // width: Get.width * 0.85,
                      width: 343.w,
                      height: 252.h,
                      // padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          80.verticalSpace,
                          Container(
                            constraints: BoxConstraints(maxWidth: 182.w),
                            child: Text(
                              'Do you want to open your store?',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          20.verticalSpace,
                          Dialogbutton2(Get.width, 50.h, "Yes", () {
                            Get.close(1);
                          }),
                          10.verticalSpace
                        ],
                      )),
                  Positioned(
                    top: 0,
                    child: Container(
                      width: 152.r,
                      height: 152.r,
                      padding: EdgeInsets.all(27.r),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 5)
                          ],
                          shape: BoxShape.circle,
                          gradient: kbtngradient,
                          border: Border.all(width: 3, color: highlightedText)),
                      child: Image.asset('assets/laptop-screen@3x.png'),
                    ),
                  ),
                ],
              ),
            ),
          ));
        });
  }

  getStripeStatusFromLocal() async {
    stripeStatus =
        await LocalStorage.readJson(key: LocalStorageKeys.stripeConnected);
    log("stripe status" + stripeStatus);
    setState(() {});
    // log("stripe status"+stripeStatus);
  }

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, () {
      setState(() {
        productController.productListingDataList.clear();
        ApiServices().viewStoreByID(storeID);
        ApiServices().productListingApiFunc(storeID);

        dashBoardController.getDashboardData();
        wishListController.getWishList();

        getStripeStatusFromLocal();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // log(storeId);
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
          'My Store Profile',
          style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
      body: FutureBuilder(
        future: ApiServices().myStoreProfileApiFunc(widget.storeId!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loader.spinkit;
          } else if (snapshot.hasData) {
            final list = ApiServices.myStoreProfileDataList.first;
            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 10.r),
              children: [
                Obx(
                  () => StoreProfileEditProfile(
                    description: list.data!.description ?? "",
                    shippingAddress: "",
                    storeWebsiteLink: list.data!.websiteLink ?? "",
                    storeProfilePic: list.data!.image ?? "",
                    profileName: list.data!.name ?? "",
                    followingCount:
                        userController.listOfFollowers.length.toString(),
                    followersCount: userController.listOfFollowedUsers.length.toString(),
                    products: list.data!.productCount ?? "",
                    storeLocation: list.data!.location ?? "",
                    taxValue: list.data!.tax ?? "",
                  ),
                ),
                24.verticalSpace,
                StoreProfileFeature(
                    storeId: widget.storeId!,
                    storeProfile: list.data!.image.toString(),
                    storeName: list.data!.name.toString()),
                Obx(() {
                  return Column(
                    children: [
                      Visibility(
                          visible: productController
                              .productListingDataList.isNotEmpty,
                          child: MyStoreNewArrivalProductList(
                            storeID: storeID,
                          )),
                      Visibility(
                        visible:
                            productController.productListingDataList.isEmpty,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 0.1.sh),
                          child: Text(
                            "No Store  Products Added",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 20.sp),
                          ),
                        ),
                      )
                      // Text("")
                    ],
                  );
                }),
              ],
            );
          } else {
            return Center(
              child: Text("Something went Wrong"),
            );
          }
        },
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          if (stripeStatus == "true") {
            Get.to(() => AddProductScreen(
                  storeID: storeID,
                ));
          } else {
            Utils.showSnack("Must Connect Stripe to Add Products", context);
            Get.to(() => StripeConnect());
            // StripeConnect()
          }
        },
        // backgroundColor: highlightedText,
        child: Container(
          width: 60.h,
          height: 60.w,
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 40.r,
          ),
          decoration:
              BoxDecoration(shape: BoxShape.circle, gradient: kgradient),
        ),
      ),
    );
  }
}

// newArrivalCard(brand, rating, price, img) {
//   return InkWell(
//     onTap: () {
//       Get.toNamed('/ReviewProductScreen');
//     },
//     child: Container(
//       width: Get.width,
//       padding: EdgeInsets.all(10.r),
//       decoration: BoxDecoration(
//           color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Container(
//             margin: EdgeInsets.symmetric(vertical: 19.r, horizontal: 10.r),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   brand,
//                   style:
//                   TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
//                 ),
//                 3.verticalSpace,
//                 Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       rating,
//                       style: GoogleFonts.inter(
//                           fontWeight: FontWeight.w500, fontSize: 14.sp),
//                     ),
//                     5.horizontalSpace,
//                     SvgPicture.asset(
//                       'assets/Icon feather-star.svg',
//                       width: 10.r,
//                     )
//                   ],
//                 ),
//                 3.verticalSpace,
//                 Text(
//                   price,
//                   style: GoogleFonts.inter(
//                       fontWeight: FontWeight.w600, fontSize: 14.sp),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             width: 182.w,
//             height: 113.h,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10.r),
//                 image: DecorationImage(
//                   image: AssetImage(img),
//                   fit: BoxFit.fill,
//                 )),
//           )
//         ],
//       ),
//     ),
//   );
// }

// moreProductCard(brand, rating, price, img) {
//   return InkWell(
//     onTap: () {
//       Get.toNamed('/ReviewProductScreen');
//     },
//     child: Container(
//       // width: Get.width * 0.45,
//
//       padding: EdgeInsets.all(10.r),
//       decoration: BoxDecoration(
//           color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
//       child: Column(
//         // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             // width: Get.width* 0.5,
//             height: 140.r,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10.r),
//                 image: DecorationImage(
//                   image: AssetImage(img),
//                   fit: BoxFit.fill,
//                 )),
//           ),
//           10.verticalSpace,
//           Container(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   brand,
//                   style:
//                   TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
//                 ),
//                 3.verticalSpace,
//                 Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       rating,
//                       style: GoogleFonts.inter(
//                           fontWeight: FontWeight.w500, fontSize: 14.sp),
//                     ),
//                     5.horizontalSpace,
//                     SvgPicture.asset(
//                       'assets/Icon feather-star.svg',
//                       width: 10.r,
//                     )
//                   ],
//                 ),
//                 3.verticalSpace,
//                 Text(
//                   price,
//                   style: GoogleFonts.inter(
//                       fontWeight: FontWeight.w600, fontSize: 14.sp),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
