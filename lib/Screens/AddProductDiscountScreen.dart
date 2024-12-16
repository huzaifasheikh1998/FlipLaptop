import 'dart:io';

import 'package:app_fliplaptop/Apiserrvices/Services.dart';
import 'package:app_fliplaptop/Controller/productController.dart';
import 'package:app_fliplaptop/Screens/ListOfProduct.dart';
import 'package:app_fliplaptop/models/dashBoardModel.dart';
import 'package:app_fliplaptop/models/product_category_data_model/display_size.dart';
import 'package:app_fliplaptop/res/utils/utils.dart';
import 'package:app_fliplaptop/widgets/disallow_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../components/global.dart';

class AddProductDiscountScreen extends StatefulWidget {
  final bool isEdit;
  File? imageFile;
  final String productID;
  final Datum? productData;

  AddProductDiscountScreen({super.key, required this.isEdit, required this.imageFile, required this.productID, this.productData});

  @override
  State<AddProductDiscountScreen> createState() => _AddProductDiscountScreenState(isEdit: isEdit, imageFile: imageFile, productID: productID!);
}

class _AddProductDiscountScreenState extends State<AddProductDiscountScreen> {
  final bool isEdit;
  File? imageFile;
  final String productID;

  _AddProductDiscountScreenState({required this.isEdit, required this.imageFile, required this.productID});

  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(Duration(days: 14));
  TextEditingController discountName = TextEditingController();
  TextEditingController discountAmount = TextEditingController();
  TextEditingController discountPercentage = TextEditingController();
  TextEditingController startDate = TextEditingController(text: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()));
  TextEditingController endDate = TextEditingController(text: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now().add(Duration(days: 14))));

  final addProductController = Get.put(ProductController());

