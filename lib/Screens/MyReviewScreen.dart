import 'package:app_fliplaptop/Apiserrvices/app_url.dart';
import 'package:app_fliplaptop/Apiserrvices/loader.dart';
import 'package:app_fliplaptop/Controller/orderController.dart';
import 'package:app_fliplaptop/Controller/reviewController.dart';
import 'package:app_fliplaptop/Screens/MyOrderScreen.dart';
import 'package:app_fliplaptop/Screens/replyReviewScreen.dart';
import 'package:app_fliplaptop/components/customNetworkImage.dart';
import 'package:app_fliplaptop/components/textButtonWithLoader.dart';
import 'package:app_fliplaptop/models/reviewModel.dart';
import 'package:app_fliplaptop/res/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/global.dart';

class MyReviewScreen extends StatefulWidget {
  const MyReviewScreen({super.key});

  @override
  State<MyReviewScreen> createState() => _MyReviewScreenState();
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
                    height: 370.h,
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
                                    "Write a Reply",
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
                            // 60.verticalSpace,
                            // Text(
                            //   "What's your Rate?",
                            //   style: TextStyle(
                            //       color: Color(0xff303030),
                            //       fontSize: 20.sp,
                            //       fontWeight: FontWeight.bold),
                            // ),
                            // 40.h.verticalSpace,
                            // GetBuilder(
                            //     init: controller,
                            //     builder: (cont) {
                            //       return RatingBar(
                            //         initialRating: 5,
                            //         direction: Axis.horizontal,
                            //         allowHalfRating: false,
                            //         itemCount: 5,
                            //         ratingWidget: RatingWidget(
                            //           full: SvgPicture.asset(
                            //               'assets/Icon awesome-star.svg'),
                            //           half: SvgPicture.asset(
                            //               'assets/Icon awesome-star.svg'),
                            //           empty: SvgPicture.asset(
                            //               'assets/Icon awesome-star-outline.svg'),
                            //         ),
                            //         itemPadding:
                            //             EdgeInsets.symmetric(horizontal: 5.r),
                            //         onRatingUpdate: (rating) {
                            //           ratingController controller = Get.find();
                            //           controller.rating.value = rating;
                            //           controller.update();
                            //         },
                            //         itemSize: 36.r,
                            //       );
                            //     }),
                            // 10.h.verticalSpace,
                            // Text(
                            //   'Write your Reply',
                            //   style: TextStyle(
                            //     color: Color(0xff303030),
                            //     fontSize: 20.sp,
                            //   ),
                            // ),
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
                                      hintText: 'Write a Reply...',
                                      hintStyle: TextStyle(
                                        fontSize: 14.sp,
                                      )),
                                );
                              }),
                            ),
                            20.h.verticalSpace,
                            // Obx(() {
                            //   return Row(
                            //     mainAxisAlignment:
                            //         MainAxisAlignment.spaceEvenly,
                            //     children: [
                            //       // Text(reviewController.reviewImageList.length
                            //       //     .toString()),
                            //       SizedBox(
                            //         height: 100.r,
                            //         width: 250.r,
                            //         // width: 30.w,
                            //         child: ListView.builder(
                            //             scrollDirection: Axis.horizontal,
                            //             shrinkWrap: true,
                            //             itemCount: reviewController
                            //                 .reviewImageList.length,
                            //             itemBuilder: (context, index) {
                            //               return Row(
                            //                 children: [
                            //                   Container(
                            //                     width: 104.r,
                            //                     height: 80.h,
                            //                     alignment: Alignment.center,
                            //                     // decoration: BoxDecoration(
                            //                     //   borderRadius:
                            //                     //       BorderRadius.circular(
                            //                     //           10.r),
                            //                     //   // image: DecorationImage(
                            //                     //   //     image: AssetImage(
                            //                     //   //         'assets/Lenovo-Laptops.jpg'),
                            //                     //   //     fit: BoxFit.cover)
                            //                     // ),
                            //                     child: Stack(
                            //                       children: [
                            //                         ClipRRect(
                            //                           borderRadius:
                            //                               BorderRadius.all(
                            //                             Radius.circular(
                            //                               10.sp,
                            //                             ),
                            //                           ),
                            //                           child: SizedBox(
                            //                             height: 80.h,
                            //                             width: 90.w,
                            //                             child: Image.file(
                            //                               File(
                            //                                 reviewController
                            //                                         .reviewImageList[
                            //                                     index],
                            //                               ),
                            //                               fit: BoxFit.fill,
                            //                             ),
                            //                           ),
                            //                         ),
                            //                         Positioned(
                            //                           right: 0,
                            //                           left: 0,
                            //                           top: 0,
                            //                           bottom: 0,
                            //                           child: IconButton(
                            //                             onPressed: () {
                            //                               // print("tapped");
                            //                               reviewController
                            //                                   .reviewImageList
                            //                                   .removeAt(index);
                            //                             },
                            //                             icon: Icon(
                            //                               Icons.cancel,
                            //                               color: Colors.black,
                            //                               size: 30.sp,
                            //                             ),
                            //                           ),
                            //                         ),
                            //                         // SvgPicture.asset(
                            //                         //   'assets/Icon ionic-ios-close-circle.svg',
                            //                         //   color: Colors.white,
                            //                         // ),
                            //                       ],
                            //                     ),
                            //                   ),
                            //                   10.horizontalSpace,
                            //                 ],
                            //               );
                            //             }),
                            //       ),
                            //       InkWell(
                            //         onTap: () {
                            //           reviewController.getImageFromGallery();
                            //         },
                            //         child: DottedBorder(
                            //           dashPattern: [3, 4],
                            //           strokeWidth: 1,
                            //           color: Colors.black.withOpacity(0.5),
                            //           strokeCap: StrokeCap.round,
                            //           borderType: BorderType.RRect,
                            //           radius: Radius.circular(10.r),
                            //           child: Container(
                            //             alignment: Alignment.center,
                            //             height: 85.r,
                            //             width: 90.r,
                            //             child: SvgPicture.asset(
                            //               'assets/Icon ionic-ios-add-circle.svg',
                            //               width: 30.r,
                            //             ),
                            //           ),
                            //         ),
                            //       )
                            //     ],
                            //   );
                            // }),
                            // 30.verticalSpace,
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
final orderController = Get.put(OrderController());

