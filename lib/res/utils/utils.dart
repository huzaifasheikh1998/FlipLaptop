import 'package:app_fliplaptop/Screens/StartNavigatorScreen.dart';
import 'package:app_fliplaptop/components/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';

class Utils {


  static showSnack(String msg, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
    ));
  }

  static showFloatingErrorSnack(String errorMsg) {
    Get.snackbar('Error', errorMsg,
        snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
  }

  static showFloatingAlertSnack(String errorMsg) {
    Get.snackbar('Alert', errorMsg,
        snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
  }

  static showFloatingSuccessSnack(String successMsg) {
    Get.snackbar('Success', successMsg,
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: Colors.green);
  }

  static showNotificationSnack(String successMsg) {
    Get.snackbar('Success', successMsg,
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: Colors.green);
  }

  static Future<dynamic> OrderConfirmationPopup(BuildContext context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Center(
              child: Material(
            type: MaterialType.transparency,
            child: Container(
              height: 430.h,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 24.r),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: Colors.white),
                      // width: Get.width * 0.85,
                      width: 343.w,
                      height: 300.h,
                      // padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          120.verticalSpace,
                          Text(
                            'Your Order Has Been Placed!',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          10.verticalSpace,
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 19.r),
                            // constraints: BoxConstraints(
                            //   maxWidth:  266.w
                            // ),
                            child: Text(
                              'You will be contacted by the Seller via direct message!',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 16.sp),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          15.verticalSpace,
                          Dialogbutton2(Get.width, 50.h, "Continue Shopping",
                              () {
                            Get.toNamed('/StartAppScreen');
                          })
                        ],
                      )),
                  Positioned(
                    top: 0,
                    child: Container(
                      width: 152.r,
                      height: 152.r,
                      padding: EdgeInsets.all(27.r),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 5)
                          ],
                          shape: BoxShape.circle,
                          gradient: kbtngradient,
                          border: Border.all(width: 3, color: highlightedText)),
                      child: Image.asset('assets/laptop-screen@3x.png'),
                    ),
                  ),
                ],
              ),
            ),
          ));
        });
  }

  static Future<dynamic> ReviewSubmitDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return Center(
              child: Material(
            type: MaterialType.transparency,
            child: Container(
              height: 430.h,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.r),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: Colors.white),
                      // width: Get.width * 0.85,
                      width: 343.w,
                      height: 295.h,
                      // padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          80.verticalSpace,
                          Text(
                            'Review',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          5.verticalSpace,
                          Container(
                            constraints: BoxConstraints(maxWidth: 208.w),
                            child: Text(
                              'Review has been submitted Successfully',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.sp,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          20.verticalSpace,
                          Dialogbutton2(313.w, 50.h, "Go Back", () {
                            // Get.offUntil(
                            //   MaterialPageRoute(
                            //       builder: (context) => MyStoreProfileScreen(
                            //         storeId: ApiServices.storeId,
                            //       )),
                            //       (Route<dynamic> route) =>
                            //   route.settings.name == "/MyStoreProfileScreen",
                            // );
                            // Get.close(1);
                            Get.off(() => StartAppScreen());
                          }),
                          20.verticalSpace
                        ],
                      )),
                  Positioned(
                    top: 0,
                    child: Container(
                      width: 152.r,
                      height: 152.r,
                      padding: EdgeInsets.all(27.r),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 5)
                          ],
                          shape: BoxShape.circle,
                          gradient: kbtngradient,
                          border: Border.all(width: 3, color: highlightedText)),
                      child: Image.asset('assets/laptop-screen@3x.png'),
                    ),
                  ),
                ],
              ),
            ),
          ));
        });
  }

  static selectImageSource(
      void Function()? takePhotoAction, void Function()? chooseGalleryAction) {
    Get.bottomSheet(
      Padding(
        padding: const EdgeInsets.all(16),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Take Photo'),
            onTap: takePhotoAction,
          ),
          const SizedBox(height: 16),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Choose from Gallery'),
            onTap: chooseGalleryAction,
          ),
        ]),
      ),
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
    );
  }

  static getAddressFromLatLng(lat, long) async {
    double longitudee = long;
    double latitudee = lat;
    final placemarks = await placemarkFromCoordinates(latitudee, longitudee);
    if (placemarks.isNotEmpty) {
      final placemark = placemarks[0];
      String completeAddress =
          '${placemark.street},${placemark.subLocality},${placemark.locality}, ${placemark.administrativeArea}  ${placemark.country}';

      print('Locationnnnn is ${completeAddress}');
      return completeAddress;
    }
    return "Unable to get address";
  }


}
