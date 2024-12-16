import 'package:app_fliplaptop/Apiserrvices/app_url.dart';
import 'package:app_fliplaptop/Controller/productController.dart';
import 'package:app_fliplaptop/Screens/MyOrderScreen.dart';
import 'package:app_fliplaptop/components/global.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/dashBoardModel.dart';

class ProductReviews extends StatelessWidget {
  final productController = Get.put(ProductController());

  ProductReviews({super.key, this.reviewList});

  List<Review>? reviewList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Product Reviews',
          style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
      body: productController.editDatumInstance.value.review!.isEmpty
          ? Center(
              child: Text("No Reviews Found"),
            )
          : ListView.builder(
              padding: EdgeInsets.all(15),
              itemCount:
                  productController.editDatumInstance.value.review!.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return _productReviewCard(
                  reviewerImage: productController
                      .editDatumInstance.value.review![index].user!.image
                      .toString(),
                  reviewerName: productController
                          .editDatumInstance.value.review![index].user!.name ??
                      "",
                  rating: productController
                          .editDatumInstance.value.review![index].rating ??
                      "0",
                  reviewDescription: productController
                          .editDatumInstance.value.review![index].description ??
                      "",
                );
              },
            ),
    );
  }

  /// this is the reviewCard shown when tapped on the review on product review screen
  Widget _productReviewCard({
    required String reviewerImage,
    required String reviewerName,
    required String rating,
    required String reviewDescription,
  }) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        // height: 0.1.sh,
        // width: 0.9.sw,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(
                10.r,
              ),
            ),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 0),
                  blurRadius: 6.r,
                  color: Colors.grey.withOpacity(0.3))
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: ClipOval(
                child: SizedBox(
                  height: 0.05.sh,
                  width: 0.1.sw,
                  // color: Colors.white,
                  child: reviewerImage ==
                      ""?Image
                      .asset(
                    "assets/avatar.png",
                    fit: BoxFit
                        .cover,
                  ):CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: reviewerImage ==
                        ""
                        ? "NoImage"
                        : ImageUrls.kUserProfile +
                      reviewerImage
                            .toString(),
                    placeholder: (context, url) =>
                        Icon(Icons.image),
                    errorWidget: (context, url, error) =>
                        Icon(Icons.error),
                  )
                ),
              ),
            ),
            10.w.horizontalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  reviewerName,
                  style: TextStyle(
                    fontSize: 16.r,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                RatingBar(
                  ignoreGestures: true,
                  initialRating: double.parse(rating),
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  ratingWidget: RatingWidget(
                    full: SvgPicture.asset('assets/Icon awesome-star.svg'),
                    half: SvgPicture.asset('assets/Icon awesome-star.svg'),
                    empty: SvgPicture.asset(
                        'assets/Icon awesome-star-outline.svg'),
                  ),
                  itemPadding: EdgeInsets.symmetric(horizontal: 2.r),
                  onRatingUpdate: (rating) {
                    ratingController controller = Get.find();
                    controller.rating.value = rating;
                    controller.update();
                  },
                  itemSize: 15.r,
                ),
                SizedBox(
                  width: 0.6.sw,
                  child: Text(
                    reviewDescription,
                    style: TextStyle(
                      fontSize: 15.r,
                    ),
                  ),
                ),
              ],
            ),
            // SizedBox(
            //   width: 0.3.sw,
            // )
          ],
        ),
      ),
    );
  }
}
