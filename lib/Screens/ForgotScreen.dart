import 'package:app_fliplaptop/Apiserrvices/Services.dart';
import 'package:app_fliplaptop/components/AuthTextField.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';

import '../components/global.dart';
// import 'package:social_login_buttons/social_login_buttons.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  var otpcode;
  OtpFieldController otpController = OtpFieldController();
  CountDownController _CountDownController = CountDownController();
  TextEditingController _email = TextEditingController();
// final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final forgototp = GlobalKey<FormState>();
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
          title: Text('Email',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        body: Form(
          key: forgototp,
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
              60.32.h.verticalSpace,
              AuthTextField(
                validator: (text) {
                  final emailRegExp = RegExp(
                      r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-]{2,}$');
                  if (_email.text.isEmpty) {
                    return 'Please enter your email address';
                  }
                  if (!emailRegExp.hasMatch(_email.text)) {
                    return 'Please enter valid email address';
                  }
                },
                controller: _email,
                fontsiz: 15,
                labelfont: 20,

                widthh: 350.0.w,
                hint: "Email / Phone",

                isPassword: false,
                // suffixIcon: Icons.remove_red_eye,
                // suffixIcon: IconButton(
                //   icon: Icon(
                //     pass ? Icons.visibility_off : Icons.visibility,
                //     color: Colors.white,
                //   ),
                //   onPressed: () {
                //     setState(() {
                //       pass = !pass;
                //     });
                //   },
                // ),
                labelText: "Password",

                prefixIcon: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Icon(
                    Icons.email,
                    color: Colors.white,
                    size: 20,
                  ),

                  // FaIcon(
                  //   FontAwesomeIcons.userLarge,
                  //   color: Color(0xff0C0D26).withOpacity(0.4),
                  //   size: 20,
                  // ),
                ),
              ),
              // TextBox(
              //   'Email / Phone',
              //   _email,
              //   (text) {},
              //   Icon(Icons.email),
              // ),
              20.verticalSpace,
              button(
                387.w,
                59.h,
                'CONTINUE',
                () async {
                  select = 'forgetpass';
                  setState(() {
                    forgotPwd = true;
                    singup_verification = false;
                  });
                  var data = {
                    "email": _email.text.trim(),
                  };
                  if (forgototp.currentState!.validate()) {
                    // Get.to(() => VerificationScreen());
                    email = _email.text.trim();
                    await ApiServices().callforgetPassword(context, data);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
