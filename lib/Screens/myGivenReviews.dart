import 'dart:io';
import 'dart:math';

import 'package:app_fliplaptop/Apiserrvices/Services.dart';
import 'package:app_fliplaptop/Apiserrvices/app_url.dart';
import 'package:app_fliplaptop/Apiserrvices/loader.dart';
import 'package:app_fliplaptop/Controller/reviewController.dart';
import 'package:app_fliplaptop/Screens/MyOrderScreen.dart';
import 'package:app_fliplaptop/components/customNetworkImage.dart';
import 'package:app_fliplaptop/components/textButtonWithLoader.dart';
import 'package:app_fliplaptop/models/reviewModel.dart';
import 'package:app_fliplaptop/res/utils/utils.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/global.dart';
import '../models/dashBoardModel.dart' as DashBoard;

class MyGivenReviewScreen extends StatefulWidget {
  const MyGivenReviewScreen({super.key});

  @override
  State<MyGivenReviewScreen> createState() => _MyReviewScreenState();
}

Future<dynamic> ReviewSubmitDialog(BuildContext context) {
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
                    height: 290.h,
                    // padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        90.verticalSpace,
                        Text(
                          'Review',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        5.verticalSpace,
                        Container(
                          constraints: BoxConstraints(maxWidth: 250.w),
                          child: Text(
                            'Review has been submitted Successfully',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.sp,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        20.verticalSpace,
                        Dialogbutton2(313.w, 50.h, "Go Back", () {
                          Get.close(1);
                        }),
                        20.verticalSpace
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

Future<dynamic> ReviewDialog(BuildContext context, String productID) {
  ratingController controller = Get.put(ratingController());
  return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Center(
              child: Material(
                type: MaterialType.transparency,
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: Colors.white),
                    // width: Get.width * 0.85,
                    width: 368.w,
                    height: 673.h,
                    // padding: EdgeInsets.all(10),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            width: 368.w,
                            height: 74.h,
                            decoration: BoxDecoration(
                                gradient: kgradient,
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(10.r))),
                            child: Container(
                              width: (329 / 2).w,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.close,
                                      color: Colors.transparent,
                                    ),
                                  ),
                                  Text(
                                    "Write a review",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.sp,
                                      // fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () => Get.back(),
                                    icon: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            60.verticalSpace,
                            Text(
                              "What's your Rate?",
                              style: TextStyle(
                                  color: Color(0xff303030),
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            40.h.verticalSpace,
                            GetBuilder(
                                init: controller,
                                builder: (cont) {
                                  return RatingBar(
                                    initialRating: 5,
                                    direction: Axis.horizontal,
                                    allowHalfRating: false,
                                    itemCount: 5,
                                    ratingWidget: RatingWidget(
                                      full: SvgPicture.asset(
                                          'assets/Icon awesome-star.svg'),
                                      half: SvgPicture.asset(
                                          'assets/Icon awesome-star.svg'),
                                      empty: SvgPicture.asset(
                                          'assets/Icon awesome-star-outline.svg'),
                                    ),
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 5.r),
                                    onRatingUpdate: (rating) {
                                      ratingController controller = Get.find();
                                      controller.rating.value = rating;
                                      controller.update();
                                    },
                                    itemSize: 36.r,
                                  );
                                }),
                            30.h.verticalSpace,
                            Text(
                              'Write your Review',
                              style: TextStyle(
                                color: Color(0xff303030),
                                fontSize: 20.sp,
                              ),
                            ),
                            40.h.verticalSpace,
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 20.r),
                              width: 332.w,
                              height: 162.h,
                              decoration: BoxDecoration(
                                color: Color(0xffF1F1F1),
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                              child: Obx(() {
                                return TextField(
                                  controller:
                                      reviewController.reviewDescription.value,
                                  maxLines: 6,
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Color(0xff94989F)),
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 19.r, horizontal: 20.r),
                                      hintMaxLines: 6,
                                      hintText: 'Write a review...',
                                      hintStyle: TextStyle(
                                        fontSize: 14.sp,
                                      )),
                                );
                              }),
                            ),
                            20.h.verticalSpace,
                            Obx(() {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  // Text(reviewController.reviewImageList.length
                                  //     .toString()),
                                  SizedBox(
                                    height: 100.r,
                                    width: 250.r,
                                    // width: 30.w,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemCount: reviewController
                                            .reviewImageList.length,
                                        itemBuilder: (context, index) {
                                          return Row(
                                            children: [
                                              Container(
                                                width: 104.r,
                                                height: 80.h,
                                                alignment: Alignment.center,
                                                // decoration: BoxDecoration(
                                                //   borderRadius:
                                                //       BorderRadius.circular(
                                                //           10.r),
                                                //   // image: DecorationImage(
                                                //   //     image: AssetImage(
                                                //   //         'assets/Lenovo-Laptops.jpg'),
                                                //   //     fit: BoxFit.cover)
                                                // ),
                                                child: Stack(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(
                                                          10.sp,
                                                        ),
                                                      ),
                                                      child: SizedBox(
                                                        height: 80.h,
                                                        width: 90.w,
                                                        child: Image.file(
                                                          File(
                                                            reviewController
                                                                    .reviewImageList[
                                                                index],
                                                          ),
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      right: 0,
                                                      left: 0,
                                                      top: 0,
                                                      bottom: 0,
                                                      child: IconButton(
                                                        onPressed: () {
                                                          // print("tapped");
                                                          reviewController
                                                              .reviewImageList
                                                              .removeAt(index);
                                                        },
                                                        icon: Icon(
                                                          Icons.cancel,
                                                          color: Colors.black,
                                                          size: 30.sp,
                                                        ),
                                                      ),
                                                    ),
                                                    // SvgPicture.asset(
                                                    //   'assets/Icon ionic-ios-close-circle.svg',
                                                    //   color: Colors.white,
                                                    // ),
                                                  ],
                                                ),
                                              ),
                                              10.horizontalSpace,
                                            ],
                                          );
                                        }),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      reviewController.getImageFromGallery();
                                    },
                                    child: DottedBorder(
                                      dashPattern: [3, 4],
                                      strokeWidth: 1,
                                      color: Colors.black.withOpacity(0.5),
                                      strokeCap: StrokeCap.round,
                                      borderType: BorderType.RRect,
                                      radius: Radius.circular(10.r),
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 85.r,
                                        width: 90.r,
                                        child: SvgPicture.asset(
                                          'assets/Icon ionic-ios-add-circle.svg',
                                          width: 30.r,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              );
                            }),
                            30.verticalSpace,
                            Obx(() {
                              return textButtonWithLoader(
                                width: 331.w,
                                height: 59.h,
                                buttonText: 'Post Now',
                                onTap: () {
                                  if (controller.rating.value == 0.0) {
                                    Get.back();
                                    Utils.showSnack(
                                        "Least You can give is 1 star",
                                        context);
                                  } else if (reviewController
                                      .reviewDescription.value.text.isEmpty) {
                                    Get.back();
                                    Utils.showSnack(
                                        "Review text can't be empty", context);
                                  } else {
                                    reviewController.createReview(
                                      context,
                                      productID,
                                      reviewController
                                          .reviewDescription.value.text,
                                      controller.rating.value.toString(),
                                      reviewController.reviewImageList,
                                    );
                                    // ReviewSubmitDialog(context);
                                  }
                                },
                                isLoading: reviewController.isLoading.value,
                              );
                            }),
                          ],
                        ) // 50.h.verticalSpace,
                      ],
                    )),
              ),
            );
          },
        );
      });
}

