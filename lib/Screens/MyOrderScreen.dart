import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:app_fliplaptop/Apiserrvices/app_url.dart';
import 'package:app_fliplaptop/Apiserrvices/loader.dart';
import 'package:app_fliplaptop/Apiserrvices/localStorage.dart';
import 'package:app_fliplaptop/Controller/orderController.dart';
import 'package:app_fliplaptop/Controller/reviewController.dart';
import 'package:app_fliplaptop/Screens/OrderConfirmation.dart';
import 'package:app_fliplaptop/components/chatWithStoreIcon.dart';
import 'package:app_fliplaptop/components/textButtonWithLoader.dart';
import 'package:app_fliplaptop/models/dashBoardModel.dart' as dash;
import 'package:app_fliplaptop/models/purchaseModel.dart';
import 'package:app_fliplaptop/res/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/global.dart';

class MyOrderScreen extends StatefulWidget {
  final bool isSeller;

  const MyOrderScreen({super.key, required this.isSeller});

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

final reviewController = Get.put(ReviewController());

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

void buyNowModalSheet(context, dash.Datum productData) {
  OrderController quatityCont = Get.put(OrderController());
  showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(35.r))),
      isDismissible: true,
      enableDrag: true,
      useRootNavigator: true,
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      backgroundColor: Colors.white,
      builder: (context) {
        return GetBuilder(
            init: quatityCont,
            builder: (cont) {
              return Container(
                decoration: BoxDecoration(
                    gradient: kbtngradient,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(35.r))),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Positioned(
                        top: 20,
                        child: SvgPicture.asset('assets/Rectangle 773.svg')),
                    Positioned(
                        top: 20,
                        right: 20,
                        child: InkWell(
                            onTap: () {
                              print('close');
                              Get.close(1);
                            },
                            child: SvgPicture.asset(
                              'assets/Icon ionic-ios-close.svg',
                              color: Colors.white,
                            ))),
                    20.verticalSpace,
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        30.verticalSpace,
                        ListView(
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.r, vertical: 30.r),
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 108.r,
                                  height: 97.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    // image: DecorationImage(
                                    //     image: AssetImage(
                                    //         'assets/M2-MacBook-Air-2022-Feature0012.png'),
                                    //     fit: BoxFit.fill),
                                  ),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: productData.productImage!.isEmpty
                                        ? "NoImage"
                                        :
                                        //  iterations.productImage == "[]"?
                                        //  "https://fliplaptop.thesuitchstaging.com/assets/images/products/thumbnails/1691623416450.jpg"

                                        ImageUrls.kProduct +
                                            productData.productImage!.first.name
                                                .toString(),
                                    placeholder: (context, url) =>
                                        Icon(Icons.image),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                ),
                                20.horizontalSpace,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        productData.name ?? "",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        'Color : ${productData.color!.name}',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w100),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            20.verticalSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Quantity',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 20.sp)),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        quatityCont.minus();
                                      },
                                      child: Container(
                                        width: 28.r,
                                        height: 28.r,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle),
                                        child: SvgPicture.asset(
                                          'assets/Icon awesome-minus.svg',
                                          color: highlightedText,
                                        ),
                                      ),
                                    ),
                                    10.horizontalSpace,
                                    Text(
                                      quatityCont.count.toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 19.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    10.horizontalSpace,
                                    InkWell(
                                      onTap: () => quatityCont.add(),
                                      child: Container(
                                        width: 29.r,
                                        height: 29.r,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle),
                                        child: SvgPicture.asset(
                                          'assets/Icon awesome-plus.svg',
                                          color: highlightedText,
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            // 20.verticalSpace,
                            // Text(
                            //   'Shipping US \$9.80',
                            //   style: TextStyle(
                            //       fontSize: 22.sp,
                            //       color: Colors.white,
                            //       fontWeight: FontWeight.bold),
                            // ),
                            20.verticalSpace,
                            // Container(
                            //   height: 79.h,
                            //   child: ListView.builder(
                            //     shrinkWrap: true,
                            //     physics: const BouncingScrollPhysics(),
                            //     scrollDirection: Axis.horizontal,
                            //     itemCount: laptopImages.length,
                            //     itemBuilder: (context, index) => Container(
                            //       margin: EdgeInsets.only(right: 10.r),
                            //       width: 71.r,
                            //       // height: 83.h,
                            //       decoration: BoxDecoration(
                            //           borderRadius: BorderRadius.circular(15.r),
                            //           image: DecorationImage(
                            //               image:
                            //                   AssetImage(laptopImages[index]),
                            //               fit: BoxFit.fill)),
                            //     ),
                            //   ),
                            // ),
                            // 20.verticalSpace,
                            // Text(
                            //   'From China to USA via DHL Standard\nEstimated Delivery 41 - 50 days',
                            //   style: TextStyle(
                            //       color: Colors.white, fontSize: 12.sp),
                            // ),
                            24.verticalSpace,
                            button2(Get.width, 59.h, 'Proceed To Buy',
                                () async {
                              if (productData.qty! <
                                  orderController.count.value) {
                                Utils.showFloatingErrorSnack(
                                    "The product is Out of Stock!");
                              } else {
                                /// mechanism for add to cart functionality
                                if (orderController.cartList.isNotEmpty) {
                                  ///for loop
                                  orderController.cartList.value
                                      .forEach((element) {
                                    print(
                                        "======> datum ID${element.datum.id}");
                                    print(
                                        "======> datum ID${orderController.datumInstance.value.id}");
                                    print("caRT list" +
                                        orderController.cartList.toString());
                                    if (element.datum.id ==
                                        orderController
                                            .datumInstance.value.id) {
                                      print("In if");
                                      Get.back();
                                      Utils.showSnack(
                                          "Item already in Cart", context);
                                    } else {
                                      print("In else");
                                      orderController.cartList.add(CartItem(
                                          datum: orderController
                                              .datumInstance.value,
                                          quantity:
                                              orderController.count.value));
                                      // addSuccessfulPopup(context);
                                      Get.to(() => OrderConfirmation());
                                      orderController
                                          .totalSumOfCartProductsPrices(0);
                                    }
                                  });
                                } else {
                                  orderController.cartList.add(CartItem(
                                      // datum:
                                      datum: productData,
                                      // Datum(
                                      //   id: productData.id,
                                      //   name: productData.name,
                                      //   price: productData.price,
                                      //   dealItemPrice: productData.dealItemPrice,
                                      //   dealItemStartDatetime:  productData.dealItemStartDatetime,
                                      //   dealItemEndDatetime:  productData.dealItemEndDatetime,
                                      //   dealItemPercentage:  productData.dealItemPercentage,
                                      //   qty:  productData.qty,
                                      //   // stock:  productData.
                                      //   conditionType:  productData.conditionType,
                                      //   deliveryType:  productData.deliveryType,
                                      //   model:  productData.model,
                                      //   descriptions:  productData.descriptions,
                                      //   createdAt:  productData.createdAt,
                                      //   storeId:  productData.storeId,
                                      //   storeName:  productData.storeName,
                                      //   shippingCost:  productData.shippingCost,
                                      //   // size:  productData.size,
                                      //   storeImage:  productData.storeImage,
                                      //   productImage:  productData.productImage as List<ProductImage>,
                                      //   tax: productData.tax,
                                      //
                                      //   // discount:  productData.discount as Discount,
                                      //
                                      //
                                      //
                                      // ),
                                      quantity: orderController.count.value));
                                  // CartItem.
                                  var cartList = orderController.cartList.value;
                                  print(jsonEncode(cartList));

                                  /// saving the cart list to local storage
                                  LocalStorage.saveJson(
                                      key: LocalStorageKeys.cartList,
                                      value: jsonEncode(cartList));
                                  // addSuccessfulPopup(context);
                                  Get.to(() => OrderConfirmation());
                                  var cart = await LocalStorage.readJson(
                                      key: LocalStorageKeys.cartList);
                                  var list = jsonDecode(cart);
                                  print("===============>cart" +
                                      list.length.toString());
                                }
                                print(
                                    "The cart have ${orderController.cartList.length} items");
                                orderController.totalSumOfCartProductsPrices(0);
                                print(productData.toString());
                                print(orderController.totalPrice.value);
                              }
                            })
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              );
            });
      });
}

