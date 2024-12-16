import 'dart:developer';

import 'package:app_fliplaptop/Apiserrvices/Services.dart';
import 'package:app_fliplaptop/Apiserrvices/app_url.dart';
import 'package:app_fliplaptop/Apiserrvices/loader.dart';
import 'package:app_fliplaptop/Controller/dashBoardController.dart';
import 'package:app_fliplaptop/Controller/filterController.dart';
import 'package:app_fliplaptop/Controller/orderController.dart';
import 'package:app_fliplaptop/Controller/productController.dart';
import 'package:app_fliplaptop/Screens/ReviewProductScreen.dart';
import 'package:app_fliplaptop/widgets/disallow_indicator_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/global.dart';
import '../models/dashBoardModel.dart';

List productList = [
  products(
      'MacBook Pro',
      'Lorem ipsum dolor sit amet consectetur adipiscing elit',
      '\$ 15.59',
      'assets/M2-MacBook-Air-2022-Feature0012.png',
      '(4.9)',
      'New'),
  products(
      'Apple Mac Book',
      'Lorem ipsum dolor sit amet consectetur adipiscing elit',
      '\$ 15.59',
      'assets/andras-vas-Bd7gNnWJBkU-unsplash.png',
      '(4.9)',
      'New'),
  products(
      'Dell Laptop',
      'Lorem ipsum dolor sit amet consectetur adipiscing elit',
      '\$ 15.59',
      'assets/M2-MacBook-Air-2022-Feature0012(2).png',
      '(4.9)',
      "Used"),
  products(
      'Apple Laptop',
      'Lorem ipsum dolor sit amet consectetur adipiscing elit',
      '\$ 15.59',
      'assets/maxim-hopman-Hin-rzhOdWs-unsplash.png',
      '(4.9)',
      'Used'),
  products(
      'Hp Laptop',
      'Lorem ipsum dolor sit amet consectetur adipiscing elit',
      '\$ 15.59',
      'assets/alex-knight-j4uuKnN43_M-unsplash.png',
      '(4.9)',
      'New'),
];

class ProductListScreen extends StatefulWidget {
  ProductListScreen(
      {super.key, this.isNewArrival, this.isFiltered = false, this.brandID});

  final bool isFiltered;
  final String? brandID;
  final bool? isNewArrival;

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final TextEditingController _searchText3 = TextEditingController();

  final dashBoardController = Get.put(DashBoardController());

  OrderController orderController = Get.put(OrderController());

  final ProductController productController = Get.put(ProductController());

  final FilterController filterController = Get.put(FilterController());

  Store storeInstance = Store();

  /// this is filtered list for all of the sublists on this screen
  // RxList<Datum> filteredList = <Datum>[].obs;

  bool isCurrentDateBetween(DateTime startDate, DateTime endDate) {
    DateTime currentDate = DateTime.now();
    return currentDate.isAfter(startDate) && currentDate.isBefore(endDate);
  }

  String getFilterType() {
    if (_selectedFilter == "Low-High") {
      return "lowToHigh";
    }
    else if (_selectedFilter == "High-Low") {
      return "highToLow";
    } else if (_selectedFilter == "A-Z") {
      return "AToZ";
    } else if (_selectedFilter == "Z-A") {
      return "ZToA";
    }
    else {
      return "";
    }
  }


