import 'package:app_fliplaptop/Controller/productController.dart';
import 'package:app_fliplaptop/Screens/AppleScreen.dart';
import 'package:app_fliplaptop/models/dashBoardModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class StoreProfileNewArrival extends StatefulWidget {
  List<Datum> newProfileList;
  String storeId;
  String storeProfile;
  String storeName;

  // Discount discountIns;

  StoreProfileNewArrival({
    super.key,
    required this.newProfileList,
    required this.storeId,
    required this.storeProfile,
    required this.storeName,
    // required this.discountIns,
  });

  @override
  State<StoreProfileNewArrival> createState() => _StoreProfileNewArrivalState();
}

class _StoreProfileNewArrivalState extends State<StoreProfileNewArrival> {
  List<Datum> filteredNewArrivalList = [];
  final threeDaysAgo = DateTime.now().subtract(Duration(days: 3));

  void filterNewArrival() {
    // print(widget.newProfileList.length);
    // print(widget.newProfileList[0].createdAt);
    // widget.newProfileList
    List<Datum> productList = widget.newProfileList;

    for (int i = 0; i < productList.length; i++) {
      final DateFormat dateFormater = DateFormat('dd MMM yyyy - HH:mm:ss');
      DateTime created =
          dateFormater.parse(productList[i].createdAt.toString());
      print(created);
      if (created.compareTo(threeDaysAgo) > 0) {
        print("In the range");
        print(threeDaysAgo);
        print(created);
        filteredNewArrivalList.add(productList[i]);
      }
      // else if(threeDaysAgo.compareTo(created)>0){
      //      print("Not in the range");
      //   print(threeDaysAgo);
      //   print(created);
      // }
    }
  }

//   final var1 = DateTime.parse("2023-08-15 01:18:03");
//   final var2 = DateTime.parse("2023-08-15 01:18:02");

// void ff(){
//     if (var1.compareTo(var2) > 0) {
//     print("var1 is after var2");
//   } else if (var1.compareTo(var2) < 0) {
//     print("var1 is before var2");
//   } else {
//     print("var1 is equal to var2");
//   }
// }
  @override
  void initState() {
    filterNewArrival();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
        // widget.newProfileList.toString != "[]"
        "$filteredNewArrivalList" != "[]"
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      // itemCount: widget.newProfileList.length,
                      itemCount: filteredNewArrivalList.length,
                      itemBuilder: (context, index) {
                        // var abc = [
                        //   {"name": widget.storeName},
                        // ];
                        final itertation = filteredNewArrivalList[index];
                        var dis = widget.newProfileList[index].discount;
                        print("==============> dis" + dis.toString());
                        final addProductController =
                            Get.put(ProductController());
                        addProductController.editDatumInstance.value =
                            itertation;
                        print("================>" +
                            addProductController.editDatumInstance.value.name
                                .toString());
                        return newArrivalCard(
                            itertation,
                            widget.storeId,
                            widget.storeProfile,
                            widget.storeName,
                            "name",
                            'Reviews (4.9)',
                            itertation.productImage!.isEmpty
                                ? ""
                                : itertation.productImage![0].name,
                            itertation.price,
                            itertation.conditionType,
                            itertation.descriptions,
                            itertation.name,
                            "",
                            index,
                            widget.newProfileList[index].discount,
                            itertation.dealItemPrice,
                            itertation.dealItemStartDatetime,
                            itertation.dealItemEndDatetime
                            // 'assets/M2-MacBook-Air-2022-Feature0012.png',
                            );
                      }),
                  // newArrivalCard('MacBook Pro', 'Reviews (4.9)', '\$ 15.59',
                  //     'assets/M2-MacBook-Air-2022-Feature0012.png'),
                  // // 20.verticalSpace,
                  // newArrivalCard('Lenovo Laptop', 'Reviews (4.9)', '\$ 15.59',
                  //     'assets/andras-vas-Bd7gNnWJBkU-unsplash.png'),
                ],
              )
            : Container();
  }
}
