import 'package:app_fliplaptop/components/myStoreNewArrivalProductList.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/global.dart';

class PersonalPostedProductScreen extends StatefulWidget {
  final String storeID;

  const PersonalPostedProductScreen({super.key, required this.storeID});

  @override
  State<PersonalPostedProductScreen> createState() =>
      _PersonalPostedProductScreenState();
}

// List productList = [
//   products('Apple', 'MacBook Pro', 'Only 1 left in stock',
//       'assets/M2-MacBook-Air-2022-Feature0012.png', '1'),
//   products('Apple', 'MacBook Pro', 'Only 1 left in stock',
//       'assets/andras-vas-Bd7gNnWJBkU-unsplash.png', '1'),
//   products('Apple', 'MacBook Pro', 'Only 1 left in stock',
//       'assets/M2-MacBook-Air-2022-Feature0012(2).png', '1'),
//   products('Apple', 'MacBook Pro', 'Only 1 left in stock',
//       'assets/maxim-hopman-Hin-rzhOdWs-unsplash.png', '1'),
//   products('Apple', 'MacBook Pro', 'Only 1 left in stock',
//       'assets/alex-knight-j4uuKnN43_M-unsplash.png', '1'),
// ];
final List<String> genderItems = [
  '1',
  '2',
];

class _PersonalPostedProductScreenState
    extends State<PersonalPostedProductScreen> {
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
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, gradient: kbtngradient),
                child: SvgPicture.asset(
                  'assets/Path 11.svg',
                  width: 14,
                ))),
        centerTitle: true,
        title: Text(
          'Personal Posted Items',
          style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
      body: Center(
        child: SizedBox(
            width: 0.95.sw,
            child: MyStoreNewArrivalProductList(
              storeID: widget.storeID,
            )),
      ),
    );
  }
}

productCard(
    productName, productModal, productStock, productImage, productQuantity) {
  return InkWell(
    onTap: () {},
    child: Container(
      height: 155.h,
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: Colors.white.withOpacity(0.23),
          boxShadow: [
            BoxShadow(
                blurRadius: 20,
                offset: Offset(0, 6),
                color: Color.fromARGB(194, 116, 115, 115).withOpacity(0.13))
          ]),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                width: Get.width * 0.45,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.r),
                        bottomLeft: Radius.circular(10.r)),
                    image: DecorationImage(
                        image: AssetImage(productImage), fit: BoxFit.cover)),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: InkWell(
                  child: Container(
                    width: 27.r,
                    height: 27.r,
                    // padding: EdgeInsets.all(5.r),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child: Icon(
                      Icons.edit,
                      color: Colors.black,
                      size: 18.r,
                    ),
                  ),
                ),
              )
            ],
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        productName,
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.bold),
                      ),
                      30.verticalSpace,
                      InkWell(
                        child: Container(
                          width: 27.r,
                          height: 27.r,
                          // padding: EdgeInsets.all(5.r),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, gradient: kbtngradient),
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 14.r,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    productModal,
                    style: GoogleFonts.inter(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 14.sp,
                    ),
                  ),
                  10.verticalSpace,
                  Text(
                    productStock,
                    style: GoogleFonts.inter(
                        fontSize: 12.sp, color: highlightedText),
                  ),
                  10.verticalSpace,
                  Container(
                    width: 65.w,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r)),
                    child: DropdownButtonFormField2(
                      decoration: InputDecoration(
                        //Add isDense true and zero Padding.

                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        isCollapsed: true,

                        border: InputBorder.none,
                        //Add more decoration as you want here
                        //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                      ),
                      isExpanded: false,
                      hint: Text(
                        'Qty ${productQuantity}',
                        style: TextStyle(fontSize: 12.sp),
                      ),
                      customButton: SvgPicture.asset(
                        'assets/Icon ionic-ios-arrow-down.svg',
                        width: 10.r,
                      ),
                      // iconSize: 10.r,
                      // buttonHeight: 20,
                      // buttonWidth: 30.w,
                      // buttonPadding: EdgeInsets.symmetric(horizontal: 10.r),
                      // dropdownDecoration: BoxDecoration(
                      //   borderRadius: BorderRadius.circular(15),
                      // ),
                      items: genderItems
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select gender.';
                        }
                      },
                      onChanged: (value) {
                        //Do something when changing the item if you want.
                      },
                      onSaved: (value) {
                        productQuantity = "Qty ${value}";
                      },
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}

class products {
  String? productName;
  String? productModal;
  String? productImage;

  String? productStock;
  String? productQuatity;

  products(this.productName, this.productModal, this.productStock,
      this.productImage, this.productQuatity);
}
