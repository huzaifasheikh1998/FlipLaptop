import 'package:app_fliplaptop/Apiserrvices/Services.dart';
import 'package:app_fliplaptop/res/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/global.dart';

class EditShippingAddress extends StatefulWidget {
  EditShippingAddress(
      {super.key,
      required this.Country,
      required this.contactDetails,
      required this.phoneNumber,
      required this.Address,
      required this.City,
      required this.ZipCode,
      required this.ShippingID});

  final String ShippingID;
  final String Country;
  final String contactDetails;
  final String phoneNumber;
  final String Address;
  final String City;
  final String ZipCode;

  @override
  State<EditShippingAddress> createState() => _EditShippingAddressState(
        Country: Country,
        contactDetails: contactDetails,
        phoneNumber: phoneNumber,
        Address: Address,
        City: City,
        ZipCode: ZipCode,
        ShippingID: ShippingID,
      );
}

class _EditShippingAddressState extends State<EditShippingAddress> {
  final String ShippingID;
  final String Country;
  final String contactDetails;
  final String phoneNumber;
  final String Address;
  final String City;
  final String ZipCode;

  TextEditingController country = TextEditingController();
  TextEditingController contactName = TextEditingController();
  TextEditingController phoneNo = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController zip = TextEditingController();

  final List<String> colorList = ['Black', 'White', 'Red', 'Orange', 'Yellow'];

  String? selectedValue;
  bool? isDefault = false;

  _EditShippingAddressState(
      {required this.ShippingID,
      required this.Country,
      required this.contactDetails,
      required this.phoneNumber,
      required this.Address,
      required this.City,
      required this.ZipCode});

  @override
  void initState() {
    country.text = Country;
    contactName.text = contactDetails;
    phoneNo.text = phoneNumber;
    address.text = Address;
    city.text = City;
    zip.text = ZipCode;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Edit Shipping Address',
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
            ApiServices().editShippingAddress(
              context,
              ShippingID,
              address.text,
              city.text,
              zip.text,
              country.text,
              phoneNo.text,
              isDefault==true?"yes":"no",
            );
          }
        }),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.r),
        children: [
          Text(
            'Country',
            style: GoogleFonts.inter(
                color: Colors.black,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600),
          ),
          15.verticalSpace,
          TextBox1('United State Of America', country,
              'assets/Icon metro-flag@3x.png'),
          15.verticalSpace,
          Text(
            'Contact Info',
            style: GoogleFonts.inter(
                color: Colors.black,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600),
          ),
          15.verticalSpace,
          TextBox2('Contact Name', contactName,
              ),
          12.verticalSpace,
          TextBox2('Phone Number', phoneNo),
          15.verticalSpace,
          Text(
            'Address',
            style: GoogleFonts.inter(
                color: Colors.black,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600),
          ),
          15.verticalSpace,
          TextBox2('Street House/appartment', address),
          12.verticalSpace,
          TextBox1('City', city, ''),
          12.verticalSpace,
          TextBox2('Zipcode', zip),
          12.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Want to Make Default?",
                style: TextStyle(
                  fontSize: 17.sp,
                ),
              ),
              Switch(
                // thumb color (round icon)
                activeColor: Colors.red,
                activeTrackColor: Colors.redAccent,
                inactiveThumbColor: Colors.blueGrey.shade600,
                inactiveTrackColor: Colors.grey.shade400,
                splashRadius: 50.0,
                // boolean variable value
                value: isDefault!,
                // changes the state of the switch
                onChanged: (value) => setState(() => isDefault = value),
              ),
            ],
          ),
        ],
      ),
    );
  }

  TextBox2(hintext, ctr) {
    return Container(
      height: 60.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(30.r)),
      child: TextField(
        maxLines: 1,
        controller: ctr,
        style: GoogleFonts.inter(
            color: Colors.black.withOpacity(0.5), fontSize: 16.sp),
        decoration: InputDecoration(
            isDense: true,
            isCollapsed: true,
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 20.r),
            hintText: hintext,
            helperStyle:
                GoogleFonts.inter(color: Colors.black.withOpacity(0.5))),
      ),
    );
  }

  TextBox1(hintText, ctr, ic) {
    return Container(
      height: 60.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(30.r)),
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
              maxLines: 1,
              controller: ctr,
              style: GoogleFonts.inter(
                  color: Colors.black.withOpacity(0.8), fontSize: 16.sp),
              decoration: InputDecoration(
                  isDense: true,
                  isCollapsed: true,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: ctr != 'assets/Path 2986.svg' ? 10.r : 18.r),
                  hintText: hintText,
                  helperStyle:
                      GoogleFonts.inter(color: Colors.black.withOpacity(0.5))),
            ),
          ),
          ctr == city
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
