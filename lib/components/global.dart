import 'dart:math';

import 'package:app_fliplaptop/Apiserrvices/Services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
//Global Variable Declaration

passwordShowController _cont = Get.put(passwordShowController());
var forgotPwd = false;
String select = "";

// var authToken;
bool singup_verification = false;
//Decoration Assets
LinearGradient kgradient = LinearGradient(
    begin: Alignment.center,
    end: Alignment.bottomCenter,
    transform: GradientRotation(180 * pi / 180),
    colors: [
      Color(0xff7D0000),
      Color(0xffE10000),
    ]);
LinearGradient kbtngradient = LinearGradient(
    begin: Alignment(1.0, 1.0),
    end: Alignment(-1.0, -1.0),
    transform: GradientRotation(168 * pi / 180),
    colors: [Color(0xff121314), Color(0xff4C5157)]);
LinearGradient kbtngradientDisabled = LinearGradient(
    begin: Alignment(1.0, 1.0),
    end: Alignment(-1.0, -1.0),
    transform: GradientRotation(168 * pi / 180),
    colors: [Colors.grey.shade700, Color(0xff4C5157)]);
Color kprimaryColor = Color(0xffE10000);
Color kPageBgColor = Color(0xfff1f2f7);
Color highlightedText = Color(0xffC20000);
//Widget define for App
TextBox(hintText, contr, validd, preIcn) {
  return Container(
      height: 61.h,
      child: TextFormField(
        validator: validd,
        cursorColor: Colors.white,
        controller: contr,
        style: TextStyle(fontSize: 17.sp, color: Colors.white),
        decoration: InputDecoration(
            prefixIcon: preIcn,
            isCollapsed: true,
            isDense: true,
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 17.sp,
              color: Colors.white,
            )),
      ));
}

PasswordBox(hintText, contr, fun, valid) {
  return GetBuilder(
      init: _cont,
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 25.r, vertical: 18.r),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(35.r), right: Radius.circular(35.r)),
              border: Border.all(width: 1, color: Colors.white)),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  validator: valid,
                  cursorColor: Colors.white,
                  controller: contr,
                  style: TextStyle(fontSize: 17.sp, color: Colors.white),
                  obscureText: fun == 1 ? _cont.show1.value : _cont.show2.value,
                  decoration: InputDecoration(
                      isCollapsed: true,
                      border: InputBorder.none,
                      isDense: true,
                      hintText: hintText,
                      hintStyle:
                          TextStyle(fontSize: 17.sp, color: Colors.white)),
                ),
              ),
              7.horizontalSpace,
              InkWell(
                  onTap: () {
                    fun == 1 ? _cont._show1() : _cont._show2();
                  },
                  child: SvgPicture.asset('assets/Icon awesome-eye.svg')),
            ],
          ),
        );
      });
  ;
}

button(wd, hg, txt, fun) {
  return InkWell(
      onTap: fun,
      child: Container(
        width: wd,
        height: hg,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            gradient: kbtngradient,
            borderRadius: BorderRadius.horizontal(
                left: Radius.circular(35.r), right: Radius.circular(35.r))),
        child: Text(
          txt,
          style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold),
        ),
      ));
}

Dialogbutton(wd, hg, txt, fun) {
  return InkWell(
      onTap: fun,
      child: Container(
        width: wd,
        height: hg,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            gradient: kbtngradient,
            borderRadius: BorderRadius.horizontal(
                left: Radius.circular(10.r), right: Radius.circular(10.r))),
        child: Text(
          txt,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 20.sp,
          ),
        ),
      ));
}

Dialogbutton2(wd, hg, txt, fun) {
  return InkWell(
      onTap: fun,
      child: Container(
        width: wd,
        height: hg,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            gradient: kgradient,
            borderRadius: BorderRadius.horizontal(
                left: Radius.circular(10.r), right: Radius.circular(10.r))),
        child: Text(
          txt,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 20.sp,
          ),
        ),
      ));
}

button2(wd, hg, txt, fun) {
  return InkWell(
      onTap: fun,
      child: Container(
        width: wd,
        height: hg,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            gradient: kgradient,
            borderRadius: BorderRadius.horizontal(
                left: Radius.circular(35.r), right: Radius.circular(35.r))),
        child: Text(
          txt,
          style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold),
        ),
      ));
}
// class AlwaysActiveBorderSide extends MaterialStateBorderSide {
//   @override
//   BorderSide? resolve(_) => BorderSide(color: , width: 1);
// }

//GetX Controllers
class passwordShowController extends GetxController {
  var show1 = false.obs;
  var show2 = false.obs;

  _show1() {
    show1.value = !show1.value;

    update();
  }

  _show2() {
    show2.value = !show2.value;
    update();
  }
}

TextEditingController _searchBrand = TextEditingController();

class BottomController extends GetxController {
  var navigationBarIndexValue = 0;
  var chk = List.generate(7, (index) => false, growable: false).obs;

