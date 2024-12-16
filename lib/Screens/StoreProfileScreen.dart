import 'dart:developer';

import 'package:app_fliplaptop/Apiserrvices/Services.dart';
import 'package:app_fliplaptop/Apiserrvices/app_url.dart';
import 'package:app_fliplaptop/Apiserrvices/loader.dart';
import 'package:app_fliplaptop/Controller/UserController.dart';
import 'package:app_fliplaptop/Controller/dashBoardController.dart';
import 'package:app_fliplaptop/Controller/filterController.dart';
import 'package:app_fliplaptop/Controller/orderController.dart';
import 'package:app_fliplaptop/Controller/productController.dart';
import 'package:app_fliplaptop/Screens/ReviewProductScreen.dart';
import 'package:app_fliplaptop/Screens/storeRating.dart';
import 'package:app_fliplaptop/models/dashBoardModel.dart';
import 'package:app_fliplaptop/widgets/disallow_indicator_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/global.dart';

List laptopImage = [
  'assets/maxim-hopman-Hin-rzhOdWs-unsplash.png',
  'assets/nubelson-fernandes-c48WlKnfsQ0-unsplash.png',
  'assets/maxim-hopman-Hin-rzhOdWs-unsplash.png',
  'assets/nubelson-fernandes-c48WlKnfsQ0-unsplash.png',
  'assets/maxim-hopman-Hin-rzhOdWs-unsplash.png',
  'assets/nubelson-fernandes-c48WlKnfsQ0-unsplash.png',
];

class StoreProfileScreen extends StatefulWidget {
  StoreProfileScreen(
      {super.key,
      this.storeData,
      this.storeProfile,
      this.brandData,
      required this.postedUserData,
      required this.isStore});

  //this field is not used
  final String? storeProfile;
  Store? storeData;
  Brand? brandData;
  final User postedUserData;
  final bool isStore;

  @override
  State<StoreProfileScreen> createState() =>
      _StoreProfileScreenState(storeData: storeData);
}

class _StoreProfileScreenState extends State<StoreProfileScreen> {
  final userController = Get.put(UserController());

  // final dashBoardController = Get.put(DashBoardController());
  final Store? storeData;

  _StoreProfileScreenState({required this.storeData});

  @override
  void initState() {
    // TODO: implement initState
    // Future.delayed(Duration(seconds: 1),(){
    //   dashBoardController.getDashboardData();
    // });
    super.initState();
  }

  final orderController = Get.put(OrderController());
  final dashBoardController = Get.put(DashBoardController());
  final ProductController productController = Get.put(ProductController());
  bool isRefresh = false;

  Store storeInstance = Store();

  // OrderController orderController = Get.put(OrderController());

  // final ProductController productController = Get.put(ProductController());

