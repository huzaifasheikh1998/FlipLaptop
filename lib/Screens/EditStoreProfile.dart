import 'dart:io';

import 'package:app_fliplaptop/Apiserrvices/Services.dart';
import 'package:app_fliplaptop/components/global.dart';
import 'package:app_fliplaptop/widgets/disallow_indicator_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../res/utils/utils.dart';

class EditStoreProfileScreen extends StatefulWidget {
  EditStoreProfileScreen({
    super.key,
    required this.storeProfilePic,
    required this.storeName,
    required this.storeWebsiteLink,
    required this.storeLocation,
    required this.storeShippingAddress,
    required this.storeDescription,
    required this.taxValue,
  });
  final String storeProfilePic;
  final String storeName;
  final String storeWebsiteLink;
  final String storeLocation;
  final String storeShippingAddress;
  final String storeDescription;
  final String taxValue;
  @override
  State<EditStoreProfileScreen> createState() => _EditStoreProfileScreenState(
        storeProfilePic: storeProfilePic,
        storeName: storeName,
        storeWebLink: storeWebsiteLink,
        storeShippingAddress: storeShippingAddress,
        storeLocation: storeLocation,
        storeDescription: storeDescription, taxValue: taxValue,
      );
}

class _EditStoreProfileScreenState extends State<EditStoreProfileScreen> {
  TextEditingController name = TextEditingController(text: 'Name');

  TextEditingController webLink = TextEditingController(text: 'Website Link');

  TextEditingController location = TextEditingController(text: 'Location');
  TextEditingController taxAmount = TextEditingController(text: 'Tax Percentage');

  TextEditingController description =
      TextEditingController(text: 'description');

  @override
  void initState() {
    // TODO: implement initState
    name.text = storeName;
    webLink.text = storeWebLink;
    location.text = storeLocation;
    description.text = storeDescription;
    taxAmount.text = taxValue;
    if(userController.user.value.store!=null){
      taxAmount.text = userController.user.value.store!.tax!;
    }
    // shippingAddress.text = storeShippingAddress;
    super.initState();
  }

  final String storeProfilePic;
  final String storeName;
  final String storeWebLink;
  final String storeShippingAddress;
  final String storeLocation;
  final String storeDescription;
  final String taxValue;

  File? imageFile;

