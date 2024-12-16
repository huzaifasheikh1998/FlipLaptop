// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:app_fliplaptop/Apiserrvices/Services.dart';
import 'package:app_fliplaptop/Apiserrvices/app_url.dart';
import 'package:app_fliplaptop/Apiserrvices/loader.dart';
import 'package:app_fliplaptop/Controller/dashBoardController.dart';
import 'package:app_fliplaptop/Controller/orderController.dart';
import 'package:app_fliplaptop/Screens/ReviewProductScreen.dart';
import 'package:app_fliplaptop/models/dashBoardModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Controller/productController.dart';
import '../components/global.dart';
import 'editProductScreen.dart';

class ListOfProductScreen extends StatefulWidget {
  String storeId;
  String storeProfile;
  String storeName;

  ListOfProductScreen(
      {super.key,
      required this.storeId,
      required this.storeProfile,
      required this.storeName});

  @override
  State<ListOfProductScreen> createState() => _ListOfProductScreenState();
}

// List productList = [
//   products('Apple', 'MacBook Pro', 'Only 1 left in stock',
//       'assets/M2-MacBook-Air-2022-Feature0012.png', '1'),
//   products('Apple', 'MacBook Pro', 'Only 1 left in stock',
//       'assets/andras-vas-Bd7gNnWJBkU-unsplash.png', '1'),
//   products('Apple', 'MacBook Pro', 'Only 1 left in stock',
//       'assets/M2-MacBook-Air-2022-Feature0012(2).png', '1'),
//   products('Apple', 'MacBook Pro', 'Only 1 left in stock',
//       'assets/maxim-hopman-Hin-rzhOdWs-unsplash.png', '1'),
//   products('Apple', 'MacBook Pro', 'Only 1 left in stock',
//       'assets/alex-knight-j4uuKnN43_M-unsplash.png', '1'),
// ];
final List<String> quantityItems = [
  '1',
  '2',
  '3',
];
String? qty;
final productController = Get.put(ProductController());
final dashBoardController = Get.put(DashBoardController());
final orderController = Get.put(OrderController());

