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

List laptopImage = [
  'assets/maxim-hopman-Hin-rzhOdWs-unsplash.png',
  'assets/NoPath - Copy (17)@3x.png',
  'assets/NoPath - Copy (19)@3x.png',
  'assets/NoPath - Copy (20)@2x.png',
  'assets/maxim-hopman-Hin-rzhOdWs-unsplash.png',
  'assets/nubelson-fernandes-c48WlKnfsQ0-unsplash.png',
];

class DellScreen extends StatelessWidget {
  const DellScreen({super.key});

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
          'Dell',
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
                                      'assets/NoPath - Copy (4)@3x.png'),
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
                      'Dell',
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
            newArrivalCard('Dell Pro', 'Reviews (4.9)', '\$ 15.59',
                'assets/Sau6W3hnWTyGiNr3MsrTHf.png'),
            20.verticalSpace,
            newArrivalCard('Lenovo Laptop', 'Reviews (4.9)', '\$ 15.59',
                'assets/72207604.png'),
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
                return moreProductCard("", 'Dell Laptop', 'Reviews (4.9)',
                    '\$ 15.59', index, "", null,"","","");
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

newArrivalCard(brand, rating, price, img) {
  return InkWell(
    onTap: () {
      Get.toNamed('/ReviewProductScreen');
    },
    child: Container(
      width: Get.width,
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
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
          Container(
            width: 182.w,
            height: 113.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                image: DecorationImage(
                  image: AssetImage(img),
                  fit: BoxFit.fill,
                )),
          )
        ],
      ),
    ),
  );
}

moreProductCard(
  iterationData,
  storeId,
  storeProfile,
  storeName,
  index,
  storeCompleteData,
  discountData,
  dealItemPrice,
  dealItemStartDatetime,
  dealItemEndDatetime,
) {
  return InkWell(
    onTap: () {
      final productController = Get.put(ProductController());
      // addProductController.editDatumInstance.value = iterations;
      productController.editDatumInstance.value = iterationData;
      // Get.toNamed('/ReviewProductScreen');
      //  newMap=  iterationData;
      // log("=============> iteration Data"+(newMap.data
      //     .toString()));

      Get.to(() => ReviewProductScreen(
            productData: {
              "name": iterationData.name,
              "rating": 0,
              "price": "\$ ${iterationData.price}",
              "dealItemPrice": dealItemPrice,
              "dealItemStartDatetime": dealItemStartDatetime,
              "dealItemEndDatetime": dealItemEndDatetime,
              "image": iterationData.productImage.isEmpty
                  ? ""
                  : ImageUrls.kProduct + iterationData.productImage[0].name,
              "condition": iterationData.conditionType,
              "discount": discountData,
              "description": iterationData.descriptions
            },
            // productData: iterationData,
            ownProduct: true,
            storeProfile: storeProfile,
            storeName: storeName,
            index: index,
            storeData: storeCompleteData,
          ));
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
              // image: DecorationImage(
              //   image: AssetImage(img),
              //   fit: BoxFit.fill,
              // )
            ),
            child: Center(
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: iterationData.productImage.toString() == "[]"
                    ? "NoImage"
                    :
                    //  iterations.productImage == "[]"?
                    //  "https://fliplaptop.thesuitchstaging.com/assets/images/products/thumbnails/1691623416450.jpg"

                    ImageUrls.kProduct +
                        iterationData.productImage.first.name.toString(),
                placeholder: (context, url) => Icon(Icons.image),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
          10.verticalSpace,
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  iterationData.name.toString(),
                  // brand,
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
                3.verticalSpace,
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Reviews (5.0)",
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
                  "\$ ${iterationData.price.toString()}",
                  // price,
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
