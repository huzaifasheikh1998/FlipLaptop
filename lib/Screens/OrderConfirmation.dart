import 'dart:developer';

import 'package:app_fliplaptop/Apiserrvices/Services.dart';
import 'package:app_fliplaptop/Apiserrvices/app_url.dart';
import 'package:app_fliplaptop/Controller/orderController.dart';
import 'package:app_fliplaptop/Controller/paymentCardController.dart';
import 'package:app_fliplaptop/Controller/shippingController.dart';
import 'package:app_fliplaptop/components/global.dart';
import 'package:app_fliplaptop/components/textButtonWithLoader.dart';
import 'package:app_fliplaptop/res/utils/utils.dart';
import 'package:app_fliplaptop/widgets/disallow_indicator_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Apiserrvices/loader.dart';

class OrderConfirmation extends StatelessWidget {
  OrderConfirmation({super.key});

  // final OrderController _controller = Get.put(OrderController());
  // final purchaseProductsController controller =
  // Get.put(purchaseProductsController());
  final ShippingController shippingController = Get.put(ShippingController());
  OrderController orderController = Get.put(OrderController());
  final purchaseProductsController controller =
      Get.put(purchaseProductsController());
  final paymentCardController = Get.put(PaymentCardController());
  List cate = [
    'assets/Icon awesome-apple@3x.png',
    'assets/174861@3x.png',
    'assets/Image 19@3x.png',
    'assets/Rectangle 364(2).png'
  ];

  String getDefaultCardImage(String brandName) {
    String imgUrl = "";
    switch (brandName.toLowerCase()) {
      case 'visa':
        imgUrl = cate[2];
        break;
      case 'mastercard':
        imgUrl = cate[3];
        // print('You chose a banana.');
        break;
      case 'paypal':
        imgUrl = cate[1];
        break;
    }
    return imgUrl;
  }

