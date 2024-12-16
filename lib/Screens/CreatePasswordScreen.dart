import 'package:app_fliplaptop/Apiserrvices/Services.dart';
import 'package:app_fliplaptop/components/AuthTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/global.dart';
// import 'package:social_login_buttons/social_login_buttons.dart';

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({super.key});

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  TextEditingController _npwd = TextEditingController();
  TextEditingController _rpwd = TextEditingController();
  final _changePassKey = GlobalKey<FormState>();
  bool pass = true;
  bool pass1 = true;
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
          title: Text('Create Password',
              style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        body: Form(
          key: _changePassKey,
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
                  if (_npwd.text.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (_npwd.text.length < 6) {
                    return 'Password Must Contain Atleast 6 Characters !';
                  }
                },
                controller: _npwd,
                fontsiz: 15,
                labelfont: 20,

                widthh: 350.0.w,
                hint: "New Password",

                isPassword: pass,
                // suffixIcon: Icons.remove_red_eye,
                suffixIcon: IconButton(
                  icon: Icon(
                    pass ? Icons.visibility_off : Icons.visibility,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      pass = !pass;
                    });
                  },
                ),
              ),
              10.verticalSpace,
              AuthTextField(
                validator: (text) {
                  if (_rpwd.text.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (_rpwd.text.length < 6 || _npwd.text != _rpwd.text) {
                    return ' Password does not match';
                  }
                },
                controller: _rpwd,
                fontsiz: 15,
                labelfont: 20,

                widthh: 350.0.w,
                hint: "Confirm New Password",

                isPassword: pass1,
                // suffixIcon: Icons.remove_red_eye,
                suffixIcon: IconButton(
                  icon: Icon(
                    pass1 ? Icons.visibility_off : Icons.visibility,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      pass1 = !pass1;
                    });
                  },
                ),
              ),
              20.verticalSpace,
              button(387.w, 59.h, 'Change', () async {
                var data = {
                  "email": email,
                  "new_password": _npwd.text.trim(),
                  "confirm_password": _rpwd.text.trim(),
                };
                if (_changePassKey.currentState!.validate()) {
                  await ApiServices().callChangePassword(context, data);
                }
                // Get.toNamed('/LoginScreen');
              }),
            ],
          ),
        ),
      ),
    );
  }
}
