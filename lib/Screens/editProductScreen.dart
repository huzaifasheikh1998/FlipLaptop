import 'dart:developer';
import 'dart:io';

import 'package:app_fliplaptop/Apiserrvices/app_url.dart';
import 'package:app_fliplaptop/Screens/ListOfProduct.dart';
import 'package:app_fliplaptop/Screens/editDescription.dart';
import 'package:app_fliplaptop/components/global.dart';
import 'package:app_fliplaptop/models/dashBoardModel.dart';
import 'package:app_fliplaptop/res/utils/utils.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../Apiserrvices/Services.dart';
import '../Apiserrvices/loader.dart';
import '../Controller/productController.dart';
import '../widgets/disallow_indicator_widget.dart';

class EditProductsScreen extends StatefulWidget {
  const EditProductsScreen({super.key, required this.productData});

  final Datum productData;

  @override
  State<EditProductsScreen> createState() =>
      _EditProductsScreenState(productData: productData);
}

class _EditProductsScreenState extends State<EditProductsScreen> {
  // Icon(Icons.gallery)
  final Datum productData;
  File? imageFile;
  TextEditingController productName = TextEditingController();
  TextEditingController modelName = TextEditingController();
  List<String> productImageList = [];
  List<ProductImage> existingImageList = [];
  // List<ProductImage> deletedExistingImageList = [];
  String? brandName;
  final addProductController = Get.put(ProductController());

  _EditProductsScreenState({
    required this.productData,
  });