class _MyReviewScreenState extends State<MyReviewScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // initial() async {
  //   await orderController.getPurchaseList();
  //   await reviewController.getMyReviews();
  //   for (var i = 0; i < orderController.completedPurchaseOrderList.length; i++) {
  //     int isTobeReviewed = reviewController.reviewsList.indexWhere(
  //             (element) =>
  //         element.product!.id ==
  //             orderController.completedPurchaseOrderList[i].orderItem.first.product.id.toString());
  //     print("order value length"+orderController.completedPurchaseOrderList[i].orderItem.length.toString());
  //
  //     print("order value"+orderController.completedPurchaseOrderList[i].orderItem.first.product.id.toString());
  //     if (isTobeReviewed == -1) {
  //       orderController.toBeReviewedPurchaseOrderList.clear();
  //       orderController.toBeReviewedPurchaseOrderList.add(orderController.completedPurchaseOrderList[i]);
  //     }
  //   }
  //   // int isTobeReviewed = reviewController.reviewsList.indexWhere(
  //   //         (element) =>
  //   //     element.product!.id ==
  //   //         orderController.toBeReviewedPurchaseOrderList[i].orderItem.first.);
  // }

  @override
  Widget build(BuildContext context) {
    print("the to be reviewed have " +
        orderController.toBeReviewedPurchaseOrderList.length.toString());
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
            'My Store Reviews',
            style: GoogleFonts.inter(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
        ),
        body: FutureBuilder(
            future: reviewController.getMyStoreReviews(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Loader.spinkit;
              } else if (snapshot.data!.length == 0) {
                return Center(
                  child: Text(
                    "No Store Reviews!",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              } else if (snapshot.hasData) {
                // final list =
                //     productController.productListingDataList.first.data;
                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return reviewProductCard(
                      snapshot.data?[index].id,
                      snapshot.data?[index].createdAt
                          .toString()
                          .substring(0, 11),
                      snapshot.data?[index].product.id,
                      snapshot.data?[index].product.name,
                      snapshot.data?[index].description,
                      "\$ ${snapshot.data?[index].product.price}",
                      snapshot.data?[index].product.productImage.first.name,
                      snapshot.data?[index].product.conditionType,
                      snapshot.data?[index].product.deliveryType,
                      snapshot.data?[index].reviewReply,
                      snapshot.data?[index].reviewImage,
                      context,
                    );
                  },
                );
              } else {
                return Center(
                  child: Text(snapshot.hasError.toString()),
                );
              }
            }));
  }

  personreviewCard(
      name, date, des, List<ReviewImage> lst, isHelpFul, rating, img) {
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
                  imageUrl: ImageUrls.kProduct + img,
                )),
              ),
              10.horizontalSpace,
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
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
                date,
                style: TextStyle(
                    color: Colors.white.withOpacity(0.8), fontSize: 14.sp),
              )
            ],
          ),
          15.verticalSpace,
          Text(
            des,
            style: TextStyle(
                fontSize: 12.sp, color: Colors.white.withOpacity(0.8)),
          ),
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
          Row(
            children: [
              Spacer(),
              Text(
                'Helpful',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 14.sp,
                ),
              ),
              3.horizontalSpace,
              InkWell(
                onTap: () {
                  setState(() {
                    isHelpFul = !isHelpFul;
                  });
                },
                child: Container(
                    color: isHelpFul ? Colors.white : Colors.transparent,
                    child: SvgPicture.asset(
                      'assets/Icon feather-thumbs-up.svg',
                    )),
              )
            ],
          )
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

