import 'dart:convert';
import 'dart:developer';

import 'package:app_fliplaptop/Apiserrvices/app_url.dart';
import 'package:app_fliplaptop/Apiserrvices/localStorage.dart';
import 'package:app_fliplaptop/Controller/orderController.dart';
import 'package:app_fliplaptop/res/utils/utils.dart';
import 'package:app_fliplaptop/widgets/disallow_indicator_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/global.dart';

class MyCartScreen extends StatelessWidget {
  MyCartScreen({super.key});

  final purchaseProductsController controller =
      Get.put(purchaseProductsController());

  // int _value = 0;
  OrderController orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: orderController,
        builder: (ctr) {
          return Obx(() {
            return Scaffold(
                appBar: AppBar(
                    // leadingWidth: 30.r,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    leading: IconButton(
                        onPressed: () {
                          final bottomcontroller = Get.put(BottomController());
                          bottomcontroller.navBarChange(0);
                          Get.toNamed('/StartAppScreen');
                        },
                        icon: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, gradient: kbtngradient),
                            child: SvgPicture.asset(
                              'assets/Path 11.svg',
                              width: 14,
                            ))),
                    centerTitle: true,
                    title: RichText(
                      text: TextSpan(
                        style: GoogleFonts.inter(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'My Cart (',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: '${orderController.cartList.length}',
                              style: TextStyle(color: highlightedText)),
                          TextSpan(
                              text: ')',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    )
                    // title: Text(
                    //   'My Cart (${controller.purchaseProduct.length})',
                    // style: GoogleFonts.inter(
                    //     fontSize: 20.sp,
                    //     fontWeight: FontWeight.bold,
                    //     color: Colors.black),
                    // ),
                    ),
                body: DisAllowIndicatorWidget(
                  child: orderController.cartList.length == 0
                      ? Center(
                          child: Text(
                            "No Product in Cart",
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      : ListView(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.r, vertical: 10.r),
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: orderController.cartList.length,
                              itemBuilder: (context, index) =>
                                  // controller
                                  //     .purchaseProduct[index].isSelected
                                  //     ?
                                  productCard(
                                      orderController
                                          .cartList[index].datum.name!,
                                      orderController
                                          .cartList[index].datum.descriptions!,
                                      orderController.cartList[index].datum
                                                  .dealItemPrice ==
                                              ""
                                          ? orderController.cartList[index]
                                                      .datum.discount
                                                      .toString() ==
                                                  "null"
                                              ? orderController
                                                  .cartList[index].datum.price!
                                              : orderController.cartList[index]
                                                  .datum.discount?.price
                                          : orderController.cartList[index]
                                              .datum.dealItemPrice
                                              .toString(),
                                      orderController.cartList[index].datum
                                                  .productImage
                                                  .toString() ==
                                              "[]"
                                          ? ""
                                          : ImageUrls.kProduct +
                                              (orderController
                                                      .cartList[index]
                                                      .datum
                                                      .productImage![0]
                                                      .name ??
                                                  ""),
                                      orderController.cartList[index].datum.avg == ""
                                          ? "0"
                                          : orderController.cartList[index].datum.avg
                                              .toString()
                                              .substring(0, 3),
                                      controller.purchaseProduct[index].Quantity.value,
                                      index,
                                      context)
                              // :Container()
                              ,
                            ),
                            // 123.verticalSpace,
                            //                 RadioListTile(
                            //     title: Text("All", style: GoogleFonts.inter(
                            //       color: Color(0xff667080)
                            //     ),),
                            //     value: "male",
                            //     selected: true,
                            //     activeColor: kprimaryColor,
                            //     =
                            //     groupValue: "male",
                            //     onChanged: (value){

                            //     },

                            // )
                            10.horizontalSpace,
                          ],
                        ),
                ),
                bottomNavigationBar: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30.sp,
                    vertical: 20.sp,
                  ),
                  child: button(0.8.sw, 59.h, "Checkout", () {
                    if (orderController.cartList.isEmpty) {
                      Utils.showSnack(
                          "Add Items in cart to Checkout!", context);
                    } else {
                      Get.toNamed('/OrderConfirmationScreen');
                      orderController.totalSumOfCartProductsPrices(0);
                    }
                    // orderController.cartList[0].qty=0;
                    // print(orderController.cartList[0].qty);
                    // print(orderController.cartList[1].qty);
                    // for (var i = 0;
                    //     i < orderController.cartList.length;
                    //     i++) {
                    //   orderController.totalSumOfAmounts(i);
                    //   orderController.cartList[0].qty;
                    // }
                  }),
                ));
          });
        });
  }
}

