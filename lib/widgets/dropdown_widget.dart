// ignore_for_file: must_be_immutable

import 'package:app_fliplaptop/Apiserrvices/Services.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DropdownWidget extends StatefulWidget {
  final double? heightt;
  final double? widthh;
  final String hint;
  String value;
  final List<String> items;
  // TextEditingController? controller;
  Widget? prefixIcon;

  DropdownWidget({
    super.key,
    this.heightt,
    this.widthh,
    this.prefixIcon,
    required this.hint,
    required this.items,
    // required this.controller,
    required this.value,
  });

  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  @override
  Widget build(BuildContext context) {
    // final userController = Get.put(UserController());

    return DropdownButtonFormField2<String>(
      value: widget.value,
      isExpanded: true,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        filled: true,
        fillColor: Colors.white,

        // hintStyle: TextStyle(color: themeColor2, fontSize: 16.h),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.all(Radius.circular(30.r)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.all(Radius.circular(30.r)),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.all(Radius.circular(30.r)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.all(Radius.circular(30.r)),
        ),
      ),
      hint: Text(
        widget.hint,
        style: TextStyle(fontSize: 16.h, color: Colors.black.withOpacity(.7.r)),
      ),
      items: widget.items
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: TextStyle(
                      fontSize: 16.h, color: Colors.black.withOpacity(.7.r)),
                ),
              ))
          .toList(),
      validator: (value) {
        return null;
      },
      onChanged: (value) {
        userController.selectedGender.value = value!;
        print(" ==================> $value");
      },
      onSaved: (items) {
        items = widget.value;
        print(items);
      },
      // buttonStyleData: ButtonStyleData(
      //   height: widget.heightt,
      //   width: widget.widthh,
      //   padding: const EdgeInsets.only(right: 0),
      // ),
      // iconStyleData: const IconStyleData(
      //   icon: Icon(
      //     Icons.keyboard_arrow_down_rounded,
      //     color: grayColor,
      //   ),
      //   iconSize: 24,
      // ),
      // dropdownStyleData: DropdownStyleData(
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(20.r),
      //   ),
      // ),
      // menuItemStyleData: MenuItemStyleData(
      //   padding: EdgeInsets.symmetric(horizontal: 20.w),
      // ),
    );
  }
}
