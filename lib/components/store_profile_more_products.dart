import 'package:app_fliplaptop/Controller/dashBoardController.dart';
import 'package:app_fliplaptop/Controller/productController.dart';
import 'package:app_fliplaptop/Screens/DellScreen.dart';
import 'package:app_fliplaptop/models/dashBoardModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
// import '../models/product_listing_data_model/datum.dart';

class StoreProfileMoreProducts extends StatefulWidget {
  List<Datum> moreProductList;
  String storeId;
  String storeProfile;
  String storeName;

  StoreProfileMoreProducts(
      {super.key,
      required this.moreProductList,
      required this.storeId,
      required this.storeProfile,
      required this.storeName});

  @override
  State<StoreProfileMoreProducts> createState() =>
      _StoreProfileMoreProductsState();
}

class _StoreProfileMoreProductsState extends State<StoreProfileMoreProducts> {
  List<Datum> filteredMoreProductsList = [];
  final threeDaysAgo = DateTime.now().subtract(Duration(days: 3));

  void filterMoreProducts() {
    List<Datum> productList = widget.moreProductList;

    for (int i = 0; i < productList.length; i++) {
      final DateFormat dateFormater = DateFormat('dd MMM yyyy - HH:mm:ss');
      DateTime created =
          dateFormater.parse(productList[i].createdAt.toString());
      print(created);
      if (created.compareTo(threeDaysAgo) < 0) {
        print("In the range");
        print(threeDaysAgo);
        print(created);
        filteredMoreProductsList.add(productList[i]);
      }
    }
  }

  @override
  void initState() {
    filterMoreProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return "$filteredMoreProductsList" != "[]"
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                itemCount: filteredMoreProductsList.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 0.83),
                itemBuilder: (BuildContext context, int index) {
                  final dashBoardController = Get.put(DashBoardController());
                  final iteration = filteredMoreProductsList[index];
                  final addProductController = Get.put(ProductController());

                  return moreProductCard(
                    iteration,
                    widget.storeId,
                    widget.storeProfile,
                    widget.storeName,
                    index,
                    "",
                    widget.moreProductList.first.discount,
                    widget.moreProductList.first.dealItemPrice,
                    widget.moreProductList.first.dealItemStartDatetime,
                    widget.moreProductList.first.dealItemEndDatetime,
                  );
                },
              )
            ],
          )
        : Container();
  }
}
