import 'dart:developer';

import 'package:app_fliplaptop/Apiserrvices/Services.dart';
import 'package:app_fliplaptop/Apiserrvices/localStorage.dart';
import 'package:app_fliplaptop/Controller/UserController.dart';
import 'package:app_fliplaptop/Screens/LoginScreen.dart';
import 'package:app_fliplaptop/Screens/StartNavigatorScreen.dart';
import 'package:app_fliplaptop/components/global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final userController = Get.put(UserController());

  late VideoPlayerController _controller;

  // String authToken = "";

  // savAuthToken() async {
  //   authToken = await  LocalStorage.readJson(key: LocalStorageKeys.authToken).toString();
  //   setState(() {
  //   });
  // }

  void initState() {
    // new Future.delayed(
    //     const Duration(seconds: 3), () => Get.toNamed('/LoginScreen',));
    _controller = VideoPlayerController.asset('assets/splashAnimation.mp4')
      ..initialize().then((_) {
        new Future.delayed(
          const Duration(seconds: 3),
          ()  {
            saveUserIDToController();

            log("authhhhhhhh Tokennnnnn " +
                userController.authTokenForSplash.value);
            userController.authTokenForSplash.value == ""
                ? Get.to(
                    () => LoginScreen(),
                    transition: Transition.fade,
                    duration: Duration(
                      seconds: 3,
                    ),
                  )
                : Get.to(
                    () => StartAppScreen(),
                    transition: Transition.fade,
                    duration: Duration(
                      seconds: 2,
                    ),
                  );
          },
        );

        // Get.to()
        // Ensure the first frame is shown
        setState(() {});
        _controller.play();
      });
    super.initState();
  }


  saveUserIDToController()async {
    var userID = await LocalStorage.readJson(
      key: LocalStorageKeys.userID,
    );
    if (userID!=
        "null" || userID!=null) {
      userController.user.value.id =
         userID;
    }
    log("-------------------USER ID ON AUTO LOGIN--------------" +
        userID.toString());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // savAuthToken();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 179, 42, 32),
      body: Container(
        decoration: BoxDecoration(
          gradient: kgradient,
        ),
        child: Center(
          child: AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          ),
        ),
      ),
    );
    // Container(
    //   decoration: BoxDecoration(
    //       image: DecorationImage(
    //           image: AssetImage(
    //             'assets/Rectangle 1.png',
    //           ),
    //           fit: BoxFit.fill)),
    //   child: Scaffold(
    //     backgroundColor: Colors.transparent,
    //     bottomNavigationBar: Padding(
    //       padding: EdgeInsets.symmetric(horizontal: 75.r),
    //       child: Column(
    //         mainAxisSize: MainAxisSize.min,
    //         children: [
    //           Text(
    //             'Loading',
    //             style: GoogleFonts.inter(color: Colors.white, fontSize: 20.sp),
    //           ),
    //           20.verticalSpace,
    //           LinearProgressIndicator(
    //             color: Colors.white,
    //             backgroundColor: Colors.white,
    //             // value: 0.3,
    //             minHeight: 0.2,
    //           ),
    //           50.verticalSpace
    //         ],
    //       ),
    //     ),
    //     body: Container(
    //       width: Get.width,
    //       height: Get.height,
    //       padding: EdgeInsets.symmetric(horizontal: 100.8.r),
    //       alignment: Alignment.center,
    //       child: Column(
    //         mainAxisSize: MainAxisSize.min,
    //         children: [
    //           Image.asset(
    //             'assets/dark_logo_transparent (1).png',
    //             width: 253.r,
    //           ),
    //           298.2.verticalSpace,
    //           Text(
    //             'Find Your Best Gadgets',
    //             style: GoogleFonts.inter(
    //                 fontSize: 41.sp,
    //                 color: Colors.white,
    //                 fontWeight: FontWeight.w900),
    //             textAlign: TextAlign.center,
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
