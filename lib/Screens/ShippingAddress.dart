import 'package:app_fliplaptop/Apiserrvices/Services.dart';
import 'package:app_fliplaptop/Controller/shippingController.dart';
import 'package:app_fliplaptop/components/global.dart';
import 'package:app_fliplaptop/widgets/disallow_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Apiserrvices/loader.dart';
import 'editShippingAddress.dart';

class ShippingAddressScreen extends StatefulWidget {
  ShippingAddressScreen({super.key});

  @override
  State<ShippingAddressScreen> createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends State<ShippingAddressScreen> {
  final shippingController = Get.put(ShippingController());
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   // ApiServices().listShippingAddresses();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    print("=========================================");
    print(shippingController.completeShippingModel.value.data);
    return Scaffold(
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 20.r),
          child: button2(
              388.w,
              59.h,
              shippingController.isDefaultSelected.value
                  ? "Set as Default"
                  : 'Add New Address',
              shippingController.isDefaultSelected.value
                  ? () async {
                      await ApiServices().setAsDefaultShippingAddress(context,
                          shippingController.isDefaultSelectedID.value);
                      setState(() {
                        shippingController.isDefaultSelected.value = false;
                      });
                    }
                  : () {
                      Get.toNamed('/AddNewAddressScreen');
                    }),
        ),
        appBar: AppBar(
          // leadingWidth: 30.r,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, gradient: kbtngradient),
                  child: SvgPicture.asset(
                    'assets/Path 11.svg',
                    width: 14,
                  ))),
          centerTitle: true,
          title: Text(
            'Shipping Address',
            style: GoogleFonts.inter(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
        ),
        body: DisAllowIndicatorWidget(
          child: Obx(
            () => shippingController.isLoading.value
                ? Center(child: Loader.spinkit)
            :shippingController.completeShippingAddresses.isEmpty?Center(child: Text("No Shipping Address Added Yet"))
                : GestureDetector(
                    onTap: () {
                      setState(() {
                        shippingController.isDefaultSelected.value = false;
                        print(shippingController.isDefaultSelected.value);
                      });
                    },
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: SizedBox(
                        height: 850.h,
                        child: ListView.builder(
                          itemCount: shippingController
                              .completeShippingAddresses.length,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.r, vertical: 10.r),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onLongPress: () {
                                setState(() {
                                  shippingController.isDefaultSelected.value =
                                      true;
                                  print(shippingController
                                      .isDefaultSelected.value);
                                  shippingController.isDefaultSelectedID.value =
                                      shippingController
                                              .completeShippingAddresses[index]
                                          ["id"];
                                  print(shippingController
                                      .isDefaultSelectedID.value);
                                });
                              },
                              onTap: () {
                                setState(() {
                                  shippingController.isDefaultSelected.value =
                                      true;
                                  print(shippingController
                                      .isDefaultSelected.value);
                                  shippingController.isDefaultSelectedID.value =
                                      shippingController
                                              .completeShippingAddresses[index]
                                          ["id"];
                                  print(shippingController
                                      .isDefaultSelectedID.value);
                                });
                              },
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        // height: 125.h,
                                        padding: EdgeInsets.only(
                                            top: 20.r,
                                            bottom: 21.r,
                                            left: 25.r,
                                            right: 41.r),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: shippingController
                                                            .isDefaultSelected
                                                            .value ==
                                                        true &&
                                                    shippingController
                                                                .completeShippingAddresses[
                                                            index]["id"] ==
                                                        shippingController
                                                            .isDefaultSelectedID
                                                            .value
                                                ? Border.all(
                                                    color: Colors.red,
                                                    width: 3.w,
                                                  )
                                                : null,
                                            boxShadow: [
                                              BoxShadow(
                                                  blurRadius: 18,
                                                  offset: Offset(0, 2),
                                                  color: Color.fromARGB(
                                                          194, 241, 203, 216)
                                                      .withOpacity(0.15))
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(10.r)),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 36.r,
                                                  height: 36.r,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      gradient: kgradient),
                                                  child: SvgPicture.asset(
                                                    'assets/Icon material-location-on.svg',
                                                    width: 13.r,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                15.horizontalSpace,
                                                Text(
                                                  "${shippingController.completeShippingAddresses[index]["city"]}, ${shippingController.completeShippingAddresses[index]["country"]}",
                                                  style: GoogleFonts.inter(
                                                      fontSize: 15.sp,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                            18.verticalSpace,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 220.w,
                                                  child: Text(
                                                    "${shippingController.completeShippingAddresses[index]["address_line1"]}, ${shippingController.completeShippingAddresses[index]["address_line2"]} \n ${shippingController.completeShippingAddresses[index]["mobile_number"]}",
                                                    style: GoogleFonts.inter(
                                                      fontSize: 12.sp,
                                                      color: Colors.black
                                                          .withOpacity(0.5),
                                                    ),
                                                  ),
                                                ),
                                                // 40.horizontalSpace,
                                                Visibility(
                                                  visible: shippingController
                                                                  .completeShippingAddresses[
                                                              index]
                                                          ["set_as_default"] ==
                                                      "yes",
                                                  child: Container(
                                                    height: 35.h,
                                                    width: 85.w,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(
                                                          15.sp,
                                                        ),
                                                      ),
                                                      border: Border.all(
                                                        color:
                                                            Colors.blueAccent,
                                                        width: 2.w,
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "Default",
                                                        style: TextStyle(
                                                          fontSize: 16.sp,
                                                          color:
                                                              Colors.blueAccent,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                1.horizontalSpace
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        right: 10,
                                        top: 20.h,
                                        child: SizedBox(
                                          height: 90.h,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Get.to(
                                                    () => EditShippingAddress(
                                                      Country: shippingController
                                                              .completeShippingAddresses[
                                                          index]["country"],
                                                      contactDetails:
                                                          shippingController
                                                                      .completeShippingAddresses[
                                                                  index]
                                                              ["mobile_number"],
                                                      phoneNumber: shippingController
                                                              .completeShippingAddresses[
                                                          index]["mobile_number"],
                                                      Address:
                                                          "${shippingController.completeShippingAddresses[index]["address_line1"]},${shippingController.completeShippingAddresses[index]["address_line2"]} ",
                                                      City: shippingController
                                                              .completeShippingAddresses[
                                                          index]["city"],
                                                      ZipCode: shippingController
                                                              .completeShippingAddresses[
                                                          index]["postal_code"],
                                                      ShippingID: shippingController
                                                              .completeShippingAddresses[
                                                          index]["id"],
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  width: 35.r,
                                                  height: 35.r,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.5),
                                                        spreadRadius: 4,
                                                        blurRadius: 5,
                                                        offset: Offset(0,
                                                            2), // changes position of shadow
                                                      ),
                                                    ],
                                                  ),
                                                  child: Icon(
                                                    Icons.edit,
                                                    color: Colors.black,
                                                    size: 18.r,
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  ConfirmationPopup(
                                                    context,
                                                    "Delete Address",
                                                    "Are you sure you want to delete this address?",
                                                    "Delete",
                                                    "Cancel",
                                                    () {
                                                      ApiServices()
                                                          .deleteShippingAddress(
                                                              shippingController
                                                                      .completeShippingAddresses[
                                                                  index]["id"],
                                                              context);
                                                    },
                                                    () {
                                                      Get.back();
                                                    },
                                                  );
                                                },
                                                child: Container(
                                                  width: 37.r,
                                                  height: 37.r,
                                                  // padding: EdgeInsets.all(5.r),
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    gradient: kbtngradient,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.5),
                                                        spreadRadius: 4,
                                                        blurRadius: 5,
                                                        offset: Offset(0,
                                                            2), // changes position of shadow
                                                      ),
                                                    ],
                                                  ),
                                                  child: Icon(
                                                    Icons.delete,
                                                    color: Colors.white,
                                                    size: 14.r,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  15.verticalSpace
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
          ),
        ));
  }
}
