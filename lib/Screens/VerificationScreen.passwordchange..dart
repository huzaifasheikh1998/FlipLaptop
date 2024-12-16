import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

import '../components/global.dart';
// import 'package:social_login_buttons/social_login_buttons.dart';

class VerificationScreenpasswordchange extends StatefulWidget {
  const VerificationScreenpasswordchange({super.key});

  @override
  State<VerificationScreenpasswordchange> createState() =>
      _VerificationScreenpasswordchangeState();
}

var otpcode;
OtpFieldController otpController = OtpFieldController();
CountDownController _CountDownController = CountDownController();

class _VerificationScreenpasswordchangeState
    extends State<VerificationScreenpasswordchange> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.r),
      decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: AssetImage(
                'assets/Group-3.jpg',
              ),
              fit: BoxFit.fill)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leadingWidth: 30.r,
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, gradient: kbtngradient),
                child: SvgPicture.asset(
                  'assets/Path 11.svg',
                )),
          ),
          title: Text('Verification',
              style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        body: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          // padding: EdgeInsets.symmetric(horizontal: 30.r),
          children: [
            30.verticalSpace,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 141.r),
              child: Image.asset(
                'assets/dark_logo_transparent (1).png',
              ),
            ),
            63.32.h.verticalSpace,
            Container(
              // width: Get.width * 0.6,

              padding: EdgeInsets.symmetric(horizontal: 10.r),
              child: OTPTextField(
                  controller: otpController,
                  obscureText: false,
                  length: 5,
                  width: MediaQuery.of(context).size.width,
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldWidth: 50,
                  keyboardType: TextInputType.text,
                  fieldStyle: FieldStyle.box,
                  outlineBorderRadius: 10.r,
                  spaceBetween: 3,
                  style:
                      GoogleFonts.inter(fontSize: 16.sp, color: Colors.black),
                  //                     boxShadow: [
                  //                       BoxShadow(color: Color(0xffEEEEF6)),
                  // BoxShadow(
                  //   color: Colors.white,
                  //   spreadRadius: -10.0,
                  //   blurRadius: 12.0,
                  // )
                  //
                  //                    ],
                  otpFieldStyle: OtpFieldStyle(
                    backgroundColor: Colors.white,
                    enabledBorderColor: Colors.white,
                    disabledBorderColor: Colors.white,
                    focusBorderColor: Colors.white,
                  ),
                  onChanged: (pin) {
                    print("Changed: " + pin);
                  },
                  onCompleted: (pin) {
                    print("Completed: " + pin);
                    otpcode = pin;
                    // if (forgotPwd == true)
                    //   Get.toNamed('/CreatePasswordScreen');
                    // else
                    //   Get.toNamed('/StartAppScreen');
                  }),
            ),
            20.verticalSpace,
            button(387.w, 59.h, 'CONTINUE', () {
              if (forgotPwd == true) {
                Get.toNamed('/CreatePasswordScreen');
              } else {
                createStore = false;
                Get.toNamed('/StartAppScreen');
              }
            }),
            200.h.verticalSpace,
            Center(
                child: Container(
                    // width: 136.r,
                    // height: 136.r,
                    padding: EdgeInsets.all(13.r),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: CircularCountDownTimer(
                      backgroundColor: Colors.white,
                      duration: 10,
                      initialDuration: 0,
                      controller: _CountDownController,
                      width: 114.r,
                      height: 114.r,
                      ringColor: Colors.transparent,
                      ringGradient: null,
                      fillColor: Color(0xff474C51),
                      fillGradient: null,
                      backgroundGradient: null,
                      strokeWidth: 5.0,
                      strokeCap: StrokeCap.round,
                      textStyle: GoogleFonts.inter(
                          fontSize: 16.sp,
                          color: Color(0xff474C51),
                          fontWeight: FontWeight.bold),
                      textFormat: CountdownTextFormat.MM_SS,
                      isReverse: false,
                      isReverseAnimation: false,
                      isTimerTextShown: true,
                      autoStart: true,
                      onStart: () {
                        print('Countdown Started');
                      },
                      onComplete: () {
                        setState(() {
                          // dispose();
                        });
                      },
                    )))
          ],
        ),
      ),
    );
  }
}
