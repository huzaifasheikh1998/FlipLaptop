import 'dart:io';

import 'package:app_fliplaptop/Apiserrvices/Services.dart';
import 'package:app_fliplaptop/Controller/productController.dart';
import 'package:app_fliplaptop/Screens/AddProductDiscountScreen.dart';
import 'package:app_fliplaptop/res/utils/utils.dart';
import 'package:app_fliplaptop/widgets/disallow_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/global.dart';

class AddProductPriceScreen extends StatefulWidget {
  // List<String>? productImageList;
  // String? brandName;
  // String? modelName;
  // String? condition;
  // String? colorValue;
  // List<String>? productSizes;
  // String? memorySize;
  // String? DriveType;
  // String? DriveSize;
  // String? description;
  AddProductPriceScreen({
    super.key,
    // this.productImageList,
    // this.brandName,
    // this.modelName,
    // this.condition,
    // this.colorValue,
    // this.productSizes,
    // this.memorySize,
    // this.DriveType,
    // this.DriveSize,
    // this.description
  });

  @override
  State<AddProductPriceScreen> createState() => _AddProductPriceScreenState();
}

class _AddProductPriceScreenState extends State<AddProductPriceScreen> {
  TextEditingController amount = TextEditingController();
  TextEditingController quatity = TextEditingController();
  TextEditingController shippingCostController = TextEditingController();
  final addProductController = Get.put(ProductController());

  bool chk1 = true;
  bool chk2 = false;