Future<dynamic> LogoutPopup(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return Center(
            child: Material(
          type: MaterialType.transparency,
          child: Container(
            height: 410.h,
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
                    height: 270.h,
                    // padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        101.verticalSpace,
                        Text(
                          'Logout',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        10.verticalSpace,
                        Container(
                          constraints: BoxConstraints(maxWidth: 168.w),
                          child: Text(
                            'Are you sure you want to logout?',
                            style:
                                TextStyle(color: Colors.black, fontSize: 16.sp),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        15.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Dialogbutton2(151.w, 50.h, "Logout", () {
                              // Get.close(4);
                              Get.toNamed('/LoginScreen');
                            }),
                            Dialogbutton(151.w, 50.h, "Cancel", () {
                              Get.close(1);
                            })
                          ],
                        )
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

var tab = 0;
final reviewController = Get.put(ReviewController());
// final orderController = Get.put(OrderController());

class _MyReviewScreenState extends State<MyGivenReviewScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      initial();
    });
  }

  initial() async {
    // await orderController.getPurchaseList();
    await reviewController.getMyReviews();
    for (var i = 0;
        i < orderController.completedPurchaseOrderList.length;
        i++) {
      int isTobeReviewed = reviewController.reviewsList.indexWhere((element) =>
          element.product!.id ==
          orderController
              .completedPurchaseOrderList[i].orderItem.first.product.id
              .toString());
      print("order value length" +
          orderController.completedPurchaseOrderList[i].orderItem.length
              .toString());

      print("order value" +
          orderController
              .completedPurchaseOrderList[i].orderItem.first.product.id
              .toString());
      // if (isTobeReviewed == -1) {
      //   orderController.toBeReviewedPurchaseOrderList.clear();
      //   orderController.toBeReviewedPurchaseOrderList
      //       .add(orderController.completedPurchaseOrderList[i]);
      // }
    }
    // int isTobeReviewed = reviewController.reviewsList.indexWhere(
    //         (element) =>
    //     element.product!.id ==
    //         orderController.toBeReviewedPurchaseOrderList[i].orderItem.first.);
  }

  @override
  Widget build(BuildContext context) {
    //
    // print("the to be reviewed have " +
    //     orderController.toBeReviewedPurchaseOrderList.length.toString());
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
            'My Reviews',
            style: GoogleFonts.inter(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
        ),
        body: Obx(() {
          return reviewController.isLoading.value ||
                  orderController.isLoading.value
              ? Center(
                  child: Loader.spinkit,
                )
              : Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.r, vertical: 10.r),
                  child: Column(
                      // physics: NeverScrollableScrollPhysics(),

                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  tab = 0;
                                });
                              },
                              child: Container(
                                width: Get.width * 0.45,
                                height: 35.h,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    gradient: tab == 0
                                        ? kgradient
                                        : LinearGradient(
                                            begin: Alignment.center,
                                            end: Alignment.bottomCenter,
                                            transform: GradientRotation(
                                                180 * pi / 180),
                                            colors: [
                                                Color(0xff4C5157)
                                                    .withOpacity(0.5),
                                                Color(0xff121314)
                                                    .withOpacity(0.5)
                                              ]),
                                    borderRadius: BorderRadius.horizontal(
                                        left: Radius.circular(35.r),
                                        right: Radius.circular(35.r))),
                                child: Text(
                                  'To Be Reviewed (${orderController.toBeReviewedCount.value})',
                                  style: GoogleFonts.inter(
                                      fontSize: 14.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  tab = 1;
                                });
                              },
                              child: Container(
                                width: Get.width * 0.45,
                                height: 35.h,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    gradient: tab == 1
                                        ? kgradient
                                        : LinearGradient(
                                            begin: Alignment.center,
                                            end: Alignment.bottomCenter,
                                            transform: GradientRotation(
                                                180 * pi / 180),
                                            colors: [
                                                Color(0xff4C5157)
                                                    .withOpacity(0.5),
                                                Color(0xff121314)
                                                    .withOpacity(0.5)
                                              ]),
                                    borderRadius: BorderRadius.horizontal(
                                        left: Radius.circular(35.r),
                                        right: Radius.circular(35.r))),
                                child: Text(
                                  'History (${reviewController.reviewsList.length})',
                                  style: GoogleFonts.inter(
                                      fontSize: 14.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ],
                        ),
                        tab == 0
                            ? Expanded(
                                child: FutureBuilder(
                                    future: ApiServices().getToBeReviewed(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<List<DashBoard.Datum>>
                                            snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Loader.spinkit;
                                      } else if (snapshot.hasError) {
                                        // log(snapshot.hasError.toString());
                                        return Text(snapshot.error.toString());
                                      } else if (snapshot.hasData) {
                                        Future.delayed(Duration.zero, () {
                                          orderController.toBeReviewedCount
                                              .value = snapshot.data!.length;
                                        });
                                        return snapshot.data!.length == 0
                                            ? Center(
                                                child: Text(
                                                  "No Product Left for review",
                                                  style: TextStyle(
                                                    fontSize: 20.r,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              )
                                            : ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    BouncingScrollPhysics(),
                                                itemCount:
                                                    snapshot.data!.length,
                                                itemBuilder: (context, index) {
                                                  return ToBeReviewedCard(
                                                      snapshot.data?[index].id,
                                                      snapshot
                                                          .data?[index].name,
                                                      snapshot.data?[index]
                                                          .descriptions,
                                                      "\$${snapshot.data?[index].price}",
                                                      snapshot
                                                          .data?[index]
                                                          .productImage
                                                          ?.first
                                                          .name,
                                                      snapshot.data?[index]
                                                          .conditionType,
                                                      snapshot.data?[index]
                                                          .deliveryType,
                                                      context);
                                                });
                                      } else {
                                        return Center(
                                            child: Text(
                                                snapshot.error.toString()));
                                      }
                                    }),
                              )
                            : reviewController.reviewsList.length == 0
                                ? Padding(
                                    padding: EdgeInsets.only(top: 0.2.sh),
                                    child: Center(
                                      child: Text("No Reviews Found"),
                                    ),
                                  )
                                : Expanded(
                                    // height: Get.h,
                                    child: ListView.builder(
                                      reverse: true,
                                        itemCount:
                                            reviewController.reviewsList.length,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 30.r),
                                        shrinkWrap: true,
                                        physics: BouncingScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          // reviewController
                                          //         .reviewsList[index].createdAt =
                                          //     reviewController
                                          //         .reviewsList[index].createdAt
                                          //         ?.replaceAll(' ', '');
                                          // var string = reviewController
                                          //     .reviewsList[index].createdAt
                                          //     ?.split('-');
                                          // print(string.toString());

                                          // // Convert the date format from DD/MM/YYYY to DD MMM YYYY.
                                          // DateFormat dateFormat =
                                          //     DateFormat('yyyy-MM-dd HH:mm:ss');
                                          // // DateTime date =
                                          // //     dateFormat.parse(string?[0] ?? "");
                                          // dateFormat = DateFormat('dd MMM yyyy');
                                          // String formattedDateString =
                                          //     dateFormat.format(DateTime.parse(
                                          //         reviewController
                                          //                 .reviewsList[index]
                                          //                 .createdAt ??
                                          //             ""));
                                          // print("formatted" +
                                          //     formattedDateString.toString());
                                          // //
                                          // // Convert the time format from 24-hour to 12-hour.
                                          // DateFormat timeFormat = DateFormat('HH:mm:ss');
                                          // DateTime time = timeFormat.parse( reviewController
                                          //     .reviewsList[index]
                                          //     .createdAt??"");
                                          // timeFormat = DateFormat('h:mm a');
                                          // String formattedTimeString = timeFormat.format(time);
                                          return Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              personreviewCard(
                                                  reviewController
                                                      .reviewsList[index]
                                                      .product
                                                      ?.name,
                                                  reviewController
                                                      .reviewsList[index]
                                                      .product
                                                      ?.createdAt
                                                      .substring(0, 12),
                                                  // "formattedDateString"
                                                  // "formattedTimeString",
                                                  reviewController
                                                      .reviewsList[index]
                                                      .description,
                                                  reviewController
                                                      .reviewsList[index]
                                                      .reviewImage!,
                                                  false,
                                                  double.parse(reviewController
                                                              .reviewsList[
                                                                  index]
                                                              .rating
                                                              .toString() ==
                                                          ""
                                                      ? "0"
                                                      : reviewController
                                                          .reviewsList[index]
                                                          .rating
                                                          .toString()),
                                                  reviewController
                                                      .reviewsList[index]
                                                      .product
                                                      ?.productImage[0]
                                                      .name,
                                                  // this is reviewReply, model need to be changed
                                                  reviewController
                                                      .reviewsList[index]
                                                      .reviewReply),
                                              20.verticalSpace
                                            ],
                                          );
                                        }),
                                  )
                      ]),
                );
        }));
  }

  personreviewCard(name, date, des, List<ReviewImage> lst, isHelpFul, rating,
      img, reviewReply) {
    print("img" + img.toString());
    return Container(
      padding: EdgeInsets.all(22.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        gradient: kbtngradient,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 60.r,
                height: 60.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // image:
                  //     DecorationImage(image: AssetImage(img), fit: BoxFit.fill),
                ),
                child: ClipOval(
                    child: CustomNetworkImage(
                  imageUrl: ImageUrls.kProduct + img.toString(),
                )),
              ),
              10.horizontalSpace,
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                  5.verticalSpace,
                  RatingBarIndicator(
                    rating: rating,
                    itemBuilder: (context, index) =>
                        SvgPicture.asset('assets/Path 2856.svg'),
                    itemCount: 5,
                    itemSize: 13.r,
                    itemPadding: EdgeInsets.only(right: 3.r),
                    direction: Axis.horizontal,
                  )
                ],
              )),
              Text(
                date.toString(),
                style: TextStyle(
                    color: Colors.white.withOpacity(0.8), fontSize: 14.sp),
              )
            ],
          ),
          15.verticalSpace,
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              des,
              style: TextStyle(
                  fontSize: 12.sp, color: Colors.white.withOpacity(0.8)),
            ),
          ).paddingOnly(left: 0.02.sw),
          15.verticalSpace,
          lst.length == 0
              ? SizedBox()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 0.1.sh,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: lst.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            print(lst[index].image.toString());
                            return Row(
                              children: [
                                Container(
                                  width: 110.r,
                                  height: 91.r,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.r),
                                    // image: DecorationImage(
                                    //     image: AssetImage(lst[i]), fit: BoxFit.fill),
                                  ),
                                  child: CustomNetworkImage(
                                    imageUrl:
                                        ImageUrls.reviewUrl + lst[index].image,
                                  ),
                                ),
                                10.horizontalSpace,
                              ],
                            );
                          }),
                    ),
                    // Container(
                    //   width: 110.r,
                    //   height: 91.r,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(15.r),
                    //     // image: DecorationImage(
                    //     //     image: AssetImage(lst[i]), fit: BoxFit.fill),
                    //   ),
                    //   child: CustomNetworkImage(
                    //     imageUrl: ImageUrls.reviewUrl + lst[i].image,
                    //   ),
                    // ),
                  ],
                ),
          20.verticalSpace,
          reviewReply.toString() == "[]"
              ? SizedBox()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    5.h.verticalSpace,
                    Text(
                      "Reply",
                      style: TextStyle(
                        fontSize: 17.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    8.h.verticalSpace,
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.all(10.r),
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            10.r,
                          ),
                        ),
                      ),
                      child: Text(
                        reviewReply.first.description.toString(),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    15.h.verticalSpace,
                  ],
                ),
          // Row(
          //   children: [
          //     Spacer(),
          //     Text(
          //       'Helpful',
          //       style: TextStyle(
          //         color: Colors.white.withOpacity(0.8),
          //         fontSize: 14.sp,
          //       ),
          //     ),
          //     3.horizontalSpace,
          //     InkWell(
          //       onTap: () {
          //         setState(() {
          //           isHelpFul = !isHelpFul;
          //         });
          //       },
          //       child: Container(
          //           color: isHelpFul ? Colors.white : Colors.transparent,
          //           child: SvgPicture.asset(
          //             'assets/Icon feather-thumbs-up.svg',
          //           )),
          //     )
          //   ],
          // )
        ],
      ),
    );
  }
}

