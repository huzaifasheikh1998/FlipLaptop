import 'package:app_fliplaptop/Apiserrvices/Services.dart';
import 'package:app_fliplaptop/Screens/MyOrderScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/global.dart';

class MyOrderTypeScreen extends StatefulWidget {
  const MyOrderTypeScreen({super.key});

  @override
  State<MyOrderTypeScreen> createState() => _MyOrderTypeScreenState();
}


class _MyOrderTypeScreenState extends State<MyOrderTypeScreen> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    Future.delayed(Duration(seconds: 1),(){

      orderController.getSellerList(ApiServices.storeId);
      orderController.getPurchaseList();
    });

  }
  @override
  Widget build(BuildContext context) {

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
            'My Orders',
            style: GoogleFonts.inter(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                button2(220.w, 59.h, 'Purchase', () {
                  Get.to(()=> MyOrderScreen(isSeller: false,));
                }),
                SizedBox(
                  height: 20.h,
                ),
                button2(220.w, 59.h, 'Sell', () {
                  Get.to(()=> MyOrderScreen(isSeller: true,));
                }),
              ],
            ),
          ],
        ));
  }
}
