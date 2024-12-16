import 'package:app_fliplaptop/Apiserrvices/loader.dart';
import 'package:app_fliplaptop/Controller/faqController.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/accordion.dart';
import '../components/global.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  // final List faqList = [
  //   {
  //     'title': 'Can I use Apple Pay?',
  //     'content':
  //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris'
  //   },
  //   {
  //     'title': 'What is the refund policy?',
  //     'content':
  //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris'
  //   },
  //   {
  //     'title': 'Are my credit card details Secured?',
  //     'content':
  //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris'
  //   },
  //   {
  //     'title': 'Can I use Apple Pay?',
  //     'content':
  //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris'
  //   },
  //   {
  //     'title': 'What is the refund policy?',
  //     'content':
  //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris'
  //   },
  // ];

  @override
  Widget build(BuildContext context) {
    final faqController = Get.put(FAQController());
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
          'FAQ',
          style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
      body: Obx(() {
        return faqController.isLoading.value
            ? Center(
                child: Loader.spinkit,
              )
            : faqController.getFAQModel.value.data == null
                ? Center(
                    child: Text(
                      "No FAQs",
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.r, vertical: 20.r),
                    itemCount: faqController.getFAQModel.value.data!.length,
                    itemBuilder: (context, index) => Column(
                      children: [
                        Accordion(
                            title: faqController
                                .getFAQModel.value.data![index].question,
                            content: faqController
                                .getFAQModel.value.data![index].answer),
                        20.verticalSpace,
                        index != 4
                            ? DottedLine(
                                dashColor: highlightedText,
                                dashGapLength: 1.3,
                                lineThickness: 0.1,
                              )
                            : Container(),
                        20.verticalSpace
                      ],
                    ),
                  );
      }),
    );
  }
}
