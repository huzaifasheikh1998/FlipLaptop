import 'package:app_fliplaptop/Apiserrvices/app_url.dart';
import 'package:app_fliplaptop/Controller/productController.dart';
import 'package:app_fliplaptop/Screens/ListOfProduct.dart';
import 'package:app_fliplaptop/components/moreProductCard.dart';
import 'package:app_fliplaptop/models/loginmodel.dart' as LoginModel;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/dashBoardModel.dart';

class MyStoreMoreProductGridView extends StatelessWidget {
  final String storeID;
  final List<LoginModel.Product> moreProductList;

  const MyStoreMoreProductGridView(
      {super.key, required this.storeID, required this.moreProductList});

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.put(ProductController());

    return Obx(
      () => productController.productListingDataList.isEmpty
          ? Padding(
              padding: EdgeInsets.only(top: 0.15.sh),
              child: Center(
                child: Text(
                  "No Store More Products",
                  style:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 20.sp),
                ),
              ),
            )
          :
          // productController
          //             .productListingDataList.isEmpty
          //
          //     ? Center(
          //         child: Text("No Listed Products!"),
          //       )
          //     :
          Column(
              children: [
                20.verticalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'More Products',
                      style: GoogleFonts.inter(
                          fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ),
                    4.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Top products incredible price',
                          style: GoogleFonts.inter(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 14.sp),
                        ),
                        10.verticalSpace,
                        productController
                                    .productListingDataList.first.data!.length >
                                2
                            ? InkWell(
                                onTap: () {
                                  Get.to(() => ListOfProductScreen(
                                        storeId: storeID,
                                        storeProfile: "",
                                        storeName: '',
                                      ));
                                },
                                child: Text(
                                  'View More',
                                  style: GoogleFonts.inter(
                                      fontSize: 14.sp,
                                      decoration: TextDecoration.underline,
                                      color:
                                          Color(0xffC20000).withOpacity(0.5)),
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                  ],
                ),
                15.verticalSpace,
                SingleChildScrollView(
                  // physics: BouncingScrollPhysics(),
                  child: GridView.builder(
                    // physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    // padding: EdgeInsets.symmetric(
                    //     horizontal: 20.r, vertical: 10.r),

                    // if the product are greater than 2 then we will show only two items
                    // and show "View More" text.
                    itemCount:
                        moreProductList.length > 4 ? 4 : moreProductList.length,
                    physics: NeverScrollableScrollPhysics(),
                    // itemCount: productController
                    //             .productListingDataList.first.data!.length >
                    //         2
                    //     ? 2
                    //     : productController
                    //         .productListingDataList.first.data!.length,
                    itemBuilder: (context, index) {
                      final iteration = productController
                          .productListingDataList.first.data![index];
                      return Column(
                        children: [
                          MoreProductCard(
                            index: index,
                            storeCompleteData: Store(
                                id: iteration.storeId,
                                name: iteration.storeName,
                                image: iteration.storeImage),
                            storeID: iteration.storeId!,
                            brand: iteration.name ?? "",
                            rating: iteration.ratingCount ?? "0",
                            price: "\$ ${iteration.price.toString()}",
                            img: iteration.productImage!.isEmpty
                                ? ""
                                : ImageUrls.kProduct +
                                    (iteration.productImage![0].name??""),
                            condition: iteration.conditionType ?? "",
                            discount: iteration.discount,
                            description: iteration.descriptions ?? "",
                            storeImage: iteration.storeImage ?? "",
                            postedUserData: iteration.user ?? User(),
                            dealPrice:
                                "\$ ${iteration.dealItemPrice.toString()}",
                            dealItemStartDatetime:
                                iteration.dealItemStartDatetime.toString(),
                            dealItemEndDatetime:
                                iteration.dealItemEndDatetime.toString(),
                            dealItemPercentage:
                            iteration.dealItemPercentage.toString(),
                          ),
                          // 5.verticalSpace
                        ],
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5.0,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: 0.83),
                  ),
                ),
              ],
            ),
    );
  }
}