// var tab = 0;
OrderController orderController = Get.put(OrderController());

class _MyOrderScreenState extends State<MyOrderScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // orderController.completedPurchaseOrderList[0].
  }

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
          // 'My Orders??
          widget.isSeller ? "Sell Orders" : "My Purchase Orders",
          style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
      body: Obx(() {
        return SingleChildScrollView(
          padding: EdgeInsets.zero,
          child: orderController.isLoading.value
              ? Center(
                  child: Loader.spinkit,
                )
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      // Text(orderController.purchaseOrderList.length.toString()),
                      SizedBox(
                        height: 0.04.sh,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                if (mounted) {
                                  // setState(() {
                                  orderController.tab.value = 0;
                                  // });
                                }
                              },
                              child: Container(
                                width: 116.w,
                                height: 35.h,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    gradient: orderController.tab.value == 0
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
                                  widget.isSeller ? "New" : 'All',
                                  style: GoogleFonts.inter(
                                      fontSize: 14.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                if (mounted) {
                                  // setState(() {
                                  orderController.tab.value = 1;
                                  // });
                                }
                              },
                              child: Container(
                                width: 116.w,
                                height: 35.h,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    gradient: orderController.tab.value == 1
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
                                  widget.isSeller ? "In progress" : 'To Ship',
                                  style: GoogleFonts.inter(
                                      fontSize: 14.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                if (mounted) {
                                  // setState(() {
                                  orderController.tab.value = 2;
                                  // });
                                }
                              },
                              child: Container(
                                width: 116.w,
                                height: 35.h,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    gradient: orderController.tab.value == 2
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
                                  widget.isSeller ? "Completed" : 'Received',
                                  style: GoogleFonts.inter(
                                      fontSize: 14.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      //     ListView.builder(
                      //         shrinkWrap: true,
                      //         itemCount: tab == 0
                      //             ? orderProductList.length
                      //             : tab == 1
                      //                 ? countOccurrencesUsingWhereMethod(
                      //                     orderProductList, 'To Ship')
                      //                 : countOccurrencesUsingWhereMethod(
                      //                     orderProductList, 'Received'),
                      //         itemBuilder: (context, index) => Column(
                      //               mainAxisSize: MainAxisSize.min,
                      //               children: [
                      //                 orderedproductCard(
                      //                     orderProductList[index].productName!,
                      //                     orderProductList[index].productDetailtext!,
                      //                     orderProductList[index].productPrice!,
                      //                     orderProductList[index].productImage!,
                      //                     orderProductList[index].orderType!,
                      //                     orderProductList[index].status!),
                      //                 20.verticalSpace
                      //               ],
                      //             ))
                      //   ],
                      // ),

                      orderController.tab.value == 0
                          ? widget.isSeller
                              ? orderController.newSellerOrderList.length == 0
                                  ? Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 70.r),
                                      child: Text("No New Orders"),
                                    )
                                  : ListView.builder(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 30.r),
                                      itemCount: orderController
                                          .newSellerOrderList.length,
                                      shrinkWrap: true,
                                      physics: BouncingScrollPhysics(),
                                      itemBuilder: (context, index) => Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          orderedproductCard(
                                              orderController
                                                  .newSellerOrderList[index],
                                              orderController
                                                  .newSellerOrderList[index]
                                                  .product[0]
                                                  .id,
                                              orderController
                                                  .newSellerOrderList[index]
                                                  .product[0]
                                                  .name,
                                              orderController
                                                  .newSellerOrderList[index]
                                                  .product[0]
                                                  .descriptions,
                                              orderController
                                                  .newSellerOrderList[index]
                                                  .product[0]
                                                  .price,
                                              ImageUrls.kProduct +
                                                  orderController
                                                      .newSellerOrderList[index]
                                                      .product[0]
                                                      .productImage![0]
                                                      .name!,
                                              orderController
                                                  .newSellerOrderList[index]
                                                  .product[0]
                                                  .deliveryType,
                                              orderController
                                                  .newSellerOrderList[index]
                                                  .product[0]
                                                  .orderProductStatus,
                                              orderController
                                                  .newSellerOrderList[index]
                                                  .product[0]
                                                  .orderProductId,
                                              index),
                                          20.verticalSpace
                                        ],
                                      ),
                                    )
                              : Column(
                                  children: [
                                    ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      // physics:
                                      //     NeverScrollableScrollPhysics(),
                                      padding:
                                          EdgeInsets.symmetric(vertical: 20.r),
                                      itemCount: orderController
                                          .newPurchaseOrderList.length,
                                      shrinkWrap: true,
                                      // physics: AlwaysScrollableScrollPhysics(),
                                      itemBuilder: (context, index) => Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          orderedproductCard(
                                              orderController
                                                  .newPurchaseOrderList[index]
                                                  .orderItem,
                                              orderController
                                                  .newPurchaseOrderList[index]
                                                  .orderItem[0]
                                                  .product
                                                  .id,
                                              orderController
                                                  .newPurchaseOrderList[index]
                                                  .orderItem[0]
                                                  .product
                                                  .name,
                                              orderController
                                                  .newPurchaseOrderList[index]
                                                  .orderItem[0]
                                                  .product
                                                  .descriptions,
                                              orderController
                                                  .newPurchaseOrderList[index]
                                                  .totalAmount,
                                              ImageUrls.kProduct +
                                                  (orderController
                                                          .newPurchaseOrderList[
                                                              index]
                                                          .orderItem[0]
                                                          .product
                                                          .productImage![0]
                                                          .name ??
                                                      ""),
                                              "New",
                                              orderController
                                                  .newPurchaseOrderList[index]
                                                  .orderItem[0]
                                                  .orderItemStatus,
                                              "",
                                              index),
                                          20.verticalSpace
                                        ],
                                      ),
                                    ),
                                    orderController.inProgressPurchaseOrderList
                                                .length ==
                                            0
                                        ? SizedBox()
                                        : ListView.builder(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 20.r),
                                            itemCount: orderController
                                                .inProgressPurchaseOrderList
                                                .length,
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) =>
                                                Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                orderedproductCard(
                                                    orderController
                                                        .inProgressPurchaseOrderList[
                                                            index]
                                                        .orderItem,
                                                    orderController
                                                        .inProgressPurchaseOrderList[
                                                            index]
                                                        .orderItem[0]
                                                        .product
                                                        .id,
                                                    orderController
                                                        .inProgressPurchaseOrderList[
                                                            index]
                                                        .orderItem[0]
                                                        .product
                                                        .name,
                                                    orderController
                                                        .inProgressPurchaseOrderList[
                                                            index]
                                                        .orderItem[0]
                                                        .product
                                                        .descriptions,
                                                    orderController
                                                        .inProgressPurchaseOrderList[
                                                            index]
                                                        .orderItem[0]
                                                        .product
                                                        .price,
                                                    ImageUrls.kProduct +
                                                        (orderController
                                                                .inProgressPurchaseOrderList[
                                                                    index]
                                                                .orderItem[0]
                                                                .product
                                                                .productImage![
                                                                    0]
                                                                .name ??
                                                            ""),
                                                    orderController
                                                        .inProgressPurchaseOrderList[
                                                            index]
                                                        .orderItem[0]
                                                        .product
                                                        .deliveryType,
                                                    orderController
                                                        .inProgressPurchaseOrderList[
                                                            index]
                                                        .orderItem[0]
                                                        .orderItemStatus,
                                                    "",
                                                    index),
                                                20.verticalSpace
                                              ],
                                            ),
                                          ),
                                    ListView.builder(
                                      itemCount: orderController
                                          .completedPurchaseOrderList.length,
                                      shrinkWrap: true,
                                      padding:
                                          EdgeInsets.symmetric(vertical: 20.r),
                                      scrollDirection: Axis.vertical,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) => Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          orderedproductCard(
                                              orderController
                                                  .completedPurchaseOrderList[
                                                      index]
                                                  .orderItem,
                                              orderController
                                                  .completedPurchaseOrderList[
                                                      index]
                                                  .orderItem
                                                  .first
                                                  .product
                                                  .id,
                                              orderController
                                                  .completedPurchaseOrderList[
                                                      index]
                                                  .orderItem
                                                  .first
                                                  .product
                                                  .name,
                                              orderController
                                                  .completedPurchaseOrderList[
                                                      index]
                                                  .orderItem
                                                  .first
                                                  .product
                                                  .descriptions,
                                              orderController
                                                  .completedPurchaseOrderList[
                                                      index]
                                                  .orderItem
                                                  .first
                                                  .product
                                                  .price,
                                              ImageUrls.kProduct +
                                                  (orderController
                                                          .completedPurchaseOrderList[
                                                              index]
                                                          .orderItem
                                                          .first
                                                          .product
                                                          .productImage![0]
                                                          .name ??
                                                      ""),
                                              "completed",
                                              orderController
                                                  .completedPurchaseOrderList[
                                                      index]
                                                  .orderItem
                                                  .first
                                                  .orderItemStatus,
                                              "",
                                              index),
                                          20.verticalSpace
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                          : orderController.tab.value == 1
                              ? widget.isSeller
                                  ? orderController.inProgressSellerOrderList
                                              .length ==
                                          0
                                      ? Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 70.r),
                                          child: Text("No  Orders In progress"),
                                        )
                                      : SizedBox(
                                          height: 0.8.sh,
                                          child: ListView.builder(
                                            itemCount: orderController
                                                .inProgressSellerOrderList
                                                .length,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 30.r),
                                            shrinkWrap: true,
                                            physics: BouncingScrollPhysics(),
                                            itemBuilder: (context, index) =>
                                                Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                orderedproductCard(
                                                    orderController
                                                            .inProgressSellerOrderList[
                                                        index],
                                                    orderController
                                                        .inProgressSellerOrderList[
                                                            index]
                                                        .product![0]
                                                        .id,
                                                    orderController
                                                        .inProgressSellerOrderList[
                                                            index]
                                                        .product![0]
                                                        .name,
                                                    orderController
                                                        .inProgressSellerOrderList[
                                                            index]
                                                        .product![0]
                                                        .descriptions,
                                                    orderController
                                                        .inProgressSellerOrderList[
                                                            index]
                                                        .product![0]
                                                        .price,
                                                    ImageUrls.kProduct +
                                                        orderController
                                                            .inProgressSellerOrderList[
                                                                index]
                                                            .product![0]
                                                            .productImage![0]
                                                            .name!,
                                                    "In Progress",
                                                    orderController
                                                        .inProgressSellerOrderList[
                                                            index]
                                                        .product![0]
                                                        .orderProductStatus,
                                                    orderController
                                                        .inProgressSellerOrderList[
                                                            index]
                                                        .product![0]
                                                        .orderProductId,
                                                    index),
                                                20.verticalSpace
                                              ],
                                            ),
                                          ),
                                        )
                                  : orderController.inProgressPurchaseOrderList
                                              .length ==
                                          0
                                      ? Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 70.r),
                                          child: Text("No New Orders"),
                                        )
                                      : SingleChildScrollView(
                                          physics:
                                              AlwaysScrollableScrollPhysics(),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10),
                                            height: 0.9.sh,
                                            child: ListView.builder(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 20.r),
                                              itemCount: orderController
                                                  .inProgressPurchaseOrderList
                                                  .length,
                                              shrinkWrap: true,
                                              // physics: AlwaysScrollableScrollPhysics(),
                                              itemBuilder: (context, index) =>
                                                  Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  orderedproductCard(
                                                      orderController
                                                          .inProgressPurchaseOrderList[
                                                              index]
                                                          .orderItem,
                                                      orderController
                                                          .inProgressPurchaseOrderList[
                                                              index]
                                                          .orderItem[0]
                                                          .product
                                                          .id,
                                                      orderController
                                                          .inProgressPurchaseOrderList[
                                                              index]
                                                          .orderItem[0]
                                                          .product
                                                          .name,
                                                      orderController
                                                          .inProgressPurchaseOrderList[
                                                              index]
                                                          .orderItem[0]
                                                          .product
                                                          .descriptions,
                                                      orderController
                                                          .inProgressPurchaseOrderList[
                                                              index]
                                                          .totalAmount,
                                                      ImageUrls.kProduct +
                                                          (orderController
                                                                  .inProgressPurchaseOrderList[
                                                                      index]
                                                                  .orderItem[0]
                                                                  .product
                                                                  .productImage![
                                                                      0]
                                                                  .name ??
                                                              ""),
                                                      orderController
                                                          .inProgressPurchaseOrderList[
                                                              index]
                                                          .orderItem[0]
                                                          .product
                                                          .deliveryType,
                                                      orderController
                                                          .inProgressPurchaseOrderList[
                                                              index]
                                                          .orderItem[0]
                                                          .orderItemStatus,
                                                      "",
                                                      index),
                                                  20.verticalSpace
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                              : widget.isSeller
                                  ? orderController.completedSellerOrderList
                                              .length ==
                                          0
                                      ? Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 70.r),
                                          child: Text("No  Orders Completed"),
                                        )
                                      : ListView.builder(
                                          itemCount: orderController
                                              .completedSellerOrderList.length,
                                          shrinkWrap: true,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 30.r),
                                          scrollDirection: Axis.vertical,
                                          physics: new BouncingScrollPhysics(),
                                          itemBuilder: (context, index) =>
                                              Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              orderedproductCard(
                                                  orderController
                                                          .completedSellerOrderList[
                                                      index],
                                                  orderController
                                                      .completedSellerOrderList[
                                                          index]
                                                      .product![0]
                                                      .id,
                                                  orderController
                                                      .completedSellerOrderList[
                                                          index]
                                                      .product![0]
                                                      .name,
                                                  orderController
                                                      .completedSellerOrderList[
                                                          index]
                                                      .product![0]
                                                      .descriptions,
                                                  "\$${orderController.completedSellerOrderList[index].product![0].price}",
                                                  ImageUrls.kProduct +
                                                      orderController
                                                          .completedSellerOrderList[
                                                              index]
                                                          .product![0]
                                                          .productImage![0]
                                                          .name!,
                                                  orderController
                                                      .completedSellerOrderList[
                                                          index]
                                                      .product![0]
                                                      .deliveryType,
                                                  orderController
                                                      .completedSellerOrderList[
                                                          index]
                                                      .product![0]
                                                      .orderProductStatus,
                                                  orderController
                                                      .completedSellerOrderList[
                                                          index]
                                                      .product![0]
                                                      .orderProductId,
                                                  index),
                                              20.verticalSpace
                                            ],
                                          ),
                                        )
                                  : orderController.completedPurchaseOrderList
                                              .length ==
                                          0
                                      ? Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 70.r),
                                          child: Text("No  Orders Completed"),
                                        )
                                      : ListView.builder(
                                          itemCount: orderController
                                              .completedPurchaseOrderList
                                              .length,
                                          shrinkWrap: true,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 30.r),
                                          scrollDirection: Axis.vertical,
                                          physics: new BouncingScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            // int foundIndex = orderController.completedPurchaseOrderList.value[index].orderItem.indexWhere((element) => element.product.review.==userController.user.id);
                                            // print("index found"+foundIndex.toString());
                                            return Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                orderedproductCard(
                                                    orderController
                                                        .completedPurchaseOrderList[
                                                            index]
                                                        .orderItem,
                                                    orderController
                                                        .completedPurchaseOrderList[
                                                            index]
                                                        .orderItem
                                                        .first
                                                        .product
                                                        .id,
                                                    orderController
                                                        .completedPurchaseOrderList[
                                                            index]
                                                        .orderItem
                                                        .first
                                                        .product
                                                        .name,
                                                    orderController
                                                        .completedPurchaseOrderList[
                                                            index]
                                                        .orderItem
                                                        .first
                                                        .product
                                                        .descriptions,
                                                    orderController
                                                        .completedPurchaseOrderList[
                                                            index]
                                                        .totalAmount,
                                                    ImageUrls.kProduct +
                                                        (orderController
                                                                .completedPurchaseOrderList[
                                                                    index]
                                                                .orderItem
                                                                .first
                                                                .product
                                                                .productImage![
                                                                    0]
                                                                .name ??
                                                            ""),
                                                    "completed",
                                                    orderController
                                                        .completedPurchaseOrderList[
                                                            index]
                                                        .orderItem
                                                        .first
                                                        .orderItemStatus,
                                                    "",
                                                    index),
                                                20.verticalSpace
                                              ],
                                            );
                                          },
                                        ),
                    ],
                  ),
                ),
        );
      }),
    );
  }

  orderedproductCard(
      completeList,
      productID,
      productName,
      productDetailText,
      productPrice,
      productImage,
      productType,
      productState,
      orderProductID,
      index) {
    print("order product ID" + orderProductID.toString());
    return InkWell(
      onTap: () {},
      child: widget.isSeller && orderController.tab.value != 0
          ? Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Row(
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
                            15.verticalSpace,
                            Text(
                              productName,
                              style: TextStyle(
                                  fontSize: 18.sp, fontWeight: FontWeight.w600),
                            ),
                            5.verticalSpace,
                            Row(
                              children: [
                                Text(
                                  "Review (${completeList.product.first.review.isEmpty ? "0.0" : double.parse(completeList.product.first
                                      // .review
                                      .review.first["rating"]).toString()})",
                                  style: GoogleFonts.inter(
                                    color: Colors.black,
                                    fontSize: 12.sp,
                                  ),
                                  overflow: TextOverflow.fade,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 18.sp,
                                ),
                              ],
                            ),
                            5.verticalSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  productPrice,
                                  style: GoogleFonts.inter(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      // index.toString()
                                      "Qty:",
                                      style: GoogleFonts.inter(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      // index.toString()
                                      widget.isSeller
                                          ? completeList
                                              .product[0].orderProductQty
                                              .toString()
                                          : completeList[index]
                                              .prduct[0]
                                              .orderProductQty
                                              .toString(),
                                      style: GoogleFonts.inter(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                                2.horizontalSpace,
                              ],
                            ),
                            5.verticalSpace,
                            SizedBox(
                              width: 100.w,
                              child: InkWell(
                                onTap: () {
                                  if (orderController.tab.value == 1) {
                                    if (mounted) {
                                      // setState(() {
                                      orderController.tab.value = 2;
                                      orderController.changeOrderStatus(
                                          orderProductID, "completed", context);
                                      setState(() {

                                      });
                                      // });
                                    }
                                  } else {
                                    null;
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      orderController.tab.value == 1
                                          ? "In Progress"
                                          : "Completed",
                                      style: GoogleFonts.inter(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                          color: highlightedText,
                                          decoration: TextDecoration.underline),
                                    ),
                                    orderController.tab.value == 2
                                        ? SizedBox()
                                        : Icon(
                                            Icons.expand_more_outlined,
                                            color: kprimaryColor,
                                          )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: Get.width * 0.4,
                        height: 131.h,
                        // decoration: BoxDecoration(
                        //   color: Colors.grey.withOpacity(0.3),
                        //   borderRadius: BorderRadius.only(
                        //       topLeft: Radius.circular(10.r),
                        //       bottomLeft: Radius.circular(10.r)),
                        //   // image: DecorationImage(
                        //   //     image: AssetImage(productImage),
                        //   //     fit: BoxFit.cover),
                        // ),
                        child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10.r),
                              bottomRight: Radius.circular(10.r),
                            ),
                            child: Image.network(
                              productImage,
                              fit: BoxFit.cover,
                            )),
                      ),
                    ],
                  ),
                  // Text(productState),
                  productState.toString().toLowerCase() ==
                              "inprogress".toString() &&
                          orderController
                              .inProgressSellerOrderList.isNotEmpty &&
                          widget.isSeller
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            5.verticalSpace,
                            DottedLine(),
                            10.h.verticalSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Total Amount"),
                                Text(
                                    "\$ ${orderController.inProgressSellerOrderList[index].totalAmount}")
                              ],
                            ),
                            20.h.verticalSpace,
                          ],
                        )
                      : SizedBox(),
                  productState.toString().toLowerCase() ==
                              "completed".toString() &&
                          orderController.completedSellerOrderList.isNotEmpty &&
                          widget.isSeller
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            5.verticalSpace,
                            DottedLine(),
                            10.h.verticalSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Total Amount"),
                                Text(
                                    "\$ ${orderController.completedSellerOrderList[index].totalAmount}")
                              ],
                            ),
                            20.h.verticalSpace,
                          ],
                        )
                      : SizedBox(),
                  5.verticalSpace,
                  ChatWithStoreIcon(
                    isSeller: true,
                    storeUser: completeList.user,
                  ),
                  5.verticalSpace,
                ],
              ),
            )
          : Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: widget.isSeller
                              ? completeList.product.length
                              : completeList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: Get.width * 0.40,
                                      height: 141.h,

                                      // decoration: BoxDecoration(
                                      //   color: Colors.grey.withOpacity(0.3),
                                      //   borderRadius: BorderRadius.only(
                                      //       topLeft: Radius.circular(20.r),
                                      //       bottomLeft: Radius.circular(20.r)),
                                      // image: DecorationImage(
                                      //     image: AssetImage(productImage),
                                      //     fit: BoxFit.cover)
                                      // ),
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15.r),
                                            bottomLeft: Radius.circular(15.r),
                                          ),
                                          child: Image.network(
                                            widget.isSeller
                                                ? ImageUrls.kProduct +
                                                    completeList.product[index]
                                                        .productImage[0].name
                                                        .toString()
                                                : ImageUrls.kProduct +
                                                    completeList[index]
                                                        .product
                                                        .productImage[0]
                                                        .name,
                                            fit: BoxFit.cover,
                                          )),
                                    ),
                                    Container(
                                      height: 180.h,
                                      // color: Colors.orange,
                                      width: Get.width * 0.45,
                                      padding: EdgeInsets.only(
                                          left: 20.r,
                                          right: 10.r,
                                          top: 5.r,
                                          bottom: 5.r),
                                      alignment: Alignment.center,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        // mainAxisSize: MainAxisSize.min,
                                        children: [
                                          // Text(completeList[index]
                                          //     .product
                                          //     .productImage[0].name.toString()),

                                          20.verticalSpace,
                                          SizedBox(
                                            width: 0.25.sw,
                                            child: Text(
                                              widget.isSeller
                                                  ? completeList
                                                      .product[index].name
                                                      .toString()
                                                  : completeList[index]
                                                      .product
                                                      .name,
                                              style: TextStyle(
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.w600),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          10.verticalSpace,
                                          SizedBox(
                                            width: 0.3.sw,
                                            child: Text(
                                              widget.isSeller
                                                  ? completeList.product[index]
                                                      .descriptions
                                                  : completeList[index]
                                                      .product
                                                      .descriptions,
                                              style: GoogleFonts.inter(
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                                fontSize: 12.sp,
                                              ),
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              // overflow: TextOverflow.fade,
                                            ),
                                          ),

                                          Text(
                                            "Qty: ${widget.isSeller ? completeList.product[index].orderProductStatus.toString().toLowerCase() == "new" ? completeList.product[index].orderProductQty.toString() : completeList.product[index].quantity.toString() : completeList[index].quantity}",
                                            // completeList.product[index].orderProductStatus.toString(),
                                            style: GoogleFonts.inter(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black),
                                          ),
                                          // 10.verticalSpace,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                productState
                                                    .toString()
                                                    .capitalize
                                                    .toString(),
                                                style: GoogleFonts.inter(
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: highlightedText,
                                                    decorationColor:
                                                        kprimaryColor,
                                                    decoration: TextDecoration
                                                        .underline),
                                              ),
                                              Text(
                                                "\$ ${widget.isSeller ? completeList.product[index].price : completeList[index].price}",
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
                                  ],
                                ),
                                20.verticalSpace,
                              ],
                            );
                          }),

                      // Text(productState.toString()),
                      // Text(productState.toString()),
                      productState.toString().capitalize ==
                                  "New".toString().capitalize &&
                              orderController.newPurchaseOrderList.isNotEmpty &&
                              !widget.isSeller
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DottedLine(),
                                10.h.verticalSpace,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Total Amount"),
                                    Text(
                                        "\$ ${orderController.newPurchaseOrderList[index].totalAmount}")
                                  ],
                                ),
                                20.h.verticalSpace,
                              ],
                            )
                          : SizedBox(),
                      productState.toString() == "inprogress" &&
                              orderController
                                  .inProgressPurchaseOrderList.isNotEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DottedLine(),
                                10.h.verticalSpace,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Total Amount"),
                                    Text(
                                        "\$ ${orderController.inProgressPurchaseOrderList[index].totalAmount}")
                                  ],
                                ),
                                20.h.verticalSpace,
                              ],
                            )
                          : SizedBox(),
                      productState.toString().capitalize ==
                                  "New".toString().capitalize &&
                              orderController.newSellerOrderList.isNotEmpty &&
                              widget.isSeller
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DottedLine(),
                                10.h.verticalSpace,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Total Amount"),
                                    Text(
                                        "\$ ${orderController.newSellerOrderList[index].totalAmount}")
                                  ],
                                ),
                                20.h.verticalSpace,
                              ],
                            )
                          : SizedBox(),
                      // Text(productState.toString()),

                      // productState.toString() ==
                      //     "completed" && orderController.completedPurchaseOrderList.isNotEmpty
                      //     ? Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     DottedLine(),
                      //     10.h.verticalSpace,
                      //     Row(
                      //       mainAxisAlignment:
                      //       MainAxisAlignment.spaceBetween,
                      //       children: [
                      //         Text("Total Amount"),
                      //         Text(
                      //             "\$ ${orderController.completedPurchaseOrderList[0].totalAmount}")
                      //
                      //       ],
                      //     ),
                      //     20.h.verticalSpace,
                      //   ],
                      // )
                      //     : SizedBox(),
                      (productType == "completed" ||
                              productType == "Received" &&
                                  (orderController.tab.value == 0 ||
                                      orderController.tab.value == 2) &&
                                  widget.isSeller == false)
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    orderController
                                                .completedPurchaseOrderList[
                                                    index]
                                                .orderItem
                                                .first
                                                .reviewStatus ==
                                            true
                                        ? Utils.showSnack(
                                            "Review can be given once only",
                                            context)
                                        :
                                        // reviewController.productIDInstance.value =
                                        ReviewDialog(context, productID);
                                  },
                                  child: Container(
                                    width: Get.width * 0.43,
                                    alignment: Alignment.center,
                                    height: 40.h,
                                    decoration: BoxDecoration(
                                        gradient: orderController
                                                    .completedPurchaseOrderList[
                                                        index]
                                                    .orderItem
                                                    .first
                                                    .reviewStatus ==
                                                true
                                            ? kbtngradientDisabled
                                            : kbtngradient,
                                        borderRadius:
                                            BorderRadius.circular(10.r)),
                                    child: Text(
                                      'Type Review',
                                      style: GoogleFonts.inter(
                                          color: Colors.white, fontSize: 13.sp),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    buyNowModalSheet(
                                        context,
                                        orderController
                                            .completedPurchaseOrderList[index]
                                            .orderItem
                                            .first
                                            .product);
                                  },
                                  child: Container(
                                    width: Get.width * 0.43,
                                    alignment: Alignment.center,
                                    height: 40.h,
                                    decoration: BoxDecoration(
                                        gradient: kgradient,
                                        borderRadius:
                                            BorderRadius.circular(10.r)),
                                    child: Text(
                                      'Buy Again',
                                      style: GoogleFonts.inter(
                                          color: Colors.white, fontSize: 13.sp),
                                    ),
                                  ),
                                )
                              ],
                            )
                          : (productType.toString() == "Delivery") &&
                                  (orderController.tab.value == 1 ||
                                      (orderController.tab.value == 0 &&
                                          widget.isSeller == false))
                              ? SizedBox()
                              : InkWell(
                                  onTap: () {
                                    widget.isSeller
                                        ? orderController.changeOrderStatus(
                                            orderProductID,
                                            "inprogress",
                                            context)
                                        : buyNowModalSheet(
                                            context,
                                            orderController
                                                .newPurchaseOrderList[index]
                                                .orderItem
                                                .first
                                                .product);
                                  },
                                  child: Container(
                                    width: Get.width,
                                    alignment: Alignment.center,
                                    height: 40.h,
                                    decoration: BoxDecoration(
                                        gradient: kbtngradient,
                                        borderRadius:
                                            BorderRadius.circular(10.r)),
                                    child: Text(
                                      widget.isSeller ? "Accept" : "Buy Again",
                                      style: GoogleFonts.inter(
                                          color: Colors.white, fontSize: 13.sp),
                                    ),
                                  ),
                                ),
                      5.verticalSpace,
                      widget.isSeller
                          ? ChatWithStoreIcon(
                              isSeller: true,
                              storeUser: completeList.user,
                            )
                          : ChatWithStoreIcon(
                              storeUser: (productType.toString() ==
                                          "Delivery") &&
                                      (orderController.tab.value == 1 ||
                                          (orderController.tab.value == 0 &&
                                              widget.isSeller == false))
                                  ? orderController
                                      .inProgressPurchaseOrderList[index]
                                      .orderItem
                                      .first
                                      .product
                                      .user
                                  : (productType == "completed" ||
                                          productType == "Received" &&
                                              (orderController.tab.value == 0 ||
                                                  orderController.tab.value ==
                                                      2) &&
                                              widget.isSeller == false)
                                      ? orderController
                                          .completedPurchaseOrderList[index]
                                          .orderItem
                                          .first
                                          .product
                                          .user
                                      : widget.isSeller
                                          ? null
                                          : orderController
                                              .newPurchaseOrderList[index]
                                              .orderItem
                                              .first
                                              .product
                                              .user,
                              isSeller: false,
                            ),
                      5.verticalSpace,
                    ],
                  ),
                ),
                Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: EdgeInsets.all(10.r),
                      decoration: BoxDecoration(
                          gradient: kgradient,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10.r),
                              topRight: Radius.circular(10.r))),
                      child: Text(
                        productType.toString(),
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          color: Colors.white,
                        ),
                      ),
                    )),
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

class ratingController extends GetxController {
  var rating = 5.0.obs;
}
