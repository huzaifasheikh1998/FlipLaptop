import 'dart:developer';

import 'package:app_fliplaptop/Apiserrvices/app_url.dart';
import 'package:app_fliplaptop/Apiserrvices/loader.dart';
import 'package:app_fliplaptop/Controller/dashBoardController.dart';
import 'package:app_fliplaptop/Controller/filterController.dart';
import 'package:app_fliplaptop/Controller/orderController.dart';
import 'package:app_fliplaptop/Controller/productController.dart';
import 'package:app_fliplaptop/Screens/ProductsListScreen.dart';
import 'package:app_fliplaptop/Screens/ReviewProductScreen.dart';
import 'package:app_fliplaptop/widgets/disallow_indicator_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/global.dart';
import '../models/dashBoardModel.dart';

class SuggestSearchScreen extends StatefulWidget {
  SuggestSearchScreen({super.key});

  @override
  State<SuggestSearchScreen> createState() => _SuggestSearchScreenState();
}

class _SuggestSearchScreenState extends State<SuggestSearchScreen> {
  final FilterController filterController = Get.put(FilterController());
  OrderController orderController = Get.put(OrderController());
  final ProductController productController = Get.put(ProductController());
  final TextEditingController _searchBrand2 = TextEditingController();
  Store storeInstance = Store();

