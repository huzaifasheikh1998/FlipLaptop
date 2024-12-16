import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'rps_custom_painter.dart';

class DiscountCard extends StatelessWidget {
  bool discountAmountType;
  String amount;
  String percentage;
  String endDate;
   DiscountCard({super.key,required this.discountAmountType,required this.amount, required this.endDate,required this.percentage});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
                              painter: RPSCustomPainter(),
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 23.r, vertical: 12.r),
                                  width: Get.width * 0.45,
                                  height: 95.h,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            discountAmountType?
                                            "$amount\$ Off":"$percentage% Off",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16.sp),
                                          ),
                                          Container(
                                            constraints:
                                                BoxConstraints(maxWidth: 79.w),
                                            child: Text(
                                              'Use by $endDate',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10.sp),
                                            ),
                                          )
                                        ],
                                      ),
                                      Image.asset(
                                        'assets/gift@3x.png',
                                        width: 50.r,
                                      )
                                    ],
                                  )));
  }
}