productCard(productName, productDetailText, productPrice, productImage,
    productRating, quantity, index, context) {
  OrderController orderController = Get.put(OrderController());

  return InkWell(
    onTap: () {},
    child: Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          // height: 151.h,
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: Colors.white,
          ),
          child: Row(
            children: [
              Container(
                height: 151.h,
                width: Get.width * 0.4,
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
                    left: 20.r, right: 10.r, top: 5.r, bottom: 5.r),
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      productName,
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "\$ $productPrice",
                      style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: highlightedText),
                    ),
                    SizedBox(
                      height: 55.h,
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
                            if (orderController.cartList[index].quantity > 1) {
                              orderController.cartList[index].quantity =
                                  orderController.cartList[index].quantity - 1;
                              print(
                                  "quantity is ${orderController.cartList[index].quantity}");
                            } else {
                              Utils.showSnack(
                                  "Least Item should be 1", context);
                            }

                            orderController.totalSumOfCartProductsPrices(index);
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
                            log("stock qty is " +
                                orderController.cartList[index].datum.qty
                                    .toString());
                            // purchaseProductsController cont = Get.find();
                            // cont.add(index);
                            if (orderController.cartList[index].quantity >=
                                orderController.cartList[index].datum.qty!) {
                              Utils.showFloatingErrorSnack(
                                  "The max items in stock are ${orderController.cartList[index].datum.qty}");
                            } else {
                              orderController.cartList[index].quantity =
                                  orderController.cartList[index].quantity + 1;
                              // orderController.count.value++;
                              orderController
                                  .totalSumOfCartProductsPrices(index);
                            }
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
                                  fontWeight: FontWeight.w500, fontSize: 14.sp),
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
        Positioned(
            right: 0,
            top: 0,
            child: InkWell(
              onTap: () {
                purchaseProductsController cont = Get.find();
                cont.productCheck(index);
                orderController.cartList.removeAt(index);

                /// saving the cart list to local storage
                LocalStorage.saveJson(
                  key: LocalStorageKeys.cartList,
                  value: jsonEncode(
                    orderController.cartList,
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(5.r),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.r),
                        topRight: Radius.circular(10.r))),
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 20.5.r,
                ),
              ),
            )),
      ],
    ),
  );
}

// class products {
//   String? productName;
//   String? productDetailtext;
//   String? productPrice;
//   String? productRating;
//   String? productImage;
//   int? Quantity = 1;
//   bool isSelected = true;

//   products(this.productName, this.productDetailtext, this.productPrice,
//       this.productImage, this.productRating);
// }

// class purchaseProductsController extends GetxController {
//   var chk = false.obs;
//   var purchaseProduct = [
//     products(
//         'MacBook Pro',
//         'Lorem ipsum dolor sit amet consectetur adipiscing elit',
//         '\$ 15.59',
//         'assets/M2-MacBook-Air-2022-Feature0012.png',
//         '(4.9)'),
//     products(
//         'Apple Mac Book',
//         'Lorem ipsum dolor sit amet consectetur adipiscing elit',
//         '\$ 15.59',
//         'assets/andras-vas-Bd7gNnWJBkU-unsplash.png',
//         '(4.9)'),
//     products(
//         'Dell Laptop',
//         'Lorem ipsum dolor sit amet consectetur adipiscing elit',
//         '\$ 15.59',
//         'assets/M2-MacBook-Air-2022-Feature0012(2).png',
//         '(4.9)'),
//     products(
//         'MacBook Pro',
//         'Lorem ipsum dolor sit amet consectetur adipiscing elit',
//         '\$ 15.59',
//         'assets/alex-knight-j4uuKnN43_M-unsplash.png',
//         '(4.9)'),
//     products(
//         'MacBook Pro',
//         'Lorem ipsum dolor sit amet consectetur adipiscing elit',
//         '\$ 15.59',
//         'assets/maxim-hopman-Hin-rzhOdWs-unsplash.png',
//         '(4.9)'),
//     products(
//         'MacBook Pro',
//         'Lorem ipsum dolor sit amet consectetur adipiscing elit',
//         '\$ 15.59',
//         'assets/andras-vas-Bd7gNnWJBkU-unsplash.png',
//         '(4.9)'),
//   ].obs;

//   productCheck(index) {
//     purchaseProduct[index].isSelected = !(purchaseProduct[index].isSelected);
//     update();
//   }

//   add(index) {
//     purchaseProduct[index].Quantity = purchaseProduct[index].Quantity! + 1;
//     update();
//   }

//   minus(index) {
//     if (purchaseProduct[index].Quantity! != 0) {
//       purchaseProduct[index].Quantity = purchaseProduct[index].Quantity! - 1;
//     }
//     update();
//   }

//   checkAll() {
//     if (chk.value == false)
//       chk.value = true;
//     else
//       chk.value = false;

//     update();
//   }
// }
