import 'dart:io';

import 'package:app_fliplaptop/Apiserrvices/Services.dart';
import 'package:app_fliplaptop/Apiserrvices/localStorage.dart';
import 'package:app_fliplaptop/Screens/LoginScreen.dart';
import 'package:app_fliplaptop/components/AuthTextField.dart';
import 'package:app_fliplaptop/components/global.dart';
import 'package:app_fliplaptop/res/utils/utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _fullName = TextEditingController();
  TextEditingController _email = TextEditingController();

  TextEditingController _pwd = TextEditingController();
  TextEditingController _rpwd = TextEditingController();

  bool remChk = false;
  bool pwd1 = false;
  bool pass = true;
  bool pass1 = true;
  bool _acceptedTerms = false;

  final _signUpFormKey = GlobalKey<FormState>();

  bool isValidPassword(String password) {
    String pattern =
        r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(password);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 20.r),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/Group-3.jpg',
              ),
              fit: BoxFit.fill)),
      child: Scaffold(
        bottomNavigationBar: Row(
          children: [
            5.horizontalSpace,
            Text(
              "Already have an account? ",
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16.sp,
              ),
            ),
            InkWell(
                onTap: () {
                  Get.to(() => LoginScreen());
                },
                child: Text(
                  'Login',
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      decorationColor: Colors.white,
                      decoration: TextDecoration.underline),
                ))
          ],
        ),
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
          title: Text('Signup',
              style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        body: Form(
          key: _signUpFormKey,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              30.verticalSpace,
              Center(
                child: Image.asset(
                  'assets/dark_logo_transparent (1).png',
                  width: 146.r,
                ),
              ),
              50.verticalSpace,
              AuthTextField(
                validator: (text) {
                  final fullNameRegExp = RegExp(r'^[A-Za-z\s]+$');
                  // String fullName = 'John Doe';
                  if (_fullName.text.isEmpty) {
                    return 'Please enter full name';
                  }
                  if (!fullNameRegExp.hasMatch(_fullName.text)) {
                    return 'Invalid full name';
                  }
                },
                controller: _fullName,
                fontsiz: 15,
                labelfont: 20,

                widthh: 350.0.w,
                hint: "Full Name",

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
                    Icons.person,
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
              //   'Full Name',
              //   _fullName,
              //   (text) {
              //     if (text == null || text.isEmpty) {
              //       return 'Enter your Name';
              //     }
              //     return null;
              //   },
              //   Icon(Icons.person),
              // ),
              10.verticalSpace,
              AuthTextField(
                validator: (text) {
                  final emailRegExp = RegExp(
                      r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-]{2,}$');

                  if (text == null || text.isEmpty) {
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
                hint: "Email",

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
              //   'Jonathonm@exm.com',
              //   _email,
              //   (text) {
              //     if (text == null || text.isEmpty) {
              //       return 'Enter User Email';
              //     }
              //     return null;
              //   },
              //   Icon(Icons.email),
              // ),
              10.verticalSpace,
              AuthTextField(
                validator: (text) {
                  if (_pwd.text.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (_pwd.text.length < 6) {
                    return 'Password Must Contain Atleast 6 Characters !';
                  }
                },

                controller: _pwd,
                fontsiz: 15,
                labelfont: 20,

                widthh: 350.0.w,
                hint: "Password",

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
                // labelText: "Password",
                // prefixIcon: Padding(
                //   padding: const EdgeInsets.all(15), child: Icon(Icons.remove_red_eye),
                //   //  FaIcon(
                //   //   FontAwesomeIcons.lock,
                //   //   color: Color(0xff9D9EA8),
                //   //   size: 20,
                //   // ),
                // ),

                // prefixIcon: Padding(
                //   padding: const EdgeInsets.all(15),
                //   child: FaIcon(
                //     FontAwesomeIcons.lock,
                //     color: Color(0xff0C0D26).withOpacity(0.4),
                //     size: 20,
                //   ),
                // ),
              ),
              15.verticalSpace,
              AuthTextField(
                validator: (text) {
                  if (_rpwd.text.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (_rpwd.text.length < 6 || _pwd.text != _rpwd.text) {
                    return ' Password does not match';
                  }
                },
                controller: _rpwd,
                fontsiz: 15,
                labelfont: 20,

                widthh: 350.0.w,
                hint: "Confirm Password",

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
              // PasswordBox(
              //   'Password',
              //   _pwd,
              //   1,
              //   (text) {
              //     if (text == null || text.isEmpty || text.length < 6) {
              //       return 'Password Must Contain Atleast 6 Characters !';
              //     }
              //     return null;
              //   },
              // ),
              // 10.verticalSpace,
              // PasswordBox(
              //   'Repeat Password',
              //   _rpwd,
              //   2,
              //   (text) {
              //     if (text == null || text.isEmpty || text.length < 6 || _pwd.text != _rpwd.text) {
              //       return 'Password Must Be Same';
              //     }
              //     return null;
              //   },
              // ),
              15.verticalSpace,
              Row(
                children: [
                  Checkbox(
                    // shape: OutlinedBorder(),
                    activeColor: Colors.white,
                    checkColor: kprimaryColor,
                    // focusColor: Colors.white,
                    value: _acceptedTerms,
                    side: BorderSide(
                      color: Colors.white,
                    ),
                    onChanged: (newValue) {
                      setState(() {
                        _acceptedTerms = newValue!;
                      });
                    },
                  ),
                  Text(
                    "I agree with terms and conditions",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),

              30.verticalSpace,
              button(387.w, 59.h, 'SIGNUP', () async {
                // FirebaseMessaging.instance.getAPNSToken().then((value) async {
                //   LocalStorage.saveJson(
                //     key: LocalStorageKeys.deviceType,
                //     value: "android",
                //   );
                //   LocalStorage.saveJson(key: LocalStorageKeys.fcmToken, value: value!);
                //   var fcmToken = await LocalStorage.readJson(key: LocalStorageKeys.fcmToken);
                //   print("Firebase Token : ${fcmToken.toString()}");
                //   // fmcToken = value!;
                // });

                String? fcmToken = await FirebaseMessaging.instance.getToken();
                print("Firebase Token : ${fcmToken.toString()}");

                if (_acceptedTerms) {
                  if (isValidPassword(_pwd.text)) {
                    setState(() {
                      forgotPwd = false;
                      singup_verification = true;
                    });
                    if (_signUpFormKey.currentState!.validate()) {
                      // var fcmToken = await LocalStorage.readJson(key: LocalStorageKeys.fcmToken);
                      var deviceType = await LocalStorage.readJson(
                          key: LocalStorageKeys.deviceType);
                      var data = {
                        'name': _fullName.text.trim(),
                        'email': _email.text.trim(),
                        'password': _pwd.text.trim(),
                        'password_confirmation': _rpwd.text.trim(),
                        "device_type": Platform.isIOS ? "ios" : "android",
                        "device_token": fcmToken ?? "test",
                      };
                      email = _email.text.trim();
                      await ApiServices().callregister(context, data);
                    } else {}
                  } else {
                    Utils.showFloatingErrorSnack(
                        "Password must contain at least one uppercase letter, one lowercase letter, one number, one special character, and be at least 8 characters long.");
                  }
                } else {
                  Utils.showFloatingErrorSnack(
                      "Accept terms & conditions to proceed");
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
