import 'dart:io';

import 'package:app_fliplaptop/Apiserrvices/Services.dart';
import 'package:app_fliplaptop/Screens/editProductPriceScreen.dart';
import 'package:app_fliplaptop/models/dashBoardModel.dart';
import 'package:app_fliplaptop/models/product_category_data_model/display_size.dart';
import 'package:app_fliplaptop/res/utils/utils.dart';
import 'package:app_fliplaptop/widgets/disallow_indicator_widget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Controller/productController.dart';
import '../components/global.dart';

final List<String> colorList = ['Black', 'White', 'Red', 'Orange', 'Yellow'];
final List<String> productSizeList = [
  '12in, 16 inc',
  '14in, 18 inc',
  '16in, 20 inc',
];
final List<String> memorySizeList = [
  '(24 gb)',
  '(32 gb)',
  '(64 gb)',
  '(128 gb)'
];

class EditDescriptionScreen extends StatefulWidget {
  EditDescriptionScreen({
    super.key,
    required this.productColor,
    required this.prodSize,
    required this.productMemory,
    required this.productDescription,
    required this.productHardDrive,
    required this.productPrice,
    required this.productQuantity,
    required this.productShippingCost,
    required this.productName,
    required this.productBrand,
    required this.productModelName,
    required this.productCondition,
    required this.productID,
    this.imageFile,
    required this.productVisibility,
    required this.productData,
    // this.pro, required Datum productDataductImageList,
    // this.brandName,
    // this.modelName,
    // this.condition
  });

  // List<String>? productImageList;
  // String? brandName;
  // String? modelName;
  // String? condition;
  final String productID;
  final Datum productData;
  final String productName;
  final String productBrand;
  final String productModelName;
  final String productCondition;
  final String productColor;
  final List<ModelColor> prodSize;
  final String productVisibility;
  final String productMemory;
  final String productDescription;
  final String productHardDrive;
  final String productPrice;
  final String productQuantity;
  final String productShippingCost;
  final File? imageFile;

  @override
  State<EditDescriptionScreen> createState() => _EditDescriptionScreenState(
        productColor: productColor,
        prodSize: prodSize,
        productMemory: productMemory,
        productDescription: productDescription,
        productHardDrive: productHardDrive,
        productPrice: productPrice,
        productQuantity: productQuantity,
        productShippingCost: productShippingCost,
        productName: productName,
        productBrand: productBrand,
        productModelName: productModelName,
        productCondition: productCondition,
        productID: productID,
        imageFile: imageFile,
        productVisibility: productVisibility,
      );
}

class _EditDescriptionScreenState extends State<EditDescriptionScreen> {
  final String productID;
  final String productName;
  final String productBrand;
  final String productModelName;
  final String productCondition;
  final String productColor;
  final List<ModelColor> prodSize;
  final String productVisibility;
  final String productMemory;
  final String productDescription;
  final String productHardDrive;
  final String productPrice;
  final String productQuantity;
  final String productShippingCost;
  final File? imageFile;
  final addProductController = Get.put(ProductController());
  TextEditingController description = TextEditingController();

  final List<DisplaySize> sizesList = [];

  String? colorValue;
  String? productSize;
  String? memorySize;

  // String? DriveType;
  String? DriveSize;

  _EditDescriptionScreenState({
    required this.imageFile,
    required this.productVisibility,
    required this.productID,
    required this.productName,
    required this.productBrand,
    required this.productModelName,
    required this.productCondition,
    required this.prodSize,
    required this.productMemory,
    required this.productDescription,
    required this.productHardDrive,
    required this.productColor,
    required this.productPrice,
    required this.productQuantity,
    required this.productShippingCost,
  });

