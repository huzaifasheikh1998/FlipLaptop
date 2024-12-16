import 'dart:io';

import 'package:app_fliplaptop/Apiserrvices/Services.dart';
import 'package:app_fliplaptop/Apiserrvices/loader.dart';
import 'package:app_fliplaptop/Apiserrvices/localStorage.dart';
import 'package:app_fliplaptop/components/AuthTextField.dart';
import 'package:app_fliplaptop/components/global.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    // SharedPreferences sp = await SharedPreferences.getInstance();
    //getting email from shared pref
    _email.text = await LocalStorage.readJson(key: LocalStorageKeys.userEmail) ?? '';
    //getting password from shared pref
    _pwd.text = await LocalStorage.readJson(key: LocalStorageKeys.userPassword) ?? '';
  }

  TextEditingController _email = TextEditingController();
  TextEditingController _pwd = TextEditingController();
  bool pass = true;
  bool remChk = false;
  final loginKey = GlobalKey<FormState>();

  Future<bool> _onWillPop(BuildContext context) async {
    bool? exitResult = await showDialog(
      context: context,
      builder: (context) => _buildExitDialog(context),
    );
    return exitResult ?? false;
  }

  Future<bool?> _showExitDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => _buildExitDialog(context),
    );
  }

  AlertDialog _buildExitDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Please confirm'),
      content: const Text('Do you want to exit the app?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            'No',
            style: TextStyle(color: Color(0xff333132)),
            selectionColor: kprimaryColor,
          ),
        ),
        TextButton(
          onPressed: () => Get.toNamed('/SplashScreen'),
          child: Text(
            'Yes',
            style: TextStyle(color: Color(0xff333132)),
            selectionColor: kprimaryColor,
          ),
        ),
      ],
    );
  }

  // Future<dynamic> acceptPolicyDialog(BuildContext context) {
  //   return showDialog(
  //     context: context,
  //     builder: (context) {
  //       bool isChecked1 = false;
  //       bool isChecked2 = false;
  //       return StatefulBuilder(
  //         builder: (context, setState) {
  //           final theme = Theme.of(context);
  //           final oldCheckboxTheme = theme.checkboxTheme;
  //           final newCheckBoxTheme = oldCheckboxTheme.copyWith(
  //             side: AlwaysActiveBorderSide(),
  //             fillColor: MaterialStateProperty.resolveWith((states) {
  //               // If the button is pressed, return green, otherwise blue
  //               if (states.contains(MaterialState.pressed)) {
  //                 return Colors.white;
  //               }
  //               return Colors.black;
  //             }),
  //             checkColor: MaterialStateProperty.resolveWith((states) {
  //               // If the button is pressed, return green, otherwise blue
  //               if (states.contains(MaterialState.pressed)) {
  //                 return kprimaryColor;
  //               }
  //               return Colors.black;
  //             }),
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(3.r)),
  //           );
  //
  //           return Center(
  //             child: Material(
  //               type: MaterialType.transparency,
  //               child: Container(
  //                   decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(10.r),
  //                       color: Colors.white),
  //                   // width: Get.width * 0.85,
  //                   width: 388.w,
  //                   height: 360.h,
  //                   // padding: EdgeInsets.all(10),
  //                   child: Stack(
  //                     alignment: Alignment.center,
  //                     children: [
  //                       Align(
  //                         alignment: Alignment.topRight,
  //                         child: Container(
  //                           width: 388.w,
  //                           height: 74.h,
  //                           decoration: BoxDecoration(
  //                               gradient: kbtngradient,
  //                               borderRadius: BorderRadius.vertical(
  //                                   top: Radius.circular(10.r))),
  //                           child: Container(
  //                             width: (329 / 2).w,
  //                             child: Row(
  //                               mainAxisAlignment:
  //                                   MainAxisAlignment.spaceBetween,
  //                               children: [
  //                                 IconButton(
  //                                   onPressed: () {
  //                                     Get.back();
  //                                   },
  //                                   icon: Icon(
  //                                     Icons.close,
  //                                     color: Colors.transparent,
  //                                   ),
  //                                 ),
  //                                 Text(
  //                                   "Agreement",
  //                                   style: TextStyle(
  //                                     color: Colors.white,
  //                                     fontSize: 20.sp,
  //                                     // fontWeight: FontWeight.bold
  //                                   ),
  //                                 ),
  //                                 IconButton(
  //                                   onPressed: () => Get.back(),
  //                                   icon: Icon(
  //                                     Icons.close,
  //                                     color: Colors.white,
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                       Column(
  //                         mainAxisSize: MainAxisSize.min,
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           90.verticalSpace,
  //                           Padding(
  //                             padding: EdgeInsets.symmetric(horizontal: 30.r),
  //                             child: Text(
  //                               'I agree with the following',
  //                               style: TextStyle(
  //                                   fontSize: 22.sp, color: Colors.black),
  //                             ),
  //                           ),
  //                           15.verticalSpace,
  //                           Row(
  //                             mainAxisAlignment: MainAxisAlignment.start,
  //                             children: [
  //                               10.horizontalSpace,
  //                               Theme(
  //                                   data: ThemeData(
  //                                       // unselectedWidgetColor: Colors.red,
  //                                       checkboxTheme: newCheckBoxTheme),
  //                                   child: Checkbox(
  //                                     value: isChecked1,
  //
  //                                     activeColor: Colors.white,
  //                                     // activeColor: isChecked1 ? Colors.white: Colors.grey ,
  //                                     checkColor: Colors.black,
  //                                     focusColor: Colors.black,
  //                                     tristate: false,
  //                                     onChanged: (value) {
  //                                       setState(() {
  //                                         isChecked1 = !isChecked1;
  //                                       });
  //                                     },
  //                                   )),
  //                               Text(
  //                                 'Term & Conditions',
  //                                 style: TextStyle(fontSize: 20.sp),
  //                               )
  //                             ],
  //                           ),
  //                           Row(
  //                             mainAxisAlignment: MainAxisAlignment.start,
  //                             children: [
  //                               10.horizontalSpace,
  //                               Theme(
  //                                   data: ThemeData(
  //                                       // unselectedWidgetColor: Colors.red,
  //                                       checkboxTheme: newCheckBoxTheme),
  //                                   child: Checkbox(
  //                                     value: isChecked2,
  //                                     tristate: false,
  //                                     activeColor: Colors.white,
  //                                     onChanged: (value) {
  //                                       setState(() {
  //                                         isChecked2 = !isChecked2;
  //                                       });
  //                                     },
  //                                   )),
  //                               Text(
  //                                 'Privacy Policy',
  //                                 style: TextStyle(fontSize: 20.sp),
  //                               )
  //                             ],
  //                           ),
  //                           20.h.verticalSpace,
  //                           Padding(
  //                             padding: EdgeInsets.symmetric(horizontal: 10.r),
  //                             child: Row(
  //                                 mainAxisAlignment: MainAxisAlignment.center,
  //                                 children: [
  //                                   GestureDetector(
  //                                     onTap: () async {
  //                                       Get.close(1);
  //
  //                                       // Get.toNamed('/StartAppScreen');
  //                                     },
  //                                     child: Container(
  //                                       width: Get.width * 0.4,
  //                                       height: 60.h,
  //                                       decoration: BoxDecoration(
  //                                           borderRadius: BorderRadius.only(
  //                                             topLeft: Radius.circular(10.r),
  //                                             bottomLeft: Radius.circular(10.r),
  //                                           ),
  //                                           gradient: kgradient),
  //                                       child: Center(
  //                                         child: Text(
  //                                           "Accept",
  //                                           style:
  //                                               TextStyle(color: Colors.white),
  //                                         ),
  //                                       ),
  //                                     ),
  //                                   ),
  //                                   GestureDetector(
  //                                     onTap: () {
  //                                       Get.close(1);
  //                                     },
  //                                     child: Container(
  //                                       width: Get.width * 0.4,
  //                                       height: 60.h,
  //                                       decoration: BoxDecoration(
  //                                           borderRadius: BorderRadius.only(
  //                                             topRight: Radius.circular(10.r),
  //                                             bottomRight:
  //                                                 Radius.circular(10.r),
  //                                           ),
  //                                           gradient: kbtngradient),
  //                                       child: Center(
  //                                         child: Text(
  //                                           "Decline",
  //                                           style:
  //                                               TextStyle(color: Colors.white),
  //                                         ),
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 ]),
  //                           ),
  //                         ],
  //                       ) // 50.h.verticalSpace,
  //                     ],
  //                   )),
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

  // String email = '';
  String password = '';
  bool rememberMe = false;

  // void initState() {
  //   super.initState();
  //   getSavedLoginCredentials().then((credentials) {
  //     setState(() {
  //       email = email;
  //       password = password;
  //       rememberMe = email.isNotEmpty && password.isNotEmpty;
  //     });
  //   });
  // }
  // Future<void> _signInWithGoogle() async {
  //   try {
  //     // Sign in
  //     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
  //
  //     // Retrieve the user details
  //     final GoogleSignInAuthentication googleAuth =
  //     await googleUser!.authentication;
  //
  //     log("email"+googleUser.email);
  //
  //     // Use the details to authenticate
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );
  //
  //     // Authenticate with Firebase
  //     await FirebaseAuth.instance.signInWithCredential(credential);
  //
  //     // Do something after sign-in
  //     // e.g. navigate to a new screen
  //   } catch (error) {
  //     print('Error signing in with Google: $error');
  //   }
  // }
  String? idToken;
  String? accessToken;

  // GoogleSignIn _googleSignIn = GoogleSignIn(
  //   scopes: [
  //     'email',
  //   ],
  // );
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Container(
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
                "Don't have an account? ",
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                ),
              ),
              InkWell(
                  onTap: () {
                    Get.toNamed('/SignUpScreen');
                  },
                  child: Text(
                    'Signup',
                    style: GoogleFonts.inter(color: Colors.white, fontSize: 16.sp, decorationColor: Colors.white, decoration: TextDecoration.underline),
                  ))
            ],
          ),
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: Container(),
            title: Text('Login', style: GoogleFonts.inter(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.bold)),
            centerTitle: true,
          ),
          body: Form(
            key: loginKey,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                20.h.verticalSpace,
                Center(
                  child: Image.asset(
                    'assets/dark_logo_transparent (1).png',
                    width: 146.r,
                  ),
                ),
                40.h.verticalSpace,
                AuthTextField(
                  validator: (text) {
                    final emailRegExp = RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-]{2,}$');
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
                //   (text) {},
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
                // PasswordBox('Password', _pwd, 1, (text) {}),

                Row(
                  children: [
                    // if (rememberMe)
                    Transform.scale(
                      scale: 0.75,
                      child: Checkbox(
                        visualDensity: VisualDensity(horizontal: -4.0),
                        checkColor: Colors.white,
                        splashRadius: 1.34,
                        value: remChk,
                        activeColor: Color(0xff214234),
                        fillColor: MaterialStateColor.resolveWith((states) => Color(0xff214234)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(360.r)),
                        onChanged: (value) {
                          setState(() {
                            remChk = !remChk;
                          });
                        },
                      ),
                    ),
                    Text(
                      'Remember Me',
                      style: GoogleFonts.inter(fontSize: 15.sp, color: Colors.white),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        forgotPwd = true;
                        Get.toNamed('/ForgotPasswordScreen');
                      },
                      child: Text(
                        'Forgot Password ?',
                        style: GoogleFonts.inter(color: Colors.white, fontSize: 15.sp),
                      ),
                    )
                  ],
                ),
                10.verticalSpace,
                button(
                  387.w,
                  59.h,
                  'LOGIN',
                  () async {
                    if (remChk) {
                      //saving email to shared pref
                      LocalStorage.saveJson(
                        key: LocalStorageKeys.userEmail,
                        value: _email.text,
                      );
                      //saving password to shared pref
                      LocalStorage.saveJson(
                        key: LocalStorageKeys.userPassword,
                        value: _pwd.text,
                      );
                    }
                    setState(() {
                      email = _email.text.trim();
                    });
                    var fcmToken = await LocalStorage.readJson(key: LocalStorageKeys.fcmToken);
                    var deviceType = await LocalStorage.readJson(key: LocalStorageKeys.deviceType);
                    String? fcmToken1 = await FirebaseMessaging.instance.getAPNSToken();
                    print("Firebase Token : ${fcmToken.toString()}");
                    var data = {
                      "email": _email.text.trim(),
                      "password": _pwd.text.trim(),
                      "device_type": Platform.isIOS?"ios":"android",
                      "device_token": "testing",
                    };
                    if (loginKey.currentState!.validate()) {
                      await ApiServices().callLogin(context, data, remChk);
                    }
                  },
                  // {
                  //   Get.toNamed('/StartAppScreen');
                  // }
                ),
                20.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 0.3,
                      width: 87.r,
                      color: Color.fromARGB(151, 255, 255, 255),
                    ),
                    7.horizontalSpace,
                    Text(
                      'OR',
                      style: GoogleFonts.inter(color: Color.fromARGB(151, 255, 255, 255)),
                    ),
                    7.horizontalSpace,
                    Container(
                      height: 0.3,
                      width: 87.r,
                      color: Color.fromARGB(151, 255, 255, 255),
                    ),
                  ],
                ),
                40.h.verticalSpace,
                Text(
                  'Signup with',
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 16.sp),
                  textAlign: TextAlign.center,
                ),
                20.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: WrapCrossAlignment.center,
                  // alignment: WrapAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () async {
                        var fcmToken = await LocalStorage.readJson(key: LocalStorageKeys.fcmToken);
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return Center(child: Loader.spinkit);
                          },
                        );
                        await ApiServices().signInWithGoogle(
                          context,
                          fcmToken,
                        );
                      },
                      child: Container(
                        width: 50.r,
                        height: 50.r,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(6.r), color: Colors.white),
                        child: SvgPicture.asset('assets/Group 2.svg'),
                      ),
                    ),
                    // InkWell(
                    //   onTap: () {
                    //     // acceptPolicyDialog(context);
                    //   },
                    //   child: Container(
                    //     width: 50.r,
                    //     height: 50.r,
                    //     alignment: Alignment.center,
                    //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(6.r), color: Color(0xff337FFF)),
                    //     child: SvgPicture.asset('assets/Path 1.svg'),
                    //   ),
                    // ),
                    Platform.isIOS?
                    InkWell(
                      onTap: () {
                        // acceptPolicyDialog(context);
                      },
                      child: Container(
                        width: 50.r,
                        height: 50.r,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(6.r), color: Colors.black),
                        child: SvgPicture.asset('assets/Icon metro-apple.svg'),
                      ),
                    ):SizedBox.shrink()
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      onWillPop: () => _onWillPop(context),
    );
  }

// void login() {
//   // Perform login logic

//   if (rememberMe) {
//     saveLoginCredentials(email, password);
//   }
// }
}

class AlwaysActiveBorderSide extends MaterialStateBorderSide {
  @override
  BorderSide? resolve(_) => BorderSide(color: Color(0xff333132), width: 1);
}

// void saveLoginCredentials(String email, String password) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.setString('email', email);
//   prefs.setString('password', password);
// }

// Future<Map<String, String>> getSavedLoginCredentials() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String email = prefs.getString('email') ?? '';
//   String password = prefs.getString('password') ?? '';

//   return {'email': email, 'password': password};
// }