  final FilterController filterController = Get.put(FilterController());

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());
    var tr = userController.listOfFollowers
        .indexWhere((element) => element.id == widget.storeData!.id);
    print("=====>value $tr");
    if (tr != -1) {
      userController.isFollowed.value = true;
    } else {
      userController.isFollowed.value = false;
    }
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
          widget.isStore ? 'Store Profile' : "Brand Profile",
          style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
      body: RefreshIndicator(
        color: kprimaryColor,
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: DisAllowIndicatorWidget(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 10.r),
              children: [
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisAlignment: widget.isStore
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
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
                                border: Border.all(
                                    width: 1.3.r, color: kprimaryColor),
                                shape: BoxShape.circle,
                                color: Color.fromARGB(255, 184, 184, 184),
                                // image: DecorationImage(
                                //     image: AssetImage('assets/Ellipse 75@3x.png'),
                                //     fit: BoxFit.cover),
                              ),
                              child: ClipRRect(
                                clipBehavior: Clip.hardEdge,
                                borderRadius: BorderRadius.circular(10.r),
                                child: ClipOval(
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: widget.isStore
                                        ? widget.storeData!.image == ""
                                            ? "https://fliplaptop.thesuitchstaging.com/assets/images/store/profile/1689949591213.jpg"
                                            : ImageUrls.kStoreProfile +
                                                widget.storeData!.image
                                                    .toString()
                                        : ImageUrls.kCategory +
                                            widget.brandData!.image.toString(),
                                    placeholder: (context, url) =>
                                        Icon(Icons.image),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                ),
                              ),
                            ),
                            widget.isStore
                                ? Positioned(
                                    bottom: 5,
                                    right: 3,
                                    child: SvgPicture.asset(
                                      'assets/Group 967.svg',
                                      width: 15.r,
                                    ),
                                  )
                                : SizedBox.shrink(),
                          ],
                        ),
                        // Text(widget.storeData!.image.toString()),
                        8.verticalSpace,
                        SizedBox(
                          width: 90.w,
                          child: Text(
                            widget.isStore
                                ? widget.storeData!.name!
                                : widget.brandData?.name ?? "",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                                color: Colors.black,
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(
                              () => StoreRating(
                                storeID: storeData!.id.toString(),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Reviews (${storeData!.ratingCount})",
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp),
                              ),
                              5.horizontalSpace,
                              SvgPicture.asset(
                                'assets/Icon feather-star.svg',
                                width: 10.r,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    24.horizontalSpace,
                    widget.isStore
                        ? Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                30.verticalSpace,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Column(
                                    //   crossAxisAlignment:
                                    //       CrossAxisAlignment.center,
                                    //   children: [
                                    //     Text(
                                    //       widget.storeData!.following.toString(),
                                    //       style: TextStyle(
                                    //           fontSize: 15.sp,
                                    //           color: kprimaryColor),
                                    //     ),
                                    //     Text(
                                    //       'Following',
                                    //       style: TextStyle(
                                    //           fontSize: 15.sp,
                                    //           color: Color(0xff1D1D1D)),
                                    //     )
                                    //   ],
                                    // ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          ((int.parse(widget.storeData!.follower
                                                  .toString()))
                                              .toString()),
                                          style: TextStyle(
                                              fontSize: 15.sp,
                                              color: kprimaryColor),
                                        ),
                                        Text(
                                          'Followers',
                                          style: TextStyle(
                                              fontSize: 15.sp,
                                              color: Color(0xff1D1D1D)),
                                        )
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          widget.storeData!.productCount
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 15.sp,
                                              color: kprimaryColor),
                                        ),
                                        Text(
                                          'Products',
                                          style: TextStyle(
                                              fontSize: 15.sp,
                                              color: Color(0xff1D1D1D)),
                                        )
                                      ],
                                    ),
                                  ],
                                ).paddingSymmetric(horizontal: 35.w),
                                20.verticalSpace,
                                // Obx(() {
                                InkWell(
                                  onTap: () async {
                                    if (!userController.isLoading.value) {
                                      // getting storeID
                                      String storeID =
                                          widget.storeData!.id.toString();
                                      if (userController.isFollowed.value) {
                                        // unfollowing the store
                                        await userController
                                            .removeFromFollowers(storeID)
                                            .then((val) {
                                          userController.isFollowed.value =
                                              false;

                                          widget.storeData!.follower =
                                              (int.parse(widget
                                                          .storeData!.follower
                                                          .toString()) -
                                                      1)
                                                  .toString();
                                          setState(() {});
                                        });
                                        setState(() {});
                                      } else {
                                        // following the store
                                        await userController
                                            .followStore(storeID)
                                            .then((val) {
                                          // widget.storeData = Store()
                                          userController.isFollowed.value =
                                              true;
                                          widget.storeData!.follower =
                                              (int.parse(widget
                                                          .storeData!.follower
                                                          .toString()) +
                                                      1)
                                                  .toString();
                                          setState(() {});
                                        });
                                        setState(() {});
                                      }
                                    } else {
                                      null;
                                    }
                                  },
                                  child: Container(
                                    width: Get.width * 0.7,
                                    alignment: Alignment.center,
                                    height: 35.h,
                                    decoration: BoxDecoration(
                                        gradient: kbtngradient,
                                        borderRadius:
                                            BorderRadius.circular(10.r)),
                                    child: userController.isLoading.value
                                        ? SizedBox(
                                            height: 20.h,
                                            width: 20.w,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              color: Colors.white,
                                            ),
                                          )
                                        : Text(
                                            userController.isFollowed.value
                                                ? "Unfollow"
                                                : 'Follow',
                                            style: GoogleFonts.inter(
                                                color: Colors.white,
                                                fontSize: 13.sp),
                                          ),
                                  ),
                                )
                                // })
                              ],
                            ),
                          )
                        : SizedBox.shrink()
                  ],
                ),
                24.verticalSpace,
                Visibility(
                  // visible: widget.storeData!.product!.length > 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.isStore
                          ? FutureBuilder(
                              future: ApiServices().viewStoreByID(
                                  widget.storeData!.id.toString()),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 50, vertical: 250),
                                    child: Loader.spinkit,
                                  );
                                }
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: Column(
                                      children: [
                                        Divider(
                                          thickness: 2.h,
                                          color: Colors.black,
                                        ),
                                        10.verticalSpace,
                                        Text(
                                          "No Posted Products",
                                          style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  return ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.data!.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          // if()

                                          // if (dashBoardController
                                          //     .newArrival.value.data!.isNotEmpty) {
                                          orderController.datumInstance.value =
                                              snapshot.data!.data![index];

                                          // productController.editDatumInstance.value =
                                          // dashBoardController.newArrival.value.data![index];

                                          // if (!isStoreProfile) {
                                          productController
                                                  .editDatumInstance.value =
                                              snapshot.data!.data![index];
                                          // }
                                          // if(storeID == ApiServices.storeId) {
                                          //   productController.editDatumInstance.value =
                                          //   productController
                                          //       .productListingDataList.first.data![index];
                                          // }
                                          // }
                                          log(productController
                                              .editDatumInstance.value.name
                                              .toString());
                                          log(productController
                                              .editDatumInstance.value.price
                                              .toString());
                                          // print("storecompelte data is $storeCompleteData");
                                          Get.to(() => ReviewProductScreen(
                                                index: index,
                                                storeID: int.parse(snapshot
                                                    .data!.data![index].id
                                                    .toString()),
                                                ownProduct: false,
                                                productData: {
                                                  "name": snapshot
                                                      .data!.data![index].name,
                                                  //  widget.storeData
                                                  //     ?.product?[index].name,
                                                  "rating": snapshot.data!
                                                              .data![index].avg
                                                              .toString() ==
                                                          ""
                                                      ? "0"
                                                      : snapshot.data!
                                                          .data![index].avg
                                                          .toString()
                                                          .substring(0, 3),
                                                  // widget
                                                  //             .storeData
                                                  //             ?.product?[
                                                  //                 index]
                                                  //             .avg
                                                  //             .toString() ==
                                                  //         ""
                                                  //     ? "0"
                                                  //     : widget
                                                  //         .storeData
                                                  //         ?.product?[index]
                                                  //         .avg
                                                  //         .toString()
                                                  //         .substring(0, 3),
                                                  "price":
                                                      "\$ ${snapshot.data!.data![index].price}",
                                                  "dealPrice":
                                                      "\$ ${snapshot.data!.data![index].dealItemPrice}",
                                                  // "\$ ${widget.storeData?.product?[index].dealItemPrice}",
                                                  "dealItemStartDatetime":
                                                      snapshot
                                                          .data!
                                                          .data![index]
                                                          .dealItemStartDatetime,
                                                  "dealItemEndDatetime":
                                                      snapshot
                                                          .data!
                                                          .data![index]
                                                          .dealItemEndDatetime,
                                                  // widget
                                                  //     .storeData
                                                  //     ?.product?[index]
                                                  //     .dealItemEndDatetime,
                                                  "dealItemPercentage": snapshot
                                                      .data!
                                                      .data![index]
                                                      .dealItemPercentage,
                                                  "image": ImageUrls.kProduct +
                                                      snapshot
                                                          .data!
                                                          .data![index]
                                                          .productImage!
                                                          .first
                                                          .name
                                                          .toString(),
                                                  // widget
                                                  //     .storeData!
                                                  //     .product![index]
                                                  //     .productImage!
                                                  //     .first
                                                  //     .name
                                                  //     .toString(),
                                                  "condition": snapshot
                                                      .data!
                                                      .data![index]
                                                      .conditionType,
                                                  "discount": snapshot.data!
                                                      .data![index].discount,
                                                  "description": snapshot
                                                      .data!
                                                      .data![index]
                                                      .descriptions,
                                                },
                                                // storeName: storeCompleteDat,
                                                storeProfile: snapshot.data
                                                    ?.data?[index].storeImage,
                                                storeData: Store(
                                                  id: snapshot.data!
                                                      .data![index].storeId,
                                                  name: snapshot.data!
                                                      .data![index].storeName,
                                                  image: snapshot.data!
                                                      .data![index].storeImage,
                                                ),
                                                // widget.storeData,
                                                postedUserData: snapshot
                                                    .data!.data![index].user,
                                              ));
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Visibility(
                                              visible: index == 0,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'New Arrivals',
                                                    style: GoogleFonts.inter(
                                                        fontSize: 20.sp,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  4.verticalSpace,
                                                  Text(
                                                    'Top products incredible price',
                                                    style: GoogleFonts.inter(
                                                        color: Colors.black
                                                            .withOpacity(0.5),
                                                        fontSize: 14.sp),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            10.verticalSpace,
                                            Container(
                                              width: Get.width,
                                              padding: EdgeInsets.all(10.r),
                                              decoration: BoxDecoration(
                                                  color: Colors.white
                                                      .withOpacity(0.5),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r)),
                                              child: Stack(
                                                children: [
                                                  Positioned(
                                                      top: 0,
                                                      left: 6,
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.all(4.0),
                                                        decoration:
                                                            BoxDecoration(
                                                          gradient: kgradient,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  bottomLeft:
                                                                      Radius.circular(
                                                                          10.r),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          10.r)),
                                                        ),
                                                        child: Text(
                                                          snapshot
                                                              .data!
                                                              .data![index]
                                                              .conditionType
                                                              .toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 10.sp),
                                                        ),
                                                      )),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                vertical: 19.r,
                                                                horizontal:
                                                                    10.r),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          // mainAxisSize: MainAxisSize.min,
                                                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          children: [
                                                            8.verticalSpace,
                                                            SizedBox(
                                                              width: 0.4.sw,
                                                              child: Text(
                                                                snapshot
                                                                    .data!
                                                                    .data![
                                                                        index]
                                                                    .name
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                                maxLines: 3,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                            3.verticalSpace,
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Text(
                                                                  "Reviews(${snapshot.data!.data![index].avg.toString() == "" ? "0" : snapshot.data?.data?[index].avg})",
                                                                  style: GoogleFonts.inter(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          14.sp),
                                                                ),
                                                                5.horizontalSpace,
                                                                SvgPicture
                                                                    .asset(
                                                                  'assets/Icon feather-star.svg',
                                                                  width: 10.r,
                                                                )
                                                              ],
                                                            ),
                                                            3.verticalSpace,
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "\$${snapshot.data!.data![index].price.toString()}",
                                                                  style: GoogleFonts.inter(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          14.sp,
                                                                      decoration: snapshot.data!.data![index].dealItemPrice.toString() != '' ||
                                                                              snapshot.data!.data![index].discount !=
                                                                                  null
                                                                          ? TextDecoration
                                                                              .lineThrough
                                                                          : null,
                                                                      color: snapshot.data!.data![index].dealItemPrice.toString() != '' ||
                                                                              snapshot.data!.data![index].discount !=
                                                                                  null
                                                                          ? Colors
                                                                              .grey
                                                                          : Colors
                                                                              .black),
                                                                ),
                                                                Visibility(
                                                                  visible: snapshot
                                                                          .data!
                                                                          .data![
                                                                              index]
                                                                          .dealItemPrice
                                                                          .toString() !=
                                                                      '',
                                                                  child: Row(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    // mainAxisAlignment: MainAxisAlignment.center,
                                                                    children: [
                                                                      6.w.horizontalSpace,
                                                                      Text(
                                                                        "\$${snapshot.data!.data![index].dealItemPrice.toString()}",
                                                                        style: GoogleFonts.inter(
                                                                            fontWeight: FontWeight.w600,
                                                                            fontSize: 14.sp,
                                                                            // decoration: TextDecoration.lineThrough,
                                                                            color: Colors.black),
                                                                      ),
                                                                      5.w.horizontalSpace,
                                                                      // SizedBox(width: 0.05.w,),
                                                                    ],
                                                                  ),
                                                                ),
                                                                snapshot.data!.data![index].discount ==
                                                                            null ||
                                                                        snapshot.data!.data![index].dealItemPrice.toString() !=
                                                                            ''
                                                                    ? SizedBox()
                                                                    : Row(
                                                                        children: [
                                                                          10.w.horizontalSpace,
                                                                          Text(
                                                                            "\$${snapshot.data!.data![index].discount!.price.toString()}",
                                                                            style: GoogleFonts.inter(
                                                                                fontWeight: FontWeight.w600,
                                                                                fontSize: 14.sp,
                                                                                // decoration: TextDecoration.lineThrough,
                                                                                color: Colors.black),
                                                                          ),
                                                                        ],
                                                                      )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 182.w,
                                                        height: 113.h,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.r),
                                                          // image: DecorationImage(
                                                          //   image: AssetImage(img),
                                                          //   fit: BoxFit.fill,
                                                          // ),
                                                        ),
                                                        child: ClipRRect(
                                                          clipBehavior:
                                                              Clip.hardEdge,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.r),
                                                          child:
                                                              CachedNetworkImage(
                                                            fit:
                                                                BoxFit.fitWidth,
                                                            imageUrl: snapshot
                                                                        .data!
                                                                        .data![
                                                                            index]
                                                                        .productImage!
                                                                        .first
                                                                        .name
                                                                        .toString() ==
                                                                    ""
                                                                ? "https://fliplaptop.thesuitchstaging.com/assets/images/store/profile/1689949591213.jpg"
                                                                : ImageUrls
                                                                        .kProduct +
                                                                    snapshot
                                                                        .data!
                                                                        .data![
                                                                            index]
                                                                        .productImage!
                                                                        .first
                                                                        .name
                                                                        .toString(),
                                                            placeholder:
                                                                (context,
                                                                        url) =>
                                                                    Icon(Icons
                                                                        .image),
                                                            errorWidget:
                                                                (context, url,
                                                                        error) =>
                                                                    Icon(Icons
                                                                        .error),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  snapshot.data!.data![index]
                                                              .dealItemPrice
                                                              .toString() !=
                                                          ''
                                                      ? Positioned(
                                                          top: 6,
                                                          right: 6,
                                                          child:
                                                              SvgPicture.asset(
                                                            "assets/hotDealIcon.svg",
                                                            height: 0.045.sh,
                                                          ))
                                                      : SizedBox(),
                                                ],
                                              ),
                                            ),
                                            12.verticalSpace,
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                }
                              },
                            )
                          : FutureBuilder(
                              future: ApiServices()
                                  .searchBrands(widget.brandData?.id ?? "1"),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Padding(
                                    padding: EdgeInsets.only(top: 0.3.sh),
                                    child: Center(child: Loader.spinkit),
                                  );
                                } else if (snapshot.hasError) {
                                  // log(snapshot.hasError.toString());
                                  return Padding(
                                    padding: EdgeInsets.only(top: 0.3.sh),
                                    child: Center(
                                      child: Text(
                                        "No Products Found",
                                        style: TextStyle(
                                          fontSize: 20.r,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  );
                                } else if (snapshot.hasData) {
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      physics: BouncingScrollPhysics(),
                                      itemCount: snapshot.data!.data!.length,
                                      itemBuilder: (context, index) {
                                        // return Container(height: 20.h,width: 90.w,color: Colors.black,)
                                        var storeIndex = dashBoardController
                                            .storeList
                                            .indexWhere((element) =>
                                                element.id ==
                                                snapshot.data!.data![index]
                                                    .storeId);
                                        // Store storeInstance = Store();
                                        if (storeIndex != -1) {
                                          storeInstance = dashBoardController
                                              .storeList[storeIndex];
                                        }
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            /// if tapped on arrival more products
                                            InkWell(
                                              onTap: () {
                                                orderController.datumInstance.value =
                                                snapshot.data!.data![index];
                                                productController.editDatumInstance.value =
                                                snapshot.data!.data![index];
                                                // if (widget.isFiltered) {
                                                //   orderController
                                                //       .datumInstance.value =
                                                //   snapshot.data!.data![index];
                                                //   productController
                                                //       .editDatumInstance
                                                //       .value =
                                                //   snapshot.data!.data![index];
                                                // }
                                              },
                                              child: productCard(
                                                  snapshot
                                                      .data!.data![index].name,
                                                  '${snapshot.data!.data![index].avg == "" ? 0 : snapshot.data!.data![index].avg.toString().substring(0, 3)}',
                                                  '\$ ${snapshot.data!.data![index].price}',
                                                  '${snapshot.data!.data![index].dealItemPrice}',
                                                  snapshot.data!.data![index]
                                                      .dealItemStartDatetime,
                                                  snapshot.data!.data![index]
                                                      .dealItemEndDatetime,
                                                  snapshot.data!.data![index]
                                                      .dealItemPercentage,
                                                  snapshot.data!.data![index]
                                                          .productImage!.isEmpty
                                                      ? ""
                                                      : ImageUrls.kProduct +
                                                          (snapshot
                                                                  .data!
                                                                  .data![index]
                                                                  .productImage![
                                                                      0]
                                                                  .name ??
                                                              ""),
                                                  index,
                                                  snapshot.data!.data![index]
                                                      .conditionType,
                                                  snapshot.data!.data![index]
                                                      .descriptions,
                                                  snapshot.data!.data![index]
                                                      .storeImage,
                                                  storeInstance,
                                                  // Store(
                                                  //     id: filterController
                                                  //         .filteredData[index].storeId,
                                                  //     name: filterController
                                                  //         .filteredData[index]
                                                  //         .storeName,
                                                  //     image: filterController
                                                  //         .filteredData[index]
                                                  //         .storeImage),
                                                  snapshot.data!.data![index]
                                                      .storeId,
                                                  snapshot.data!.data![index]
                                                          .user ??
                                                      User(),
                                                  snapshot.data!.data![index]
                                                      .discount),
                                            ),
                                            20.verticalSpace
                                          ],
                                        );
                                      });
                                  ;
                                } else {
                                  return Center(
                                      child: Text(snapshot.error.toString()));
                                }
                              }),
                    ],
                  ),
                ),
                // Visibility(
                //   visible: widget.storeData!.product!.length == 0,
                //   child: Center(
                //     child: Column(
                //       children: [
                //         Divider(
                //           thickness: 2.h,
                //           color: Colors.black,
                //         ),
                //         10.verticalSpace,
                //         Text(
                //           "No Posted Products",
                //           style: TextStyle(
                //             fontSize: 18.sp,
                //             fontWeight: FontWeight.bold,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
        onRefresh: () async {
          setState(() {
            isRefresh = true;
          });
          print("Check Store ID: ${widget.storeData!.id}");
          widget.storeData!.id;
          setState(() {
            isRefresh = false;
          });
        },
      ),
    );
  }

  productCard(
      brand,
      rating,
      price,
      dealPrice,
      dealItemStartDatetime,
      dealItemEndDatetime,
      dealItemPercentage,
      img,
      index,
      condition,
      description,
      storeImage,
      storeCompleteData,
      storeID,
      User postedUserData,
      Discount? discount) {
    return InkWell(
      onTap: () {
        Future.delayed(Duration.zero, () {
          log("store complete data" + storeCompleteData.name.toString());
          log("index is" + index.toString());
          log("length filtered is" +
              filterController.filteredData.length.toString());
          // if (widget.isNewArrival!) {

          // } else {
          //   orderController.datumInstance.value =
          //   dashBoardController.moreProductList.value[index];
          //   productController.editDatumInstance.value =
          //   dashBoardController.moreProductList.value[index];
          // }
          // log("datum name is" + orderController.datumInstance.value.name!);
          // }
          log("deal price " + "\$ $dealPrice");
          log("discount" + discount.toString());
          Get.to(() => ReviewProductScreen(
                index: index,
                storeID: storeID,
                productData: {
                  "name": brand,
                  "rating": rating,
                  "price": price,
                  "dealPrice": "\$ $dealPrice",
                  "dealItemStartDatetime": dealItemStartDatetime,
                  "dealItemEndDatetime": dealItemEndDatetime,
                  "dealItemPercentage": dealItemPercentage,
                  "image": img,
                  "condition": condition,
                  "discount": discount,
                  "description": description
                },
                storeProfile: storeImage,
                // storeProfile: img,
                ownProduct: false,
                storeData: storeCompleteData,
                postedUserData: postedUserData,
              ));
        });
      },
      child: Container(
        height: 141.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: Colors.white,
        ),
        child: Stack(
          children: [
            Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    gradient: kgradient,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.r),
                        topRight: Radius.circular(10.r)),
                  ),
                  child: Text(
                    condition,
                    style: TextStyle(color: Colors.white, fontSize: 10.sp),
                  ),
                )),
            Row(
              children: [
                Container(
                  width: Get.width * 0.45,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.r),
                        bottomLeft: Radius.circular(10.r)),
                    // image: DecorationImage(
                    //     image: AssetImage(productImage), fit: BoxFit.fill),
                  ),
                  child: ClipRRect(
                    clipBehavior: Clip.hardEdge,
                    borderRadius: BorderRadius.circular(10.r),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: img == ""
                          ?
                          // "https://fliplaptop.thesuitchstaging.com/assets/images/store/profile/1689949591213.jpg"
                          "NoImage"
                          : img,
                      placeholder: (context, url) => Icon(Icons.image),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
                Container(
                  width: Get.width * 0.45,
                  padding: EdgeInsets.all(7.r),
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        brand,
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 35.h,
                        child: Text(
                          description,
                          style: GoogleFonts.inter(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 12.sp,
                          ),
                          overflow: TextOverflow.fade,
                        ),
                      ),
                      // Row(
                      //   mainAxisSize: MainAxisSize.min,
                      //   children: [
                      //     Text(
                      //       "Reviews(${rating!="0"?rating.toString().substring(0,3):rating})",
                      //       style: GoogleFonts.inter(
                      //           fontWeight: FontWeight.w500,
                      //           fontSize: 14.sp),
                      //     ),
                      //     5.horizontalSpace,
                      //     SvgPicture.asset(
                      //       'assets/Icon feather-star.svg',
                      //       width: 10.r,
                      //     )
                      //   ],
                      // ),
                      2.verticalSpace,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                price,
                                style: GoogleFonts.inter(
                                  fontSize: dealPrice != '' || discount != null
                                      ? 14.sp
                                      : 16.sp,
                                  fontWeight: FontWeight.w600,
                                  decoration:
                                      dealPrice != '' || discount != null
                                          ? TextDecoration.lineThrough
                                          : null,
                                  color: dealPrice != '' || discount != null
                                      ? Colors.grey
                                      : highlightedText,
                                ),
                              ),
                              10.horizontalSpace,
                              Visibility(
                                visible: dealPrice != '',
                                child: Text(
                                  "\$${dealPrice}",
                                  style: GoogleFonts.inter(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: highlightedText),
                                ),
                              ),
                              discount == null || dealPrice != ''
                                  ? SizedBox()
                                  : Text(
                                      "\$ ${discount!.price.toString()}",
                                      style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16.sp,
                                          // decoration: TextDecoration.lineThrough,
                                          color: highlightedText),
                                    )
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                'assets/Icon feather-star.svg',
                                width: 13.r,
                              ),
                              5.horizontalSpace,
                              Text(
                                "${rating != "0" ? rating.toString().substring(0, 3) : rating}",
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            dealPrice != ''
                ? Positioned(
                    top: 6,
                    left: 6,
                    child: SvgPicture.asset(
                      "assets/hotDealIcon.svg",
                      height: 0.05.sh,
                    ))
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}

