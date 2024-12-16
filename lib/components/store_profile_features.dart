import 'package:app_fliplaptop/Screens/ListOfProduct.dart';
import 'package:app_fliplaptop/components/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class StoreProfileFeature extends StatelessWidget {
  String storeId;
  String storeProfile;
  String storeName;
  StoreProfileFeature(
      {super.key,
      required this.storeId,
      required this.storeProfile,
      required this.storeName});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            Get.to(ListOfProductScreen(
                storeId: storeId,
                storeProfile: storeProfile,
                storeName: storeName));
            // Get.toNamed('/ListOfProductScreen');
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical:15.r, horizontal: 26.r),
            // constraints: BoxConstraints(
            //     // maxHeight: 92.h,
            //     maxWidth: 120.w),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // SvgPicture.asset('assets/Icon feather-list-1.svg', width: 59.r,),
                Image.asset(
                  'assets/Icon feather-list.png',
                  scale: 1.3,
                ),
                10.verticalSpace,
                Text(
                  'Listed\nProducts',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                      fontSize: 13.sp, fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Get.toNamed('/MyReviewScreen');
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical:15.r, horizontal: 26.r),
            // constraints: BoxConstraints(
            //     // maxHeight: 92.h,
            //     maxWidth: 120.w),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  'assets/Icon feather-star(2).svg',
                  width: 21.r,
                ),
                10.verticalSpace,
                Text(
                  'My\nReviews',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                      fontSize: 13.sp, fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
        ),
        // InkWell(
        //   onTap: () {
        //     Get.toNamed('/ListOfDraftedProductScreen');
        //   },
        //   child: Container(
        //     padding: EdgeInsets.all(15.r),
        //     constraints: BoxConstraints(
        //         // maxHeight: 92.h,
        //         maxWidth: 89.w),
        //     decoration: BoxDecoration(
        //         color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
        //     child: Column(
        //       mainAxisSize: MainAxisSize.min,
        //       children: [
        //         SvgPicture.asset(
        //           'assets/Icon awesome-inbox.svg',
        //           width: 25.r,
        //         ),
        //         10.verticalSpace,
        //         Text(
        //           'Drafted\nProducts',
        //           textAlign: TextAlign.center,
        //           style: GoogleFonts.inter(
        //               fontSize: 13.sp, fontWeight: FontWeight.w500),
        //         )
        //       ],
        //     ),
        //   ),
        // ),
        InkWell(
          onTap: () {
            Get.toNamed('/SelectTemplateScreen');
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical:15.r, horizontal: 26.r),
            // constraints: BoxConstraints(
            //     // maxHeight: 92.h,
            //     maxWidth: 120.w),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  'assets/Path 2969.svg',
                  width: 18.5.r,
                  color: highlightedText,
                ),
                10.verticalSpace,
                Text(
                  'Add Hot\nDeals',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                      fontSize: 13.sp, fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
