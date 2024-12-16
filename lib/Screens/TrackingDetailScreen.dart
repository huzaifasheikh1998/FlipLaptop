import 'package:app_fliplaptop/widgets/disallow_indicator_widget.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/global.dart';

class TrackingDetailScreen extends StatelessWidget {
  const TrackingDetailScreen({super.key});

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
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, gradient: kbtngradient),
                child: SvgPicture.asset(
                  'assets/Path 11.svg',
                  width: 14,
                ))),
        centerTitle: true,
        title: Text(
          'Tracking Details',
          style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
      body: DisAllowIndicatorWidget(
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: 20.r,
          ),
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 20.r, horizontal: 22.r),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  gradient: kbtngradient),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'RU 1234 567 890',
                    style: GoogleFonts.varta(
                      color: Colors.white,
                      fontSize: 28.sp,
                    ),
                  ),
                  10.verticalSpace,
                  DottedLine(
                    dashColor: Colors.white,
                    dashGapLength: 1.4,
                    lineThickness: 0.2,
                  ),
                  20.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Delivery Partner',
                            style: GoogleFonts.varta(
                                fontSize: 12.sp, color: Colors.white),
                          ),
                          8.verticalSpace,
                          Text(
                            'Courier',
                            style: GoogleFonts.varta(
                                fontSize: 18.sp, color: Colors.white),
                          )
                        ],
                      ),
                      SvgPicture.asset('assets/Icon feather-arrow-right.svg'),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Receiver',
                            style: GoogleFonts.varta(
                                fontSize: 12.sp, color: Colors.white),
                          ),
                          8.verticalSpace,
                          Text(
                            'John Smith',
                            style: GoogleFonts.varta(
                                fontSize: 18.sp, color: Colors.white),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            20.verticalSpace,
            Text(
              'Parcel Status',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp),
            ),
            22.verticalSpace,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 50.r,
                      height: 50.r,
                      padding: EdgeInsets.all(15.r),
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.2),
                          shape: BoxShape.circle),
                      child: SvgPicture.asset('assets/Path 3002.svg'),
                    ),
                    Container(
                      height: 50.h,
                      child: VerticalDivider(
                        color: Colors.black.withOpacity(0.2),
                        thickness: 1,
                      ),
                    )
                  ],
                ),
                10.horizontalSpace,
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        4.verticalSpace,
                        Text(
                          'Parcel Delivered',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 19.sp),
                        ),
                        3.verticalSpace,
                        Text(
                          'New York, USA',
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.2),
                              fontSize: 12.sp),
                        )
                      ],
                    ),
                    Text(
                      '8 jan, 08:24',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.2),
                          fontSize: 12.sp),
                    ),
                  ],
                )),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 50.r,
                      height: 50.r,
                      padding: EdgeInsets.all(15.r),
                      decoration: BoxDecoration(
                          gradient: kgradient, shape: BoxShape.circle),
                      child: SvgPicture.asset('assets/Path 3003.svg'),
                    ),
                    Container(
                      height: 50.h,
                      child: VerticalDivider(
                        color: Colors.black,
                        thickness: 1,
                      ),
                    )
                  ],
                ),
                10.horizontalSpace,
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        4.verticalSpace,
                        Text(
                          'Parcel on the way',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 19.sp),
                        ),
                        3.verticalSpace,
                        Text(
                          'New York, USA',
                          style:
                              TextStyle(color: Colors.black, fontSize: 12.sp),
                        )
                      ],
                    ),
                    Text(
                      '8 jan, 08:24',
                      style: TextStyle(color: Colors.black, fontSize: 12.sp),
                    ),
                  ],
                )),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 50.r,
                      height: 50.r,
                      padding: EdgeInsets.all(15.r),
                      decoration: BoxDecoration(
                          gradient: kgradient, shape: BoxShape.circle),
                      child: SvgPicture.asset('assets/Path 3004.svg'),
                    ),
                    Container(
                      height: 50.h,
                      child: VerticalDivider(
                        color: Colors.black,
                        thickness: 1,
                      ),
                    )
                  ],
                ),
                10.horizontalSpace,
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        4.verticalSpace,
                        Text(
                          'Parcel on the way',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 19.sp),
                        ),
                        3.verticalSpace,
                        Text(
                          'New York, USA',
                          style:
                              TextStyle(color: Colors.black, fontSize: 12.sp),
                        )
                      ],
                    ),
                    Text(
                      '8 jan, 08:24',
                      style: TextStyle(color: Colors.black, fontSize: 12.sp),
                    ),
                  ],
                )),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 50.r,
                      height: 50.r,
                      padding: EdgeInsets.all(15.r),
                      decoration: BoxDecoration(
                          gradient: kgradient, shape: BoxShape.circle),
                      child: SvgPicture.asset('assets/Path 3005.svg'),
                    ),
                    Container(
                      height: 50.h,
                      child: VerticalDivider(
                        color: Colors.black,
                        thickness: 1,
                      ),
                    )
                  ],
                ),
                10.horizontalSpace,
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        4.verticalSpace,
                        Text(
                          'Sent to Courier',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 19.sp),
                        ),
                        3.verticalSpace,
                        Text(
                          'New York, USA',
                          style:
                              TextStyle(color: Colors.black, fontSize: 12.sp),
                        )
                      ],
                    ),
                    Text(
                      '8 jan, 08:24',
                      style: TextStyle(color: Colors.black, fontSize: 12.sp),
                    ),
                  ],
                )),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 50.r,
                  height: 50.r,
                  padding: EdgeInsets.all(15.r),
                  decoration: BoxDecoration(
                      gradient: kgradient, shape: BoxShape.circle),
                  child: SvgPicture.asset('assets/Path 3007.svg'),
                ),
                10.horizontalSpace,
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        4.verticalSpace,
                        Text(
                          'Sent to Courier',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 19.sp),
                        ),
                        3.verticalSpace,
                        Text(
                          'New York, USA',
                          style:
                              TextStyle(color: Colors.black, fontSize: 12.sp),
                        )
                      ],
                    ),
                    Text(
                      '8 jan, 08:24',
                      style: TextStyle(color: Colors.black, fontSize: 12.sp),
                    ),
                  ],
                )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
