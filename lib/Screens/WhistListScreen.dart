import 'package:app_fliplaptop/Apiserrvices/app_url.dart';
import 'package:app_fliplaptop/Apiserrvices/loader.dart';
import 'package:app_fliplaptop/Controller/wishListController.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/global.dart';

class MyWishlistScreen extends StatelessWidget {
  MyWishlistScreen({super.key});

  final purchaseProductsController controller =
      Get.put(purchaseProductsController());
  WishListController wishListController = Get.put(WishListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Wishlist',
          style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 10.r),
        children: [
          Obx(() {
            return wishListController.isLoading.value
                ? Center(
                    child: Loader.spinkit,
                  )
                : wishListController.wishListCompleteData.value.data!.isEmpty
                    ? Center(
                        child: Text("No Items in Wishlist"),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: wishListController
                            .wishListCompleteData.value.data!.length,
                        itemBuilder: (context, index) => Column(
                          children: [
                            productCard(
                              wishListController
                                  .wishListCompleteData.value.data![index].name,
                              wishListController.wishListCompleteData.value
                                  .data![index].descriptions,
                              wishListController
                                  .wishListCompleteData.value.data![index].price
                                  .toString(),
                              wishListController.wishListCompleteData.value
                                      .data![index].productImage!.isEmpty
                                  ? ""
                                  : ImageUrls.kProduct +
                                      wishListController
                                          .wishListCompleteData
                                          .value
                                          .data![index]
                                          .productImage![0]
                                          .name!,
                              // controller.purchaseProduct[index].productRating!,
                              "0.0",
                              wishListController
                                  .wishListCompleteData.value.data![index].qty,
                              index,
                            ),
                            15.h.verticalSpace,
                          ],
                        ),
                        // controller
                        //         .purchaseProduct[index].isSelected
                        //     ?
                      );
          }),
          // Text(
          //   "0.0",
          //   style: TextStyle(color: Colors.black),
          // ),
        ],
      ),
    );
  }

  productCard(productName, productDetailText, productPrice, productImage,
      productRating, quatity, index) {
    return InkWell(
      onTap: () {},
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: 151.h,
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: [
                BoxShadow(
                  offset: Offset(2.r, 4.r),
                  color: Colors.grey.withOpacity(.5.r),
                  blurRadius: 10.r,
                ),
              ],
              color: Colors.white,
            ),
            child: Row(
              children: [
                Container(
                  width: Get.width * 0.4,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.r),
                        bottomLeft: Radius.circular(10.r)),
                    // image: DecorationImage(
                    //     image: AssetImage(productImage), fit: BoxFit.fill),
                  ),
                  child: Stack(
                    // clipBehavior: Clip.hardEdge,
                    children: [
                      CachedNetworkImage(
                        width: 180.w,
                        fit: BoxFit.fill,
                        imageUrl: productImage,
                        placeholder: (context, url) => Icon(Icons.image),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      wishListController.wishListCompleteData.value.data![index]
                                  .dealItemPrice !=
                              ''
                          ? SvgPicture.asset(
                              "assets/hotDealIcon.svg",
                              height: 0.045.sh,
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
                Container(
                  // width: Get.width * 0.,
                  padding: EdgeInsets.only(
                      left: 10.r, right: 10.r, top: 5.r, bottom: 5.r),
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: Get.width * 0.4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Text(
                              productName,
                              style: TextStyle(
                                  fontSize: 18.sp, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            // Text(iteration.dealItemPrice.toString()),
                            Text(
                              "\$${wishListController.wishListCompleteData.value.data![index].price.toString()}",
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.sp,
                                  decoration: wishListController
                                                  .wishListCompleteData
                                                  .value
                                                  .data![index]
                                                  .dealItemPrice !=
                                              '' ||
                                          wishListController
                                                  .wishListCompleteData
                                                  .value
                                                  .data![index]
                                                  .discount !=
                                              null
                                      ? TextDecoration.lineThrough
                                      : null,
                                  color: wishListController
                                                  .wishListCompleteData
                                                  .value
                                                  .data![index]
                                                  .dealItemPrice !=
                                              '' ||
                                          wishListController
                                                  .wishListCompleteData
                                                  .value
                                                  .data![index]
                                                  .discount !=
                                              null
                                      ? Colors.grey
                                      : Colors.black),
                            ),
                            Visibility(
                              visible: wishListController.wishListCompleteData
                                      .value.data![index].dealItemPrice !=
                                  '',
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  6.w.horizontalSpace,
                                  Text(
                                    "\$${wishListController.wishListCompleteData.value.data![index].dealItemPrice}",
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
                            wishListController.wishListCompleteData.value
                                            .data![index].discount ==
                                        null ||
                                    wishListController.wishListCompleteData
                                            .value.data![index].dealItemPrice !=
                                        ''
                                ? SizedBox()
                                : Row(
                                    children: [
                                      10.w.horizontalSpace,
                                      Text(
                                        "\$${wishListController.wishListCompleteData.value.data![index].discount.price.toString()}",
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

                        SizedBox(
                          height: 30.h,
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
                          children: [
                            Text("Reviews", style: TextStyle(fontSize: 10.h)),
                            5.w.horizontalSpace,
                            Text(
                              wishListController.wishListCompleteData.value
                                          .data![index].avg ==
                                      ""
                                  ? "(0.0)"
                                  : "(${wishListController.wishListCompleteData.value.data![index].avg.toString().substring(0, 3)})",
                              style: TextStyle(fontSize: 10.h),
                            ),
                            2.w.horizontalSpace,
                            Icon(
                              Icons.star,
                              size: 12.r,
                              color: Colors.amber,
                            )
                          ],
                        )
                        // Row(
                        //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     InkWell(
                        //       onTap: () {
                        //         purchaseProductsController cont = Get.find();
                        //         cont.minus(index);
                        //       },
                        //       child: Container(
                        //         alignment: Alignment.topCenter,
                        //         padding: EdgeInsets.all(9.r),
                        //         decoration: BoxDecoration(
                        //           shape: BoxShape.circle,
                        //           gradient: kbtngradient,
                        //         ),
                        //         child: SvgPicture.asset(
                        //             'assets/Icon awesome-minus.svg'),
                        //       ),
                        //     ),
                        //     10.horizontalSpace,
                        //     Text(
                        //       quatity.toString(),
                        //       style: GoogleFonts.dmSans(
                        //           fontSize: 15.sp, fontWeight: FontWeight.w600),
                        //     ),
                        //     14.horizontalSpace,
                        //     InkWell(
                        //       onTap: () {
                        //         purchaseProductsController cont = Get.find();
                        //         cont.add(index);
                        //       },
                        //       child: Container(
                        //         alignment: Alignment.topCenter,
                        //         padding: EdgeInsets.all(5.2.r),
                        //         decoration: BoxDecoration(
                        //           shape: BoxShape.circle,
                        //           gradient: kbtngradient,
                        //         ),
                        //         child: SvgPicture.asset(
                        //           'assets/Icon awesome-plus.svg',
                        //         ),
                        //       ),
                        //     ),
                        //     Spacer(),
                        //     Row(
                        //       mainAxisSize: MainAxisSize.min,
                        //       children: [
                        //         SvgPicture.asset(
                        //           'assets/Icon feather-star.svg',
                        //           width: 13.r,
                        //         ),
                        //         5.horizontalSpace,
                        //         Text(
                        //           productRating,
                        //           style: GoogleFonts.inter(
                        //               fontWeight: FontWeight.w500, fontSize: 14.sp),
                        //         ),
                        //       ],
                        //     )
                        //   ],
                        // )
                      ],
                    ),
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
                // purchaseProductsController cont = Get.find();
                // cont.productCheck(index);
                String currentProductID = wishListController
                    .wishListCompleteData.value.data![index].id
                    .toString();
                wishListController.removeWishList(currentProductID);
                // removeWishList;
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
            ),
          ),
        ],
      ),
    );
  }
}
