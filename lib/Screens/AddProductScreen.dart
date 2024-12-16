import 'dart:developer';
import 'dart:io';

import 'package:app_fliplaptop/Apiserrvices/Services.dart';
import 'package:app_fliplaptop/Apiserrvices/loader.dart';
import 'package:app_fliplaptop/Controller/productController.dart';
import 'package:app_fliplaptop/Screens/AddDescriptionScreen.dart';
import 'package:app_fliplaptop/res/utils/utils.dart';
import 'package:app_fliplaptop/widgets/disallow_indicator_widget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../components/global.dart';

class AddProductScreen extends StatefulWidget {
  final String storeID;

  AddProductScreen({super.key, required this.storeID});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  late File imageFile;
  TextEditingController productName = TextEditingController();
  TextEditingController modelName = TextEditingController();
  List<String> productImageList = [];
  String? brandName;
  final addProductController = Get.put(ProductController());

  _getFromGallery() async {
    // List<ImageSo> list = [ImageSource.gallery,ImageSource.gallery];
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      if (!productImageList.contains(pickedFile.path)) {
        print("Doesnot caontain");
        productImageList.add(pickedFile.path);
        print(productImageList);
        addProductController.incrementCounter();
        // setState(() {
        imageFile = File(pickedFile.path);
        // });
      }
    }
  }

  String? selectedValue;

  bool isNew = false;
  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];
  String? selectedValue1;


  @override
  Widget build(BuildContext context) {
    void deleteEntry(String productImage) {
      for (int i = 0; i < productImageList.length; i++) {
        if (productImageList[i] == productImage) {
          productImageList.removeAt(i);
          addProductController.incrementCounter();
          break;
        }
      }
    }

    Widget addProductImage(String imagePath) {
      return Row(
        children: [
          Container(
            // margin: EdgeInsets.only(right: 10.horizontalSpace,),
            width: Get.width * 0.2,
            alignment: Alignment.center,
            height: 83.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                image: DecorationImage(
                    image: FileImage(File(imagePath)), fit: BoxFit.cover)),
            child: GestureDetector(
              onTap: () {
                deleteEntry(imagePath);
              },
              child: Image.asset(
                'assets/Icon ionic-ios-close-circle.png',
                color: Colors.white,
                scale: 1.4,
              ),
            ),
          ),
          10.horizontalSpace,
        ],
      );
    }

    // @override
    // void initState() {
    //   if (ApiServices.storeId.toString() == "") {
    //     print(ApiServices.storeId);
    //     print("empty");
    //     Get.toNamed('/CreateStoreScreen');
    //   }else{
    //     print("not empty");
    //   }
    //     print(ApiServices.storeId);
    //   super.initState();
    // }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Add Product  ',
            style: GoogleFonts.inter(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, gradient: kbtngradient),
                child: SvgPicture.asset(
                  'assets/Path 11.svg',
                  width: 14,
                )),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 20.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: "1",
                            style: GoogleFonts.inter(color: highlightedText)),
                        TextSpan(
                            text: "/",
                            style: GoogleFonts.inter(color: Colors.black)),
                        TextSpan(
                            text: "3",
                            style: GoogleFonts.inter(color: Colors.black))
                      ],
                      style: GoogleFonts.inter(
                          fontSize: 15.sp,
                          color: highlightedText,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              23.verticalSpace,
              Container(
                height: 10.h,
                width: Get.width,
                padding: EdgeInsets.only(right: Get.width * 0.63),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.r)),
                child: Container(
                  decoration: BoxDecoration(
                      gradient: kbtngradient,
                      borderRadius: BorderRadius.circular(5.r)),
                ),
              ),
              30.verticalSpace,
              button2(388.w, 59.h, 'Next', () {
                print(
                    "brand $brandName model${modelName.text} condition new?$isNew ");
                // addProductController.addproductModel["store_id"] = "123";
                // addProductController.addproductModel["store_id"] = "345";
                // print(addProductController.addproductModel);
                // print(addProductController.addproductModel["store_id"]);

                if (productImageList.length == 0) {
                  Utils.showSnack("Add Image", context);
                } else if (productName.text.isEmpty) {
                  Utils.showSnack("Enter Product Name", context);
                } else if (brandName == null) {
                  Utils.showSnack("Enter Brand", context);
                } else if (modelName.text.isEmpty) {
                  Utils.showSnack("Enter Model", context);
                } else {
                  print(
                      "brand $brandName model${modelName.text} condition new?$isNew ");

                  Get.to(AddDescriptionScreen(
                      //      productImageList: productImageList,
                      // brandName: brandName,
                      // modelName: modelName.text,
                      // condition:isNew?"New":"Used"
                      ));

                  //          addProductController.addproductModel["store_id"] = "123";
                  // addProductController.addproductModel["store_id"] = "345";
                  // print(addProductController.addproductModel);
                  // print(addProductController.addproductApiModel["store_id"]);
                  // addProductController.addproductApiModel["store_id"] = "4";
                  addProductController.addproductApiModel.clear();
                  addProductController.addproductApiModel["name"] =
                      productName.text;
                  addProductController.addproductApiModel["store_id"] =
                      widget.storeID;
                  addProductController.addproductApiModel["condition_type"] =
                      isNew ? "New" : "Used";
                  addProductController.addproductApiModel["category_id"] =
                      int.parse(brandName!);
                  addProductController.addproductApiModel["model"] =
                      modelName.text;
                  addProductController.addproductApiModel["images[]"] =
                      productImageList;
                  print(addProductController.addproductApiModel);
                }
              }

                  //  Get.toNamed('/AddDescriptionScreen')

                  )
            ],
          ),
        ),
        body: DisAllowIndicatorWidget(
          child: FutureBuilder(
              future: ApiServices().productCategoryApiFunc(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Loader.spinkit;
                } else if (snapshot.hasError) {
                  // log(snapshot.hasError.toString());
                  return Text(snapshot.error.toString());
                } else if (snapshot.hasData) {
                  return ListView(
                    padding: EdgeInsets.symmetric(horizontal: 20.r),
                    children: [
                      GetBuilder<ProductController>(
                        builder: (controller) {
                          return productImageList.length == 0
                              ? Container()
                              : Container(
                                  height: 85.h,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: productImageList.length,
                                      itemBuilder: (context, index) {
                                        final iteration =
                                            productImageList[index];
                                        return addProductImage(iteration);
                                      }),
                                );
                          //  Center(
                          //   child: Text('${controller.counter}'),
                          // );
                        },
                      ),
                      // Row(
                      //   children: [
                      // AddProductImage(imagePath: "imagePath"),
                      //     InkWell(
                      //       onTap: () {},
                      //       child: Container(
                      //         width: Get.width * 0.2,
                      //         alignment: Alignment.center,
                      //         height: 83.h,
                      //         decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(10.r),
                      //             image: DecorationImage(
                      //                 image: AssetImage(
                      //                     'assets/NoPath - Copy (23)Apple.png'),
                      //                 fit: BoxFit.cover)),
                      //         child: Image.asset(
                      //           'assets/Icon ionic-ios-close-circle.png',
                      //           color: Colors.white,
                      //           scale: 1.4,
                      //         ),
                      //       ),
                      //     ),
                      //     10.horizontalSpace,
                      //     InkWell(
                      //       onTap: () {},
                      //       child: Container(
                      //         width: Get.width * 0.2,
                      //         alignment: Alignment.center,
                      //         height: 83.h,
                      //         decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(10.r),
                      //             image: DecorationImage(
                      //                 image: AssetImage(
                      //                     'assets/M2-MacBook-Air-2022-Feature0012.png'),
                      //                 fit: BoxFit.cover)),
                      //         child: Image.asset(
                      //           'assets/Icon ionic-ios-close-circle.png',
                      //           color: Colors.white,
                      //           scale: 1.4,
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      20.verticalSpace,
                      Container(
                        height: 120.h,
                        alignment: Alignment.center,
                        // padding: EdgeInsets.symmetric(
                        //   vertical: 37.r
                        // ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.r),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 6)
                            ]),
                        child: InkWell(
                            onTap: _getFromGallery,
                            child: SvgPicture.asset(
                              'assets/Icon feather-upload.svg',
                              width: 47.r,
                            )),
                      ),
                      15.verticalSpace,
                      Text(
                        'Condition',
                        style: GoogleFonts.inter(
                            color: Colors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600),
                      ),
                      15.verticalSpace,
                      GetBuilder<ProductController>(builder: (controller) {
                        return Row(
                          children: [
                            InkWell(
                              onTap: () {
                                // setState(() {
                                addProductController.incrementCounter();
                                isNew = !isNew;
                                // });
                              },
                              child: Container(
                                width: 123.w,
                                height: 40.h,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: isNew == false
                                        ? Color(0xff1D1D1D)
                                        : Color(0xff1D1D1D).withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(10.r)),
                                child: Text(
                                  'Used',
                                  style: GoogleFonts.inter(
                                      color: isNew == false
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 16.sp),
                                ),
                              ),
                            ),
                            10.horizontalSpace,
                            InkWell(
                              onTap: () {
                                // setState(() {
                                addProductController.incrementCounter();
                                isNew = !isNew;
                                // });
                              },
                              child: Container(
                                width: 123.w,
                                height: 40.h,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: isNew == false
                                        ? Color(0xff1D1D1D).withOpacity(0.2)
                                        : Colors.black,
                                    borderRadius: BorderRadius.circular(10.r)),
                                child: Text(
                                  'New',
                                  style: GoogleFonts.inter(
                                      color: isNew == false
                                          ? Colors.black
                                          : Colors.white,
                                      fontSize: 16.sp),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                      15.verticalSpace,
                      Text(
                        'Name ',
                        style: GoogleFonts.inter(
                            color: Colors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600),
                      ),
                      15.verticalSpace,
                      Container(
                        height: 60.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30.r)),
                        child: TextField(
                          maxLines: 1,
                          controller: productName,
                          style: GoogleFonts.inter(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 16.sp),
                          decoration: InputDecoration(
                              isDense: true,
                              isCollapsed: true,
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 20.r),
                              hintText: 'Product Name',
                              helperStyle: GoogleFonts.inter(
                                  color: Colors.black.withOpacity(0.5))),
                        ),
                      ),


                      15.verticalSpace,
                      Text(
                        'Brand',
                        style: GoogleFonts.inter(
                            color: Colors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600),
                      ),
                      15.verticalSpace,


                      Container(
                        height: 60.h,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30.r)),
                        child: DropdownButtonFormField2(
                          
                          iconStyleData: IconStyleData(
                            icon: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black,)
                          ),
                          




                          value: brandName,

                          isExpanded: true,
                          hint: Text(
                            'Select Brand',
                            style: GoogleFonts.inter(fontSize: 16.sp,color: Colors.red),
                          ),


                          items: ApiServices
                              .productCategoryDataList.first.data!.brand!
                              // productSizeList
                              .map((item) => DropdownMenuItem<String>(
                                    value: item.id.toString(),
                                    child: Text(
                                      item.name.toString(),
                                      style: GoogleFonts.inter(
                                          fontSize: 16.sp,
                                          color: Colors.black.withOpacity(0.5)),
                                    ),
                                  ))
                              .toList(),
                          validator: (value) {
                            if (value == null) {
                              return 'Please select gender.';
                            }
                          },
                          onChanged: (value) {
                              brandName = value.toString();
                                                         print("Brand $value");
                            // addEntry(value.toString());
                            // productSize = value.toString();
                            // print(productSize);
                            //Do something when changing the item if you want.
                          },
                          onSaved: (value) {
                            // productSize = value.toString();
                          },



                          decoration: InputDecoration(
                            //Add isDense true and zero Padding.
                            //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                              isDense: true,



                              fillColor: Colors.green,
                              contentPadding: EdgeInsets.only(top: 15.h, left: 10.w , right: 20.w
                                  
                              ),
                              border: InputBorder.none
                            //Add more decoration as you want here
                            //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                          ),
                        ),
                      ),
                      // Text(
                      //   'Brand',
                      //   style: GoogleFonts.inter(
                      //       color: Colors.black,
                      //       fontSize: 18.sp,
                      //       fontWeight: FontWeight.w600),
                      // ),
                      // 15.verticalSpace,
                      // Container(
                      //   height: 60.h,
                      //   alignment: Alignment.center,
                      //   decoration: BoxDecoration(
                      //       color: Colors.white,
                      //       borderRadius: BorderRadius.circular(30.r)),
                      //   child: TextField(
                      //     maxLines: 1,
                      //     controller: brandName,
                      //     style: GoogleFonts.inter(
                      //         color: Colors.black.withOpacity(0.5), fontSize: 16.sp),
                      //     decoration: InputDecoration(
                      //         isDense: true,
                      //         isCollapsed: true,
                      //         border: InputBorder.none,
                      //         contentPadding: EdgeInsets.symmetric(horizontal: 20.r),
                      //         hintText: 'Dell',
                      //         helperStyle: GoogleFonts.inter(
                      //             color: Colors.black.withOpacity(0.5))),
                      //   ),
                      // ),
                      15.verticalSpace,
                      Text(
                        'Model Name ',
                        style: GoogleFonts.inter(
                            color: Colors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600),
                      ),
                      15.verticalSpace,
                      Container(
                        height: 60.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30.r)),
                        child: TextField(
                          maxLines: 1,
                          controller: modelName,
                          style: GoogleFonts.inter(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 16.sp),
                          decoration: InputDecoration(
                              isDense: true,
                              isCollapsed: true,
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 20.r),
                              hintText: 'Core i3',
                              helperStyle: GoogleFonts.inter(
                                  color: Colors.black.withOpacity(0.5))),
                        ),
                      ),

                      // 57.verticalSpace,
                    ],
                  );
                } else {
                  return Center(child: Text(snapshot.error.toString()));
                }
              }),
        ));
  }
}