class _ListOfProductScreenState extends State<ListOfProductScreen> {
  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.put(ProductController());

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
          'Listed Products',
          style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
      body: FutureBuilder(
        future:
            ApiServices().productListingApiFunc(ApiServices.storeId.toString()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loader.spinkit;
          }
          if (snapshot.data!.isEmpty || !snapshot.hasData) {
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
              itemCount: snapshot.data!.first.data!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // if()

                    // if (dashBoardController
                    //     .newArrival.value.data!.isNotEmpty) {
                    orderController.datumInstance.value =
                        snapshot.data!.first.data![index];

                    // productController.editDatumInstance.value =
                    // dashBoardController.newArrival.value.data![index];

                    // if (!isStoreProfile) {
                    productController.editDatumInstance.value =
                        snapshot.data!.first.data![index];
                    // }
                    // if(storeID == ApiServices.storeId) {
                    //   productController.editDatumInstance.value =
                    //   productController
                    //       .productListingDataList.first.data![index];
                    // }
                    // }
                    log(productController.editDatumInstance.value.name
                        .toString());
                    log(productController.editDatumInstance.value.price
                        .toString());
                    // print("storecompelte data is $storeCompleteData");
                    Get.to(() => ReviewProductScreen(
                          index: index,
                          storeID: int.parse(
                              snapshot.data!.first.data![index].id.toString()),
                          ownProduct: false,
                          productData: {
                            "name": snapshot.data!.first.data![index].name,
                            //  widget.storeData
                            //     ?.product?[index].name,
                            "rating": snapshot.data!.first.data![index].avg
                                        .toString() ==
                                    ""
                                ? "0"
                                : snapshot.data!.first.data![index].avg
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
                                "\$ ${snapshot.data!.first.data![index].price}",
                            "dealPrice":
                                "\$ ${snapshot.data!.first.data![index].dealItemPrice}",
                            // "\$ ${widget.storeData?.product?[index].dealItemPrice}",
                            "dealItemStartDatetime": snapshot
                                .data!.first.data![index].dealItemStartDatetime,
                            "dealItemEndDatetime": snapshot
                                .data!.first.data![index].dealItemEndDatetime,
                            // widget
                            //     .storeData
                            //     ?.product?[index]
                            //     .dealItemEndDatetime,
                            "dealItemPercentage": snapshot
                                .data!.first.data![index].dealItemPercentage,
                            "image": ImageUrls.kProduct +
                                snapshot.data!.first.data![index].productImage!
                                    .first.name
                                    .toString(),
                            // widget
                            //     .storeData!
                            //     .product![index]
                            //     .productImage!
                            //     .first
                            //     .name
                            //     .toString(),
                            "condition":
                                snapshot.data!.first.data![index].conditionType,
                            "discount":
                                snapshot.data!.first.data![index].discount,
                            "description":
                                snapshot.data!.first.data![index].descriptions,
                          },
                          // storeName: storeCompleteDat,
                          storeProfile:
                              snapshot.data?.first.data?[index].storeImage,
                          storeData: Store(
                            id: snapshot.data?.first.data?[index].storeId,
                            image: snapshot.data?.first.data?[index].storeImage,
                            name: snapshot.data?.first.data?[index].storeName,
                          ),
                          // widget.storeData,
                          // postedUserData: widget
                          //     .storeData
                          //     ?.product?[index]
                          //     .user,
                        ));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Visibility(
                        visible: index == 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //   Text(
                            //     'New Arrivals',
                            //     style: GoogleFonts.inter(
                            //         fontSize: 20.sp,
                            //         fontWeight: FontWeight.bold),
                            //   ),
                            //   4.verticalSpace,
                            //   Text(
                            //     'Top products incredible price',
                            //     style: GoogleFonts.inter(
                            //         color:
                            //             Colors.black.withOpacity(0.5),
                            //         fontSize: 14.sp),
                            //   ),
                          ],
                        ),
                      ),
                      10.verticalSpace,
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Container(
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
                                      snapshot.data!.first.data![index]
                                          .conditionType
                                          .toString(),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 10.sp),
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
                                        Text(
                                          snapshot.data!.first.data![index].name
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        3.verticalSpace,
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "Reviews(${snapshot.data!.first.data![index].avg.toString() == "" ? "0" : snapshot.data!.first.data![index].avg.toString().substring(0,3)})",
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
                                            Text(
                                              "\$ ${snapshot.data!.first.data![index].price}"
                                                  .toString(),
                                              style: GoogleFonts.inter(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14.sp,
                                                  decoration: snapshot
                                                                  .data!
                                                                  .first
                                                                  .data![index]
                                                                  .dealItemPrice
                                                                  .toString() !=
                                                              '' ||
                                                          snapshot
                                                                  .data!
                                                                  .first
                                                                  .data![index]
                                                                  .discount !=
                                                              null
                                                      ? TextDecoration
                                                          .lineThrough
                                                      : null,
                                                  color: snapshot
                                                                  .data!
                                                                  .first
                                                                  .data![index]
                                                                  .dealItemPrice
                                                                  .toString() !=
                                                              '' ||
                                                          snapshot
                                                                  .data!
                                                                  .first
                                                                  .data![index]
                                                                  .discount !=
                                                              null
                                                      ? Colors.grey
                                                      : Colors.black),
                                            ),
                                            Visibility(
                                              visible: snapshot
                                                      .data!
                                                      .first
                                                      .data![index]
                                                      .dealItemPrice
                                                      .toString() !=
                                                  '',
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                // mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  6.w.horizontalSpace,
                                                  Text(
                                                    "\$${snapshot.data!.first.data![index].dealItemPrice.toString()}",
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
                                            snapshot.data!.first.data![index]
                                                            .discount ==
                                                        null ||
                                                    snapshot
                                                            .data!
                                                            .first
                                                            .data![index]
                                                            .dealItemPrice
                                                            .toString() !=
                                                        ''
                                                ? SizedBox()
                                                : Row(
                                                    children: [
                                                      10.w.horizontalSpace,
                                                      Text(
                                                        "\$${snapshot.data!.first.data![index].discount!.price.toString()}",
                                                        style:
                                                            GoogleFonts.inter(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 14.sp,
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
                                      borderRadius: BorderRadius.circular(10.r),
                                      // image: DecorationImage(
                                      //   image: AssetImage(img),
                                      //   fit: BoxFit.fill,
                                      // ),
                                    ),
                                    child: ClipRRect(
                                      clipBehavior: Clip.hardEdge,
                                      borderRadius: BorderRadius.circular(10.r),
                                      child: CachedNetworkImage(
                                        fit: BoxFit.fitWidth,
                                        imageUrl: snapshot
                                                    .data!
                                                    .first
                                                    .data![index]
                                                    .productImage!
                                                    .first
                                                    .name
                                                    .toString() ==
                                                ""
                                            ? "https://fliplaptop.thesuitchstaging.com/assets/images/store/profile/1689949591213.jpg"
                                            : ImageUrls.kProduct +
                                                snapshot
                                                    .data!
                                                    .first
                                                    .data![index]
                                                    .productImage!
                                                    .first
                                                    .name
                                                    .toString(),
                                        placeholder: (context, url) =>
                                            Icon(Icons.image),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              snapshot.data!.first.data![index].dealItemPrice
                                          .toString() !=
                                      ''
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
                      ),
                      12.verticalSpace,
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

productCard(
    context,
    productData,
    storeId,
    storeProfile,
    storeName,
    index,
    img,
    Store storeCompleteData,
    productName,
    rating,
    price,
    dealPrice,
    dealItemStartDatetime,
    dealItemEndDatetime,
    dealItemPercentage,
    condition,
    description,
    discount,
    User postedUserData) {
  return InkWell(
    onTap: () {
      productController.editDatumInstance.value =
          productController.productListingDataList.first.data![index];
      productController.myProductImageList.value = productController
          .productListingDataList.first.data![index].productImage!;
      // if (dashBoardController.newArrival.value.data!.isNotEmpty) {
      //   orderController.datumInstance.value =
      //   dashBoardController.newArrival.value.data![index];
      //   productController.editDatumInstance.value =
      //   dashBoardController.newArrival.value.data![index];
      // }
      print("storecompelte data is $storeCompleteData");
      Get.to(() => ReviewProductScreen(
            index: index,
            storeID: int.parse(storeId),
            ownProduct: false,
            productData: {
              "name": productName,
              "rating": rating,
              "price": "\$ ${price}",
              "dealPrice": "\$ ${dealPrice}",
              "dealItemStartDatetime": dealItemStartDatetime,
              "dealItemEndDatetime": dealItemEndDatetime,
              "dealItemPercentage": dealItemPercentage,
              "image": ImageUrls.kProduct + img,
              "condition": condition,
              "discount": discount,
              "description": description
            },
            // storeName: storeCompleteDat,
            storeProfile: storeProfile,
            storeData: storeCompleteData,
            postedUserData: postedUserData,
          ));
    },
    child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        // height: 155.h,
        // padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  blurRadius: 20,
                  offset: Offset(0, 6),
                  color: Color.fromARGB(194, 116, 115, 115).withOpacity(0.23))
            ]),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                Container(
                  // padding: EdgeInsets.only(left: 5.w),
                  // width: Get.width * 0.45,
                  // height: 155.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.r),
                        bottomLeft: Radius.circular(10.r)),
                    // image: DecorationImage(
                    //     image: AssetImage(productImage), fit: BoxFit.cover)
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        // padding: EdgeInsets.only(left: 0.05.sw),
                        height: 125.h,
                        width: Get.width * 0.44,
                        child: ClipRRect(
                          clipBehavior: Clip.hardEdge,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.r),
                            bottomLeft: Radius.circular(10.r),
                          ),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: productData.productImage.toString() ==
                                    "[]"
                                ?
                                // "https://fliplaptop.thesuitchstaging.com/assets/images/store/profile/1689949591213.jpg"
                                "NoImage"
                                : ImageUrls.kProduct +
                                    productData.productImage.first.name
                                        .toString(),
                            placeholder: (context, url) => Icon(Icons.image),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 15.w,
                  child: InkWell(
                    onTap: () {
                      Get.to(() => EditProductsScreen(
                            productData: productData,
                          ));
                      var abc = productData;
                      print(abc..toString());
                    },
                    child: Container(
                      width: 32.r,
                      height: 32.r,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: Icon(
                        Icons.edit,
                        color: Colors.black,
                        size: 18.r,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.r, vertical: 15.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 0.25.sw,
                          child: Text(
                            productData.name.toString(),
                            softWrap: true,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ),
                        30.verticalSpace,
                        StatefulBuilder(
                          builder: (BuildContext context,
                              void Function(void Function()) _setState) {
                            return InkWell(
                              onTap: () {
                                ConfirmationPopup(
                                  context,
                                  "Delete",
                                  "Are you Sure you want to Delete this Product?",
                                  "Delete",
                                  "Cancel",
                                  () {
                                    Get.back();
                                    print("Called delete on product ID" +
                                        productData.id.toString());

                                    _setState(() {
                                      ApiServices().deleteProduct(context,
                                          int.parse(productData.id), storeId);
                                    });
                                  },
                                  () {
                                    Get.back();
                                  },
                                );
                              },
                              child: Container(
                                width: 32.r,
                                height: 32.r,
                                // padding: EdgeInsets.all(5.r),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: kbtngradient),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                  size: 14.r,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    Text(
                      productData.model.toString(),
                      style: GoogleFonts.inter(
                        color: Colors.black.withOpacity(0.5),
                        fontSize: 14.sp,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Reviews(${rating.toString()})",
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
                    10.verticalSpace,
                    Row(
                      children: [
                        Text(
                          "\$${productData.price.toString()}",
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                              decoration: dealPrice != '' || discount != null
                                  ? TextDecoration.lineThrough
                                  : null,
                              color: dealPrice != '' || discount != null
                                  ? Colors.grey
                                  : Colors.black),
                        ),
                        Visibility(
                          visible: dealPrice != '',
                          child: Row(
                            children: [
                              5.w.horizontalSpace,
                              Text(
                                "\$${dealPrice}",
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.sp,
                                    // decoration: TextDecoration.lineThrough,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        discount == null || dealPrice != ''
                            ? SizedBox()
                            : Row(
                                children: [
                                  5.w.horizontalSpace,
                                  Text(
                                    "\$ ${productData.discount!.price.toString()}",
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
                    // Text(
                    //   "Only ${productData.qty.toString()} left in stock",
                    //   // productStock,
                    //   style: GoogleFonts.inter(
                    //       fontSize: 12.sp, color: highlightedText),
                    // ),
                    // 10.verticalSpace,
                    // Container(
                    //   width: 100.w,
                    //   decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       borderRadius: BorderRadius.circular(10.r)),
                    //   child: DropdownButtonFormField2(
                    //     decoration: InputDecoration(
                    //       //Add isDense true and zero Padding.
                    //
                    //       isDense: true,
                    //       contentPadding: EdgeInsets.zero,
                    //       isCollapsed: true,
                    //
                    //       border: InputBorder.none,
                    //       //Add more decoration as you want here
                    //       //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                    //     ),
                    //     isExpanded: false,
                    //     hint: Text(
                    //       'Select Qty',
                    //       style: TextStyle(fontSize: 12.sp),
                    //     ),
                    //     icon: SvgPicture.asset(
                    //       'assets/Icon ionic-ios-arrow-down.svg',
                    //       width: 10.r,
                    //     ),
                    //     iconSize: 10.r,
                    //     buttonHeight: 20,
                    //     buttonWidth: 30.w,
                    //     buttonPadding: EdgeInsets.symmetric(horizontal: 10.r),
                    //     dropdownDecoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(15),
                    //     ),
                    //     items: quantityItems
                    //         .map((item) => DropdownMenuItem<String>(
                    //               value: item,
                    //               child: Text(
                    //                 "Qty ${item}",
                    //                 style: const TextStyle(
                    //                   fontSize: 14,
                    //                 ),
                    //               ),
                    //             ))
                    //         .toList(),
                    //     validator: (value) {
                    //       if (value == null) {
                    //         return 'Please select gender.';
                    //       }
                    //     },
                    //     onChanged: (value) {
                    //       qty = " ${value}";
                    //
                    //       //Do something when changing the item if you want.
                    //     },
                    //     onSaved: (value) {
                    //       // productQuantity = "Qty ${value}";
                    //     },
                    //   ),
                    // )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

class products {
  String? productName;
  String? productModal;
  String? productImage;

  String? productStock;
  String? productQuatity;

  products(this.productName, this.productModal, this.productStock,
      this.productImage, this.productQuatity);
}
