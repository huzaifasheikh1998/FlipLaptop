import 'package:app_fliplaptop/Apiserrvices/Services.dart';
import 'package:app_fliplaptop/Apiserrvices/app_url.dart';
import 'package:app_fliplaptop/Apiserrvices/loader.dart';
import 'package:app_fliplaptop/Controller/UserController.dart';
import 'package:app_fliplaptop/Controller/productController.dart';
import 'package:app_fliplaptop/Screens/EditProfileScreen.dart';
import 'package:app_fliplaptop/Screens/ListOfProduct.dart';
import 'package:app_fliplaptop/Screens/MyStoreProfileScreen.dart';
import 'package:app_fliplaptop/Screens/SelectPaymentMethod.dart';
import 'package:app_fliplaptop/Screens/myGivenReviews.dart';
import 'package:app_fliplaptop/components/global.dart';
import 'package:app_fliplaptop/widgets/disallow_indicator_widget.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

List profileOptionList = [
  {
    'title': 'My Store Profile',
    'img': 'assets/Path 3020(2).svg',
    'route': () {
      // Get.to(MyStoreProfileScreen(storeId: ApiServices.myProfileDataList.first.data!.id.toString(),));
      Get.toNamed('/MyStoreProfileScreen');
    }
  },
  {
    'title': 'My Orders',
    'img': 'assets/Icon feather-truck.svg',
    'route': () {
      // orderController.sellerOrderList.clear();
      // orderController.newSellerOrderList.clear();
      // orderController.inProgressSellerOrderList.clear();
      // orderController.completedSellerOrderList.clear();
      // orderController.purchaseOrderList.clear();

      Get.toNamed('/MyOrderTypeScreen');
    }
  },
  {
    'title': 'My Reviews',
    'img': 'assets/Icon feather-star(2).svg',
    'route': () {
      Get.to(() => MyGivenReviewScreen());
    }
  },
  {
    'title': 'Uploaded Products',
    'img': 'assets/Group 966.svg',
    'route': () {
      Get.to(() => ListOfProductScreen(
            storeId: ApiServices.storeId,
            storeProfile: '',
            storeName: '',
          ));
    }
  },
  {
    'title': 'Following',
    'img': 'assets/Icon feather-user-check.svg',
    'route': () {
      Get.toNamed('/FollowingStoriesScreen');
    }
  },
  {
    'title': 'Wishlist',
    'img': 'assets/Icon feather-heart.svg',
    'route': () {
      Get.toNamed('/MyWhistListScreen');
    }
  },
  {
    'title': 'Payment option',
    'img': 'assets/Path 2985.svg',
    'route': () {
      Get.toNamed('/SelectPaymentMethod');
    }
  }
];

class _ProfileScreenState extends State<ProfileScreen> {
  final addProductController = Get.put(ProductController());
  final userController = Get.put(UserController());