  bool discount = false;

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
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: Colors.white),
                      // width: Get.width * 0.85,
                      width: 335.w,
                      height: 270.h,
                      // padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          101.verticalSpace,
                          Text(
                            'Congratulations',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          10.verticalSpace,
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 19.r),
                            // constraints: BoxConstraints(
                            //   maxWidth:  266.w
                            // ),
                            child: Text(
                              'Your product has been added',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 16.sp),
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
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 5)
                          ],
                          shape: BoxShape.circle,
                          gradient: kbtngradient,
                          border: Border.all(width: 3, color: highlightedText)),
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Add Product Price',
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
                      children: [
                        TextSpan(
                            text: "3",
                            style: GoogleFonts.inter(color: highlightedText)),
                        TextSpan(
                            text: "/",
                            style: GoogleFonts.inter(color: Colors.black)),
                        TextSpan(
                            text: discount ? "4" : "3",
                            style: GoogleFonts.inter(color: Colors.black))
                      ],
                      style: GoogleFonts.inter(
                          fontSize: 15.sp,
                          color: highlightedText,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              23.verticalSpace,
              Container(
                height: 10.h,
                width: Get.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.r)),
                child: Container(
                  decoration: BoxDecoration(
                      gradient: kbtngradient,
                      borderRadius: BorderRadius.circular(5.r)),
                ),
              ),
              30.verticalSpace,
              button2(388.w, 59.h, discount ? "Next" : 'Post', () {
                print("discount $discount");
                if (amount.text.isEmpty) {
                  Utils.showSnack("Enter Amount", context);
                } else if (quatity.text.isEmpty) {
                  Utils.showSnack("Enter Quantity", context);
                }
                // else if (shippingCostController.text.isEmpty) {
                //   Utils.showSnack("Enter Shipping Cost", context);
                // }
                else {
                  String deliveryType = chk1 ? "Delivery" : "Local_Pick";
                  addProductController.addproductApiModel["price"] =
                      amount.text;
                  addProductController.addproductApiModel["qty"] = quatity.text;
                  addProductController.addproductApiModel["delivery_type"] =
                      deliveryType;
                  //  addProductController.addproductApiModel["shipping_cost"]=shippingCostController.text;
                  if (discount) {
                    Get.to(() => AddProductDiscountScreen(
                          // productData: null,
                          isEdit: false,
                          imageFile: File(addProductController
                              .addproductApiModel["images[]"][0]),
                          productID:
                              addProductController.editDatumInstance.value.id ??
                                  "",
                        ));
                  } else {
                    addProductController
                        .addproductApiModel["discount[0][name]"] = "";
                    addProductController
                        .addproductApiModel["discount[0][type]"] = "";
                    addProductController
                        .addproductApiModel["discount[0][price]"] = "";
                    addProductController.addproductApiModel[
                        "discount[0][percentage_target]"] = "";
                    addProductController
                        .addproductApiModel["discount[0][start_datetime]"] = "";
                    addProductController
                        .addproductApiModel["discount[0][end_datetime]"] = "";
                    print("Api call");

                    setState(() {
                      ApiServices().callProductCreate2(context, 3);
                    });
                  }
                  // var data = {};
                  // ApiServices().callProductCreate(
                  //     context,
                  //     data,
                  //     "1",
                  //     amount.text.toString(),
                  //     widget.brandName!,
                  //     quatity.text.toString(),
                  //     widget.productSizes!.first,
                  //     widget.memorySize!,
                  //     widget.condition!,
                  //     deliveryType,
                  //     widget.modelName!,
                  //     "128 GB SSD",
                  //     widget.colorValue!,
                  //     "6",
                  //     "publish",
                  //     "location",
                  //     widget.description!,
                  //     "link",
                  //     File(widget.productImageList!.first!));
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
                'Price',
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
                child: Row(
                  children: [
                    10.horizontalSpace,
                    Image.asset('assets/Icon metro-dollar.png'),
                    Expanded(
                      child: TextField(
                        maxLines: 1,
                        controller: amount,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        style: GoogleFonts.inter(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 16.sp),
                        decoration: InputDecoration(
                          isDense: true,
                          isCollapsed: true,
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 10.r),
                          hintText: 'Add Amount',
                          helperStyle: GoogleFonts.inter(
                              color: Colors.black.withOpacity(0.5)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              15.verticalSpace,
              Text(
                'Quantity',
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
                  controller: quatity,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  style: GoogleFonts.inter(
                      color: Colors.black.withOpacity(0.5), fontSize: 16.sp),
                  decoration: InputDecoration(
                      isDense: true,
                      isCollapsed: true,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.r),
                      hintText: 'Number of items',
                      helperStyle: GoogleFonts.inter(
                          color: Colors.black.withOpacity(0.5))),
                ),
              ),
              29.verticalSpace,
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        if (chk1 == false) chk1 = !chk1;
                        if (chk2 == true) chk2 = !chk2;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.all(1.4),
                      padding: const EdgeInsets.all(1.7),
                      decoration: BoxDecoration(
                          color: chk1 ? kprimaryColor : Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(width: 2.0, color: kprimaryColor)),
                      child: Icon(
                        Icons.circle,
                        size: 12.0,
                        color: chk1 ? kprimaryColor : Colors.white,
                      ),
                    ),
                  ),
                  10.horizontalSpace,
                  Text(
                    'Delivery',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.sp),
                  )
                ],
              ),
              20.verticalSpace,
              // Row(
              //   children: [
              //     // InkWell(
              //     //   onTap: () {
              //     //     setState(() {
              //     //       if (chk2 == false) chk2 = !chk2;
              //     //       if (chk1 == true) chk1 = !chk1;
              //     //     });
              //     //   },
              //     //   child: Container(
              //     //     margin: const EdgeInsets.all(1.4),
              //     //     padding: const EdgeInsets.all(1.7),
              //     //     decoration: BoxDecoration(
              //     //         color: chk2 ? kprimaryColor : Colors.white,
              //     //         shape: BoxShape.circle,
              //     //         border: Border.all(width: 2.0, color: kprimaryColor)),
              //     //     child: Icon(
              //     //       Icons.circle,
              //     //       size: 12.0,
              //     //       color: chk2 ? kprimaryColor : Colors.white,
              //     //     ),
              //     //   ),
              //     // ),
              //     10.horizontalSpace,
              //     Text(
              //       'Local pick',
              //       style: TextStyle(
              //           color: Colors.black,
              //           fontSize: 18.sp,
              //           fontWeight: FontWeight.w600),
              //     )
              //   ],
              // ),
              // 29.verticalSpace,
              // Text(
              //   'Shipping Cost',
              //   style: GoogleFonts.inter(
              //       color: Colors.black,
              //       fontSize: 18.sp,
              //       fontWeight: FontWeight.w600),
              // ),
              // 15.verticalSpace,
              // Container(
              //   height: 60.h,
              //   alignment: Alignment.center,
              //   decoration: BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: BorderRadius.circular(30.r)),
              //   child: TextField(
              //     maxLines: 1,
              //     controller: shippingCostController,
              //     keyboardType: TextInputType.number,
              //     inputFormatters: <TextInputFormatter>[
              //       FilteringTextInputFormatter.digitsOnly
              //     ],
              //     style: GoogleFonts.inter(
              //         color: Colors.black.withOpacity(0.5), fontSize: 16.sp),
              //     decoration: InputDecoration(
              //         isDense: true,
              //         isCollapsed: true,
              //         border: InputBorder.none,
              //         contentPadding: EdgeInsets.symmetric(horizontal: 20.r),
              //         hintText: 'Shipping Cost',
              //         helperStyle: GoogleFonts.inter(
              //             color: Colors.black.withOpacity(0.5))),
              //   ),
              // ),
              29.verticalSpace,
              Text(
                'Discount',
                style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600),
              ),
              15.verticalSpace,
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        if (!discount) {
                          discount = !discount;
                        }
                        // if (chk1 == false) chk1 = !chk1;
                        // if (chk2 == true) chk2 = !chk2;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.all(1.4),
                      padding: const EdgeInsets.all(1.7),
                      decoration: BoxDecoration(
                          color: discount ? kprimaryColor : Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(width: 2.0, color: kprimaryColor)),
                      child: Icon(
                        Icons.circle,
                        size: 12.0,
                        color: discount ? kprimaryColor : Colors.white,
                      ),
                    ),
                  ),
                  10.horizontalSpace,
                  Text(
                    'Yes',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.sp),
                  )
                ],
              ),
              20.verticalSpace,
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        if (discount) {
                          discount = !discount;
                        }
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.all(1.4),
                      padding: const EdgeInsets.all(1.7),
                      decoration: BoxDecoration(
                          color: !discount ? kprimaryColor : Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(width: 2.0, color: kprimaryColor)),
                      child: Icon(
                        Icons.circle,
                        size: 12.0,
                        color: !discount ? kprimaryColor : Colors.white,
                      ),
                    ),
                  ),
                  10.horizontalSpace,
                  Text(
                    'No',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
