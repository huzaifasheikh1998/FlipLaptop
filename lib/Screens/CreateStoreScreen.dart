import 'dart:io';

import 'package:app_fliplaptop/Apiserrvices/Services.dart';
import 'package:app_fliplaptop/Controller/location_controller.dart';
import 'package:app_fliplaptop/Screens/location_screen.dart';
import 'package:app_fliplaptop/components/global.dart';
import 'package:app_fliplaptop/res/utils/utils.dart';
import 'package:app_fliplaptop/widgets/disallow_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class CreateStoreScreen extends StatefulWidget {
  CreateStoreScreen({super.key});

  @override
  State<CreateStoreScreen> createState() => _CreateStoreScreenState();
}

class _CreateStoreScreenState extends State<CreateStoreScreen> {
  TextEditingController name = TextEditingController();

  TextEditingController description = TextEditingController();

  final locationController = Get.put(LocationScreenController());

  TextEditingController webLink = TextEditingController();
  TextEditingController taxPercentage = TextEditingController();

  late File imageFile;
  bool imagePath = false;

  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imagePath = true;
        imageFile = File(pickedFile.path);
      });
    }
  }

  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imagePath = true;
        imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPageBgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Create Store',
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
        child: button2(388.w, 59.h, 'Save', () async {
          print(email.toString());
          print(authToken);
          if (name.text.isEmpty) {
            Utils.showSnack("Enter Name", context);
          } else if (locationController.locationController.text.isEmpty) {
            Utils.showSnack("Enter Location", context);
          } else if (imagePath == false) {
            Utils.showSnack("Add Image", context);
          } else if (double.parse(taxPercentage.text) > 100) {
            Utils.showSnack("Invalid Tax", context);
          } else {
            Map data = {
              "name": name.text,
              "location": locationController.locationController.text,
              "image": "",
              "description": description.text.toString(),
              "website_link": webLink.text
            };
            await ApiServices().callStoreCreate(
              context,
              data,
              name.text.toString(),
              locationController.locationController.text.toString(),
              description.text.toString(),
              webLink.text.toString(),
              imageFile,
              taxPercentage.text,
            );
          }

          //  ScaffoldMessenger.of(context).showSnackBar(
          //       SnackBar(
          //         content: Text('This is a snackbar message'),
          //       ));
          //     await  Fluttertoast.showToast(
          //     msg: "This is Center Short Toast",
          //     // toastLength: Toast.LENGTH_SHORT,
          //     // gravity: ToastGravity.CENTER,
          //     // timeInSecForIosWeb: 1,
          //     // backgroundColor: Colors.red,
          //     // textColor: Colors.white,
          //     // fontSize: 16.0
          // );
          // createStore = true;
          // Get.close(2);
        }),
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
              Center(
                child: Stack(
                  children: [
                    imagePath
                        ?
                        // imageFile.path != null?
                        Container(
                            width: 151.r,
                            height: 151.r,
                            margin: EdgeInsets.only(top: 10.r),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: FileImage(imageFile),
                                fit: BoxFit.cover,
                              ),
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          )
                        : Container(
                            width: 151.r,
                            height: 151.r,
                            margin: EdgeInsets.only(top: 10.r),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(
                                  // "assets/Path 523.svg",
                                  'assets/profile.png',
                                ),
                                fit: BoxFit.contain,
                              ),
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                    Positioned(
                        right: 0,
                        bottom: 0,
                        child: InkWell(
                          onTap: () {
                            Utils.selectImageSource(
                              () {
                                _getFromCamera();
                                Navigator.pop(context);
                              },
                              () {
                                _getFromGallery();
                                Navigator.pop(context);
                              },
                            );
                          },
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
              TextEditBox(name, 'assets/Icon awesome-user-alt-2.svg', "name",
                  true, () {}),
              15.verticalSpace,
              TextEditBox(locationController.locationController,
                  'assets/Path 2986.svg', "location", false, () {
                // Get.to(() => LocationScreen());
              }),
              15.verticalSpace,
              NumEditBox(taxPercentage, 'assets/taxIcon.svg', "tax percentage"),
              15.verticalSpace,
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.r)),
                child: GestureDetector(
                  onTap: () {
                    // Close the keyboard and remove focus from TextField when tapped outside
                    FocusScope.of(context).unfocus();
                  },
                  child: TextField(
                    maxLines: 5,
                    controller: description,
                    style: GoogleFonts.inter(
                        color: Colors.black.withOpacity(0.5), fontSize: 16.sp),
                    decoration: InputDecoration(
                        hintText: "Description",
                        isDense: true,
                        isCollapsed: true,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.r, vertical: 15.r),
                        helperStyle: GoogleFonts.inter(
                            color: Colors.black.withOpacity(0.5))),
                  ),
                ),
              ),
              15.verticalSpace,
              TextEditBox(webLink, 'assets/Icon ionic-ios-link.svg',
                  "website link", true, () {}),
            ],
          ),
        ),
      ),
    );
  }

  TextEditBox(ctr, ic, String hintText, bool enable, void Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
            ),
            Expanded(
              child: TextField(
                enabled: enable,
                maxLines: 1,
                controller: ctr,
                style: GoogleFonts.inter(
                    color: Colors.black.withOpacity(0.8), fontSize: 16.sp),
                decoration: InputDecoration(
                    hintText: hintText,
                    isDense: true,
                    isCollapsed: true,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: ic != 'assets/Path 2986.svg' ? 15.r : 18.r),
                    helperStyle: GoogleFonts.inter(
                        color: Colors.black.withOpacity(0.5))),
              ),
            ),
            // ctr != webLink
            //     ? IconButton(
            //         onPressed: () {},
            //         icon: SvgPicture.asset(
            //           'assets/Icon feather-edit.svg',
            //           width: 18.r,
            //         ))
            //     : Container()
          ],
        ),
      ),
    );
  }

  NumEditBox(ctr, ic, String hintText) {
    return GestureDetector(
      onTap: () {
        // Close the keyboard and remove focus from TextField when tapped outside
        FocusScope.of(context).unfocus();
      },
      child: Container(
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
            ),
            Expanded(
              child: TextField(
                keyboardType: TextInputType.number,
                maxLines: 1,
                controller: ctr,
                style: GoogleFonts.inter(
                    color: Colors.black.withOpacity(0.8), fontSize: 16.sp),
                decoration: InputDecoration(
                    hintText: hintText,
                    isDense: true,
                    isCollapsed: true,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: ic != 'assets/Path 2986.svg' ? 15.r : 18.r),
                    helperStyle: GoogleFonts.inter(
                        color: Colors.black.withOpacity(0.5))),
              ),
            ),
            // ctr != webLink
            //     ? IconButton(
            //         onPressed: () {},
            //         icon: SvgPicture.asset(
            //           'assets/Icon feather-edit.svg',
            //           width: 18.r,
            //         ))
            //     : Container()
          ],
        ),
      ),
    );
  }
}