// startDate.text = "";
  bool disTypeAmount = false;

  Future<dynamic> ConguratulationPopup(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return Center(
              child: Material(
            type: MaterialType.transparency,
            child: Container(
              height: 410.h,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 24.r),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r), color: Colors.white),
                      // width: Get.width * 0.85,
                      width: 335.w,
                      height: 270.h,
                      // padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          101.verticalSpace,
                          Text(
                            'Congratulations',
                            style: TextStyle(color: Colors.black, fontSize: 20.sp, fontWeight: FontWeight.bold),
                          ),
                          10.verticalSpace,
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 19.r),
                            // constraints: BoxConstraints(
                            //   maxWidth:  266.w
                            // ),
                            child: Text(
                              'Your product has been added',
                              style: TextStyle(color: Colors.black, fontSize: 16.sp),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          30.verticalSpace,
                          Dialogbutton2(Get.width, 50.h, "Go Back", () {
                            Get.toNamed('/StartAppScreen');
                          })
                        ],
                      )),
                  Positioned(
                    top: 0,
                    child: Container(
                      width: 152.r,
                      height: 152.r,
                      padding: EdgeInsets.all(27.r),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 5)], shape: BoxShape.circle, gradient: kbtngradient, border: Border.all(width: 3, color: highlightedText)),
                      child: Image.asset('assets/laptop-screen@3x.png'),
                    ),
                  ),
                ],
              ),
            ),
          ));
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    if (widget.productData != null) {
      if (widget.productData!.discount != null) {
        discountName.text = widget.productData!.discount!.name ?? "";
        // print("type" + widget.productData!.discount!.type);
        discountPercentage.text = widget.productData!.discount!.percentageTarget ?? "";
        startDate.text = widget.productData!.discount!.startDatetime.toString() ?? "";
        endDate.text = widget.productData!.discount!.endDatetime.toString() ?? "";
        _startDate = DateTime.parse(widget.productData!.discount!.startDatetime.toString());
        _endDate = DateTime.parse(widget.productData!.discount!.endDatetime.toString());
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Add Product Discount',
          style: GoogleFonts.inter(fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(shape: BoxShape.circle, gradient: kbtngradient),
              child: SvgPicture.asset(
                'assets/Path 11.svg',
                width: 14,
              )),
        ),
      ),
      bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 20.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [TextSpan(text: "4", style: GoogleFonts.inter(color: highlightedText)), TextSpan(text: "/", style: GoogleFonts.inter(color: Colors.black)), TextSpan(text: "4", style: GoogleFonts.inter(color: Colors.black))],
                      style: GoogleFonts.inter(fontSize: 15.sp, color: highlightedText, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              23.verticalSpace,
              Container(
                height: 10.h,
                width: Get.width,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5.r)),
                child: Container(
                  decoration: BoxDecoration(gradient: kbtngradient, borderRadius: BorderRadius.circular(5.r)),
                ),
              ),
              30.verticalSpace,
              button2(388.w, 59.h, 'Post', () async {
                // print(int.parse(discountAmount.text));
                // print(int.parse(
                //     addProductController.addproductApiModel["price"]));
                // print("discount amount $disTypeAmount");
                if (discountName.text.isEmpty) {
                  Utils.showSnack("Enter Discount Name", context);
                } else if (disTypeAmount && discountAmount.text.isEmpty) {
                  Utils.showSnack("Enter Discount Amount", context);
                } else if (disTypeAmount && int.parse("${discountAmount.text}") > int.parse(addProductController.addproductApiModel["price"])) {
                  Utils.showSnack("Enter Correct Discount Amount", context);
                } else if (!disTypeAmount && discountPercentage.text.isEmpty) {
                  Utils.showSnack("Enter Discount Percentage", context);
                } else {
                  String discountType = disTypeAmount ? "direct_amount" : "percentage";
                  if (disTypeAmount) {
                    addProductController.addproductApiModel["discount[0][price]"] = discountAmount.text;
                    addProductController.addproductApiModel["discount[0][percentage_target]"] = "";
                  } else {
                    addProductController.addproductApiModel["discount[0][price]"] = "";
                    addProductController.addproductApiModel["discount[0][percentage_target]"] = discountPercentage.text;
                  }
                  addProductController.addproductApiModel["discount[0][name]"] = discountName.text;
                  addProductController.addproductApiModel["discount[0][type]"] = discountType;
                  addProductController.addproductApiModel["discount[0][start_datetime]"] = startDate.text;
                  addProductController.addproductApiModel["discount[0][end_datetime]"] = endDate.text;
                  print(addProductController.addproductApiModel);
                  var editIns = addProductController.editDatumInstance.value;
                  if (isEdit) {
                    /// this needs to be done
                    // List<DisplaySize> sizeList = <DisplaySize>[];
                    // editIns.size!.forEach((element) {
                    //   sizeList.add(DisplaySize(id: element.id,name: element.name));
                    // });
                    await addProductController.editProductDiscount(int.parse(productID), discountName.text, discountType, startDate.text, endDate.text, discountPercentage.text, discountAmount.text);
                    await ApiServices().updateProduct(
                        context,
                        editIns.name,
                        editIns.price.toString(),
                        editIns.qty.toString(),
                        editIns.size!.cast<DisplaySize>(),
                        editIns.memory!.id,
                        editIns.conditionType,
                        "cash on Delivery",
                        editIns.model,
                        editIns.hardDrive!.id,
                        editIns.color!.id,
                        // productColor,
                        editIns.descriptions,
                        editIns.shippingCost,
                        "draft",
                        imageFile,
                        productID.toString(),
                        productController.deletedExistingImageList
                        // editIns.deleteImageIds ?? [],
                        );
                  } else {
                    ApiServices().callProductCreate2(context, 4);
                  }
                }
              }
                  //ConguratulationPopup(context)
                  ),
            ],
          )),
      body: GestureDetector(
        onTap: () {
          // Close the keyboard and remove focus from TextField when tapped outside
          FocusScope.of(context).unfocus();
        },
        child: DisAllowIndicatorWidget(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20.r),
            children: [
              Text(
                'Discount Name',
                style: GoogleFonts.inter(color: Colors.black, fontSize: 18.sp, fontWeight: FontWeight.w600),
              ),
              15.verticalSpace,
              Container(
                height: 60.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30.r)),
                child: TextField(
                  maxLines: 1,
                  controller: discountName,
                  keyboardType: TextInputType.text,
                  style: GoogleFonts.inter(color: Colors.black.withOpacity(0.5), fontSize: 16.sp),
                  decoration: InputDecoration(isDense: true, isCollapsed: true, border: InputBorder.none, contentPadding: EdgeInsets.symmetric(horizontal: 20.r), hintText: 'Name', helperStyle: GoogleFonts.inter(color: Colors.black.withOpacity(0.5))),
                ),
              ),
              29.verticalSpace,
              Text(
                'Discount Type',
                style: GoogleFonts.inter(color: Colors.black, fontSize: 18.sp, fontWeight: FontWeight.w600),
              ),
              15.verticalSpace,
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        if (!disTypeAmount) {
                          disTypeAmount = !disTypeAmount;
                          discountAmount.clear();
                        }

                        // if (chk1 == false) chk1 = !chk1;
                        // if (chk2 == true) chk2 = !chk2;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.all(1.4),
                      padding: const EdgeInsets.all(1.7),
                      decoration: BoxDecoration(color: disTypeAmount ? kprimaryColor : Colors.white, shape: BoxShape.circle, border: Border.all(width: 2.0, color: kprimaryColor)),
                      child: Icon(
                        Icons.circle,
                        size: 12.0,
                        color: disTypeAmount ? kprimaryColor : Colors.white,
                      ),
                    ),
                  ),
                  10.horizontalSpace,
                  Text(
                    'Amount',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18.sp),
                  )
                ],
              ),
              20.verticalSpace,
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        if (disTypeAmount) {
                          disTypeAmount = !disTypeAmount;
                          discountPercentage.clear();
                        }
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.all(1.4),
                      padding: const EdgeInsets.all(1.7),
                      decoration: BoxDecoration(color: !disTypeAmount ? kprimaryColor : Colors.white, shape: BoxShape.circle, border: Border.all(width: 2.0, color: kprimaryColor)),
                      child: Icon(
                        Icons.circle,
                        size: 12.0,
                        color: !disTypeAmount ? kprimaryColor : Colors.white,
                      ),
                    ),
                  ),
                  10.horizontalSpace,
                  Text(
                    'Percentage',
                    style: TextStyle(color: Colors.black, fontSize: 18.sp, fontWeight: FontWeight.w600),
                  )
                ],
              ),
              disTypeAmount
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        29.verticalSpace,
                        Text(
                          'Discount Amount',
                          style: GoogleFonts.inter(color: Colors.black, fontSize: 18.sp, fontWeight: FontWeight.w600),
                        ),
                        15.verticalSpace,
                        Container(
                          height: 60.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30.r)),
                          child: TextField(
                            maxLines: 1,
                            controller: discountAmount,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                            style: GoogleFonts.inter(color: Colors.black.withOpacity(0.5), fontSize: 16.sp),
                            decoration: InputDecoration(isDense: true, isCollapsed: true, border: InputBorder.none, contentPadding: EdgeInsets.symmetric(horizontal: 20.r), hintText: 'Amount', helperStyle: GoogleFonts.inter(color: Colors.black.withOpacity(0.5))),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        29.verticalSpace,
                        Text(
                          'Discount Percentage',
                          style: GoogleFonts.inter(color: Colors.black, fontSize: 18.sp, fontWeight: FontWeight.w600),
                        ),
                        15.verticalSpace,
                        Container(
                          height: 60.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30.r)),
                          child: TextField(
                            maxLines: 1,
                            maxLength: 2,
                            controller: discountPercentage,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                            style: GoogleFonts.inter(color: Colors.black.withOpacity(0.5), fontSize: 16.sp),
                            decoration: InputDecoration(counterText: "", isDense: true, isCollapsed: true, border: InputBorder.none, contentPadding: EdgeInsets.symmetric(horizontal: 20.r), hintText: 'Percentage', helperStyle: GoogleFonts.inter(color: Colors.black.withOpacity(0.5))),
                          ),
                        ),
                      ],
                    ),
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
                          style: GoogleFonts.inter(color: Colors.black, fontSize: 18.sp, fontWeight: FontWeight.w600),
                        ),
                        15.verticalSpace,
                        Container(
                          height: 60.h,
                          width: 0.4.sw,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30.r)),
                          child: Center(
                            child: Text(
                              startDate.text.substring(0, 10),
                              style: GoogleFonts.inter(color: Colors.black.withOpacity(0.5), fontSize: 16.sp),
                            ),
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
                          style: GoogleFonts.inter(color: Colors.black, fontSize: 18.sp, fontWeight: FontWeight.w600),
                        ),
                        15.verticalSpace,
                        Container(
                          width: 0.4.sw,
                          height: 60.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30.r)),
                          child: Center(
                            child: Text(
                              endDate.text.substring(0, 10),
                              style: GoogleFonts.inter(color: Colors.black.withOpacity(0.5), fontSize: 16.sp),
                            ),
                          ),
                          // TextField(
                          //   enabled: false,
                          //   maxLines: 1,
                          //   // maxLength: 2,
                          //   controller: endDate,
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
                          //       hintText: 'End Date',
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
                  onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                    String _range = "";
                    if (args.value is PickerDateRange) {
                      startDate.text = DateFormat("yyyy-MM-dd HH:mm:ss").format(args.value.startDate);
                      endDate.text = DateFormat("yyyy-MM-dd HH:mm:ss").format(args.value.endDate ?? args.value.startDate);
                      _range = '${DateFormat('yyyy-MM-dd HH:mm:ss').format(args.value.startDate)} -'
                          // ignore: lines_longer_than_80_chars
                          ' ${DateFormat('yyyy-MM-dd HH:mm:ss').format(args.value.endDate ?? args.value.startDate)}';
                      print(_range);
                    }
                    // startDate.text = _startDate.toString();
                    // endDate.text = _endDate.toString();
                    // print(args.);
                    setState(() {});
                  },
                  // onViewChanged: (DateRange) {
                  //   print(arf)
                  //   print(_startDate);
                  //   print(_endDate);
                  // },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
