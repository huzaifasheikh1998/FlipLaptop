import 'dart:developer';

import 'package:another_xlider/another_xlider.dart';
import 'package:app_fliplaptop/Apiserrvices/Services.dart';
import 'package:app_fliplaptop/Apiserrvices/loader.dart';
import 'package:app_fliplaptop/Controller/filterController.dart';
import 'package:app_fliplaptop/Screens/ProductsListScreen.dart';
import 'package:app_fliplaptop/components/global.dart';
import 'package:app_fliplaptop/widgets/disallow_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterScreen extends StatefulWidget {
  FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

final filterController = Get.put(FilterController());
var _lowerValue = 0.0, _upperValue = 10000.0;

class _FilterScreenState extends State<FilterScreen> {
  final FilterController filterController = Get.put(FilterController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filterController.getAllFilters();
  }

  @override
  Widget build(BuildContext context) {
    final filterController = Get.put(FilterController());
    return Scaffold(
      backgroundColor: kPageBgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Filters',
          style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Container(
              padding: const EdgeInsets.all(6),
              decoration:
                  BoxDecoration(shape: BoxShape.circle, gradient: kbtngradient),
              child: SvgPicture.asset(
                'assets/Path 11.svg',
                width: 14,
              )),
        ),
        actions: [
          InkWell(
              onTap: () {
                // Get.offAndToNamed('/FilterScreen');
                filterController.getAllFilters();
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    'assets/Group 57.svg',
                    width: 13.48.r,
                  ),
                  5.horizontalSpace,
                  Text(
                    'Reset',
                    style: TextStyle(color: highlightedText, fontSize: 15.sp),
                  )
                ],
              )),
          20.horizontalSpace
        ],
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        margin: EdgeInsets.symmetric(horizontal: 20.r, vertical: 20.r),
        padding: EdgeInsets.symmetric(vertical: 11.r),
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                  blurRadius: 20,
                  offset: Offset(0, 3),
                  color: Color.fromARGB(194, 238, 236, 236).withOpacity(0.1))
            ]),
        child: Column(
          children: [
            Expanded(
              child: GetBuilder(
                  init: filterController,
                  builder: (contr) {
                    return DisAllowIndicatorWidget(
                      child: contr.isLoading.value
                          ? Center(
                              child: Loader.spinkit,
                            )
                          : Obx(() {
                              return ListView(
                                physics: BouncingScrollPhysics(),
                                padding: EdgeInsets.symmetric(horizontal: 20.r),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                children: [
                                  Text(
                                    'Item Type',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20.sp),
                                  ),
                                  15.verticalSpace,
                                  Wrap(
                                    children: [
                                      for (var index = 0;
                                          index <
                                              filterController
                                                  .itemTypeList.length;
                                          index++) ...[
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 10.r, right: 2.r),
                                          width: Get.width * 0.26,
                                          constraints: BoxConstraints(
                                            minWidth: Get.width * 0.10,
                                            maxWidth: Get.width * 0.3,
                                          ),
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 12.r),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(23.r),
                                            border: Border.all(
                                              width: 0.6,
                                              color: Colors.grey.withOpacity(
                                                0.4,
                                              ),
                                            ),
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              filterController
                                                  .removeItemType(index);
                                            },
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SizedBox(
                                                  width: Get.width * 0.16,
                                                  child: Text(
                                                    filterController
                                                        .itemTypeList[index]

                                                        .toString(),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                5.horizontalSpace,
                                                SvgPicture.asset(
                                                  'assets/Path 2942.svg',
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ]
                                    ],
                                  ),
                                  20.h.verticalSpace,
                                  Text(
                                    'Brands',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20.sp),
                                  ),
                                  15.verticalSpace,
                                  Wrap(
                                    children: [
                                      for (var index = 0;
                                          index <
                                              filterController
                                                  .ListOfBrands.length;
                                          index++) ...[
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 10.r, right: 2.r),
                                          width: Get.width * 0.26,
                                          constraints: BoxConstraints(
                                            minWidth: Get.width * 0.10,
                                            maxWidth: Get.width * 0.3,
                                          ),
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 12.r),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(23.r),
                                            border: Border.all(
                                              width: 0.6,
                                              color: Colors.grey.withOpacity(
                                                0.4,
                                              ),
                                            ),
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              filterController
                                                  .removeItemList1(index);
                                            },
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SizedBox(
                                                  width: Get.width * 0.16,
                                                  child: Text(
                                                    filterController
                                                        .ListOfBrands[index]
                                                        .name
                                                        .toString(),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                5.horizontalSpace,
                                                SvgPicture.asset(
                                                  'assets/Path 2942.svg',
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ]
                                    ],
                                  ),
                                  // 20.verticalSpace,
                                  // Text(
                                  //   'Price Range',
                                  //   style: TextStyle(
                                  //       color: Colors.black,
                                  //       fontWeight: FontWeight.w700,
                                  //       fontSize: 20.sp),
                                  // ),
                                  // 20.verticalSpace,
                                  // priceSlider(),
                                  // 10.verticalSpace,
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     Text("\$" + _lowerValue.toInt().toString(),
                                  //         style: TextStyle(
                                  //           fontSize: 18.sp,
                                  //           fontWeight: FontWeight.bold,
                                  //         )),
                                  //     Text("\$" + _upperValue.toInt().toString(),
                                  //         style: TextStyle(
                                  //           fontSize: 18.sp,
                                  //           fontWeight: FontWeight.bold,
                                  //         ))
                                  //   ],
                                  // ),
                                  20.verticalSpace,
                                  Text(
                                    'Location',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20.sp),
                                  ),
                                  15.verticalSpace,
                                  Wrap(
                                    // crossAxisAlignment: WrapCrossAlignment.center,
                                    alignment: WrapAlignment.start,
                                    children: [
                                      for (var index = 0;
                                          index <
                                              filterController
                                                  .locationList.length;
                                          index++) ...[
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 10.r, right: 10.r),
                                          constraints: BoxConstraints(
                                              minWidth: Get.width * 0.08,
                                              maxWidth:
                                                  filterController.locationList[
                                                              index] ==
                                                          'LA'
                                                      ? Get.width * 0.23
                                                      : Get.width * 0.38),
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 12.r),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(23.r),
                                              border: Border.all(
                                                  width: 0.6,
                                                  color: Colors.grey
                                                      .withOpacity(0.4))),
                                          child: InkWell(
                                            onTap: () {
                                              // filterController
                                              //     .removeItemList2(index);
                                            },
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  filterController
                                                      .locationList[index],
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18.sp,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                10.horizontalSpace,
                                                SvgPicture.asset(
                                                    'assets/Path 2942.svg')
                                              ],
                                            ),
                                          ),
                                        ),
                                      ]
                                    ],
                                  ),
                                  20.verticalSpace,
                                  Text(
                                    'Screen Size',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20.sp),
                                  ),
                                  15.verticalSpace,
                                  Wrap(
                                    // crossAxisAlignment: WrapCrossAlignment.center,
                                    alignment: WrapAlignment.start,
                                    children: [
                                      for (var index = 0;
                                          index <
                                              filterController.sizeList.length;
                                          index++) ...[
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 10.r, right: 5.r),
                                          constraints: BoxConstraints(
                                              minWidth: Get.width * 0.10,
                                              maxWidth: Get.width * 0.258),
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 12.r, horizontal: 5.r),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(23.r),
                                              border: Border.all(
                                                  width: 0.6,
                                                  color: Colors.grey
                                                      .withOpacity(0.4))),
                                          child: InkWell(
                                            onTap: () {
                                              filterController
                                                  .removeItemList3(index);
                                            },
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  filterController
                                                      .sizeList[index].name
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                10.horizontalSpace,
                                                SvgPicture.asset(
                                                    'assets/Path 2942.svg')
                                              ],
                                            ),
                                          ),
                                        ),
                                      ]
                                    ],
                                  ),
                                  25.verticalSpace,
                                ],
                              );
                            }),
                    );
                  }),
            ),
            Obx(() {
              return InkWell(
                onTap: () async {
                  filterController.queryParameters["min_price"] =
                      filterController.lowerValue.value;
                  filterController.queryParameters["max_price"] =
                      filterController.upperValue.value;
                  for (var i = 0;
                      i < filterController.ListOfBrands.length;
                      i++) {
                    filterController.queryParameters["brand_name[$i]"] =
                        filterController.ListOfBrands[i].name;
                  }

                  /// adding to locations
                  for (var i = 0;
                      i < filterController.locationList.length;
                      i++) {
                    filterController.queryParameters["location[$i]"] =
                        filterController.locationList[i];
                  }

                  /// adding display size
                  for (var i = 0; i < filterController.sizeList.length; i++) {
                    filterController.queryParameters["display_size[$i]"] =
                        filterController.sizeList[i].name;
                  }

                  /// adding item type\
                  for (var i = 0; i < filterController.itemTypeList.length; i++) {
                    filterController.queryParameters["condition_type[$i]"] =
                        filterController.itemTypeList[i];
                  }
                  filterController.update();
                  log(filterController.queryParameters.toString());
                  await ApiServices().searchFilter();
                  Get.to(() => ProductListScreen(
                        isNewArrival: true,
                        isFiltered: true,
                      ));
                },
                child: Container(
                  width: Get.width,
                  height: 59.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35.r),
                      gradient: kbtngradient),
                  child: filterController.isApplyingFilters.value == true
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          'Apply Filters',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold),
                        ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }

  Widget priceSlider() {
    return FlutterSlider(
      // rtl: true,
      values: [_lowerValue, _upperValue],
      maximumDistance: 15000.0,
      minimumDistance: _lowerValue,
      touchSize: 24,
      disabled: false,
      visibleTouchArea: false,
      rangeSlider: true,
      max: 15000,
      min: 0,
      handlerWidth: 20.r,
      handlerHeight: 20.r,
      selectByTap: false,
      handlerAnimation: FlutterSliderHandlerAnimation(scale: 1),
      rightHandler: FlutterSliderHandler(
          child: Container(
        decoration:
            BoxDecoration(color: Color(0xff313131), shape: BoxShape.circle),
      )),
      handler: FlutterSliderHandler(
        child: Container(
          decoration:
              BoxDecoration(color: Color(0xff313131), shape: BoxShape.circle),
        ),
      ),

      tooltip: FlutterSliderTooltip(
        disabled: false,
        custom: (value) {
          return Text(
            "\$" + value.toString(),
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          );
        },
        positionOffset: FlutterSliderTooltipPositionOffset(
          top: 0.0,
        ),
      ),
      trackBar: FlutterSliderTrackBar(
        activeTrackBarHeight: 9.h,
        inactiveTrackBarHeight: 9.h,
        inactiveTrackBar: BoxDecoration(
          borderRadius: BorderRadius.circular(35.r),
          color: Colors.black12,
          // border: Border.all(width: 3, color: Colors.blue),
        ),
        activeTrackBar: BoxDecoration(
            borderRadius: BorderRadius.circular(4), color: highlightedText),
      ),
      onDragging: (handlerIndex, lowerValue, upperValue) {
        setState(() {
          _lowerValue = lowerValue;
          _upperValue = upperValue;
          filterController.lowerValue.value = lowerValue;
          filterController.upperValue.value = upperValue;
        });
      },
    );
  }
}
