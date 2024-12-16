import 'dart:developer';

import 'package:app_fliplaptop/Apiserrvices/Services.dart';
import 'package:app_fliplaptop/Apiserrvices/loader.dart';
import 'package:app_fliplaptop/Controller/subscriptionController.dart';
import 'package:app_fliplaptop/components/global.dart';
import 'package:app_fliplaptop/components/textButtonWithLoader.dart';
import 'package:app_fliplaptop/res/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectPackageScreen extends StatefulWidget {
  SelectPackageScreen({super.key});

  @override
  State<SelectPackageScreen> createState() => _SelectPackageScreenState();
}

class _SelectPackageScreenState extends State<SelectPackageScreen> {
  final SubscriptionController subscriptionController =
  Get.put(SubscriptionController());


  int activeIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // bool isSelected=false;

  @override
  Widget build(BuildContext context) {

    Widget card = Obx(() {
      return subscriptionController.isLoading.value
          ? Center(
        child: Loader.spinkit,
      )
          : InkWell(
        onTap: () {
          // subscriptionController.isSelectedID.value= "";
        },
        child: PageView.builder(
          // padding: EdgeInsets.all(30.sp),
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: subscriptionController.subscriptionList.length,
            onPageChanged: (value) {
              subscriptionController.isSelectedID.value =
                  subscriptionController.subscriptionList[value].id;
              log("Selected subscription ID is" +
                  subscriptionController.isSelectedID.value);
            },
            itemBuilder: (context, index) {
              if (subscriptionController.subscriptionList.isNotEmpty) {
                subscriptionController.isSelectedID.value =
                    subscriptionController.subscriptionList[0].id;
              }
              return Center(
                child: Padding(
                  padding:
                  EdgeInsets.only(left: 0.11.sw, bottom: 0.05.sh),
                  child: InkWell(
                    onTap: () {
                      subscriptionController.isSelectedID.value =
                          subscriptionController
                              .subscriptionList[index].id;
                      log(subscriptionController.isSelectedID.value);
                    },
                    child: SubscriptionCard(
                      subscriptionController.subscriptionList[index].id,
                      subscriptionController.subscriptionList[index].name,
                      subscriptionController
                          .subscriptionList[index].price,
                      subscriptionController
                          .subscriptionList[index].duration,
                      subscriptionController
                          .subscriptionList[index].stripePlanId,
                      subscriptionController
                          .subscriptionList[index].stripePlanPriceId,
                      subscriptionController
                          .subscriptionList[index].description,
                    ),
                  ),
                ),
              );
            }),
      );
      ;
    });

    // SubscriptionCard(),
    // SubscriptionCard()

    return Scaffold(
      bottomNavigationBar: Obx(() {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 20.r),
          child: textButtonWithLoader(
            width: 388.w,
            // 59.h,
            buttonText: 'Try Now  ',
            onTap: () {
              subscriptionController.isSelectedID.value == ""
                  ? Utils.showSnack("Please Select Any Subscription", context)
                  : ApiServices()
                  .buySubscription(subscriptionController.isSelectedID.value);
            },
            height: 59.h,
            isLoading: subscriptionController.isLoading.value,
          ),
        );
      }),
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
          'Select Package',
          style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
      body: Obx(() {
        return subscriptionController.isLoading.value
            ? Center(
          child: Loader.spinkit,
        )
            : Container(
          width: double.infinity,
          child: Container(child: card
            // CarouselSlider(
            //   // carouselController: CarouselController(),
            //   items: cards,
            //
            //   options: CarouselOptions(
            //       // autoPlay: true,
            //       aspectRatio: 2.0,
            //       enlargeCenterPage: true,
            //       // viewportFraction: 0.71,
            //       // viewportFraction: 1.0,
            //       onPageChanged: (index, reason) {
            //         setState(() {
            //           activeIndex = index;
            //         });
            //       },
            //       enlargeStrategy: CenterPageEnlargeStrategy.height,
            //       height: 480.h,
            //       enlargeFactor: 0.2),
            // ),
          ),
        );
      }),
    );
  }

  SubscriptionCard(String id,
      String name,
      String price,
      String duration,
      String stripePlanId,
      String stripePlanPriceId,
      String description,) =>
         Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 322.w,
              margin: EdgeInsets.only(bottom: 10.r),
              constraints: BoxConstraints(maxHeight: 427.h, maxWidth: 427.h),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 9,
                      spreadRadius: 6)
                ],
                // border: subscriptionController.isSelectedID.value == id
                //     ? Border.all(color: kprimaryColor, width: 3.w)
                //     : null,
                color: Colors.white,
                borderRadius: BorderRadius.circular(17.r),
              ),
              padding: EdgeInsets.only(bottom: 44.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 322.w,
                    height: 93.h,
                    decoration: BoxDecoration(
                        gradient: kgradient,
                        borderRadius:
                        BorderRadius.vertical(top: Radius.circular(17.r))),
                    alignment: Alignment.center,
                    child: Text(
                      name,
                      style: GoogleFonts.inter(
                        fontSize: 24.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    // color: Colors.red,

                    padding: EdgeInsets.all(24.r),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        detailItem(description),
                        23.h.verticalSpace,
                        detailItem(description),
                        23.h.verticalSpace,
                        detailItem(description)
                      ],
                    ),
                  ),
                  //  Spacer(),
                  Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RichText(
                            text: TextSpan(children: [
                              WidgetSpan(
                                child: Transform.translate(
                                  offset: const Offset(0.0, -18.0),
                                  child: Text(
                                    '\$',
                                    style: GoogleFonts.inter(
                                        fontSize: 20.sp,
                                        color: Color(0xff2C2C2C).withOpacity(
                                            0.5),
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              TextSpan(
                                  text: price,
                                  style: GoogleFonts.inter(
                                      fontSize: 56.sp,
                                      color: highlightedText,
                                      fontWeight: FontWeight.bold))
                            ])),
                        Text(
                          'Per Month',
                          style: TextStyle(
                              color: Color(0xff2C2C2C).withOpacity(0.5),
                              fontSize: 13.sp),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            40.horizontalSpace
          ],
        );


  Row detailItem(String detailText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.check,
          color: Colors.black,
          size: 15,
        ),
        16.w.horizontalSpace,
        Expanded(
            child: Text(
              detailText,
              style: GoogleFonts.inter(
                  color: Color(0xff6C6C6C),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400),
            ))
      ],
    );
  }
}
