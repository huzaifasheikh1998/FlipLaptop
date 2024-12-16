import 'dart:developer';

import 'package:app_fliplaptop/Controller/dashBoardController.dart';
import 'package:app_fliplaptop/Controller/orderController.dart';
import 'package:app_fliplaptop/Controller/productController.dart';
import 'package:app_fliplaptop/Screens/ReviewProductScreen.dart';
import 'package:app_fliplaptop/components/global.dart';
import 'package:app_fliplaptop/models/dashBoardModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MoreProductCard extends StatelessWidget {
  const MoreProductCard(
      {super.key,
      required this.index,
      required this.storeCompleteData,
      required this.storeID,
      required this.brand,
      required this.rating,
      required this.price,
      required this.dealPrice,
      required this.dealItemStartDatetime,
      required this.dealItemEndDatetime,
      required this.dealItemPercentage,
      required this.img,
      required this.condition,
      this.discount,
      required this.description,
      required this.storeImage,
      required this.postedUserData});

  final int index;
  final Store storeCompleteData;
  final int storeID;
  final String brand;
  final String rating;
  final String price;
  final String dealPrice;
  final String dealItemStartDatetime;
  final String dealItemEndDatetime;
  final String dealItemPercentage;
  final String img;
  final String condition;
  final Discount? discount;
  final String description;
  final String storeImage;
  final User postedUserData;

  @override
  Widget build(BuildContext context) {
    log("discount price is"+dealPrice.toString());
    final productController = Get.put(ProductController());
    final dashBoardController = Get.put(DashBoardController());
    final orderController = Get.put(OrderController());
    return InkWell(
      onTap: () {
        print("storecompelte data is ${storeCompleteData.name}");
        final productController = Get.put(ProductController());

        orderController.datumInstance.value =
            dashBoardController.moreProductList.value[index];
        productController.editDatumInstance.value =
            dashBoardController.moreProductList.value[index];

        // var productID  = orderController.datumInstance.value.id;
        // for (var i in wishListController.ishListCompleteData.value.data!) {
        //   // result = true;
        //   print(i.id.toString());
        //   print(orderController.datumInstance.value.id);
        //   if (i.id.toString() == orderController.datumInstance.value.id) {
        //
        //     print("===============> true");
        //     // return true;
        //   } else {
        //     // result = false;
        //     print("===============> false");
        //   }
        // }
        // orderController.totalPrice.value + dashBoardController
        //     .moreProduct.value.data![index].price!;
        Get.to(() => ReviewProductScreen(
          index: index,
          storeID: storeID,
          ownProduct: false,
          productData: {
            "name": brand,
            "rating": rating,
            "price": price,
            "dealPrice": "\$ ${dealPrice}",
            "dealItemStartDatetime": dealItemStartDatetime,
            "dealItemEndDatetime": dealItemEndDatetime,
            "dealItemPercentage":dealItemPercentage,
            "image": img,
            "condition": condition,
            "discount": discount,
            "description": description
          },
          // storeName: storeCompleteDat,
          storeProfile: storeImage,
          storeData: storeCompleteData,
          postedUserData: postedUserData,
            ));
        print(orderController.datumInstance.value.name);
      },
      child: Container(
        // width: Get.width * 0.45,

        padding: EdgeInsets.all(9.r),
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10.r)),
        child: Stack(
          children: [
            Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Text(dashBoardController.moreProduct.value
                //     .data![index].productImage![0].name.toString(),style: TextStyle(fontSize: 30.sp),),
                // dashBoardController.moreProduct.value.data == null
                Container(
                  // width: Get.width* 0.5,
                  // height: 139.r,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: ClipRRect(
                    clipBehavior: Clip.hardEdge,
                    borderRadius: BorderRadius.circular(10.r),
                    child: Center(
                      child: SizedBox(
                        height: 0.14.sh,
                        width: 0.4.sw,
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: img == ""
                              ? "https://fliplaptop.thesuitchstaging.com/assets/images/store/profile/1689949591213.jpg"
                              : img,
                          placeholder: (context, url) => Icon(Icons.image),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                ),
                10.verticalSpace,
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 135.w,
                            child: Text(
                              brand,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 18.sp, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              gradient: kgradient,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10.r),
                                  topRight: Radius.circular(10.r)),
                            ),
                            child: Text(
                              index % 2 == 0 ? 'New' : 'Used',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10.sp),
                            ),
                          )
                        ],
                      ),
                      3.verticalSpace,
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Reviews (${rating!="0"?rating.toString().substring(0,3):rating})",
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
                      Row(
                        children: [
                          Text(
                            price,
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              fontSize: dealPrice!=''|| discount!=null?12.sp:14.sp,
                              color: dealPrice!=''|| discount!=null?Colors.grey:Colors.black,
                              decoration: dealPrice!=''|| discount!=null?TextDecoration.lineThrough:null,
                            ),
                          ),
                          Visibility(
                            visible: dealPrice!='',
                            child: Row(
                              children: [
                                5.w.horizontalSpace,
                                Text(
                                  "\$$dealPrice",
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.sp,
                                    color: Colors.black,
                                    // decoration: dealPrice!='\$ '?TextDecoration.lineThrough:null,
                                  ),
                                ),
                                // Padding(
                                //   padding:  EdgeInsets.only(bottom: 0.004.sh),
                                //   child: SvgPicture.asset("assets/hotDealIcon.svg",width: 0.14.sw,),
                                // )
                              ],
                            ),
                          ),
                          // Text(data)
                          discount==null ?SizedBox():
                          dealPrice==''?Row(
                            children: [
                              5.w.horizontalSpace,
                              Text("\$${discount!.price.toString()}",  style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.sp,
                                  // decoration: TextDecoration.lineThrough,
                                  color: Colors.black
                              ),),
                            ],
                          ):SizedBox()

                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            dealPrice != ''
                ? Positioned(
                top: 6,
                right: 6,
                child: SvgPicture.asset(
                  "assets/hotDealIcon.svg",
                  height: 0.045.sh,
                ))
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