  // final List _brandList = [
  @override
  Widget build(BuildContext context) {
    final dashBoardController = Get.put(DashBoardController());
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 50.r,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Get.close(1);
          },
          child: Container(
              padding: const EdgeInsets.all(5),
              margin: EdgeInsets.only(left: 20.r),
              decoration:
                  BoxDecoration(shape: BoxShape.circle, gradient: kbtngradient),
              child: SvgPicture.asset(
                'assets/Path 11.svg',
                width: 20,
              )),
        ),
        title: Container(
          width: Get.width,
          height: 51.h,
          alignment: Alignment.center,
          // padding: EdgeInsets.symmetric(horizontal: 25.r),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                blurRadius: 18,
                offset: Offset(0, 2),
                color: Color.fromARGB(194, 241, 203, 216).withOpacity(0.15))
          ], color: Colors.white, borderRadius: BorderRadius.circular(35.r)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              10.horizontalSpace,
              Icon(
                opticalSize: 0.9,
                Icons.search,
                color: Color(0xff1D1E1E).withOpacity(0.5),
                size: 21,
              ),
              14.horizontalSpace,
              Expanded(
                  child: TextField(
                onChanged: (val) {
                  log(val.toString());
                  setState(() {});
                  filterController.filteredData.value.clear();
                  filterController.filteredData.value.addAll(dashBoardController
                      .newArrival.value.data!
                      .where((product) => product.name
                          .toString()
                          .toLowerCase()
                          .contains(val.toLowerCase()))
                      .toList());
                  filterController.filteredData.value.addAll(dashBoardController
                      .moreProduct.value.data!
                      .where((product) => product.name
                          .toString()
                          .toLowerCase()
                          .contains(val.toLowerCase()))
                      .toList());
                },
                controller: _searchBrand2,
                style: GoogleFonts.inter(
                    color: Color(0xff1D1E1E).withOpacity(0.5), fontSize: 15.sp),
                cursorColor: Color(0xff1D1E1E),
                decoration: InputDecoration(
                    isCollapsed: true,
                    isDense: true,
                    contentPadding: EdgeInsets.only(top: 0, bottom: 3.5.r),
                    border: InputBorder.none,
                    hintText: 'Dell Laptop, MacBook Air',
                    hintStyle: GoogleFonts.inter(
                        color: Color(0xff1D1E1E).withOpacity(0.5),
                        fontSize: 15.sp,
                        fontWeight: FontWeight.normal)),
              )),
              IconButton(
                  onPressed: () {
                    _searchBrand2.clear();
                    setState(() {});
                  },
                  icon: SvgPicture.asset(
                    'assets/Icon ionic-ios-close.svg',
                    width: 13.r,
                  ))
            ],
          ),
        ),
      ),
      body: DisAllowIndicatorWidget(
        child: Obx(() {
          return filterController.isLoading.value
              ? Center(
                  child: Loader.spinkit,
                )
              : _searchBrand2.text == ""
                  ? ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.r, vertical: 20.r),
                      itemCount: dashBoardController.brandList.length,
                      itemBuilder: (context, index) => suggestItem(
                        dashBoardController.brandList[index].name.toString(),
                        dashBoardController.brandList[index].id.toString(),
                        index,
                      ),
                    )
                  : filterController.filteredData.value.isEmpty
                      ? Center(
                          child: Text("No Product Found", style: TextStyle(
                            fontSize: 20.r,
                            fontWeight: FontWeight.bold,
                          ),),
                        )
                      : Padding(
                          padding: EdgeInsets.all(15.r),
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemCount:
                                  filterController.filteredData.value.length,
                              itemBuilder: (context, index) {
                                // return Container(height: 20.h,width: 90.w,color: Colors.black,)
                                var storeIndex = dashBoardController.storeList
                                    .indexWhere((element) =>
                                        element.id ==
                                        filterController
                                            .filteredData.value[index].storeId);
                                // Store storeInstance = Store();
                                if (storeIndex != -1) {
                                  storeInstance =
                                      dashBoardController.storeList[storeIndex];
                                }
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    /// if tapped on arrival more products
                                    InkWell(
                                      onTap: () {},
                                      child: productCard(
                                          filterController
                                              .filteredData.value[index].name,
                                          '${filterController.filteredData.value[index].avg == "" ? 0 : filterController.filteredData.value[index].avg.toString().substring(0, 3)}',
                                          '\$ ${filterController.filteredData.value[index].price}',
                                          '${filterController.filteredData.value[index].dealItemPrice}',
                                          filterController
                                              .filteredData
                                              .value[index]
                                              .dealItemStartDatetime,
                                          filterController.filteredData
                                              .value[index].dealItemEndDatetime,
                                          filterController.filteredData
                                              .value[index].dealItemPercentage,
                                          filterController
                                                  .filteredData
                                                  .value[index]
                                                  .productImage!
                                                  .isEmpty
                                              ? ""
                                              : ImageUrls.kProduct +
                                                  (filterController
                                                          .filteredData
                                                          .value[index]
                                                          .productImage![0]
                                                          .name ??
                                                      ""),
                                          index,
                                          filterController.filteredData
                                              .value[index].conditionType,
                                          filterController.filteredData
                                              .value[index].descriptions,
                                          filterController.filteredData
                                              .value[index].storeImage,
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
                                          filterController.filteredData
                                              .value[index].storeId,
                                          filterController.filteredData
                                                  .value[index].user ??
                                              User(),
                                          filterController.filteredData
                                              .value[index].discount),
                                    ),
                                    20.verticalSpace
                                  ],
                                );
                              }),
                        );
        }),
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
        log("store complete data" + storeCompleteData.name.toString());
        log("index is" + index.toString());
        // if (isFiltered) {
        orderController.datumInstance.value =
            filterController.filteredData[index];
        productController.editDatumInstance.value =
            filterController.filteredData[index];
        // } else {
        //   if (isNewArrival!) {
        //     orderController.datumInstance.value =
        //     dashBoardController.newArrival.value.data![index];
        //     productController.editDatumInstance.value =
        //     dashBoardController.newArrival.value.data![index];
        //   } else {
        //     orderController.datumInstance.value =
        //     dashBoardController.moreProductList.value[index];
        //     productController.editDatumInstance.value =
        //     dashBoardController.moreProductList.value[index];
        //   }
        //   log("datum name is" + orderController.datumInstance.value.name!);
        // }
        // log("deal price " + "\$ $dealPrice");
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
          ],
        ),
      ),
    );
  }
}

suggestItem(String brandName, String brandID, i) {
  return InkWell(
    onTap: () {
      // filterController.brandFilter(brandID).then((value) {
      // log("value"+value.toString());
      // filterController.filteredData.value = value;
      Get.to(
        () => ProductListScreen(
          isFiltered: true,
          brandID: brandID,
          isNewArrival: false,
        ),
        // );
      );
    },
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              brandName,
              style: GoogleFonts.inter(
                  fontSize: 18.sp, fontWeight: FontWeight.w500),
            ),
            SvgPicture.asset(
              'assets/Group 49.svg',
              width: 12.r,
            )
          ],
        ),
        10.verticalSpace,
        DottedLine(
          dashColor: Colors.black.withOpacity(0.7),
          dashGapLength: 1.4,
          lineThickness: 0.2,
        ),
        20.verticalSpace
      ],
    ),
  );
}
