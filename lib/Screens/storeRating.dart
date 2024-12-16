import 'package:app_fliplaptop/Apiserrvices/app_url.dart';
import 'package:app_fliplaptop/Apiserrvices/loader.dart';
import 'package:app_fliplaptop/Screens/MyOrderScreen.dart';
import 'package:app_fliplaptop/components/global.dart';
import 'package:app_fliplaptop/models/getStoreRating.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Apiserrvices/Services.dart';

class StoreRating extends StatelessWidget {
  StoreRating({super.key, required this.storeID});

  String storeID;

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
            'Store Reviews',
            style: GoogleFonts.inter(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
        ),
        body: FutureBuilder(
            future: ApiServices().getStoreRating(storeID),
            builder:
                (BuildContext context, AsyncSnapshot<GetStoreRating> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Loader.spinkit;
              } else if (snapshot.hasError) {
                // log(snapshot.hasError.toString());
                return Text(snapshot.error.toString());
              } else if (snapshot.hasData) {
                return ListView(
                    padding: EdgeInsets.symmetric(horizontal: 20.r),
                    children: <Widget>[
                      snapshot.data!.data!.length == 0
                          ? Padding(
                              padding: EdgeInsets.symmetric(vertical: 0.35.sh),
                              child: Center(
                                child: Text(
                                  "No Store Reviews Found",
                                  style: TextStyle(
                                    fontSize: 20.r,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.data!.length,
                              itemBuilder: (context, index) {
                                return _storeRatingCard(
                                  reviewerImage:
                                      snapshot.data!.data![index].user!.image ??
                                          "",
                                  reviewerName:
                                      snapshot.data!.data![index].user!.name ??
                                          "",
                                  rating:
                                      snapshot.data!.data![index].rating ?? "",
                                  reviewDescription: "",
                                );
                              })
                    ]);
              } else {
                return SizedBox();
              }
            }));
  }

  Widget _storeRatingCard({
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: ClipOval(
                child: SizedBox(
                    height: 0.05.sh,
                    width: 0.1.sw,
                    // color: Colors.white,
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: reviewerImage == ""
                          ? "NoImage"
                          : ImageUrls.kUserProfile + reviewerImage.toString(),
                      placeholder: (context, url) => Icon(Icons.image),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    )),
              ),
            ),
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
                Text(
                  reviewDescription,
                  style: TextStyle(
                    fontSize: 15.r,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 0.4.sw,
            )
          ],
        ),
      ),
    );
  }
}
