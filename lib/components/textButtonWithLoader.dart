import 'package:app_fliplaptop/components/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class textButtonWithLoader extends StatelessWidget {
  const textButtonWithLoader(
      {super.key,
      this.onTap,
      required this.height,
      required this.width,
      required this.buttonText, required this.isLoading});

  final void Function()? onTap;
  final double height;
  final double width;
  final String buttonText;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            gradient: kbtngradient,
            borderRadius: BorderRadius.horizontal(
                left: Radius.circular(35.r), right: Radius.circular(35.r))),
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(color: Colors.white,),
              )
            : Text(
                buttonText,
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}
