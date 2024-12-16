import 'package:app_fliplaptop/res/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';

locationPermissionAlert(context) async {
  return await showDialog(
      context: context,
      builder: (context) {
        return Material(
          color: Colors.transparent,
          child: StatefulBuilder(
            builder: (context, setState) {
              return Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    elevation: 0,
                  ),
                  Container(
                    height: 300.h,
                    width: 319.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            65.h.verticalSpace,
                            Text(
                              'Location Permission',
                              style: TextStyle(
                                color: Colors.purple,
                                fontSize: 25.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            10.h.verticalSpace,
                            Container(
                              padding: const EdgeInsets.all(15),
                              child: Text(
                                'Please enable location services to add location',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                        30.h.verticalSpace,
                        Container(
                          height: 51.h,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.withOpacity(.4),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  Navigator.pop(context, false);
                                  Utils.showFloatingErrorSnack(
                                    'Location services are disabled. Please enable the services',
                                  );
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  width: 130.w,
                                  child: Center(
                                    child: Text(
                                      'Deny',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 1,
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(.4),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  bool? state;
                                  var permission =
                                      await Geolocator.requestPermission();
                                  if (permission == LocationPermission.always ||
                                      permission ==
                                          LocationPermission.whileInUse) {
                                    state = true;
                                  } else {
                                    state = false;
                                  }
                                  Navigator.pop(context, state);
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  width: 130.w,
                                  child: Center(
                                    child: Text(
                                      'Allow',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 160.h,
                    child: Container(
                      width: 98.w,
                      height: 98.h,
                      decoration: const BoxDecoration(
                        // gradient: myColor,
                        shape: BoxShape.circle,
                      ),
                      // child: Image.asset(
                      //   'assets/images/3r.png',
                      //   scale: 3,
                      // ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      });
}
