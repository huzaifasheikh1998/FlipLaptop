import 'dart:developer';

import 'package:app_fliplaptop/Apiserrvices/Services.dart';
import 'package:app_fliplaptop/Apiserrvices/app_url.dart';
import 'package:app_fliplaptop/Controller/productController.dart';
import 'package:app_fliplaptop/Screens/ListOfProduct.dart';
import 'package:app_fliplaptop/Screens/ReviewProductScreen.dart';
import 'package:app_fliplaptop/components/global.dart';
import 'package:app_fliplaptop/models/dashBoardModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MyStoreNewArrivalProductList extends StatelessWidget {
  final String storeID;

  const MyStoreNewArrivalProductList({super.key, required this.storeID});

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.put(ProductController());

    return Obx(
      () =>
          // productController
          //             .productListingDataList.isEmpty
          //
          //     ? Center(
          //         child: Text("No Listed Products!"),
          //       )
          //     :
          Column(
        children: [
          20.verticalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'New Arrivals',
                style: GoogleFonts.inter(
                    fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
              4.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Top products incredible price',
                    style: GoogleFonts.inter(
                        color: Colors.black.withOpacity(0.5), fontSize: 14.sp),
                  ),
                  10.verticalSpace,
                  productController.productListingDataList.first.data!.length >
                          2
                      ? InkWell(
                          onTap: () {
                            Get.to(() => ListOfProductScreen(
                                  storeId: storeID,
                                  storeProfile: "",
                                  storeName: '',
                                ));
                          },
                          child: Text(
                            'View More',
                            style: GoogleFonts.inter(
                                fontSize: 14.sp,
                                decoration: TextDecoration.underline,
                                decorationColor:
                                    Color(0xffC20000).withOpacity(0.5),
                                color: Color(0xffC20000).withOpacity(0.5)),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            ],
          ),
          15.verticalSpace,
          SingleChildScrollView(
            // physics: BouncingScrollPhysics(),
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 10.r),

              // if the product are greater than 2 then we will show only two items
              // and show "View More" text.
              itemCount: productController
                          .productListingDataList.first.data!.length >
                      2
                  ? 2
                  : productController.productListingDataList.first.data!.length,
              itemBuilder: (context, index) {
                final iteration =
                    productController.productListingDataList.first.data![index];
                // var abc = productController
                //     .productListingDataList.first.data![index].productImage;
                productController.myProductImageList.value = productController
                    .productListingDataList.first.data![index].productImage!;

                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                        // if()

                        // if (dashBoardController.newArrival.value.data!.isNotEmpty) {
                        //   orderController.datumInstance.value =
                        //   dashBoardController.newArrival.value.data![index];
                        //   // productController.editDatumInstance.value =
                        //   // dashBoardController.newArrival.value.data![index];
                        //
                        //   if (!isStoreProfile) {
                        //     productController.editDatumInstance.value =
                        //     dashBoardController.newArrival.value.data![index];
                        //   }
                        //   // if(storeID == ApiServices.storeId) {
                        productController.editDatumInstance.value =
                            productController
                                .productListingDataList.first.data![index];
                        productController.myProductImageList.value =
                            productController.productListingDataList.first
                                .data![index].productImage!;
                        //   // }
                        // }
                        log(productController.editDatumInstance.value.name
                            .toString());
                        // print("storecompelte data is $storeCompleteData");
                        Get.to(() => ReviewProductScreen(
                              index: index,
                              storeID: int.parse(ApiServices.storeId),
                              ownProduct: false,
                              productData: {
                                "name": iteration.name,
                                "rating": iteration.avg == ""
                                    ? "0"
                                    : iteration.avg.toString().substring(0, 3),
                                "price": "\$ ${iteration.price.toString()}",
                                "dealPrice":
                                    "\$ ${iteration.dealItemPrice.toString()}",
                                "dealItemStartDatetime":
                                    iteration.dealItemStartDatetime.toString(),
                                "dealItemEndDatetime":
                                    iteration.dealItemEndDatetime.toString(),
                                "dealItemPercentage":
                                    iteration.dealItemPercentage.toString(),
                                "image": ImageUrls.kProduct +
                                    iteration.productImage!.first.name
                                        .toString(),
                                "condition": iteration.conditionType.toString(),
                                "discount": iteration.discount,
                                "description": iteration.descriptions
                              },
                              // storeName: storeCompleteDat,
                              storeProfile: iteration.storeImage,
                              storeData: Store(
                                id: iteration.storeId,
                                image: iteration.storeImage,
                                name: iteration.storeName,
                              ),
                              postedUserData: iteration.user,
                            ));
                      },
                      child: Column(
                        children: [
                          Container(
                            width: Get.width,
                            padding: EdgeInsets.all(10.r),
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10.r)),
                            child: Stack(
                              children: [
                                Positioned(
                                    top: 0,
                                    left: 6,
                                    child: Container(
                                      padding: EdgeInsets.all(4.0),
                                      decoration: BoxDecoration(
                                        gradient: kgradient,
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(10.r),
                                            topRight: Radius.circular(10.r)),
                                      ),
                                      child: Text(
                                        iteration.conditionType.toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10.sp),
                                      ),
                                    )),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 19.r, horizontal: 10.r),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        // mainAxisSize: MainAxisSize.min,
                                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          8.verticalSpace,
                                          SizedBox(
                                            width: 0.3.sw,
                                            child: Text(
                                              iteration.name.toString(),
                                              style: TextStyle(
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.bold),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          3.verticalSpace,
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "Reviews(${iteration.avg == "" ? "0" : iteration.avg.toString().substring(0, 3)})",
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
                                          3.verticalSpace,
                                          Row(
                                            children: [
                                              // Text(iteration.dealItemPrice.toString()),
                                              Text(
                                                "\$${iteration.price.toString()}",
                                                style: GoogleFonts.inter(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14.sp,
                                                    decoration: iteration
                                                                    .dealItemPrice !=
                                                                '' ||
                                                            iteration
                                                                    .discount !=
                                                                null
                                                        ? TextDecoration
                                                            .lineThrough
                                                        : null,
                                                    color: iteration.dealItemPrice !=
                                                                '' ||
                                                            iteration
                                                                    .discount !=
                                                                null
                                                        ? Colors.grey
                                                        : Colors.black),
                                              ),
                                              Visibility(
                                                visible:
                                                    iteration.dealItemPrice !=
                                                        '',
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  // mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    6.w.horizontalSpace,
                                                    Text(
                                                      "\$${iteration.dealItemPrice}",
                                                      style: GoogleFonts.inter(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14.sp,
                                                          // decoration: TextDecoration.lineThrough,
                                                          color: Colors.black),
                                                    ),
                                                    5.w.horizontalSpace,
                                                    // SizedBox(width: 0.05.w,),
                                                  ],
                                                ),
                                              ),
                                              iteration.discount == null ||
                                                      iteration.dealItemPrice !=
                                                          ''
                                                  ? SizedBox()
                                                  : Row(
                                                      children: [
                                                        10.w.horizontalSpace,
                                                        Text(
                                                          "\$${iteration.discount!.price.toString()}",
                                                          style:
                                                              GoogleFonts.inter(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize:
                                                                      14.sp,
                                                                  // decoration: TextDecoration.lineThrough,
                                                                  color: Colors
                                                                      .black),
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
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        // image: DecorationImage(
                                        //   image: AssetImage(img),
                                        //   fit: BoxFit.fill,
                                        // ),
                                      ),
                                      child: ClipRRect(
                                        clipBehavior: Clip.hardEdge,
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        child: CachedNetworkImage(
                                          fit: BoxFit.fitWidth,
                                          imageUrl: iteration
                                                  .productImage!.isEmpty
                                              ? "https://fliplaptop.thesuitchstaging.com/assets/images/store/profile/1689949591213.jpg"
                                              : ImageUrls.kProduct +
                                                      iteration.productImage!
                                                          .first.name
                                                          .toString() ??
                                                  "",
                                          placeholder: (context, url) =>
                                              Icon(Icons.image),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                iteration.dealItemPrice != ''
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
                          12.verticalSpace,
                        ],
                      ),
                    )
                    // NewArrivalCard(
                    //   index: index,
                    //   storeCompleteData: Store(
                    //       id: iteration.storeId,
                    //       name: iteration.storeName,
                    //       image: iteration.storeImage),
                    //   storeID: iteration.storeId!,
                    //   brand: iteration.name ?? "",
                    //   rating: "${iteration.avg == "" ? 0 : iteration.avg}",
                    //   price: "\$ ${iteration.price.toString()}",
                    //   // dealPrice: "\$ ${iteration.price.toString()}",
                    //   img: iteration.productImage!.isEmpty
                    //       ? ""
                    //       : ImageUrls.kProduct +
                    //           (iteration.productImage![0].name ?? ""),
                    //   condition: iteration.conditionType ?? "",
                    //   discount: iteration.discount,
                    //   description: iteration.descriptions ?? "",
                    //   storeImage: iteration.storeImage ?? "",
                    //   postedUserData: iteration.user!,
                    //   dealPrice: "${iteration.dealItemPrice.toString()}" ?? "",
                    //   dealItemStartDatetime:
                    //       iteration.dealItemStartDatetime.toString(),
                    //   dealItemEndDatetime:
                    //       iteration.dealItemEndDatetime.toString(),
                    //   dealItemPercentage:
                    //       iteration.dealItemPercentage.toString(),
                    //   isStoreProfile: false,
                    // ),
                    ,
                    10.verticalSpace
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