int countOccurrencesUsingWhereMethod(
    List<orderedProduct> list, String element) {
  var foundElements = list.where((e) => e.orderType == element);
  return foundElements.length;
}

reviewProductCard(productID, productName, productDetailText, productPrice,
    productImage, productType, productState, BuildContext context) {
  return InkWell(
    onTap: () {},
    child: Container(
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: Get.width * 0.45,
                padding: EdgeInsets.only(
                    left: 20.r, right: 10.r, top: 5.r, bottom: 5.r),
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Posted on Jan, 2022',
                      style: TextStyle(
                          color: Color(0xff9C0707).withOpacity(0.3),
                          fontSize: 12.sp),
                    ),
                    20.verticalSpace,
                    Text(
                      productName,
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.w600),
                    ),
                    10.verticalSpace,
                    Text(
                      productDetailText,
                      style: GoogleFonts.inter(
                        color: Colors.black.withOpacity(0.5),
                        fontSize: 12.sp,
                      ),
                      overflow: TextOverflow.fade,
                    ),
                    10.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          productState,
                          style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: highlightedText,
                              decoration: TextDecoration.underline),
                        ),
                        Text(
                          productPrice.toString(),
                          style: GoogleFonts.inter(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                width: Get.width * 0.4,
                height: 131.h,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10.r),
                      bottomRight: Radius.circular(10.r)),
                  // image: DecorationImage(
                  //     image: AssetImage(productImage), fit: BoxFit.cover)
                ),
                child: CustomNetworkImage(
                  imageUrl: ImageUrls.kProduct + productImage,
                ),
              ),
            ],
          ),
          20.verticalSpace,
          InkWell(
            onTap: () {
              ReviewDialog(context, productID);
            },
            child: Container(
              width: Get.width,
              alignment: Alignment.center,
              height: 40.h,
              decoration: BoxDecoration(
                  gradient: kbtngradient,
                  borderRadius: BorderRadius.circular(10.r)),
              child: Text(
                'Reply Review',
                style: GoogleFonts.inter(color: Colors.white, fontSize: 13.sp),
              ),
            ),
          ),
          20.verticalSpace
        ],
      ),
    ),
  );
}