  // @override
  // void initState() {
  //   ApiServices().myProfileApiFunc();
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPageBgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'My Profile',
          style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            final bottomcontroller = Get.put(BottomController());
            bottomcontroller.navBarChange(0);
            Get.toNamed('/StartAppScreen');
          },
          icon: Container(
              padding: const EdgeInsets.all(6),
              decoration:
                  BoxDecoration(shape: BoxShape.circle, gradient: kbtngradient),
              child: SvgPicture.asset(
                'assets/Path 11.svg',
                width: 14,
              )),
        ),
        actions: [
          InkWell(
              onTap: () {
                Get.toNamed('/SettingScreen');
              },
              child: SvgPicture.asset(
                'assets/Icon feather-settings-black.svg',
                width: 25.r,
              )),
          20.horizontalSpace,
          InkWell(
              onTap: () {
                // Get.toNamed('/EditProfileScreen',arguments: {
                //   "completeData":ApiServices.myProfileDataList.first.data
                // });
                var data = ApiServices.myProfileDataList.first.data!.first;
                Get.to(() => EditProfileScreen(
                      completeData: data,
                    ));
              },
              child: SvgPicture.asset(
                'assets/Icon feather-edit.svg',
                width: 22.r,
              )),
          20.horizontalSpace
        ],
      ),
      body: DisAllowIndicatorWidget(
        child: FutureBuilder(
            future: ApiServices().myProfileApiFunc(),
            builder: (context, snapshot) {
              // log("snapshot"+snapshot.toString());
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Loader.spinkit;
              } else if (snapshot.hasError) {
// log(snapshot.hasError.toString());
                return Text(snapshot.error.toString());
              } else if (snapshot.hasData) {
                // print(
                //     "image${ApiServices.myProfileDataList.first.data!.image}image");
                return ListView(
                  padding: EdgeInsets.symmetric(horizontal: 20.r),
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          Container(
                              width: 151.r,
                              height: 151.r,
                              margin: EdgeInsets.only(top: 10.r),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: ApiServices.myProfileDataList.first.data!
                                            .first!.image !=
                                        ""
                                    ? null
                                    : DecorationImage(
                                        image: AssetImage(
                                          // "assets/Path 523.svg",
                                          'assets/profile.png',
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                color: Colors.white,
                                border: Border.all(
                                    width: 0.3, color: kprimaryColor),
                              ),
                              child: ApiServices.myProfileDataList.first.data!
                                          .first!.image !=
                                      ""
                                  ? ClipOval(
                                      child: Image.network(
                                        ImageUrls.kUserProfile +
                                            ApiServices.myProfileDataList.first
                                                .data!.first!.image!,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : null
                              // child: ApiServices.myProfileDataList.first.data!
                              //             .image ==
                              //         ""
                              //     ? Container(
                              //         width: 50.r,
                              //         height: 50.r,
                              //         child: ClipRRect(
                              //           clipBehavior: Clip.hardEdge,
                              //           child: SvgPicture.asset(
                              //             'assets/Path 523.svg',
                              //             // width: 20,
                              //             //  height: 10,
                              //             fit: BoxFit.cover,
                              //             clipBehavior: Clip.hardEdge,
                              //             // width: 14,
                              //             color: highlightedText,
                              //           ),
                              //         ),
                              //       )
                              //     : null,
                              //             child:  CachedNetworkImage(
                              //   fit: BoxFit.cover,
                              //   imageUrl: ApiServices.myProfileDataList.first.data!.image.toString()
                              //   storeProfilePic.toString()==""?
                              //   "NoImage":
                              //   //  iterations.productImage == "[]"?
                              //   //  "https://fliplaptop.thesuitchstaging.com/assets/images/products/thumbnails/1691623416450.jpg"

                              //    ImageUrls.kStoreProfile+storeProfilePic.toString(),
                              //   placeholder: (context, url) => Icon(Icons.image),
                              //   errorWidget: (context, url, error) => Icon(Icons.error),
                              // ),
                              ),
                          Positioned(
                              right: 10,
                              bottom: 8,
                              child: SvgPicture.asset(
                                'assets/Group 967.svg',
                                width: 25.r,
                              ))
                        ],
                      ),
                    ),
                    // Text(ApiServices.myProfileDataList.first.data!.name
                    //     .toString(),style: TextStyle(fontSize: 30,color: Colors.black),),
                    20.verticalSpace,
                    Text(
                      ApiServices.myProfileDataList.first.data!.first!.name
                          .toString(),
                      // status.toString(),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    30.verticalSpace,
                    Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 30.r, horizontal: 20.r),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          gradient: kbtngradient,
                        ),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                if (ApiServices.storeId.toString() == "") {
                                  print(ApiServices.storeId);
                                  print("empty");
                                  Get.toNamed('/CreateStoreScreen');
                                } else {
                                  print("not empty");
                                  addProductController
                                          .addproductApiModel["store_id"] =
                                      ApiServices.storeId.toString();
                                  // ApiServices.myProfileDataList.first.data!
                                  //     .myStore!.first.id
                                  //     .toString();
                                  Get.to(MyStoreProfileScreen(
                                      storeId: ApiServices.storeId.toString()));
                                }
                                // if (ApiServices
                                //         .myProfileDataList.first.data!.myStore
                                //         .toString() ==
                                //     "[]") {
                                //   Utils.showSnack(
                                //       "Create Store First", context);
                                // } else {
                                //   addProductController
                                //           .addproductApiModel["store_id"] =
                                //       ApiServices.myProfileDataList.first.data!
                                //           .myStore!.first.id
                                //           .toString();
                                //   Get.to(MyStoreProfileScreen(
                                //       storeId: ApiServices.myProfileDataList
                                //           .first.data!.myStore!.first.id
                                //           .toString()));
                                // }
                              },
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 50.r,
                                        height: 50.r,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white),
                                        child: SvgPicture.asset(
                                          profileOptionList[0]["img"],
                                          width: 18.r,
                                        ),
                                      ),
                                      20.horizontalSpace,
                                      Text(
                                        profileOptionList[0]["title"],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.white,
                                        size: 18.r,
                                      )
                                    ],
                                  ),
                                  15.verticalSpace,
                                  DottedLine(
                                    dashColor: Colors.white,
                                    dashGapLength: 0.8,
                                    lineThickness: 0.2,
                                  ),
                                  10.verticalSpace
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                //  Get.toNamed('/MyOrderScreen');
                                Get.toNamed('/MyOrderTypeScreen');
                              },
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 50.r,
                                        height: 50.r,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white),
                                        child: SvgPicture.asset(
                                          profileOptionList[1]["img"],
                                          width: 18.r,
                                        ),
                                      ),
                                      20.horizontalSpace,
                                      Text(
                                        profileOptionList[1]["title"],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.white,
                                        size: 18.r,
                                      )
                                    ],
                                  ),
                                  15.verticalSpace,
                                  DottedLine(
                                    dashColor: Colors.white,
                                    dashGapLength: 0.8,
                                    lineThickness: 0.2,
                                  ),
                                  10.verticalSpace
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                //  Get.toNamed('/MyOrderScreen');
                                Get.toNamed('/MyGivenReviewScreen');
                              },
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 50.r,
                                        height: 50.r,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white),
                                        child: SvgPicture.asset(
                                          profileOptionList[2]["img"],
                                          width: 18.r,
                                        ),
                                      ),
                                      20.horizontalSpace,
                                      Text(
                                        profileOptionList[2]["title"],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.white,
                                        size: 18.r,
                                      )
                                    ],
                                  ),
                                  15.verticalSpace,
                                  DottedLine(
                                    dashColor: Colors.white,
                                    dashGapLength: 0.8,
                                    lineThickness: 0.2,
                                  ),
                                  10.verticalSpace
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(() => ListOfProductScreen(
                                      storeId: ApiServices.storeId,
                                      storeProfile: '',
                                      storeName: '',
                                    ));
                                // Get.toNamed('/PersonalPostedProductScreen');
                              },
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 50.r,
                                        height: 50.r,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white),
                                        child: SvgPicture.asset(
                                          profileOptionList[3]["img"],
                                          width: 18.r,
                                        ),
                                      ),
                                      20.horizontalSpace,
                                      Text(
                                        profileOptionList[3]["title"],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.white,
                                        size: 18.r,
                                      )
                                    ],
                                  ),
                                  15.verticalSpace,
                                  DottedLine(
                                    dashColor: Colors.white,
                                    dashGapLength: 0.8,
                                    lineThickness: 0.2,
                                  ),
                                  10.verticalSpace
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Get.toNamed('/FollowingStoriesScreen');
                              },
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 50.r,
                                        height: 50.r,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white),
                                        child: SvgPicture.asset(
                                          profileOptionList[4]["img"],
                                          width: 18.r,
                                        ),
                                      ),
                                      20.horizontalSpace,
                                      Text(
                                        profileOptionList[4]["title"],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.white,
                                        size: 18.r,
                                      )
                                    ],
                                  ),
                                  15.verticalSpace,
                                  DottedLine(
                                    dashColor: Colors.white,
                                    dashGapLength: 0.8,
                                    lineThickness: 0.2,
                                  ),
                                  10.verticalSpace
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Get.toNamed('/MyWhistListScreen');
                              },
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 50.r,
                                        height: 50.r,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white),
                                        child: SvgPicture.asset(
                                          profileOptionList[5]["img"],
                                          width: 18.r,
                                        ),
                                      ),
                                      20.horizontalSpace,
                                      Text(
                                        profileOptionList[5]["title"],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.white,
                                        size: 18.r,
                                      )
                                    ],
                                  ),
                                  15.verticalSpace,
                                  DottedLine(
                                    dashColor: Colors.white,
                                    dashGapLength: 0.8,
                                    lineThickness: 0.2,
                                  ),
                                  10.verticalSpace
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(() => SelectPaymentMethod(
                                      fromProfile: true,
                                    ));
                              },
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 50.r,
                                        height: 50.r,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white),
                                        child: SvgPicture.asset(
                                          profileOptionList[6]["img"],
                                          width: 18.r,
                                        ),
                                      ),
                                      20.horizontalSpace,
                                      Text(
                                        profileOptionList[6]["title"],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.white,
                                        size: 18.r,
                                      )
                                    ],
                                  ),
                                  15.verticalSpace,
                                  DottedLine(
                                    dashColor: Colors.white,
                                    dashGapLength: 0.8,
                                    lineThickness: 0.2,
                                  ),
                                  10.verticalSpace
                                ],
                              ),
                            )

                            // profileOption(profileOptionList[0]["img"], profileOptionList[0]["title"],

                            // // Get.to(MyStoreProfileScreen(storeId: ApiServices.myProfileDataList.first.data!.id.toString()));
                            // ),
                            // profileOption(profileOptionList[1]["img"], profileOptionList[1]["title"], profileOptionList[1]["route"]),
                            // profileOption(profileOptionList[2]["img"], profileOptionList[2]["title"], profileOptionList[2]["route"]),
                            // profileOption(profileOptionList[3]["img"], profileOptionList[3]["title"], profileOptionList[3]["route"]),
                            // profileOption(profileOptionList[4]["img"], profileOptionList[4]["title"], profileOptionList[4]["route"]),
                            // profileOption(profileOptionList[5]["img"], profileOptionList[5]["title"], profileOptionList[5]["route"]),
                          ],
                        )
                        //  ListView.builder(
                        //   shrinkWrap: true,
                        //   padding: EdgeInsets.zero,
                        //   physics: NeverScrollableScrollPhysics(),
                        //   itemCount: profileOptionList.length,
                        //   itemBuilder: (context, index) => profileOption(
                        //       profileOptionList[index]['img'],
                        //       profileOptionList[index]['title'],
                        //       // index == 0?
                        //       // Get.to(MyStoreProfileScreen(storeId: ApiServices.myProfileDataList.first.data!.id.toString(),)):
                        //       profileOptionList[index]['route']
                        //       ),
                        // ),
                        )
                  ],
                );
              } else {
                return Text("Some thing went wrong");
              }
            }),
      ),
    );
  }

  profileOption(img, text, VoidCallback fun) {
    return InkWell(
      onTap: () => fun,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 50.r,
                height: 50.r,
                alignment: Alignment.center,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                child: SvgPicture.asset(
                  img,
                  width: 18.r,
                ),
              ),
              20.horizontalSpace,
              Text(
                text,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 18.r,
              )
            ],
          ),
          15.verticalSpace,
          DottedLine(
            dashColor: Colors.white,
            dashGapLength: 0.8,
            lineThickness: 0.2,
          ),
          10.verticalSpace
        ],
      ),
    );
  }
}
