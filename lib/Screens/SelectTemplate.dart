import 'package:app_fliplaptop/Apiserrvices/app_url.dart';
import 'package:app_fliplaptop/Apiserrvices/loader.dart';
import 'package:app_fliplaptop/Controller/dealController.dart';
import 'package:app_fliplaptop/components/customNetworkImage.dart';
import 'package:app_fliplaptop/components/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectTemplateScreen extends StatefulWidget {
  SelectTemplateScreen({super.key});

  @override
  State<SelectTemplateScreen> createState() => _SelectTemplateScreenState();
}

class _SelectTemplateScreenState extends State<SelectTemplateScreen> {
  // List dealBannerList = [
  final DealController dealController = Get.put(DealController());

  @override
  Widget build(BuildContext context) {
    final DealController dealController = Get.put(DealController());

    return Scaffold(
      backgroundColor: kPageBgColor,
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
          'Select Template',
          style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 20.r),
        child:
            button2(388.w, 59.h, 'Next', () => Get.toNamed('/AddTextScreen')),
      ),
      body: Obx(() {
        return dealController.isLoading.value
            ? Center(
                child: Loader.spinkit,
              )
            : dealController.listOfDealIndex.length==0?Center(child: Text("No Deals Found"),):
        ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 10.r),
                shrinkWrap: true,
                itemCount: dealController.listOfDealIndex.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                dealController.updateOnTapIndexID(
                                    dealController.listOfDealIndex[index].id);
                              });
                            },
                            child: Container(
                              width: Get.width,
                              height: 226.h,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      blurRadius: 10,
                                      spreadRadius: 0.4)
                                ],
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child:
                                  // Image.network(ImageUrls.dealUrl +
                                  //     dealController.listOfDealIndex[index].image)
                                  ClipRRect(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    10.sp,
                                  ),
                                ),
                                child: CustomNetworkImage(
                                  imageUrl: ImageUrls.dealUrl +
                                      dealController
                                          .listOfDealIndex[index].image,
                                ),
                              ),
                            ),
                          ),
                          20.verticalSpace
                        ],
                      ),
                      dealController.onTapIndexID.value ==
                              dealController.listOfDealIndex[index].id
                          ? Positioned(
                              right: 20,
                              top: 30,
                              child: Container(
                                padding: EdgeInsets.all(5.r),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: kgradient,
                                ),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 15,
                                ),
                              ),
                            )
                          : Container()
                    ],
                  );
                },
              );
      }),
    );
  }
}

// dealBannerList[index]['isActive']
//     ? Positioned(
//         right: 20,
//         top: 30,
//         child: Container(
//           padding: EdgeInsets.all(5.r),
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             gradient: kgradient,
//           ),
//           child: Icon(
//             Icons.check,
//             color: Colors.white,
//             size: 15,
//           ),
//         ),
//       )
//     : Container()
