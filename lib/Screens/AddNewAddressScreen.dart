import 'package:app_fliplaptop/Apiserrvices/Services.dart';
import 'package:app_fliplaptop/res/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/global.dart';

class AddNewAddressScreen extends StatefulWidget {
  AddNewAddressScreen({super.key});

  @override
  State<AddNewAddressScreen> createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  TextEditingController country = TextEditingController();
  TextEditingController contactName = TextEditingController();
  TextEditingController phoneNo = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController zip = TextEditingController();

  final List<String> colorList = ['Black', 'White', 'Red', 'Orange', 'Yellow'];

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Add New Address',
          style: GoogleFonts.inter(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(shape: BoxShape.circle, gradient: kbtngradient),
              child: SvgPicture.asset(
                'assets/Path 11.svg',
                width: 14,
              )),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 20.r),
        child: button2(388.w, 59.h, 'Update & Save', () {
          if (country.text == "") {
            Utils.showSnack("Enter Country", context);
          } else if (contactName.text == "") {
            Utils.showSnack("Enter Contact Name", context);
          } else if (phoneNo.text == "") {
            Utils.showSnack("Enter Phone Number", context);
          } else if (address.text == "") {
            Utils.showSnack("Enter Address", context);
          } else if (city.text == "") {
            Utils.showSnack("Enter City", context);
          } else if (zip.text == "") {
            Utils.showSnack("Enter Zip Code", context);
          } else {
            ApiServices().postShippingAddress(
              context,
              country.text,
              contactName.text,
              phoneNo.text,
              address.text,
              city.text,
              zip.text,
            );
          }
        }),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.r),
          children: [
            Text(
              'Country',
              style: GoogleFonts.inter(color: Colors.black, fontSize: 18.sp, fontWeight: FontWeight.w600),
            ),
            15.verticalSpace,
            TextBox1('United State Of America', country, 'assets/Icon metro-flag@3x.png', TextInputType.text),
            15.verticalSpace,
            Text(
              'Contact Info',
              style: GoogleFonts.inter(color: Colors.black, fontSize: 18.sp, fontWeight: FontWeight.w600),
            ),
            15.verticalSpace,
            TextBox2('Contact Name', contactName, TextInputType.text),
            12.verticalSpace,
            TextBox2('Phone Number', phoneNo, TextInputType.number),
            15.verticalSpace,
            Text(
              'Address',
              style: GoogleFonts.inter(color: Colors.black, fontSize: 18.sp, fontWeight: FontWeight.w600),
            ),
            15.verticalSpace,
            TextBox2('Street House/appartment', address, TextInputType.text),
            12.verticalSpace,
            TextBox1('City', city, '', TextInputType.text),
            12.verticalSpace,
            TextBox2('Zipcode', zip, TextInputType.number)
          ],
        ),
      ),
    );
  }

  TextBox2(hintext, ctr, keyboardType) {
    return Container(
      height: 60.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30.r)),
      child: TextField(
        keyboardType: keyboardType,
        maxLines: 1,
        controller: ctr,
        style: GoogleFonts.inter(color: Colors.black.withOpacity(0.5), fontSize: 16.sp),
        decoration: InputDecoration(isDense: true, isCollapsed: true, border: InputBorder.none, contentPadding: EdgeInsets.symmetric(horizontal: 20.r), hintText: hintext, helperStyle: GoogleFonts.inter(color: Colors.black.withOpacity(0.5))),
      ),
    );
  }

  TextBox1(hintText, ctr, ic, keyboardType) {
    return Container(
      height: 60.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30.r)),
      child: Row(
        children: [
          ctr != city ? 20.horizontalSpace : 10.horizontalSpace,
          ctr != city
              ? Image.asset(
                  ic,
                  width: 21.r,
                )
              : Container(),
          Expanded(
            child: TextField(
              keyboardType: keyboardType,
              maxLines: 1,
              controller: ctr,
              style: GoogleFonts.inter(color: Colors.black.withOpacity(0.8), fontSize: 16.sp),
              decoration: InputDecoration(isDense: true, isCollapsed: true, border: InputBorder.none, contentPadding: EdgeInsets.symmetric(horizontal: ctr != 'assets/Path 2986.svg' ? 10.r : 18.r), hintText: hintText, helperStyle: GoogleFonts.inter(color: Colors.black.withOpacity(0.5))),
            ),
          ),
          ctr == city || ctr == address
              ? IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    'assets/Icon material-location-on.png',
                    width: 15.r,
                    color: highlightedText,
                  ))
              : Container()
        ],
      ),
    );
  }
}