  @override
  void initState() {
    // TODO: implement initState
    if (productColor ==
        addProductController.editDatumInstance.value.color!.id) {
      // print(addProductController.editDatumInstance.value.color!.name);
      colorValue = addProductController.editDatumInstance.value.color!.name;
    }
    // print(prodSize);
    // print(addProductController.editDatumInstance.value.size![0].id);
    // if (prodSize[0].id ==
    //     addProductController.editDatumInstance.value.size![0].id) {
    //   print(addProductController.editDatumInstance.value.size![0].name);
    //   productSize = addProductController.editDatumInstance.value.size![0].name;
    //   sizesList.add(DisplaySize(id: prodSize[0].id, name: prodSize[0].name));
    // }
    for (var i in addProductController.editDatumInstance.value.size!) {
      print("======>ii" + (i.name??""));
    }
    print(prodSize.length);
    addProductController.editDatumInstance.value.size!.forEach((element) {
      // sizesList.add(DisplaySize(id: element.id, name: element.name));
      sizesList.add(DisplaySize(id: element.id, name: element.name));
      print(element.id.toString() + "added in size list");
    });

    // if (productHardDrive ==
    //     addProductController.editDatumInstance.value.memory!.id) {
    // print(addProductController.editDatumInstance.value.color!.name);
    memorySize = addProductController.editDatumInstance.value.memory!.name;
    // print("hard drive"+DriveSize!);
    print(
        "hard drive" + (addProductController.editDatumInstance.value.memory!.id??""));
    // }
    // var colorString =  addProductController.editDatumInstance.value.wher;
    // colorValue = productColor;
    // productSize = prodSize;
    DriveSize = addProductController.editDatumInstance.value.hardDrive!.name;
    description.text = productDescription;
    // memorySize = productMemory;

    super.initState();
  }

