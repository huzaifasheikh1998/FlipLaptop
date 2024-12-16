import 'package:app_fliplaptop/Apiserrvices/app_url.dart';
import 'package:app_fliplaptop/Controller/productController.dart';
import 'package:app_fliplaptop/Screens/ReviewProductScreen.dart';
import 'package:app_fliplaptop/widgets/disallow_indicator_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/global.dart';

class AppleScreen extends StatelessWidget {
  AppleScreen({super.key});

  final List laptopImage = [
    'assets/NoPath - Copy (25).png',
    'assets/NoPath - Copy (28)@3x.png',
    'assets/NoPath - Copy (29)@3x.png',
    'assets/NoPath - Copy (30).png',
    'assets/maxim-hopman-Hin-rzhOdWs-unsplash.png',
    'assets/nubelson-fernandes-c48WlKnfsQ0-unsplash.png',
  ];

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
          'Apple',
          style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
      body: DisAllowIndicatorWidget(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 10.r),
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 91.r,
                          height: 91.r,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromARGB(255, 184, 184, 184),
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/NoPath - Copy (15)@3x.png'),
                                  fit: BoxFit.cover)),
                        ),
                        Positioned(
                          bottom: 5,
                          right: 3,
                          child: SvgPicture.asset(
                            'assets/Group 967.svg',
                            width: 15.r,
                          ),
                        ),
                      ],
                    ),
                    8.verticalSpace,
                    Text(
                      'Apple',
                      style: GoogleFonts.inter(
                          color: Colors.black,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                24.horizontalSpace,
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      30.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '10',
                                style: TextStyle(
                                    fontSize: 15.sp, color: highlightedText),
                              ),
                              Text(
                                'Following',
                                style: TextStyle(
                                    fontSize: 15.sp, color: Color(0xff1D1D1D)),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '2654',
                                style: TextStyle(
                                    fontSize: 15.sp, color: highlightedText),
                              ),
                              Text(
                                'Followers',
                                style: TextStyle(
                                    fontSize: 15.sp, color: Color(0xff1D1D1D)),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '265',
                                style: TextStyle(
                                    fontSize: 15.sp, color: highlightedText),
                              ),
                              Text(
                                'Products',
                                style: TextStyle(
                                    fontSize: 15.sp, color: Color(0xff1D1D1D)),
                              )
                            ],
                          )
                        ],
                      ),
                      20.verticalSpace,
                      InkWell(
                        onTap: () {},
                        child: Container(
                          width: Get.width * 0.7,
                          alignment: Alignment.center,
                          height: 35.h,
                          decoration: BoxDecoration(
                              gradient: kbtngradient,
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Text(
                            'Follow',
                            style: GoogleFonts.inter(
                                color: Colors.white, fontSize: 13.sp),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            24.verticalSpace,
            Text(
              'New Arrivals',
              style: GoogleFonts.inter(
                  fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            4.verticalSpace,
            Text(
              'Top products incredible price',
              style: GoogleFonts.inter(
                  color: Colors.black.withOpacity(0.5), fontSize: 14.sp),
            ),
            10.verticalSpace,
            // newArrivalCard([],storeId, 'Dell Pro', 'Reviews (4.9)', '\$ 15.59',
            //     'assets/NoPath - Copy (23)Apple.png'),
            // 20.verticalSpace,
            // newArrivalCard([],,storeId, 'Lenovo Laptop', 'Reviews (4.9)', '\$ 15.59',
            //     'assets/NoPath - Copy (24).png'),
            24.verticalSpace,
            Text(
              'More Products',
              style: GoogleFonts.inter(
                  fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            4.verticalSpace,
            Text(
              'Top products incredible price',
              style: GoogleFonts.inter(
                  color: Colors.black.withOpacity(0.5), fontSize: 14.sp),
            ),
            10.verticalSpace,
            GridView.builder(
              itemCount: laptopImage.length,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 0.83),
              itemBuilder: (BuildContext context, int index) {
                return moreProductCard('Dell Laptop', 'Reviews (4.9)',
                    '\$ 15.59', laptopImage[index]);
              },
            )
          ],
        ),
      ),
      //     floatingActionButton: FloatingActionButton(
      //     onPressed: (){},
      //     backgroundColor:  highlightedText,
      //     child: Container(
      //   width: 60,
      //   height: 60,
      //   child: Icon(
      //     Icons.add,
      //     size: 40.r,
      //   ),
      //   decoration: BoxDecoration(
      //     shape: BoxShape.circle,
      //     gradient: kgradient
      //   ),
      // ),

      //     ),
    );
  }
}

newArrivalCard(
  iterations,
  storeId,
  storeProfile,
  storeName,
  brand,
  rating,
  img,
  price,
  condition,
  description,
  productName,
  storeCompleteData,
  index,
  discountInstance,
  dealItemPrice,
  dealItemStartDatetime,
  dealItemEndDatetime,
) {
  return InkWell(
    onTap: () {
      print("image is $img");
      final productController = Get.put(ProductController());
      // addProductController.editDatumInstance.value = iterations;
      productController.editDatumInstance.value = iterations;

      // Get.toNamed('/ReviewProductScreen');
      Get.to(() => ReviewProductScreen(
            // productData: {
            //   "name": brand,
            //   "rating": rating,
            //   "price": price,
            //   "image": img,
            //   "condition": condition,
            //   "discount": null,
            //   "description": description
            // },
            productData: {
              "name": productName,
              "rating": rating,
              "price": price,
              "image": ImageUrls.kProduct + img,
              "condition": condition,
              "dealPrice": "\$ ${dealItemPrice}",
              "dealItemStartDatetime": dealItemStartDatetime,
              "dealItemEndDatetime": dealItemEndDatetime,
              "description": description,
              "discount": discountInstance
            },
            storeID: int.parse(storeId),
            index: index,
            ownProduct: true,
            storeProfile: storeProfile,
            storeName: storeName,
            storeData: storeCompleteData,
          ));
    },
    child: Column(
      children: [
        Container(
          width: Get.width,
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.r)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 19.r, horizontal: 10.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      iterations.name,
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                    3.verticalSpace,
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          rating,
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500, fontSize: 14.sp),
                        ),
                        5.horizontalSpace,
                        SvgPicture.asset(
                          'assets/Icon feather-star.svg',
                          width: 10.r,
                        )
                      ],
                    ),
                    3.verticalSpace,
                    Text(
                      "\$ ${iterations.price.toString()}",
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600, fontSize: 14.sp),
                    ),
                  ],
                ),
              ),
              Container(
                width: 182.w,
                height: 113.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  // image:
                  // DecorationImage(
                  //   image: AssetImage(img),
                  //   fit: BoxFit.fill,
                  // )
                ),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: iterations.productImage.toString() == "[]"
                      ? "NoImage"
                      : ImageUrls.kProduct +
                          iterations.productImage.first.name.toString(),
                  placeholder: (context, url) => Icon(Icons.image),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              )
            ],
          ),
        ),
        // 20.verticalSpace,
      ],
    ),
  );
}

moreProductCard(brand, rating, price, img) {
  return InkWell(
    onTap: () {
      Get.toNamed('/ReviewProductScreen');
    },
    child: Container(
      // width: Get.width * 0.45,

      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            // width: Get.width* 0.5,
            height: 140.r,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                image: DecorationImage(
                  image: AssetImage(img),
                  fit: BoxFit.fill,
                )),
          ),
          10.verticalSpace,
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  brand,
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
                3.verticalSpace,
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      rating,
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500, fontSize: 14.sp),
                    ),
                    5.horizontalSpace,
                    SvgPicture.asset(
                      'assets/Icon feather-star.svg',
                      width: 10.r,
                    )
                  ],
                ),
                3.verticalSpace,
                Text(
                  price,
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600, fontSize: 14.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