reviewProductCard(
    parentID,
    postedTime,
    productID,
    productName,
    productDetailText,
    productPrice,
    productImage,
    productType,
    productState,
    reviewReply,
    reviewImage,
    BuildContext context) {
  return InkWell(
    onTap: () {},
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        padding:
            EdgeInsets.only(left: 20.r, right: 10.r, top: 5.r, bottom: 5.r),
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
                  // padding: EdgeInsets.only(
                  //     left: 20.r, right: 10.r, top: 5.r, bottom: 5.r),
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Posted on ${postedTime}',
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Text(
                          //   productState,
                          //   style: GoogleFonts.inter(
                          //       fontSize: 12.sp,
                          //       fontWeight: FontWeight.w500,
                          //       color: highlightedText,
                          //       decoration: TextDecoration.underline),
                          // ),
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
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  reviewImage.isEmpty?SizedBox():
                  SizedBox(
                    height: 0.2.sh,
                      width: 0.3.sw,
                      child: CachedNetworkImage(
                          imageUrl: ImageUrls.kProduct + reviewImage[0])),
                  Text(
                    "My Review",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  6.h.verticalSpace,
                  // Text(
                  //   productDetailText,
                  //   style: GoogleFonts.inter(
                  //     color: Colors.black.withOpacity(0.8),
                  //     fontSize: 13.sp,
                  //   ),
                  //   overflow: TextOverflow.fade,
                  // ),
                  Padding(
                    padding: EdgeInsets.only(left: 0.05.sw),
                    child: Container(
                      width: Get.width,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.all(10),
                      // height: 40.h,
                      decoration: BoxDecoration(
                          // gradient: kbtngradient,
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Text(
                        productDetailText.toString(),
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        // textAlign: TextAlign.start,
                      ),
                    ),
                  )
                ],
              ),
            ),
            10.verticalSpace,
            reviewReply.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Reply",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      6.h.verticalSpace,
                      Padding(
                        padding: EdgeInsets.only(left: 0.05.sw),
                        child: Container(
                          width: Get.width,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.all(10),
                          // height: 40.h,
                          decoration: BoxDecoration(
                              // gradient: kbtngradient,
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Text(
                            reviewReply.first["description"].toString(),
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            // textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                    ],
                  )
                : InkWell(
                    onTap: () {
                      // ReviewDialog(context, productID);
                      Get.to(() => ReviewReplyScreen(
                            parentID: parentID,
                            productID: productID,
                          ));
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
                        style: GoogleFonts.inter(
                            color: Colors.white, fontSize: 13.sp),
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