ToBeReviewedCard(productID, productName, productDetailText, productPrice,
    productImage, productType, productState, BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 12.0),
    child: InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: Get.width * 0.45,
                  padding: EdgeInsets.only(
                      left: 20.r, right: 10.r, top: 5.r, bottom: 5.r),
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Posted on Jan, 2022',
                        style: TextStyle(
                            color: Color(0xff9C0707).withOpacity(0.3),
                            fontSize: 12.sp),
                      ),
                      20.verticalSpace,
                      Text(
                        productName,
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.w600),
                      ),
                      10.verticalSpace,
                      Text(
                        productDetailText,
                        style: GoogleFonts.inter(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 12.sp,
                        ),
                        overflow: TextOverflow.fade,
                      ),
                      10.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            productState,
                            style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: highlightedText,
                                decoration: TextDecoration.underline),
                          ),
                          Text(
                            productPrice.toString(),
                            style: GoogleFonts.inter(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  width: Get.width * 0.4,
                  height: 131.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10.r),
                        bottomRight: Radius.circular(10.r)),
                    // image: DecorationImage(
                    //     image: AssetImage(productImage), fit: BoxFit.cover)
                  ),
                  child: CustomNetworkImage(
                    imageUrl: ImageUrls.kProduct + productImage,
                  ),
                ),
              ],
            ),
            20.verticalSpace,
            InkWell(
              onTap: () {
                ReviewDialog(context, productID);
              },
              child: Container(
                width: Get.width,
                alignment: Alignment.center,
                height: 40.h,
                decoration: BoxDecoration(
                    gradient: kbtngradient,
                    borderRadius: BorderRadius.circular(10.r)),
                child: Text(
                  'Type Review',
                  style:
                      GoogleFonts.inter(color: Colors.white, fontSize: 13.sp),
                ),
              ),
            ),
            20.verticalSpace
          ],
        ),
      ),
    ),
  );
}

class orderedProduct {
  String? productName;
  String? productDetailtext;
  String? productPrice;
  String? productImage;
  String? orderType;
  String? status;

  orderedProduct(this.productName, this.productDetailtext, this.productPrice,
      this.productImage, this.orderType, this.status);
}

class personReview {
  String? name;
  String? date;
  String? des;
  String? avatarImg;
  List? imageList;
  bool isHelpful = false;
  double? rating;

  personReview(this.name, this.date, this.des, this.imageList, this.isHelpful,
      this.rating, this.avatarImg);
}