  _getFromGallery() async {
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
        imageFile = File(pickedFile.path);
      }
    }
  }

  String? selectedValue;
  bool isNew = false;

  @override
  void initState() {
    // TODO: implement initState
    productName.text = productData.name!;
    modelName.text = productData.model!;
    log("================== Edit product data"+productData.toJson().toString());
    print("=============> brand name from model is" +
        (productData.brands!.name ?? ""));
    brandName = productData.brands!.name;
    addProductController.editDatumInstance.value = productData;
    // productData.productImage.forEach((element) {element})
    // for(var  i=0; i<productData.productImage!.length;i++){
    // productImageList.add()
    existingImageList = productData.productImage!;
    // }
    // brandName =
    /// want to get the brand name and handle its default value
    // brandName = productData.
    super.initState();
  }

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

    void deleteExisting(ProductImage productImage) {
      // for (int i = 0; i < productImageList.length; i++) {
      productController.deletedExistingImageList.add(productImage);
      existingImageList.remove(productImage);
      print(productController.deletedExistingImageList.toString());
      print(existingImageList.toString());
      setState(() {});
      // if (productImageList[i] == productImage) {
      //   productImageList.removeAt(i);
      //   addProductController.incrementCounter();
      //   break;
      // }
      // }
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

    Widget addExistingImage(ProductImage imagePath) {
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
                fit: BoxFit.cover,
                image: NetworkImage(ImageUrls.kProduct + imagePath.name!),
              ),
            ),
            child: GestureDetector(
              onTap: () {
                deleteExisting(imagePath);
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

    return Scaffold(
      appBar: AppBar(
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
          'Update Product',
          style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
      body: DisAllowIndicatorWidget(
        child: FutureBuilder(
            future: ApiServices().productCategoryApiFunc(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Loader.spinkit;
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else if (snapshot.hasData) {
                return ListView(
                  padding: EdgeInsets.symmetric(horizontal: 20.r),
                  children: [
                    Row(
                      children: [
                        existingImageList.length == 0
                            ? Container()
                            : Container(
                                height: 85.h,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: existingImageList.length,
                                    itemBuilder: (context, index) {
                                      final iteration =
                                          existingImageList[index];
                                      return addExistingImage(iteration);
                                    }),
                              ),
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
                          },
                        ),
                      ],
                    ),
                    20.verticalSpace,
                    Container(
                      height: 120.h,
                      alignment: Alignment.center,
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
                    20.verticalSpace,
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text(
                    //       'Visibility',
                    //       style: GoogleFonts.inter(
                    //           color: Colors.black,
                    //           fontSize: 18.sp,
                    //           fontWeight: FontWeight.w600),
                    //     ),
                    //     Obx(
                    //       () => Column(
                    //         children: [
                    //           Switch(
                    //             activeColor: Colors.red,
                    //             value: addProductController.isVisibile.value,
                    //             onChanged: addProductController
                    //                 .handleSwitchValueChanged,
                    //           ),
                    //           Text(
                    //             '${addProductController.isVisibile.value ? 'Visible' : 'Draft'}',
                    //             style: TextStyle(
                    //               fontWeight: FontWeight.bold,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //     // 1.horizontalSpace,
                    //   ],
                    // ),
                    // SizedBox(height: 16),
                    // 15.verticalSpace,
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
                              addProductController.incrementCounter();
                              isNew = !isNew;
                              print(isNew);
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
                              addProductController.incrementCounter();
                              isNew = !isNew;
                              print(isNew);
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
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: DropdownButtonFormField2(
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
                        iconStyleData: IconStyleData(
                            icon: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black,)
                        ),
                        isExpanded: true,
                        hint: Text(
                          brandName.toString(),
                          style: GoogleFonts.inter(fontSize: 16.sp),
                        ),

                        // iconSize: 30,
                        // buttonHeight: 60.h,
                        // buttonPadding: EdgeInsets.only(left: 10.r, right: 20.r),
                        // dropdownDecoration: BoxDecoration(
                        //   borderRadius: BorderRadius.circular(15),
                        // ),
                        items: ApiServices
                            .productCategoryDataList.first.data!.brand!
                            .map((item) => DropdownMenuItem<String>(
                                  value: item.name.toString(),
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
                          print("brand name is" + brandName.toString());
                          brandName = value.toString();
                          print("Brand $brandName");
                        },
                        onSaved: (value) {},
                      ),
                    ),
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
                  ],
                );
              } else {
                return Center(child: Text(snapshot.error.toString()));
              }
            }),
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
              // if (productImageList.length == 0) {
              //   Utils.showSnack("Add Image", context);
              // } else
              if (productName.text.isEmpty) {
                Utils.showSnack("Enter Product Name", context);
              } else if (brandName == null) {
                Utils.showSnack("Enter Brand", context);
              } else if (modelName.text.isEmpty) {
                Utils.showSnack("Enter Model", context);
              } else {
                print(
                    "brand $brandName model${modelName.text} condition new?$isNew ");

                // print(productData.size!.length);
                if (imageFile != null) {
                  Get.to(() => EditDescriptionScreen(
                        productData: productData,
                        productVisibility: addProductController.isVisibile.value
                            ? "Visible"
                            : "Draft",
                        productColor: productData.color!.id!,
                        prodSize: productData.size!,
                        productMemory: productData.memory!.id!,
                        productDescription: productData.descriptions!,
                        productHardDrive: productData.hardDrive!.id ?? "",
                        productPrice: productData.price.toString(),
                        productQuantity: productData.qty.toString(),

                        /// This is hard quoted needs tpo be changed from backend
                        productShippingCost: "",
                        productName: productName.text,
                        productBrand: brandName ?? productData.brands!.id ?? "",
                        productModelName: modelName.text,
                        productCondition: isNew ? "New" : "Used",
                        productID: productData.id.toString(),
                        imageFile: imageFile!,

                        //      productImageList: productImageList,
                        // brandName: brandName,
                        // modelName: modelName.text,
                        // condition:isNew?"New":"Used"
                      ));
                } else {
                  Get.to(() => EditDescriptionScreen(
                        productData: productData,
                        productColor: productData.color!.id ?? "",
                        prodSize: productData.size!,
                        productMemory: productData.memory!.id ?? "",
                        productDescription: productData.descriptions!,
                        productHardDrive: productData.hardDrive!.id ?? "",
                        productPrice: productData.price.toString(),
                        productQuantity: productData.qty.toString(),

                        /// This is hard quoted needs tpo be changed from backend
                        productShippingCost: "120",
                        productName: productName.text,
                        productBrand: brandName ?? productData.brands!.id ?? "",
                        productModelName: modelName.text,
                        productCondition: isNew == true ? "New" : "Used",
                        productID: productData.id.toString(),
                        productVisibility: addProductController.isVisibile.value
                            ? "Visible"
                            : "Draft",
                        // imageFile: imageFile!,
                        //      productImageList: productImageList,
                        // brandName: brandName,
                        // modelName: modelName.text,
                        // condition:isNew?"New":"Used"
                      ));
                }
                //          addProductController.addproductModel["store_id"] = "123";
                // addProductController.addproductModel["store_id"] = "345";
                // print(addProductController.addproductModel);
                // print(addProductController.addproductApiModel["store_id"]);
                // addProductController.addproductApiModel["store_id"] = "4";
                addProductController.addproductApiModel.clear();
                addProductController.addproductApiModel["name"] =
                    productName.text;
                addProductController.addproductApiModel["condition_type"] =
                    isNew ? "New" : "Used";
                int foundIndex = ApiServices
                    .productCategoryDataList.first.data!.brand!
                    .indexWhere((element) => element.name == brandName);
                addProductController.addproductApiModel["category_id"] =
                    ApiServices.productCategoryDataList.first.data!
                        .brand?[foundIndex].id;
                // int.parse(brandName!)

                addProductController.addproductApiModel["model"] =
                    modelName.text;
                addProductController.addproductApiModel["images[]"] =
                    productImageList;
                addProductController.addproductApiModel["deleteImages[]"] =
                    productController.deletedExistingImageList;
                print(addProductController.addproductApiModel);
              }
            }

                //  Get.toNamed('/AddDescriptionScreen')

                ),
          ],
        ),
      ),
    );
  }
}