  @override
  Widget build(BuildContext context) {
    // paymentCardController.getAllPaymentCards();
    return Scaffold(
      backgroundColor: kPageBgColor,
      appBar: AppBar(
        // leadingWidth: 30.r,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, gradient: kbtngradient),
                child: SvgPicture.asset(
                  'assets/Path 11.svg',
                  width: 14,
                ))),
        centerTitle: true,
        title: Text(
          'Order Confirmation',
          style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 20.r),
        child: Obx(() {
          return textButtonWithLoader(
            onTap: () {
              if (paymentCardController.cardModelID.value.isEmpty) {
                Utils.showSnack("Select Card", context);
              }
              log("shipping" +
                  shippingController.defaultShippingModel.value.id.toString());
              if (shippingController.defaultShippingModel.value.id.toString() ==
                  "null") {
                Utils.showSnack("Shipping Address Not selected", context);
              } else {
                orderController.createOrder(
                    paymentCardController.cardModelID.value,
                    shippingController.defaultShippingModel.value.id!,
                    ((orderController.totalPrice.value)).toString(),
                    "stripe",
                    orderController.cartList,
                    context);
                print("product id is" +
                    orderController.cartList[0].datum.id.toString());
              }
            },
            width: Get.width,
            height: 59.h,
            buttonText: 'Pay Now',
            isLoading: orderController.isLoading.value,
          );
        }),
      ),
      body: FutureBuilder(
          future: ApiServices().listShippingAddresses(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Loader.spinkit;
            } else if (snapshot.hasError) {
              // log(snapshot.hasError.toString());
              return Text(snapshot.error.toString());
            } else if (snapshot.hasData) {
              return DisAllowIndicatorWidget(
                child: Obx(() {
                  return ListView(
                    padding: EdgeInsets.symmetric(horizontal: 20.r),
                    children: <Widget>[
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: orderController.cartList.length,
                        itemBuilder: (context, index) =>
                            // controller
                            //     .purchaseProduct[index].isSelected
                            //     ?
                            productCard(
                                orderController.cartList[index].datum.name!,
                                orderController
                                    .cartList[index].datum.descriptions!,
                                orderController.cartList[index].datum
                                            .dealItemPrice ==
                                        ""
                                    ? orderController
                                                .cartList[index].datum.discount
                                                .toString() ==
                                            "null"
                                        ? orderController
                                            .cartList[index].datum.price!
                                        : orderController.cartList[index].datum
                                            .discount?.price
                                    : orderController
                                        .cartList[index].datum.dealItemPrice
                                        .toString(),
                                orderController
                                            .cartList[index].datum.productImage
                                            .toString() ==
                                        "[]"
                                    ? ""
                                    : ImageUrls.kProduct +
                                        (orderController.cartList[index].datum
                                                .productImage?[0].name ??
                                            ""),
                                orderController.cartList[index].datum.avg == ""
                                    ? "0"
                                    : orderController.cartList[index].datum.avg
                                        .toString()
                                        .substring(0, 3),
                                orderController.cartList[index].datum.qty,
                                index,
                                context)
                        // :Container()
                        ,
                      ),
                      // Container(
                      //   height: 151.h,
                      //   padding: EdgeInsets.all(10.r),
                      //   decoration: BoxDecoration(
                      //     boxShadow: [
                      //       BoxShadow(
                      //           blurRadius: 20,
                      //           spreadRadius: 1,
                      //           offset: Offset(0, 3),
                      //           color: Color.fromARGB(194, 241, 203, 216)
                      //               .withOpacity(0.07))
                      //     ],
                      //     borderRadius: BorderRadius.circular(10.r),
                      //     color: Colors.white.withOpacity(0.4),
                      //   ),
                      //   child: Row(
                      //     children: [
                      //       Container(
                      //         width: Get.width * 0.4,
                      //         decoration: BoxDecoration(
                      //             color: Colors.grey.withOpacity(0.3),
                      //             borderRadius: BorderRadius.only(
                      //                 topLeft: Radius.circular(10.r),
                      //                 bottomLeft: Radius.circular(10.r)),
                      //             image: DecorationImage(
                      //                 image: AssetImage(
                      //                     'assets/M2-MacBook-Air-2022-Feature0012@3x.png'),
                      //                 fit: BoxFit.fill)),
                      //       ),
                      //       Container(
                      //         width: Get.width * 0.45,
                      //         padding: EdgeInsets.only(
                      //             left: 20.r,
                      //             right: 10.r,
                      //             top: 5.r,
                      //             bottom: 5.r),
                      //         alignment: Alignment.center,
                      //         child: Column(
                      //           crossAxisAlignment:
                      //               CrossAxisAlignment.start,
                      //           mainAxisAlignment:
                      //               MainAxisAlignment.spaceBetween,
                      //           // mainAxisSize: MainAxisSize.min,
                      //           children: [
                      //             Text(
                      //               'MacBook Pro',
                      //               style: TextStyle(
                      //                   fontSize: 18.sp,
                      //                   fontWeight: FontWeight.bold),
                      //             ),
                      //             Text(
                      //               '\$ 15.59',
                      //               style: GoogleFonts.inter(
                      //                   fontSize: 16.sp,
                      //                   fontWeight: FontWeight.w600,
                      //                   color: highlightedText),
                      //             ),
                      //             Text(
                      //               'Lorem ipsum dolor sit amet consectetur adipiscing elit',
                      //               style: GoogleFonts.inter(
                      //                 color: Colors.black.withOpacity(0.5),
                      //                 fontSize: 12.sp,
                      //               ),
                      //               overflow: TextOverflow.fade,
                      //             ),
                      //             Row(
                      //               // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //               children: [
                      //                 InkWell(
                      //                   onTap: () {
                      //                     _controller.minus();
                      //                   },
                      //                   child: Container(
                      //                     alignment: Alignment.topCenter,
                      //                     padding: EdgeInsets.all(9.r),
                      //                     decoration: BoxDecoration(
                      //                       shape: BoxShape.circle,
                      //                       gradient: kbtngradient,
                      //                     ),
                      //                     child: SvgPicture.asset(
                      //                         'assets/Icon awesome-minus.svg'),
                      //                   ),
                      //                 ),
                      //                 10.horizontalSpace,
                      //                 Text(
                      //                   _controller.count.toString(),
                      //                   style: GoogleFonts.dmSans(
                      //                       fontSize: 15.sp,
                      //                       fontWeight: FontWeight.w600),
                      //                 ),
                      //                 14.horizontalSpace,
                      //                 InkWell(
                      //                   onTap: () {
                      //                     _controller.add();
                      //                   },
                      //                   child: Container(
                      //                     alignment: Alignment.topCenter,
                      //                     padding: EdgeInsets.all(5.2.r),
                      //                     decoration: BoxDecoration(
                      //                       shape: BoxShape.circle,
                      //                       gradient: kbtngradient,
                      //                     ),
                      //                     child: SvgPicture.asset(
                      //                       'assets/Icon awesome-plus.svg',
                      //                     ),
                      //                   ),
                      //                 ),
                      //                 Spacer(),
                      //                 Row(
                      //                   mainAxisSize: MainAxisSize.min,
                      //                   children: [
                      //                     SvgPicture.asset(
                      //                       'assets/Icon feather-star.svg',
                      //                       width: 13.r,
                      //                     ),
                      //                     5.horizontalSpace,
                      //                     Text(
                      //                       '(4.9)',
                      //                       style: GoogleFonts.inter(
                      //                           fontWeight: FontWeight.w500,
                      //                           fontSize: 14.sp),
                      //                     ),
                      //                   ],
                      //                 )
                      //               ],
                      //             )
                      //           ],
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      10.verticalSpace,
// Text(orderController.isLoading.value.toString()),
                      Container(
                        padding: EdgeInsets.all(20.r),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 20,
                                spreadRadius: 1,
                                offset: Offset(0, 3),
                                color: Color.fromARGB(194, 241, 203, 216)
                                    .withOpacity(0.07))
                          ],
                          borderRadius: BorderRadius.circular(10.r),
                          color: Colors.white.withOpacity(0.4),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Shipping Address',
                                  style: TextStyle(
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                InkWell(
                                  onTap: () {
                                    // final shippingController =
                                    //     Get.put(ShippingController());
                                    // ApiServices().listShippingAddresses();
                                    Get.toNamed('/ShippingAddressScreen');
                                  },
                                  child: Text(
                                    'Change',
                                    style: TextStyle(
                                        color: highlightedText,
                                        decoration: TextDecoration.underline,
                                        decorationColor: kprimaryColor,
                                        fontSize: 12.sp),
                                  ),
                                )
                              ],
                            ),
                            15.verticalSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'City',
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color: Colors.black.withOpacity(0.5)),
                                ),
                                Text(
                                  shippingController
                                          .defaultShippingModel.value.city ??
                                      "Not Selected",
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color: Colors.black.withOpacity(0.5)),
                                )
                              ],
                            ),
                            10.verticalSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Delivery Address',
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color: Colors.black.withOpacity(0.5)),
                                ),
                                SizedBox(
                                  width: 0.5.sw,
                                  // height: 0.3.sh,
                                  child: Text(
                                    shippingController.defaultShippingModel.value
                                            .addressLine1 ??
                                        "Not Selected",
                                    maxLines: 3,
                                    textAlign: TextAlign.end,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 15.sp,
                                        color: Colors.black.withOpacity(0.5)),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      20.verticalSpace,
                      paymentCardController.completeDataList.isEmpty
                          ? Container(
                              height: 45.h,
                              width: Get.width * 0.9,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: kprimaryColor.withOpacity(0.05),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    15,
                                  ),
                                ),
                                border: Border.all(
                                  color: kprimaryColor.withOpacity(
                                    0.4,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "You don't have any payment method",
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // final shippingController =
                                      //     Get.put(ShippingController());
                                      // ApiServices().listShippingAddresses();
                                      // Get.toNamed('/ShippingAddressScreen');
                                      Get.toNamed('/SelectPaymentMethod');
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(
                                            Icons.add,
                                            color: highlightedText,
                                            size: 13.sp,
                                          ),
                                          Text(
                                            'Add',
                                            style: TextStyle(
                                                color: highlightedText,
                                                decoration:
                                                    TextDecoration.underline,
                                                fontSize: 13.sp),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                Get.toNamed('/SelectPaymentMethod');
                              },
                              child: Container(
                                padding: EdgeInsets.all(20.r),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 20,
                                        spreadRadius: 1,
                                        offset: Offset(0, 3),
                                        color:
                                            Color.fromARGB(194, 241, 203, 216)
                                                .withOpacity(0.07))
                                  ],
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: Color(0xff3B3B3B),
                                ),
                                child: Row(
                                  children: [
                                    10.horizontalSpace,
                                    paymentCardController.defaultCardModel.value
                                                .cardNumber ==
                                            null
                                        ? SizedBox()
                                        : Image.asset(
                                            getDefaultCardImage(
                                                paymentCardController
                                                        .defaultCardModel
                                                        .value
                                                        .brand ??
                                                    ""),
                                            width: 35.r,
                                          ),
                                    40.horizontalSpace,
                                    Text(
                                      paymentCardController.defaultCardModel
                                                  .value.cardNumber ==
                                              null
                                          ? "No Default Card"
                                          :
                                          // paymentCardController.completeDataList.toString(),
                                          '**** **** **** ${paymentCardController.defaultCardModel.value.last4!.isEmpty ? "" : paymentCardController.defaultCardModel.value.last4!}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.white,
                                      size: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                      100.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Price',
                            style: TextStyle(
                                color: highlightedText,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            '\$ ${(orderController.totalPrice.value - orderController.totalTaxAmount.value).toStringAsFixed(2)}',
                            style: TextStyle(
                                color: highlightedText,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      10.verticalSpace,
                      DottedLine(
                        dashColor: Colors.black.withOpacity(0.7),
                        dashGapLength: 1.4,
                        lineThickness: 0.2,
                      ),
                      20.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Tax',
                                style: TextStyle(
                                    color: highlightedText,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                '(${orderController.totalTax.value}%)',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Text(
                            '\$ ${orderController.totalTaxAmount.value.toStringAsFixed(2)}',
                            style: TextStyle(
                                color: highlightedText,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      10.verticalSpace,
                      DottedLine(
                        dashColor: Colors.black.withOpacity(0.7),
                        dashGapLength: 1.4,
                        lineThickness: 0.2,
                      ),
                      20.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: TextStyle(
                                color: highlightedText,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            '\$${orderController.totalPrice.value.toStringAsFixed(2)}',
                            style: TextStyle(
                                color: highlightedText,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      10.verticalSpace,
                      DottedLine(
                        dashColor: Colors.black.withOpacity(0.7),
                        dashGapLength: 1.4,
                        lineThickness: 0.2,
                      ),
                      20.verticalSpace,
                    ],
                  );
                }),
              );
            } else {
              return Center(child: Text(snapshot.error.toString()));
            }
          }),
    );
  }

  Widget productCard(productName, productDetailText, productPrice, productImage,
      productRating, quantity, index, context) {
    // OrderController orderController = Get.put(OrderController());

    return InkWell(
      onTap: () {},
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            // height: 152.h,
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Container(
                  width: Get.width * 0.4,
                  height: 152.h,

                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.r),
                        bottomLeft: Radius.circular(10.r)),
                    // image: DecorationImage(
                    //     image: AssetImage(productImage), fit: BoxFit.fill),
                  ),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: productImage,
                    placeholder: (context, url) => Icon(Icons.image),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                Container(
                  width: Get.width * 0.45,
                  padding: EdgeInsets.only(
                      left: 20.r, right: 10.r, top: 5.r, bottom: 4.r),
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        productName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 17.1.sp, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "\$ $productPrice",
                        style: GoogleFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: highlightedText),
                      ),
                      SizedBox(
                        height: 40.h,
                        child: Text(
                          productDetailText,
                          style: GoogleFonts.inter(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 12.sp,
                          ),
                          overflow: TextOverflow.fade,
                        ),
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              // purchaseProductsController cont = Get.find();
                              // cont.minus(index);
                              if (orderController.cartList[index].quantity >
                                  1) {
                                // setState(() {
                                // isChecked1 = !isChecked1;
                                orderController.cartList[index].quantity =
                                    orderController.cartList[index].quantity -
                                        1;
                                // });
                                print(
                                    "quantity is ${orderController.cartList[index].quantity}");
                              } else {
                                Utils.showSnack(
                                    "Least Quantity Should be 1", context);
                              }
                              orderController
                                  .totalSumOfCartProductsPrices(index);
                            },
                            child: Container(
                              alignment: Alignment.topCenter,
                              padding: EdgeInsets.all(9.r),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: kbtngradient,
                              ),
                              child: SvgPicture.asset(
                                  'assets/Icon awesome-minus.svg'),
                            ),
                          ),
                          10.horizontalSpace,
                          Text(
                            orderController.cartList[index].quantity.toString(),
                            style: GoogleFonts.dmSans(
                                fontSize: 15.sp, fontWeight: FontWeight.w600),
                          ),
                          14.horizontalSpace,
                          InkWell(
                            onTap: () {
                              // setState(() {
                              // isChecked1 = !isChecked1;
                              // cont.add(index);
                              if (orderController.cartList[index].quantity >=
                                  orderController.cartList[index].datum.qty!) {
                                Utils.showFloatingErrorSnack(
                                    "The max items in stock are ${orderController.cartList[index].datum.qty}");
                              } else {
                                orderController.cartList[index].quantity =
                                    orderController.cartList[index].quantity +
                                        1;
                                // });
                                orderController
                                    .totalSumOfCartProductsPrices(index);
                              }
                              // purchaseProductsController cont = Get.find();
                              // cont.add(index);
                            },
                            child: Container(
                              alignment: Alignment.topCenter,
                              padding: EdgeInsets.all(5.2.r),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: kbtngradient,
                              ),
                              child: SvgPicture.asset(
                                'assets/Icon awesome-plus.svg',
                              ),
                            ),
                          ),
                          Spacer(),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                'assets/Icon feather-star.svg',
                                width: 13.r,
                              ),
                              5.horizontalSpace,
                              Text(
                                productRating.toString(),
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
                ),
              ],
            ),
          ),
          // Positioned(
          //     right: 0,
          //     top: 0,
          //     child: InkWell(
          //       onTap: () {
          //         purchaseProductsController cont = Get.find();
          //         cont.productCheck(index);
          //         orderController.cartList.removeAt(index);
          //         orderController.totalSumOfCartProductsPrices(index);
          //       },
          //       child: Container(
          //         padding: EdgeInsets.all(5.r),
          //         decoration: BoxDecoration(
          //             color: Colors.black,
          //             borderRadius: BorderRadius.only(
          //                 bottomLeft: Radius.circular(10.r),
          //                 topRight: Radius.circular(10.r))),
          //         child: Icon(
          //           Icons.close,
          //           color: Colors.white,
          //           size: 20.5.r,
          //         ),
          //       ),
          //     )),
        ],
      ),
    );
  }
}