  List<String> _filters = ['Low-High', 'High-Low', 'A-Z', 'Z-A'];
  String _selectedFilter = 'Low-High';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leadingWidth: 30.r,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              filterController.filteredData.clear();
              Get.back();
            },
            icon: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, gradient: kbtngradient),
                child: SvgPicture.asset(
                  'assets/Path 11.svg',
                  width: 14,
                ))),
        actions: [
          IconButton(
              onPressed: () => Get.toNamed('/MyCartScreen'),
              icon: SvgPicture.asset(
                'assets/Icon feather-shopping-cart.svg',
                width: 17,
              )),
        ],
      ),
      body: DisAllowIndicatorWidget(
        child: Obx(() {
          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 20.r),
            // physics: NeverScrollableScrollPhysics(),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 0.65.sw,
                    height: 51.h,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 25.r),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(35.r),
                        border: Border.all(color: Colors.grey)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          opticalSize: 0.9,
                          Icons.search,
                          color: Color(0xff1D1E1E).withOpacity(0.5),
                          size: 21,
                        ),
                        10.horizontalSpace,
                        Expanded(
                            child: TextField(
                              controller: _searchText3,
                              onChanged: (val) {
                                widget.isFiltered
                                    ? filterController.filteredData.value =
                                    filterController.filteredData!.value
                                        .where((product) =>
                                        product.name
                                            .toString()
                                            .toLowerCase()
                                            .contains(val.toLowerCase()))
                                        .toList()
                                    : widget.isNewArrival!
                                    ? filterController.filteredData.value = dashBoardController
                                    .newArrival.value.data!
                                    .where((product) =>
                                    product.name
                                        .toString()
                                        .toLowerCase()
                                        .contains(val.toLowerCase()))
                                    .toList()
                                    : filterController.filteredData.value = (dashBoardController
                                    .moreProduct.value.data!
                                    .where((product) =>
                                    product.name.toString()
                                        .toLowerCase()
                                        .contains(val.toLowerCase()))
                                    .toList());
                                setState(() {
                                  log(val);
                                  log(filterController.filteredData.value.toString());
                                });
                              },
                              style: GoogleFonts.inter(
                                  color: Color(0xff1D1E1E).withOpacity(0.5),
                                  fontSize: 15.sp),
                              cursorColor: Color(0xff1D1E1E),
                              decoration: InputDecoration(
                                  isCollapsed: true,
                                  isDense: true,
                                  contentPadding:
                                  EdgeInsets.only(top: 0, bottom: 3.5.r),
                                  border: InputBorder.none,
                                  hintText: 'Search here',
                                  hintStyle: GoogleFonts.inter(
                                      color: Color(0xff1D1E1E).withOpacity(0.5),
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.normal)),
                            ))
                      ],
                    ),
                  ),
                  SizedBox(
                    // width: 0.15.sw,
                    child: DropdownButton<String>(
                      value: _selectedFilter,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedFilter = newValue!;
                        });
                        dashBoardController.getDashBoardFilter(getFilterType());
                      },
                      items:
                      _filters.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(fontSize: 13.sp),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  // InkWell(
                  //   onTap: () {},
                  //   child: SvgPicture.asset(
                  //     'assets/Path 2948.svg',
                  //     width: 16,
                  //   ),
                  // ),
                  // InkWell(
                  //   onTap: () {},
                  //   child: SvgPicture.asset(
                  //     'assets/Path 2949.svg',
                  //     width: 18,
                  //   ),
                  // )
                ],
              ),
              32.verticalSpace,
              widget.isFiltered
                  ? filterController.isApplyingFilters.value ||
                  dashBoardController.isLoading.value
                  ? Center(
                child: Loader.spinkit,
              )
                  : widget.brandID.toString() == "null"
                  ? filterController.filteredData.isEmpty
                  ? Padding(
                padding: EdgeInsets.only(top: 0.3.sh),
                child: Center(
                  child: Text(
                    "No Products Found",
                    style: TextStyle(
                      fontSize: 20.r,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
                  : widget.isFiltered && _searchText3.text != ""
                  ? ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: filterController.filteredData.value.length,
                  itemBuilder: (context, index) {
                    // return Container(height: 20.h,width: 90.w,color: Colors.black,)
                    var storeIndex = dashBoardController
                        .storeList
                        .indexWhere((element) =>
                    element.id ==
                        filterController.filteredData
                            .value[index].storeId);
                    // Store storeInstance = Store();
                    if (storeIndex != -1) {
                      storeInstance = dashBoardController
                          .storeList[storeIndex];
                    }
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        /// if tapped on arrival more products
                        InkWell(
                          onTap: () {},
                          child: productCard(
                              filterController.filteredData.value[index].name,
                              '${filterController.filteredData.value[index].avg == ""
                                  ? 0
                                  : filterController.filteredData.value[index].avg.toString()
                                  .substring(0, 3)}',
                              '\$ ${filterController.filteredData.value[index].price}',
                              '${filterController.filteredData.value[index].dealItemPrice}',
                              filterController.filteredData.value[index]
                                  .dealItemStartDatetime,
                              filterController.filteredData.value[index]
                                  .dealItemEndDatetime,
                              filterController.filteredData.value[index]
                                  .dealItemPercentage,
                              filterController.filteredData.value[index]
                                  .productImage!.isEmpty
                                  ? ""
                                  : ImageUrls.kProduct +
                                  (filterController.filteredData
                                      .value[index]
                                      .productImage![
                                  0]
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
                  })
                  : ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount:
                  filterController.filteredData.length,
                  itemBuilder: (context, index) {
                    // return Container(height: 20.h,width: 90.w,color: Colors.black,)
                    var storeIndex = dashBoardController
                        .storeList
                        .indexWhere((element) =>
                    element.id ==
                        filterController
                            .filteredData[index].storeId);
                    // Store storeInstance = Store();
                    if (storeIndex != -1) {
                      storeInstance = dashBoardController
                          .storeList[storeIndex];
                    }
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        /// if tapped on arrival more products
                        InkWell(
                          onTap: () {},
                          child: productCard(
                              filterController
                                  .filteredData[index].name,
                              '${filterController.filteredData[index].avg == ""
                                  ? 0
                                  : filterController.filteredData[index].avg
                                  .toString().substring(0, 3)}',
                              '\$ ${filterController.filteredData[index]
                                  .price}',
                              '${filterController.filteredData[index]
                                  .dealItemPrice}',
                              filterController
                                  .filteredData[index]
                                  .dealItemStartDatetime,
                              filterController
                                  .filteredData[index]
                                  .dealItemEndDatetime,
                              filterController
                                  .filteredData[index]
                                  .dealItemPercentage,
                              filterController
                                  .filteredData[index]
                                  .productImage!
                                  .isEmpty
                                  ? ""
                                  : ImageUrls.kProduct +
                                  (filterController
                                      .filteredData[
                                  index]
                                      .productImage![
                                  0]
                                      .name ??
                                      ""),
                              index,
                              filterController
                                  .filteredData[index]
                                  .conditionType,
                              filterController
                                  .filteredData[index]
                                  .descriptions,
                              filterController
                                  .filteredData[index]
                                  .storeImage,
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
                              filterController
                                  .filteredData[index]
                                  .storeId,
                              filterController
                                  .filteredData[index]
                                  .user ??
                                  User(),
                              filterController
                                  .filteredData[index]
                                  .discount),
                        ),
                        20.verticalSpace
                      ],
                    );
                  })
                  : FutureBuilder(
                  future: ApiServices()
                      .searchBrands(widget.brandID.toString()),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Padding(
                        padding: EdgeInsets.only(top: 0.3.sh),
                        child: Center(child: Loader.spinkit),
                      );
                    } else if (snapshot.hasError) {
                      // log(snapshot.hasError.toString());
                      return Padding(
                        padding: EdgeInsets.only(top: 0.3.sh),
                        child: Center(
                          child: Text(
                            "No Products Found",
                            style: TextStyle(
                              fontSize: 20.r,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: snapshot.data!.data!.length,
                          itemBuilder: (context, index) {
                            // return Container(height: 20.h,width: 90.w,color: Colors.black,)
                            var storeIndex = dashBoardController
                                .storeList
                                .indexWhere((element) =>
                            element.id ==
                                snapshot
                                    .data!.data![index].storeId);
                            // Store storeInstance = Store();
                            if (storeIndex != -1) {
                              storeInstance = dashBoardController
                                  .storeList[storeIndex];
                            }
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [

                                /// if tapped on arrival more products
                                InkWell(
                                  onTap: () {
                                    if (widget.isFiltered) {
                                      orderController
                                          .datumInstance.value =
                                      snapshot.data!.data![index];
                                      productController
                                          .editDatumInstance
                                          .value =
                                      snapshot.data!.data![index];
                                    }
                                  },
                                  child: productCard(
                                      snapshot
                                          .data!.data![index].name,
                                      '${snapshot.data!.data![index].avg == ""
                                          ? 0
                                          : snapshot.data!.data![index].avg
                                          .toString().substring(0, 3)}',
                                      '\$ ${snapshot.data!.data![index].price}',
                                      '${snapshot.data!.data![index]
                                          .dealItemPrice}',
                                      snapshot.data!.data![index]
                                          .dealItemStartDatetime,
                                      snapshot.data!.data![index]
                                          .dealItemEndDatetime,
                                      snapshot.data!.data![index]
                                          .dealItemPercentage,
                                      snapshot.data!.data![index]
                                          .productImage!.isEmpty
                                          ? ""
                                          : ImageUrls.kProduct +
                                          (snapshot
                                              .data!
                                              .data![index]
                                              .productImage![
                                          0]
                                              .name ??
                                              ""),
                                      index,
                                      snapshot.data!.data![index]
                                          .conditionType,
                                      snapshot.data!.data![index]
                                          .descriptions,
                                      snapshot.data!.data![index]
                                          .storeImage,
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
                                      snapshot
                                          .data!.data![index].storeId,
                                      snapshot.data!.data![index]
                                          .user ??
                                          User(),
                                      snapshot.data!.data![index]
                                          .discount),
                                ),
                                20.verticalSpace
                              ],
                            );
                          });
                      ;
                    } else {
                      return Center(
                          child: Text(snapshot.error.toString()));
                    }
                  })
                  : filterController.filteredData.isEmpty && _searchText3.text == ""
                  ? ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.isNewArrival!
                    ? dashBoardController.newArrival.value.data!.length
                    : dashBoardController.moreProductList.value.length,
                itemBuilder: (context, index) {
                  // if (isNewArrival!) {
                  var storeIndex = dashBoardController.storeList
                      .indexWhere((element) =>
                  element.id ==
                      (widget.isNewArrival!
                          ? dashBoardController
                          .newArrival.value.data![index].storeId
                          : dashBoardController
                          .moreProductList[index].storeId));
                  // Store storeInstance = Store();
                  if (storeIndex != -1) {
                    storeInstance =
                    dashBoardController.storeList[storeIndex];
                  }
                  // } else {
                  //   var storeIndex = dashBoardController.storeList
                  //       .indexWhere((element) =>
                  //           element.id ==
                  //           (isNewArrival!
                  //               ? dashBoardController
                  //                   .moreProductList.value[index].storeId
                  //               : dashBoardController.moreProductList
                  //                   .value[index].storeId));
                  //   if (storeIndex != -1) {
                  //     storeInstance =
                  //         dashBoardController.storeList[storeIndex];
                  //   }
                  // }
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      widget.isNewArrival!
                          ?

                      /// if tapped on arrival more products
                      InkWell(
                        onTap: () {
                          log("store Name" +
                              storeInstance.name.toString());
                        },
                        child: productCard(
                            dashBoardController.newArrival.value
                                .data![index].name,
                            '${dashBoardController.newArrival.value.data![index]
                                .avg == "" ? 0 : dashBoardController.newArrival
                                .value.data![index].avg.toString().substring(
                                0, 3)}',
                            '\$ ${dashBoardController.newArrival.value
                                .data![index].price}',
                            '${dashBoardController.newArrival.value.data![index]
                                .dealItemPrice}',
                            dashBoardController
                                .newArrival
                                .value
                                .data![index]
                                .dealItemStartDatetime,
                            dashBoardController.newArrival.value
                                .data![index].dealItemEndDatetime,
                            dashBoardController.newArrival.value
                                .data![index].dealItemPercentage,
                            dashBoardController
                                .newArrival
                                .value
                                .data![index]
                                .productImage!
                                .isEmpty
                                ? ""
                                : ImageUrls.kProduct +
                                (dashBoardController
                                    .newArrival
                                    .value
                                    .data![index]
                                    .productImage![0]
                                    .name ??
                                    ""),
                            index,
                            dashBoardController.newArrival.value
                                .data![index].conditionType,
                            dashBoardController.newArrival.value
                                .data![index].descriptions,
                            dashBoardController.newArrival.value
                                .data![index].storeImage,
                            storeInstance,
                            // Store(
                            //     id: dashBoardController.newArrival
                            //         .value.data![index].storeId,
                            //     name: dashBoardController.newArrival
                            //         .value.data![index].storeName,
                            //     image: dashBoardController.newArrival
                            //         .value.data![index].storeImage),
                            dashBoardController.newArrival.value
                                .data![index].storeId,
                            dashBoardController.newArrival.value
                                .data![index].user ??
                                User(),
                            dashBoardController.newArrival.value
                                .data![index].discount),
                      )
                          : InkWell(
                        onTap: () {
                          log("store Name" +
                              storeInstance.name.toString());
                        },
                        child: productCard(
                            dashBoardController.moreProductList
                                .value[index].name,
                            '${dashBoardController.moreProductList.value[index]
                                .avg == "" ? 0 : dashBoardController
                                .moreProductList.value[index].avg.toString()
                                .substring(0, 3)}',
                            '\$ ${dashBoardController.moreProductList
                                .value[index].price}',
                            '${dashBoardController.moreProductList.value[index]
                                .dealItemPrice}',
                            dashBoardController
                                .moreProductList
                                .value[index]
                                .dealItemStartDatetime,
                            dashBoardController.moreProductList
                                .value[index].dealItemEndDatetime,
                            dashBoardController.moreProductList
                                .value[index].dealItemPercentage,
                            dashBoardController
                                .moreProductList
                                .value[index]
                                .productImage!
                                .isEmpty
                                ? ""
                                : ImageUrls.kProduct +
                                (dashBoardController
                                    .moreProductList
                                    .value[index]
                                    .productImage![0]
                                    .name ??
                                    ""),
                            index,
                            dashBoardController.moreProductList
                                .value[index].conditionType,
                            dashBoardController.moreProductList
                                .value[index].descriptions,
                            dashBoardController.moreProductList
                                .value[index].storeImage,
                            storeInstance,
                            dashBoardController.moreProductList
                                .value[index].storeId,
                            dashBoardController.moreProductList
                                .value[index].user ??
                                User(),
                            dashBoardController.moreProductList
                                .value[index].discount),
                      ),
                      20.verticalSpace
                    ],
                  );
                },
              )
                  : ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: filterController.filteredData.length,
                itemBuilder: (context, index) {
                  // if (isNewArrival!) {
                  var storeIndex = dashBoardController.storeList
                      .indexWhere((element) =>
                  element.id == filterController.filteredData[index].storeId);
                  // Store storeInstance = Store();
                  if (storeIndex != -1) {
                    storeInstance =
                    dashBoardController.storeList[storeIndex];
                  }
                  // } else {
                  //   var storeIndex = dashBoardController.storeList
                  //       .indexWhere((element) =>
                  //           element.id ==
                  //           (isNewArrival!
                  //               ? dashBoardController
                  //                   .moreProductList.value[index].storeId
                  //               : dashBoardController.moreProductList
                  //                   .value[index].storeId));
                  //   if (storeIndex != -1) {
                  //     storeInstance =
                  //         dashBoardController.storeList[storeIndex];
                  //   }
                  // }
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      /// if tapped on arrival more products
                      InkWell(
                        onTap: () {
                          log("store Name" +
                              storeInstance.name.toString());
                        },
                        child: productCard(
                            filterController.filteredData[index].name,
                            '${filterController.filteredData[index].avg == ""
                                ? 0
                                : filterController.filteredData[index].avg.toString().substring(
                                0, 3)}',
                            '\$ ${filterController.filteredData[index].price}',
                            '${filterController.filteredData[index].dealItemPrice}',
                            filterController.filteredData[index].dealItemStartDatetime,
                            filterController.filteredData[index].dealItemEndDatetime,
                            filterController.filteredData[index].dealItemPercentage,
                            filterController.filteredData[index].productImage!.isEmpty
                                ? ""
                                : ImageUrls.kProduct +
                                (filterController.filteredData[index]
                                    .productImage![0]
                                    .name ??
                                    ""),
                            index,
                            filterController.filteredData[index].conditionType,
                            filterController.filteredData[index].descriptions,
                            filterController.filteredData[index].storeImage,
                            storeInstance,
                            // Store(
                            //     id: dashBoardController.newArrival
                            //         .value.data![index].storeId,
                            //     name: dashBoardController.newArrival
                            //         .value.data![index].storeName,
                            //     image: dashBoardController.newArrival
                            //         .value.data![index].storeImage),
                            filterController.filteredData[index].storeId,
                            filterController.filteredData[index].user ?? User(),
                            filterController.filteredData[index].discount),
                      ),
                      20.verticalSpace
                    ],
                  );
                },
              ),
            ],
          );
        }),
      ),
    );
  }

  productCard(brand,
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
        Future.delayed(Duration.zero, () {
          log("store complete data" + storeCompleteData.name.toString());
          log("index is" + index.toString());
          log("length filtered is" +
              filterController.filteredData.length.toString());
          // else {
          if(widget.isFiltered){

          }
          else{
            if (widget.isNewArrival!) {
              orderController.datumInstance.value =
              dashBoardController.newArrival.value.data![index];
              productController.editDatumInstance.value =
              dashBoardController.newArrival.value.data![index];
            } else {
              orderController.datumInstance.value =
              dashBoardController.moreProductList.value[index];
              productController.editDatumInstance.value =
              dashBoardController.moreProductList.value[index];
            }
          }
          // log("datum name is" + orderController.datumInstance.value.name!);
          // }
          log("deal price " + "\$ $dealPrice");
          log("discount" + discount.toString());
          Get.to(() =>
              ReviewProductScreen(
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
        });
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
                                "${rating != "0" ? rating.toString().substring(
                                    0, 3) : rating}",
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
            dealPrice != ''
                ? Positioned(
                top: 6,
                left: 6,
                child: SvgPicture.asset(
                  "assets/hotDealIcon.svg",
                  height: 0.05.sh,
                ))
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}

class products {
  String? productName;
  String? productDetailtext;
  String? productPrice;
  String? productRating;
  String? productImage;
  String? condition;

  products(this.productName, this.productDetailtext, this.productPrice,
      this.productImage, this.productRating, this.condition);
}
