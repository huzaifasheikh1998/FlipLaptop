import 'dart:developer';
import 'dart:io';

import 'package:app_fliplaptop/Apiserrvices/Services.dart';
import 'package:app_fliplaptop/Apiserrvices/app_url.dart';
import 'package:app_fliplaptop/components/global.dart';
import 'package:app_fliplaptop/res/utils/utils.dart';
import 'package:app_fliplaptop/widgets/disallow_indicator_widget.dart';
import 'package:app_fliplaptop/widgets/dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../models/my_profile_data_model/my_profile_data_model.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({super.key, this.completeData});

  final Data? completeData;

  @override
  State<EditProfileScreen> createState() =>
      _EditProfileScreenState(completeData: completeData!);
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  List<String> gender = ["Male", "Female"];
  final Data completeData;

  TextEditingController nameController = TextEditingController();
  // TextEditingController genderController = TextEditingController();
  TextEditingController locationController = TextEditingController(text: "Downtown");
  TextEditingController phoneController = TextEditingController();

  final _editProfileKey = GlobalKey<FormState>();

  _EditProfileScreenState({required this.completeData});

  File? imageFile;
  final picker = ImagePicker();

  _getFromGallery() async {
    final result = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (result != null) {
      setState(() {
        imageFile = File(result.path);
      });
    }
  }

  @override
  void initState() {
    nameController.text = completeData.name.toString();
    // genderController.text = completeData.gender.toString();
    // locationController.text = completeData.address.toString();
    phoneController.text = completeData.phoneNumber.toString();

    print("==========> complete profile data" + completeData.gender.toString());
    // TODO: implement initState
    super.initState();
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
          'Edit Profile',
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
        child: button2(
          388.w,
          59.h,
          'Update & Save',
          () async {
            log(phoneController.text.isNumericOnly.toString());
            if (phoneController.text.isNumericOnly &&
                phoneController.text.length >= 8 &&
                phoneController.text.length <= 15) {
              Map<String, dynamic> data = {
                "name": nameController.text.trim(),
                "address": locationController.text.trim(),
                "phone_number": phoneController.text.trim(),
                "gender": userController.selectedGender.value,
                "zipCode": "12345",
                "country": "USA",
                "state": "Los Angles",
                "city":"Los Angles"
                // genderController.text.trim()
              };
              ApiServices().callEditProfile(context, data, imageFile);
            } else {
              Utils.showSnack("Enter a valid Phone number", context);
            }
          },
        ),
      ),
      body: DisAllowIndicatorWidget(
        child: Form(
          key: _editProfileKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20.r),
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 151.r,
                      height: 151.r,
                      margin: EdgeInsets.only(top: 10.r),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: imageFile == null
                            ? completeData.image == ""
                                ? DecorationImage(
                                    image: AssetImage(
                                      'assets/profile.png',
                                    ),
                                    fit: BoxFit.cover,
                                  )
                                : DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      ImageUrls.kUserProfile +
                                          completeData.image,
                                    ),
                                  )
                            : null,
                        color: Colors.white,
                        border: Border.all(width: 0.3, color: kprimaryColor),
                      ),
                      child: imageFile != null
                          ? ClipOval(child: Image.file(imageFile!))
                          : null,
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
              TextEditBox(
                imgUrl: 'assets/Icon awesome-user-alt-2.svg',
                title: 'Name',
                ctr: nameController,
                enable: true,
                validationn: (value) {},
              ),
              15.verticalSpace,
              DropdownWidget(
                value: completeData.gender.toString() == "Male"
                    ? gender.first
                    : gender.last,
                hint: "Gender",
                items: gender,
                prefixIcon: SvgPicture.asset(
                  'assets/male-gender.svg',
                  fit: BoxFit.scaleDown,
                ),
              ),
              15.verticalSpace,

              // TextEditBox(
              //   imgUrl: 'assets/male-gender.svg',
              //   title: 'Gender',
              //   ctr: genderController,
              //   validationn: (value) {},
              // ),

              // Expanded(
              //   child: DropDownTextField(
              //     // initialValue: "name4",
              //     controller: genderController,
              //     clearOption: true,
              //     // enableSearch: true,
              //     // dropdownColor: Colors.green,
              //     searchDecoration: const InputDecoration(hintText: "Gender"),
              //     validator: (value) {
              //       if (value == null) {
              //         return "Required field";
              //       } else {
              //         return null;
              //       }
              //     },
              //     dropDownItemCount: 2,

              //     dropDownList: const [
              //       DropDownValueModel(name: 'Male', value: "Female"),
              //     ],
              //     onChanged: (val) {},
              //   ),
              // ),
              TextEditBox(
                imgUrl: 'assets/Path 2986.svg',
                title: 'Location',
                ctr: locationController,
                enable: false,
                validationn: (value) {},
              ),
              15.verticalSpace,
              TextEditBox(
                title: 'Phone',
                ctr: phoneController,
                enable: true,
                validationn: (value) {
                  // log(value.toString());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget TextEditBox(
      {String? imgUrl,
      required String title,
      required ctr,
      required validationn,
      required enable}) {
    return Container(
      height: 60.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Row(
        children: [
          20.horizontalSpace,
          imgUrl != null
              ? SvgPicture.asset(
                  imgUrl,
                )
              : Icon(
                  Icons.phone,
                  color: Colors.red.shade900,
                ),
          Expanded(
            child: TextFormField(
              enabled: enable,
              validator: validationn,
              keyboardType:
                  imgUrl == null ? TextInputType.number : TextInputType.text,
              maxLines: 1,
              controller: ctr,
              style: GoogleFonts.inter(
                  color: Colors.black.withOpacity(0.8), fontSize: 16.sp),
              decoration: InputDecoration(
                hintText: title,
                isDense: true,
                isCollapsed: true,
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 18.r),
                helperStyle: GoogleFonts.inter(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ),
          ),

          /// this is edit icon place holder removed
          // IconButton(
          //   onPressed: () {},
          //   icon: SvgPicture.asset(
          //     'assets/Icon feather-edit.svg',
          //     width: 18.r,
          //   ),
          // ),
        ],
      ),
    );
  }
}