newArrivalCard(brand, rating, price, img) {
  return InkWell(
    onTap: () {
      Get.toNamed('/ReviewProductScreen');
    },
    child: Column(
      children: [
        Container(
          width: Get.width,
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 19.r, horizontal: 10.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      brand,
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                    3.verticalSpace,
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          rating,
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500, fontSize: 14.sp),
                        ),
                        5.horizontalSpace,
                        SvgPicture.asset(
                          'assets/Icon feather-star.svg',
                          width: 10.r,
                        )
                      ],
                    ),
                    3.verticalSpace,
                    Text(
                      price,
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600, fontSize: 14.sp),
                    ),
                  ],
                ),
              ),
              Container(
                width: 182.w,
                height: 113.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  // image: DecorationImage(
                  //   image: AssetImage(img),
                  //   fit: BoxFit.fill,
                  // )
                ),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: img == ""
                      ?
                      // "https://fliplaptop.thesuitchstaging.com/assets/images/store/profile/1689949591213.jpg"
                      "NoImage"
                      : img,
                  placeholder: (context, url) => Icon(Icons.image),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              )
            ],
          ),
        ),
        10.verticalSpace,
      ],
    ),
  );
}

moreProductCard(brand, rating, price, img) {
  return InkWell(
    onTap: () {
      Get.toNamed('/ReviewProductScreen');
    },
    child: Container(
      // width: Get.width * 0.45,

      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            // width: Get.width* 0.5,
            height: 140.r,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                image: DecorationImage(
                  image: AssetImage(img),
                  fit: BoxFit.fill,
                )),
          ),
          10.verticalSpace,
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  brand,
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
                3.verticalSpace,
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      rating,
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500, fontSize: 14.sp),
                    ),
                    5.horizontalSpace,
                    SvgPicture.asset(
                      'assets/Icon feather-star.svg',
                      width: 10.r,
                    )
                  ],
                ),
                3.verticalSpace,
                Text(
                  price,
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600, fontSize: 14.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

//remove from line number 786
// 20.verticalSpace,
// newArrivalCard('Lenovo Laptop', 'Reviews (4.9)', '\$ 15.59',
//     'assets/andras-vas-Bd7gNnWJBkU-unsplash.png'),
// 24.verticalSpace,
// Text(
//   'More Products',
//   style: GoogleFonts.inter(
//       fontSize: 20.sp, fontWeight: FontWeight.bold),
// ),
// 4.verticalSpace,
// Text(
//   'Top products incredible price',
//   style: GoogleFonts.inter(
//       color: Colors.black.withOpacity(0.5), fontSize: 14.sp),
// ),
// 10.verticalSpace,
// GridView.builder(
//   itemCount: laptopImage.length,
//   physics: NeverScrollableScrollPhysics(),
//   shrinkWrap: true,
//   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//       crossAxisCount: 2,
//       crossAxisSpacing: 5.0,
//       mainAxisSpacing: 10.0,
//       childAspectRatio: 0.83),
//   itemBuilder: (BuildContext context, int index) {
//     return moreProductCard('Lenovo Laptop', 'Reviews (4.9)',
//         '\$ 15.59', laptopImage[index]);
//   },
// )
