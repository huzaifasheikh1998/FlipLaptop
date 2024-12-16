import 'package:app_fliplaptop/Apiserrvices/Services.dart';
import 'package:app_fliplaptop/Apiserrvices/app_url.dart';
import 'package:app_fliplaptop/Apiserrvices/loader.dart';
import 'package:app_fliplaptop/Controller/dealController.dart';
import 'package:app_fliplaptop/components/customNetworkImage.dart';
import 'package:app_fliplaptop/components/global.dart';
import 'package:app_fliplaptop/res/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AddTextScreen extends StatelessWidget {
  AddTextScreen({super.key, });

  // bool? isSubscribedUser = false;

  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(Duration(days: 14));
  TextEditingController dealTitle = TextEditingController();
  TextEditingController dealDescription = TextEditingController();
  TextEditingController salePercentage = TextEditingController();
  TextEditingController startDate = TextEditingController(
      text: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()));
  TextEditingController endDate = TextEditingController(
      text: DateFormat('yyyy-MM-dd HH:mm:ss')
          .format(DateTime.now().add(Duration(days: 14))));
  final DealController dealController = Get.put(DealController());
  // String? SelectedDealImageUrl;

  loadImage() async {
    int foundInd = await dealController.listOfDealIndex.indexWhere(
            (element) => element.id == dealController.onTapIndexID.value);
    if (foundInd != -1) {
      dealController.SelectedDealImageUrl.value =
          ImageUrls.dealUrl + dealController.listOfDealIndex[foundInd].image;
      // log("Image url"+SelectedDealImageUrl.t);
    }}

    bool isNumeric(String str) {
      try{
        var value = double.parse(str);
      } on FormatException {
        return false;
      } finally {
        return true;
      }
    }

    // print(int.parse('0xab'));

  @override
  Widget build(BuildContext context) {
    loadImage();
    // isSubscribedUser ?? false;

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
          'Add Deal Details',
          style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 20.r),
        child: button2(388.w, 59.h, 'Continue', () {
          if (dealTitle.text.isEmpty ||
              salePercentage.text.isEmpty ||
              dealDescription.text.isEmpty ||
              startDate.text.isEmpty ||
              endDate.text.isEmpty) {
            Utils.showSnack("Fill out all the details", context);
          }
          else if (int.parse(salePercentage.text)>100 ){
            Utils.showSnack("Enter valid deal Percent", context);

          }

          else {
            dealController.addDeal(
              ApiServices.storeId,
              dealController.onTapIndexID.value,
              dealTitle.text,
              dealDescription.text,
              salePercentage.text,
              startDate.text,
              endDate.text,
            );
          }
          ;
        }),
      ),
      body: Obx(() {
        return dealController.isLoading.value
            ? Center(
                child: Loader.spinkit,
              )
            : ListView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 10.r),
                children: [
                  Container(
                    width: Get.width,
                    height: 226.h,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 10,
                            spreadRadius: 0.4)
                      ],
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          10.sp,
                        ),
                      ),
                      child: CustomNetworkImage(
                        imageUrl: dealController.SelectedDealImageUrl.value ?? "",
                      ),
                    ),
                  ),
                  30.verticalSpace,
                  // Text(
                  //   'Special Offer',
                  //   style: GoogleFonts.inter(
                  //       fontWeight: FontWeight.w600,
                  //       fontSize: 22.sp,
                  //       color: Colors.black),
                  // ),
                  // 15.verticalSpace,
                  // Text(
                  //   'Fashion Sale',
                  //   style: GoogleFonts.inter(
                  //       fontWeight: FontWeight.w600,
                  //       fontSize: 22.sp,
                  //       color: highlightedText),
                  // ),
                  // 15.verticalSpace,
                  // Text(
                  //   'Shope Online Sale',
                  //   style: GoogleFonts.inter(
                  //     fontSize: 18.sp,
                  //     fontWeight: FontWeight.w600,
                  //   ),
                  // ),
                  // 15.verticalSpace,
                  // Text(
                  //   '50% OFF',
                  //   style: GoogleFonts.inter(
                  //     fontSize: 38.sp,
                  //     fontWeight: FontWeight.w600,
                  //   ),
                  // ),
                  Text(
                    'Deal Title',
                    style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  15.verticalSpace,
                  Container(
                    height: 60.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30.r)),
                    child: TextField(
                      maxLines: 1,
                      controller: dealTitle,
                      keyboardType: TextInputType.text,
                      style: GoogleFonts.inter(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 16.sp),
                      decoration: InputDecoration(
                          isDense: true,
                          isCollapsed: true,
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 20.r),
                          hintText: 'Enter Deal Title..',
                          helperStyle: GoogleFonts.inter(
                              color: Colors.black.withOpacity(0.5))),
                    ),
                  ),
                  29.verticalSpace,
                  Text(
                    'Sale Percentage',
                    style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  15.verticalSpace,
                  Container(
                    height: 60.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30.r)),
                    child: TextField(
                      maxLines: 1,
                      controller: salePercentage,
                      maxLength: 3,
                      keyboardType: TextInputType.text,
                      style: GoogleFonts.inter(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 16.sp),
                      decoration: InputDecoration(
                        counterText: "",
                          isDense: true,
                          isCollapsed: true,
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 20.r),
                          hintText: 'Enter Sale Percentage..',
                          helperStyle: GoogleFonts.inter(
                              color: Colors.black.withOpacity(0.5))),
                    ),
                  ),
                  29.verticalSpace,
                  Text(
                    'Deal Description',
                    style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  15.verticalSpace,
                  Container(
                    height: 130.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30.r)),
                    child: TextField(
                      maxLines: 5,
                      controller: dealDescription,
                      keyboardType: TextInputType.text,
                      style: GoogleFonts.inter(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 16.sp),
                      decoration: InputDecoration(
                          isDense: true,
                          isCollapsed: true,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20.r, vertical: 10.r),
                          hintText: 'Enter Deal Description..',
                          helperStyle: GoogleFonts.inter(
                              color: Colors.black.withOpacity(0.5))),
                    ),
                  ),

                  20.verticalSpace,
                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            29.verticalSpace,
                            Text(
                              'Start Date',
                              style: GoogleFonts.inter(
                                  color: Colors.black,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                            15.verticalSpace,
                            Container(
                              height: 60.h,
                              width: 0.4.sw,
                              padding: EdgeInsets.all(15),
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30.r)),
                              child: Text(
                                startDate.text.substring(0,10),
                                style: GoogleFonts.inter(
                                    color: Colors.black.withOpacity(0.5),
                                    fontSize: 16.sp),
                              ),
                              // TextField(
                              //   enabled: false,
                              //   maxLines: 1,
                              //   maxLength: 2,
                              //   controller: startDate,
                              //   // keyboardType: TextInputType.number,
                              //   inputFormatters: <TextInputFormatter>[
                              //     FilteringTextInputFormatter.digitsOnly
                              //   ],
                              //   style: GoogleFonts.inter(
                              //       color: Colors.black.withOpacity(0.5),
                              //       fontSize: 16.sp),
                              //   decoration: InputDecoration(
                              //       counterText: "",
                              //       isDense: true,
                              //       isCollapsed: true,
                              //       border: InputBorder.none,
                              //       contentPadding:
                              //           EdgeInsets.symmetric(horizontal: 20.r),
                              //       hintText: 'Start Date',
                              //       helperStyle: GoogleFonts.inter(
                              //           color: Colors.black.withOpacity(0.5))),
                              // ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            29.verticalSpace,
                            Text(
                              'End Date',
                              style: GoogleFonts.inter(
                                  color: Colors.black,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                            15.verticalSpace,
                            Container(
                              height: 60.h,
                              width: 0.4.sw,
                              padding: EdgeInsets.all(15),
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30.r)),
                              child: Text(
                                endDate.text.substring(0,10),
                                style: GoogleFonts.inter(
                                    color: Colors.black.withOpacity(0.5),
                                    fontSize: 16.sp),
                              ),
                              // TextField(
                              //   enabled: false,
                              //   maxLines: 1,
                              //   maxLength: 2,
                              //   controller: startDate,
                              //   // keyboardType: TextInputType.number,
                              //   inputFormatters: <TextInputFormatter>[
                              //     FilteringTextInputFormatter.digitsOnly
                              //   ],
                              //   style: GoogleFonts.inter(
                              //       color: Colors.black.withOpacity(0.5),
                              //       fontSize: 16.sp),
                              //   decoration: InputDecoration(
                              //       counterText: "",
                              //       isDense: true,
                              //       isCollapsed: true,
                              //       border: InputBorder.none,
                              //       contentPadding:
                              //           EdgeInsets.symmetric(horizontal: 20.r),
                              //       hintText: 'Start Date',
                              //       helperStyle: GoogleFonts.inter(
                              //           color: Colors.black.withOpacity(0.5))),
                              // ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  29.verticalSpace,
                  Container(
                    width: double.infinity,
                    child: SfDateRangePicker(
                      enablePastDates: false,
                      todayHighlightColor: highlightedText,
                      selectionTextStyle: TextStyle(color: Colors.white),
                      selectionColor: highlightedText,
                      endRangeSelectionColor: highlightedText,
                      startRangeSelectionColor: highlightedText,
                      rangeSelectionColor: Color.fromARGB(40, 235, 6, 6),
                      // onSelectionChanged: _onSelectionChanged,
                      selectionMode: DateRangePickerSelectionMode.range,
                      initialSelectedRange: PickerDateRange(_startDate, _endDate
                          // DateTime.now(),
                          // DateTime.now().add(const Duration(days: 14))
                          ),
                      onSelectionChanged:
                          (DateRangePickerSelectionChangedArgs args) {
                        String _range = "";
                        if (args.value is PickerDateRange) {
                          startDate.text = DateFormat("yyyy-MM-dd HH:mm:ss")
                              .format(args.value.startDate);
                          endDate.text = DateFormat("yyyy-MM-dd HH:mm:ss")
                              .format(
                                  args.value.endDate ?? args.value.startDate);
                          _range =
                              '${DateFormat('yyyy-MM-dd HH:mm:ss').format(args.value.startDate)} -'
                              // ignore: lines_longer_than_80_chars
                              ' ${DateFormat('yyyy-MM-dd HH:mm:ss').format(args.value.endDate ?? args.value.startDate)}';
                          print(_range);
                        }
                        // startDate.text = _startDate.toString();
                        // endDate.text = _endDate.toString();
                        // print(args.);
                      },
                      // onViewChanged: (DateRange) {
                      //   print(arf)
                      //   print(_startDate);
                      //   print(_endDate);
                      // },
                    ),
                  )
                ],
              );
      }),
    );
  }
}
