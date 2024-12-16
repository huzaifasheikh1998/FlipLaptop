import 'dart:developer';

import 'package:app_fliplaptop/Apiserrvices/Services.dart';
import 'package:app_fliplaptop/Apiserrvices/loader.dart';
import 'package:app_fliplaptop/Controller/reviewController.dart';
import 'package:app_fliplaptop/components/global.dart';
import 'package:app_fliplaptop/components/textButtonWithLoader.dart';
import 'package:app_fliplaptop/res/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ReviewReplyScreen extends StatelessWidget {
  ReviewReplyScreen(
      {super.key, required this.parentID, required this.productID});

  final String parentID;
  final String productID;

  TextEditingController replyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final reviewController = Get.put(ReviewController());
    return Scaffold(
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
          'Reply Review',
          style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
      body: Obx(() {
        return reviewController.isLoading.value
            ? Center(
                child: Loader.spinkit,
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // 20.h.horizontalSpace,
                  20.h.verticalSpace,
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.r),
                      // width: 332.w,
                      // height: 162.h,
                      decoration: BoxDecoration(
                        color: Color(0xffF1F1F1),
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      child: TextField(
                        controller: replyController,
                        // reviewController.reviewDescription.value,
                        maxLines: 10,
                        style: TextStyle(
                            fontSize: 14.sp, color: Color(0xff94989F)),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 19.r, horizontal: 20.r),
                            hintMaxLines: 6,
                            hintText: 'Write a Reply...',
                            hintStyle: TextStyle(
                              fontSize: 14.sp,
                            )),
                      )),
                ],
              );
      }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: textButtonWithLoader(
          width: 331.w,
          height: 59.h,
          buttonText: 'Submit',
          onTap: () {
            log(productID);
            log(userController.user.value.id.toString());
            log(replyController.text);
            log(parentID);
            if (replyController.text.isEmpty) {
              Utils.showSnack("Reply text is empty!", context);
            } else {
              reviewController.postReviewReply(
                  productID,
                  userController.user.value.id.toString(),
                  replyController.text,
                  parentID);
            }
            // reviewController.createReview(
            //   context,
            //   productID,
            //   reviewController
            //       .reviewDescription.value.text,
            //   controller.rating.value.toString(),
            //   reviewController.reviewImageList,
            // );
            // ReviewSubmitDialog(context);
          },
          isLoading: false,
          // isLoading: reviewController.isLoading.value,
        ),
      ),
    );
  }
}