  Widget productSizes(String size) {
    return Row(
      children: [
        Container(
          height: 33.h,
          decoration: BoxDecoration(
              color: Color(0xff1D1D1D),
              borderRadius: BorderRadius.circular(10.r)),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                  top: 3,
                  right: 4,
                  child: GestureDetector(
                    onTap: () {
                      deleteEntry(size);
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 15.r,
                    ),
                  )),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                child: Text(
                  size,
                  style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
        10.horizontalSpace,
      ],
    );
  }

  void addEntry(DisplaySize sizes) {
    if (!sizesList.contains(sizes)) {
      sizesList.add(sizes);
      setState(() {});
    }
  }

  void deleteEntry(String sizes) {
    for (int i = 0; i < sizesList.length; i++) {
      if (sizesList[i].name == sizes) {
        sizesList.removeAt(i);
        setState(() {});
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Edit Description',
          style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Container(
              padding: const EdgeInsets.all(6),
              decoration:
                  BoxDecoration(shape: BoxShape.circle, gradient: kbtngradient),
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
                          text: "2",
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
              padding: EdgeInsets.only(right: Get.width * 0.28),
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
              // print(addProductController.addproductModel);
              if (colorValue == null) {
                Utils.showSnack("Select Color", context);
              } else if (sizesList.length == 0) {
                Utils.showSnack("Select Product Size", context);
              } else if (memorySize == null) {
                Utils.showSnack("Select Memory", context);
                // } else if (DriveType == null) {
                //   Utils.showSnack("Select Drive Type", context);
              } else if (DriveSize == null) {
                Utils.showSnack("Select Drive Size", context);
              } else if (description.text.isEmpty) {
                Utils.showSnack("Enter Description", context);
              } else {
                List<String> sizesIdList = [];
                for (int i = 0; i < sizesList.length; i++) {
                  sizesIdList.add(sizesList[i].id.toString());
                }
                print(sizesIdList);
                String ColorID = "";
                String MemoryID = "";
                String HardDiskID = "";
                if (addProductController.editDatumInstance.value.color!.name ==
                    colorValue) {
                  ColorID =
                      (addProductController.editDatumInstance.value.color!.id??"");
                }
                if (addProductController.editDatumInstance.value.memory!.name ==
                    memorySize) {
                  MemoryID =
                      (addProductController.editDatumInstance.value.memory!.id??"");
                }
                if (addProductController
                        .editDatumInstance.value.hardDrive!.name ==
                    DriveSize) {
                  HardDiskID = (addProductController
                      .editDatumInstance.value.hardDrive!.id??"");
                }
                addProductController.addproductApiModel["color_id"] = ColorID;
                for (var i = 0; i < sizesIdList.length; i++) {
                  // int count = 0;
                  print("=============> count" + i.toString());
                  addProductController.addproductApiModel["size[$i]"] =
                      sizesIdList[i];
                  // count++;
                }
                ;
                // addProductController.addproductApiModel["size[]"] = sizesIdList;
                addProductController.addproductApiModel["ram_memory_id"] =
                    MemoryID;
                addProductController.addproductApiModel["hard_disk_id"] =
                    HardDiskID;
                addProductController.addproductApiModel["descriptions"] =
                    description.text;
                print(addProductController.addproductApiModel);
                // print(
                //     "${widget.brandName} ${widget.modelName} ${widget.condition} $colorValue $sizesList $memorySize $DriveSize ${description.text}");
                if (imageFile != null) {
                  Get.to(() => EditProductPriceScreen(
                    productData: widget.productData,
                        productPrice: productPrice,
                        productQuantity: productQuantity,
                        productShippingCost: productShippingCost,
                        productName: productName,
                        productBrand: productBrand,
                        productModelName: productModelName,
                        productCondition: productCondition,
                        productColor: productColor,
                        prodSize: sizesList,
                        productMemory: productMemory,
                        productDescription: productDescription,
                        productHardDrive: productHardDrive,
                        productID: productID,
                        imageFile: imageFile!,
                        productVisibility: productVisibility,
                        // productImageList: widget.productImageList,
                        // brandName: widget.brandName,
                        // modelName: widget.modelName,
                        // condition: widget.condition,
                        // colorValue: colorValue!,
                        // productSizes: sizesList,
                        // memorySize: memorySize!,
                        // // DriveType: DriveType!,
                        // DriveSize: DriveSize!,
                        // description: description.text
                      ));
                } else {
                  Get.to(() => EditProductPriceScreen(
                    productData: widget.productData,
                        productPrice: productPrice,
                        productQuantity: productQuantity,
                        productShippingCost: productShippingCost,
                        productName: productName,
                        productBrand: productBrand,
                        productModelName: productModelName,
                        productCondition: productCondition,
                        productColor: productColor,
                        prodSize: sizesList,
                        productMemory: productMemory,
                        productDescription: productDescription,
                        productHardDrive: productHardDrive,
                        productID: productID,
                        productVisibility: productVisibility,
                        // imageFile: imageFile!,
                        // productImageList: widget.productImageList,
                        // brandName: widget.brandName,
                        // modelName: widget.modelName,
                        // condition: widget.condition,
                        // colorValue: colorValue!,
                        // productSizes: sizesList,
                        // memorySize: memorySize!,
                        // // DriveType: DriveType!,
                        // DriveSize: DriveSize!,
                        // description: description.text
                      ));
                }

                // Get.toNamed('/AddProductPriceScreen');
              }
            })
            //
          ],
        ),
      ),
      body: GestureDetector(
        onTap: () {
          // Close the keyboard and remove focus from TextField when tapped outside
          FocusScope.of(context).unfocus();
        },
        child: DisAllowIndicatorWidget(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20.r),
            children: [
              Text(
                'Color',
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
                  // searchController: description,
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
                    colorValue.toString(),
                    style: GoogleFonts.inter(fontSize: 16.sp),
                  ),

                  // iconSize: 30,
                  // buttonHeight: 60.h,
                  // buttonPadding: EdgeInsets.only(left: 5.r, right: 20.r),
                  // dropdownDecoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(15),
                  // ),
                  items:
                      //  colorList
                      ApiServices.productCategoryDataList.first.data!.color!
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
                    colorValue = value.toString();
                    print("Color value$colorValue");
                    //Do something when changing the item if you want.
                  },
                  onSaved: (value) {
                    colorValue = value.toString();
                  },
                ),
              ),
              15.verticalSpace,
              Text(
                'Product Size',
                style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600),
              ),
              15.verticalSpace,
              Container(
                height: sizesList.length == 0 ? 0 : 34.h,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: sizesList.length,
                    itemBuilder: (context, index) {
                      final iteration = sizesList[index];
                      return productSizes(iteration.name!);
                    }),
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
                    "Select Size",
                    style: GoogleFonts.inter(fontSize: 16.sp),
                  ),

                  // iconSize: 30,
                  // buttonHeight: 60.h,
                  // buttonPadding: EdgeInsets.only(left: 10.r, right: 20.r),
                  // dropdownDecoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(15),
                  // ),
                  items:
                      // productSizeList
                      ApiServices
                          .productCategoryDataList.first.data!.displaySize!
                          .map((item) => DropdownMenuItem(
                                value: item,
                                child: Text(
                                  item.name.toString(),
                                  style: GoogleFonts.inter(
                                      fontSize: 16.sp,
                                      color: Colors.black.withOpacity(0.5)),
                                ),
                              ))
                          .toList(),
                  selectedItemBuilder: (context) {
                    return ApiServices
                        .productCategoryDataList.first.data!.displaySize!
                        .map(
                      (item) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Select Size',
                              style: GoogleFonts.inter(
                                  fontSize: 16.sp,
                                  color: Colors.black.withOpacity(0.5)),
                            ),
                          ],
                        );
                      },
                    ).toList();
                  },
                  //  Container(
                  //   width: 20,
                  //   height: 20,
                  //   color: Colors.amber,
                  // )

                  validator: (value) {
                    if (value == null) {
                      return 'Please select gender.';
                    }
                  },
                  onChanged: (value) {
                    addEntry(value!);
                    // productSize = value.toString();
                    // print(productSize);
                    //Do something when changing the item if you want.
                  },
                  onSaved: (value) {
                    // productSize = value.toString();
                  },
                ),
              ),
              15.verticalSpace,
              Text(
                'Memory',
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
                    memorySize.toString(),
                    style: GoogleFonts.inter(fontSize: 16.sp),
                  ),

                  // iconSize: 30,
                  // buttonHeight: 60.h,
                  // buttonPadding: EdgeInsets.only(left: 10.r, right: 20.r),
                  // dropdownDecoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(15),
                  // ),
                  items:
                      //  memorySizeList
                      ApiServices.productCategoryDataList.first.data!.ramMemory!
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
                    //Do something when changing the item if you want.
                    memorySize = value.toString();
                    print(memorySize);
                  },
                  onSaved: (value) {
                    memorySize = value.toString();
                  },
                ),
              ),
              15.verticalSpace,
              Text(
                'Hard Drive',
                style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600),
              ),
              15.verticalSpace,
              // Container(
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.circular(30.r),
              //   ),
              //   child: DropdownButtonFormField2(
              //     decoration: InputDecoration(
              //         //Add isDense true and zero Padding.
              //         //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
              //         isDense: true,
              //         fillColor: Colors.white,
              //         contentPadding: EdgeInsets.zero,
              //         border: InputBorder.none
              //         //Add more decoration as you want here
              //         //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
              //         ),
              //     isExpanded: true,
              //     hint: Text(
              //       'Select Hard Drive Type',
              //       style: GoogleFonts.inter(fontSize: 16.sp),
              //     ),
              //     icon: SvgPicture.asset(
              //       'assets/Icon ionic-ios-arrow-down.svg',
              //       width: 12.r,
              //     ),
              //     iconSize: 30,
              //     buttonHeight: 60.h,
              //     buttonPadding: EdgeInsets.only(left: 10.r, right: 20.r),
              //     dropdownDecoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(15),
              //     ),
              //     items: const ['HDD', 'SSD']
              //         .map((item) => DropdownMenuItem<String>(
              //               value: item,
              //               child: Text(
              //                 item,
              //                 style: GoogleFonts.inter(
              //                     fontSize: 16.sp,
              //                     color: Colors.black.withOpacity(0.5)),
              //               ),
              //             ))
              //         .toList(),
              //     validator: (value) {
              //       if (value == null) {
              //         return 'Please select gender.';
              //       }
              //     },
              //     onChanged: (value) {
              //       //Do something when changing the item if you want.
              //       DriveType = value.toString();
              //       print(DriveSize);
              //     },
              //     onSaved: (value) {
              //       DriveType = value.toString();
              //     },
              //   ),
              // ),
              // 15.verticalSpace,
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
                    // 'Select Hard Drive Size',
                    DriveSize.toString(),
                    style: GoogleFonts.inter(fontSize: 16.sp),
                  ),

                  // iconSize: 30,
                  // buttonHeight: 60.h,
                  // buttonPadding: EdgeInsets.only(left: 10.r, right: 20.r),
                  // dropdownDecoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(15),
                  // ),
                  items:
                      ApiServices.productCategoryDataList.first.data!.hardDisk!
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
                    //Do something when changing the item if you want.
                    DriveSize = value.toString();
                  },
                  onSaved: (value) {
                    DriveSize = value.toString();
                  },
                ),
              ),
              15.verticalSpace,
              Text(
                'Add Product Description',
                style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600),
              ),
              15.verticalSpace,
              Container(
                // height: 60.h,

                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r)),
                child: TextField(
                  maxLines: 5,
                  controller: description,
                  style: GoogleFonts.inter(
                      color: Colors.black.withOpacity(0.5), fontSize: 16.sp),
                  decoration: InputDecoration(
                      isDense: true,
                      isCollapsed: true,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.r, vertical: 20.r),
                      hintText: 'Type here..',
                      helperStyle: GoogleFonts.inter(
                          color: Colors.black.withOpacity(0.5)),
                      hintMaxLines: 5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
