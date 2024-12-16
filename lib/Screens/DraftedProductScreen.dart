import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/global.dart';

class ListOfDraftedProductScreen extends StatefulWidget {
  const ListOfDraftedProductScreen({super.key});

  @override
  State<ListOfDraftedProductScreen> createState() =>
      _ListOfDraftedProductScreenState();
}

List draftedProductList = [
  products('Apple', 'MacBook Pro', 'assets/M2-MacBook-Air-2022-Feature0012.png',
      'Lorem ipsum dolor sit amet consectetur adipiscing elit'),
  products('Apple', 'MacBook Pro', 'assets/andras-vas-Bd7gNnWJBkU-unsplash.png',
      'Lorem ipsum dolor sit amet consectetur adipiscing elit'),
  products(
      'Apple',
      'MacBook Pro',
      'assets/M2-MacBook-Air-2022-Feature0012(2).png',
      'Lorem ipsum dolor sit amet consectetur adipiscing elit'),
  products(
      'Apple',
      'MacBook Pro',
      'assets/maxim-hopman-Hin-rzhOdWs-unsplash.png',
      'Lorem ipsum dolor sit amet consectetur adipiscing elit'),
  products(
      'Apple',
      'MacBook Pro',
      'assets/alex-knight-j4uuKnN43_M-unsplash.png',
      'Lorem ipsum dolor sit amet consectetur adipiscing elit'),
];
final List<String> genderItems = [
  '1',
  '2',
];

class _ListOfDraftedProductScreenState
    extends State<ListOfDraftedProductScreen> {
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
          'Drafted products',
          style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 10.r),
        itemCount: draftedProductList.length,
        itemBuilder: (context, index) => Column(
          children: [
            productCard(
              draftedProductList[index].productName,
              draftedProductList[index].productModal,
              draftedProductList[index].productDes,
              draftedProductList[index].productImage,
            ),
            20.verticalSpace
          ],
        ),
      ),
    );
  }
}

productCard(productName, productModal, productDes, productImage) {
  return InkWell(
    onTap: () {},
    child: Container(
      height: 155.h,
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              blurRadius: 20,
              offset: Offset(0, 6),
              color: Color.fromARGB(194, 116, 115, 115).withOpacity(0.23))
        ],
        borderRadius: BorderRadius.circular(10.r),
        color: Colors.white.withOpacity(0.1),
      ),
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
              padding: EdgeInsets.only(
                left: 20.r,
              ),
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
                    productDes,
                    style: GoogleFonts.inter(
                        fontSize: 12.sp, color: Colors.black.withOpacity(0.5)),
                  ),
                  10.verticalSpace,
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
  String? productDes;

  products(
      this.productName, this.productModal, this.productImage, this.productDes);
}
