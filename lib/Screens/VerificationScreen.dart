import 'package:app_fliplaptop/Apiserrvices/Services.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../components/global.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({
    super.key,
  });

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  bool singupVerification = true;
  final _otpFormKey = GlobalKey<FormState>();
  bool isVisible = false;

  var otpcode;
  TextEditingController otpController = TextEditingController();
  CountDownController _CountDownController = CountDownController();
  String currentText = "";
  String otp = "";

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
        body: Form(
          key: _otpFormKey,
          child: ListView(
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 60),
                child: PinCodeTextField(
                  appContext: context,
                  pastedTextStyle: TextStyle(
                    color: Colors.green.shade600,
                    fontWeight: FontWeight.bold,
                  ),
                  length: 5,
                  obscureText: true,
                  hintStyle: TextStyle(color: Colors.white),
                  textStyle: TextStyle(color: Colors.white),
                  obscuringCharacter: '*',
                  //
                  blinkWhenObscuring: true,
                  validator: (v) {
                    if (v!.length < 5) {
                      return "Enter Full Code";
                    } else {
                      return null;
                    }
                  },
                  pinTheme: PinTheme(
                    fieldOuterPadding: EdgeInsets.symmetric(horizontal: 0),
                    selectedFillColor: Colors.white,
                    selectedColor: Colors.white,
                    disabledColor: Colors.white,
                    inactiveColor: Colors.black,
                    inactiveFillColor: Colors.black,
                    activeColor: Colors.black,
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(10),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Colors.black,
                  ),
                  errorTextSpace: 30.h,
                  cursorColor: Colors.transparent,
                  // animationDuration: const Duration(milliseconds: 300),
                  enableActiveFill: true,
                  // errorAnimationController: errorController,
                  controller: otpController,
                  keyboardType: TextInputType.number,
                  // boxShadows: const [
                  //   BoxShadow(
                  //     offset: Offset(0, 1),
                  //     color: Colors.black12,
                  //     blurRadius: 10,
                  //   )
                  // ],
                  onCompleted: (v) async {
                    debugPrint("Completed");

                    // var data = {
                    //   "email": email,
                    //   "otp": otpController.text,
                    //   "singup_verification": singup_verification,
                    // };

                    // Get.to(() => VerificationScreen());
                  },
                  // onTap: () {
                  //   print("Pressed");
                  // },
                  onChanged: (value) {
                    debugPrint(value);
                    if (mounted) {
                      setState(() {
                        currentText = value;
                      });
                    }
                  },
                  beforeTextPaste: (text) {
                    debugPrint("Allowing to paste $text");
                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return true;
                  },
                ),
              ),
              20.verticalSpace,
              button(387.w, 59.h, 'CONTINUE', () async {
                Map<String, dynamic> data = {
                  "otp": otpController.text.trim(),
                  "singup_verification": singupVerification,
                  "email": email,
                };
                if (_otpFormKey.currentState!.validate()) {
                  await ApiServices()
                      .callVerifyOtp(context, data, email, singupVerification);
                }
              }),
              130.h.verticalSpace,
              Container(
                  // width: 136.r,
                  // height: 136.r,
                  padding: EdgeInsets.all(13.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: CircularCountDownTimer(
                    backgroundColor: Colors.white,
                    duration: 30,
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
                      Future.delayed(Duration.zero, () {
                        if (mounted) {
                          setState(() {
                            // dispose();
                            isVisible = false;
                          });
                        }
                      });
                    },
                    onComplete: () {
                      if (mounted) {
                        setState(() {
                          // dispose();
                          isVisible = true;
                        });
                      }
                    },
                  )),
              100.h.verticalSpace,
              Visibility(
                visible: isVisible,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Code didn\'t receive?',
                    ),
                    2.horizontalSpace,
                    GestureDetector(
                      onTap: () async {
                        try {
                          var data = {
                            "email": email,
                          };
                          await ApiServices().callResendOtp(context, data);
                          otpController.clear();
                        } catch (e) {
                          print('Error: $e');
                        }

                        _CountDownController.restart(duration: 10);
                      },
                      child: Text(
                        'Resend',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
