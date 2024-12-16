import 'dart:developer';

import 'package:app_fliplaptop/Controller/location_controller.dart';
import 'package:app_fliplaptop/models/prediction.dart';
import 'package:app_fliplaptop/widgets/google_places_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:lottie/lottie.dart' as lottie;

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  static const routeName = '/location-screen';

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  Set<Marker> markers = {};
  double? latitude;
  double? longitude;

  // final locationController = Get.put(LocationScreenController());
  late GoogleMapController googleMapController;
  static CameraPosition initialCameraPosition = const CameraPosition(
      target: LatLng(37.42796133580664, -122.0857449655962), zoom: 14);
  bool isLoading = true;
  final locationController = Get.put(LocationScreenController());

  @override
  void initState() {
    //createLeadController.cameraInitialized = false; // Reset cameraInitialized
    Future.delayed(Duration.zero, () {
      locationController.getCurrentPosition(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: InkWell(
          onTap: () => Get.back(),
          child: const Icon(
            Icons.keyboard_backspace_rounded,
          ),
        ),
      ),
      body: GetBuilder(
          init: LocationScreenController(),
          builder: (controller) {
            return Stack(
              children: [
                GoogleMap(
                  // onCameraMove: (position) {
                  //   // locationController.setCurrentPositionAddressInitial();
                  //   // locationController.onCameraLocationChanged(position.target);
                  //   value.setCurrentPositionAddressInitial();
                  //   value.onCameraLocationChanged(position.target);
                  // },
                  onCameraMove: (position) {
                    controller.setCurrentPositionAddressInitial();
                    controller.onCameraLocationChanged(position.target);
                  },
                  padding: EdgeInsets.only(
                    top: 250.h,
                  ),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  //initialCameraPosition: CameraPosition(target: LatLng(36.1693102, -115.1405492), zoom: 15),
                  //initialCameraPosition: createLeadController.initialMapCameraPosition ?? CameraPosition(target: LatLng(36.1693102, -115.1405492), zoom: 15),
                  //initialCameraPosition: value.initialMapCameraPosition!,
                  initialCameraPosition: controller.initialMapCameraPosition ??
                      CameraPosition(
                          target: LatLng(24.88197462340103, -67.08192575722933),
                          zoom: 15),

                  zoomControlsEnabled: false,
                  onMapCreated: (GoogleMapController mapController) {
                    controller.mapController.complete(mapController);
                    //value.mapController.complete(controller);
                  },
                ),
                Positioned(
                  top: 80,
                  right: 15,
                  left: 15,
                  child: Row(children: [
                    Expanded(
                      child: GooglePlaceAutoCompleteTextField(
                        textEditingController: controller.searchController,
                        googleAPIKey: "AIzaSyDqPvip7cVNNkSv1wxbNi9DAgwxOfpEA5o",
                        textStyle: TextStyle(
                          fontSize: 30.sp,
                          color: Colors.black,
                        ),
                        boxDecoration: BoxDecoration(),
                        // textAlignVertical: TextAlignVertical.center,
                        // keyboardType: TextInputType.text,

                        inputDecoration: InputDecoration(
                            // isDense: false,
                            // isCollapsed: true,

                          alignLabelWithHint: true,
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.zero,
                            hintText: "Search Location",
                            hintStyle: TextStyle(
                              color: Color(0xffA7B1BF),
                              fontSize: 20.sp,
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(15.r)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(15.r)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(15.r)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(15.r)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(15.r)),
                            labelStyle: TextStyle(
                              fontSize: 14.sp,

                              color: Color(0xffA7B1BF),
                              fontFamily: "Inter, Regular",
                            ),
                            prefixIcon: GestureDetector(
                                onTap: () async {},
                                child: Row(
                                  children: [
                                    4.w.horizontalSpace,
                                    Icon(Icons.search),
                                    3.w.horizontalSpace,
                                  ],
                                )),
                            prefixIconConstraints: BoxConstraints(
                              maxWidth: 65.w,
                              minWidth: 50.r,
                            )),
                        isLatLngRequired: true,
                        getPlaceDetailWithLatLng:
                            (Prediction prediction) async {
                          double lat = double.parse(prediction.lat.toString());
                          double lng = double.parse(prediction.lng.toString());
                          print("placeDetailslats" + lat.toString());
                          print("placeDetailslong" + lng.toString());

                          await controller.searchAnimation(LatLng(lat, lng));

                          FocusScope.of(context).unfocus();
                        },
                        itemClick: (Prediction prediction) {
                          controller.searchController.text =
                              prediction.description.toString();
                          controller.searchController.selection =
                              TextSelection.fromPosition(TextPosition(
                                  offset: prediction.description!.length));
                          print(prediction.lat);
                        },
                      ),
                    ),

                    //     InputField(
                    //
                    //   hint: 'Search Location',
                    //   isPassword: false,
                    //   prefixIcon: SizedBox(
                    //     width: 5.w,
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Image.asset(AppAssets.searchIcon).paddingOnly(left: 10),
                    //         SvgPicture.asset(AppAssets.dottedLineIcon)
                    //             .paddingOnly(right: 10)
                    //       ],
                    //     ),
                    //   ),
                    // )
                  ]),

                  // if (isLoading)
                  // Center(
                  //   child: Container(
                  //     width: Get.width,
                  //     height: Get.height,
                  //     decoration: const BoxDecoration(color: Colors.white),
                  //     child: lottie.Lottie.asset("assets/images/mapIndicator.json"),
                  //   ),
                  // ),
                ),
                Positioned(
                  bottom: 20,
                  left: 15,
                  right: 15,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                          locationController.locationController.text = locationController.destinationPositionAddress??"";
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.red.shade800,
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                15.r,
                              ),
                            ),
                          ),
                          child: Text(
                            "Set Location",
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.white,
                            ),
                          ).paddingSymmetric(horizontal: 70.r, vertical: 15.r),
                        ),
                      )
                      // GestureDetector(
                      //         onTap: () {
                      //           Get.off(() => const EditProfileScreen());
                      //         },
                      //         child: CustomButton(
                      //           width: Get.width,
                      //           onTap: () {
                      //             controller.latitude = latitude;
                      //             controller.longitude = longitude;
                      //             controller.update();
                      //             log("location"+controller.latitude.toString() +
                      //                 controller.longitude.toString());
                      //             Get.back();
                      //             controller.locationController.text =
                      //                 locationController
                      //                     .destinationPositionAddress ??
                      //                     "";
                      //             FocusScope.of(context).unfocus();
                      //
                      //           },
                      //           height: 21.h,
                      //           title: 'Set Location',
                      //           fontFamily: 'Nunito0',
                      //           fontsize: 9.h,
                      //           color: AppColors.whiteColor,
                      //           // gradient: AppColors.gradient,
                      //
                      //         ),
                      //       )
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0.35.sh,
                  right: 0.45.sw,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // controller.destinationPositionAddress == null
                      //     ? Container()
                      //     : Container(
                      //   constraints:
                      //   BoxConstraints(maxWidth: 280.w),
                      //   margin: EdgeInsets.only(bottom: 10),
                      //   padding: EdgeInsets.symmetric(
                      //       vertical: 10.h, horizontal: 20.h),
                      //   decoration: BoxDecoration(
                      //     // color: Colors.black.withOpacity(0.4),
                      //       color: Colors.purple.withOpacity(0.75),
                      //       borderRadius:
                      //       BorderRadius.circular(10.r)),
                      //   child: Text(
                      //     controller.destinationPositionAddress ?? "",
                      //     maxLines: 2,
                      //     style: TextStyle(color: Colors.white),
                      //   ),
                      // ),
                      Image.asset(
                        "assets/location_icon.png",
                        color: Colors.red.shade800,
                        height: 60.h,
                      )
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
