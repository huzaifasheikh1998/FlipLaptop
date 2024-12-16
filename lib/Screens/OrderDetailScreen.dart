import 'package:app_fliplaptop/components/global.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderDetailScreen extends StatefulWidget {
  OrderDetailScreen({super.key});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 20.r),
          child: button2(388.w, 59.h, 'Update Customer', () {}),
        ),
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
            'Order Details',
            style: GoogleFonts.inter(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
        ),
        body: ListView(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20.r),
          children: [
            Container(
              // height: 125.h,
              padding: EdgeInsets.only(
                  top: 20.r, bottom: 21.r, left: 20, right: 20.r),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 6,
                        offset: Offset(0, 2),
                        color: Colors.black.withOpacity(0.3).withOpacity(0.15))
                  ],
                  borderRadius: BorderRadius.circular(10.r)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50.r,
                        height: 50.r,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: kgradient,
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/NoPath - Copy (28)@3x.png'),
                                fit: BoxFit.cover)),
                      ),
                      15.horizontalSpace,
                      Text(
                        'Hp Laptop',
                        style: GoogleFonts.inter(
                            fontSize: 15.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Container(
                        width: 117.w,
                        height: 30.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: highlightedText,
                            borderRadius: BorderRadius.circular(16.r)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.watch_later_rounded,
                              color: Colors.white,
                              size: 15.r,
                            ),
                            6.horizontalSpace,
                            Text(
                              'Pending',
                              style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  10.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Name',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.sp,
                        ),
                      ),
                      Text(
                        'Joe Wilson',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  10.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Item',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.sp,
                        ),
                      ),
                      Text(
                        'Hp Laptop',
                        style: TextStyle(
                            color: kprimaryColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  10.verticalSpace,
                  DottedLine(
                    dashColor: Colors.black.withOpacity(0.7),
                    dashGapLength: 1.4,
                    lineThickness: 0.2,
                  ),
                  10.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Quantity',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.sp,
                        ),
                      ),
                      Text(
                        '02',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  10.verticalSpace,
                  DottedLine(
                    dashColor: Colors.black.withOpacity(0.7),
                    dashGapLength: 1.4,
                    lineThickness: 0.2,
                  ),
                  20.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Delivery Address',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.sp,
                        ),
                      ),
                      Text(
                        '1234 Lorem Ipsum',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  10.verticalSpace,
                ],
              ),
            )
          ],
        ));
  }
}