  void navBarChange(value) {
    navigationBarIndexValue = value;
    update();
  }

  chkInvert(_chk) {
    _chk = true;
    // chk.forEach((element) => element = false);
    update();
  }
}

Future<dynamic> LogoutPopup(BuildContext context) {
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
                    padding: EdgeInsets.symmetric(horizontal: 10.r),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        color: Colors.white),
                    // width: Get.width * 0.85,
                    width: 343.w,
                    height: 270.h,
                    // padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        101.verticalSpace,
                        Text(
                          'Logout',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        10.verticalSpace,
                        Container(
                          constraints: BoxConstraints(maxWidth: 168.w),
                          child: Text(
                            'Are you sure you want to logout?',
                            style:
                                TextStyle(color: Colors.black, fontSize: 16.sp),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        15.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Dialogbutton2(
                              151.w,
                              50.h,
                              "Logout",
                              () async {
                                var data = {};
                                await ApiServices().callLogout(context, data);
                                // Get.close(4);
                                // Get.toNamed('/LoginScreen');
                              },
                            ),
                            Dialogbutton(
                              151.w,
                              50.h,
                              "Cancel",
                              () {
                                Get.close(1);
                              },
                            ),
                          ],
                        ),
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

Future<dynamic> ConfirmationPopup(
  BuildContext context,
  String heading,
  String middleText,
  String leftButtonText,
  String rightButtonText,
  void Function()? onLeftTap,
  void Function()? onRightTap,
) {
  return showDialog(
      context: context,
      builder: (context) {
        return Center(
            child: Material(
          type: MaterialType.transparency,
          child: Container(
            // height: 410.h,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.r),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        color: Colors.white),
                    // width: Get.width * 0.85,
                    width: 343.w,
                    height: 330.h,
                    // padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        110.verticalSpace,
                        Text(
                          heading,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        20.verticalSpace,
                        Container(
                          constraints: BoxConstraints(maxWidth: 168.w),
                          child: Text(
                            middleText,
                            style:
                                TextStyle(color: Colors.black, fontSize: 16.sp),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        30.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Dialogbutton2(
                              151.w,
                              50.h,
                              leftButtonText,
                              onLeftTap,
                            ),
                            Dialogbutton(
                              151.w,
                              50.h,
                              rightButtonText,
                              onRightTap,
                            ),
                          ],
                        ),
                      ],
                    )),
                Positioned(
                  top: -60,
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

class products {
  String? productName;
  String? productDetailtext;
  String? productPrice;
  String? productRating;
  String? productImage;
  RxInt Quantity = 1.obs;
  bool isSelected = true;

  products(this.productName, this.productDetailtext, this.productPrice,
      this.productImage, this.productRating);
}

class purchaseProductsController extends GetxController {
  var chk = false.obs;
  var purchaseProduct = [
    products(
        'MacBook Pro',
        'Lorem ipsum dolor sit amet consectetur adipiscing elit',
        '\$ 15.59',
        'assets/M2-MacBook-Air-2022-Feature0012.png',
        '(4.9)'),
    products(
        'Apple Mac Book',
        'Lorem ipsum dolor sit amet consectetur adipiscing elit',
        '\$ 15.59',
        'assets/andras-vas-Bd7gNnWJBkU-unsplash.png',
        '(4.9)'),
    products(
        'Dell Laptop',
        'Lorem ipsum dolor sit amet consectetur adipiscing elit',
        '\$ 15.59',
        'assets/M2-MacBook-Air-2022-Feature0012(2).png',
        '(4.9)'),
    products(
        'MacBook Pro',
        'Lorem ipsum dolor sit amet consectetur adipiscing elit',
        '\$ 15.59',
        'assets/alex-knight-j4uuKnN43_M-unsplash.png',
        '(4.9)'),
    products(
        'MacBook Pro',
        'Lorem ipsum dolor sit amet consectetur adipiscing elit',
        '\$ 15.59',
        'assets/maxim-hopman-Hin-rzhOdWs-unsplash.png',
        '(4.9)'),
    products(
        'MacBook Pro',
        'Lorem ipsum dolor sit amet consectetur adipiscing elit',
        '\$ 15.59',
        'assets/andras-vas-Bd7gNnWJBkU-unsplash.png',
        '(4.9)'),
  ].obs;

  productCheck(index) {
    purchaseProduct[index].isSelected = !(purchaseProduct[index].isSelected);
    update();
  }

  add(index) {
    purchaseProduct[index].Quantity = purchaseProduct[index].Quantity! + 1;
    update();
  }

  minus(index) {
    if (purchaseProduct[index].Quantity! != 0) {
      purchaseProduct[index].Quantity = purchaseProduct[index].Quantity! - 1;
    }
    update();
  }

  checkAll() {
    if (chk.value == false)
      chk.value = true;
    else
      chk.value = false;

    update();
  }
}

//CREATE STORE

var createStore = false;