  _EditStoreProfileScreenState({
    required this.storeName,
    required this.storeWebLink,
    required this.storeShippingAddress,
    required this.storeProfilePic,
    required this.storeLocation,
    required this.storeDescription,
    required this.taxValue,
  });

  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }
  bool discount = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPageBgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Store Profile Edit',
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
        child: button2(388.w, 59.h, 'Update & Save', () async {
          if (name.text.isEmpty) {
            Utils.showSnack("Enter Name", context);
          } else if (location.text.isEmpty) {
            Utils.showSnack("Enter Location", context);
          } else if (imageFile == false && storeProfilePic == "") {
            Utils.showSnack("Add Image", context);
          } else {
            Map data = {
              "name": name.text,
              "location": location.text,
              "image": "",
              "description": description.text.toString(),
              "website_link": webLink.text,
              "tax": taxAmount.text
              // ""
            };
            await ApiServices().callStoreUpdate(
              context,
              data,
              name.text,
              location.text,
              description.text.toString(),
              webLink.text,
              imageFile,
              taxAmount.text
            );
            // await ApiServices().updateStoreTaxAndAmount(taxAmount.text, context);
            setState(() {});
            // if (imageFile == null) {
            //   print("OK");
            //   print(imageFile);
            // }
          }
        }),
      ),
      body: DisAllowIndicatorWidget(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.r),
          children: [
            // Text(userController.user.store!.first.tax.toString()),
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 121.r,
                    height: 121.r,
                    margin: EdgeInsets.only(top: 10.r),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: imageFile != null
                          ? Image.file(imageFile!)
                          : CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: storeProfilePic,
                              placeholder: (context, url) => Icon(Icons.image),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                    ),
                  ),
                  Positioned(
                      right: 0,
                      bottom: 0,
                      child: InkWell(
                        onTap: () => _getFromGallery(),
                        child: Container(
                          width: 43.r,
                          height: 43.r,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black,
                            border: Border.all(
                              width: 1,
                              color: Colors.white,
                            ),
                          ),
                          child: Icon(
                            Icons.camera_alt_rounded,
                            color: Colors.white,
                            size: 24.r,
                          ),
                        ),
                      ))
                ],
              ),
            ),
            30.verticalSpace,
            TextEditBox(name, 'assets/Icon awesome-user-alt-2.svg',false,true),
            15.verticalSpace,
            TextEditBox(webLink, 'assets/Icon ionic-ios-link.svg',false,true),
            15.verticalSpace,
            TextEditBox(location, 'assets/Path 2986.svg',false,false),
            15.verticalSpace,
            // Row(
            //   children: [
            //     InkWell(
            //       onTap: () {
            //         setState(() {
            //           if (!discount) {
            //             discount = !discount;
            //           }
            //           // if (chk1 == false) chk1 = !chk1;
            //           // if (chk2 == true) chk2 = !chk2;
            //         });
            //       },
            //       child: Container(
            //         margin: const EdgeInsets.all(1.4),
            //         padding: const EdgeInsets.all(1.7),
            //         decoration: BoxDecoration(
            //             color: discount ? kprimaryColor : Colors.white,
            //             shape: BoxShape.circle,
            //             border: Border.all(width: 2.0, color: kprimaryColor)),
            //         child: Icon(
            //           Icons.circle,
            //           size: 12.0,
            //           color: discount ? kprimaryColor : Colors.white,
            //         ),
            //       ),
            //     ),
            //     10.horizontalSpace,
            //     Text(
            //       'Yes',
            //       style: TextStyle(
            //           color: Colors.black,
            //           fontWeight: FontWeight.w600,
            //           fontSize: 18.sp),
            //     )
            //   ],
            // ),
            // 20.verticalSpace,
            // Row(
            //   children: [
            //     InkWell(
            //       onTap: () {
            //         setState(() {
            //           if (discount) {
            //             discount = !discount;
            //           }
            //         });
            //       },
            //       child: Container(
            //         margin: const EdgeInsets.all(1.4),
            //         padding: const EdgeInsets.all(1.7),
            //         decoration: BoxDecoration(
            //             color: !discount ? kprimaryColor : Colors.white,
            //             shape: BoxShape.circle,
            //             border: Border.all(width: 2.0, color: kprimaryColor)),
            //         child: Icon(
            //           Icons.circle,
            //           size: 12.0,
            //           color: !discount ? kprimaryColor : Colors.white,
            //         ),
            //       ),
            //     ),
            //     10.horizontalSpace,
            //     Text(
            //       'No',
            //       style: TextStyle(
            //           color: Colors.black,
            //           fontSize: 18.sp,
            //           fontWeight: FontWeight.w600),
            //     )
            //   ],
            // ),
            TextEditBox(taxAmount, 'assets/taxIcon.svg',true,true),
            15.verticalSpace,
            TextEditBoxWith5Lines(description, 'assets/descriptionIcon.svg',),
          ],
        ),
      ),
    );
  }

  TextEditBox(ctr, ic,isNumeric,bool enable) {
    return Container(
      height: 60.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(30.r)),
      child: Row(
        children: [
          20.horizontalSpace,
          SvgPicture.asset(
            ic,
            width: ic != 'assets/Path 2986.svg' ? 20.r : 15.r,
            color: Colors.red,
          ),
          Expanded(
            child: TextField(
              enabled: enable,
              keyboardType: isNumeric?TextInputType.number:TextInputType.text,
              maxLines: 1,
              controller: ctr,
              style: GoogleFonts.inter(
                  color: Colors.black.withOpacity(0.8), fontSize: 16.sp),
              decoration: InputDecoration(
                  isDense: true,
                  isCollapsed: true,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: ic != 'assets/Path 2986.svg' ? 15.r : 18.r),
                  helperStyle:
                      GoogleFonts.inter(color: Colors.black.withOpacity(0.5))),
            ),
          ),
          // IconButton(
          //     onPressed: () {},
          //     icon: SvgPicture.asset(
          //       'assets/Icon feather-edit.svg',
          //       width: 18.r,
          //     ))
        ],
      ),
    );
  }

  TextEditBoxWith5Lines(ctr, ic) {
    return Container(
      height: 120.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(30.r)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          20.horizontalSpace,
          Column(
            children: [
              20.verticalSpace,
              SvgPicture.asset(
                ic,
                width: ic != 'assets/Path 2986.svg' ? 20.r : 15.r,
                color: Colors.red,
              ),
            ],
          ),
          Expanded(
            child: TextField(
              maxLines: 5,
              controller: ctr,
              style: GoogleFonts.inter(
                  color: Colors.black.withOpacity(0.8), fontSize: 16.sp),
              decoration: InputDecoration(
                  isDense: true,
                  isCollapsed: true,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: ic != 'assets/Path 2986.svg' ? 15.r : 18.r,vertical: 15.r),
                  helperStyle:
                  GoogleFonts.inter(color: Colors.black.withOpacity(0.5))),
            ),
          ),
          // IconButton(
          //     onPressed: () {},
          //     icon: SvgPicture.asset(
          //       'assets/Icon feather-edit.svg',
          //       width: 18.r,
          //     ))
        ],
      ),
    );
  }
}
