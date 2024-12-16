// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// class AddProductImage extends StatelessWidget {
//   final String imagePath;
//   const AddProductImage({super.key,required this.imagePath});

//   @override
//   Widget build(BuildContext context) {
//     return     Row(
//       children: [
//         InkWell(
//                       onTap: () {},
//                       child: Container(
//                         // margin: EdgeInsets.only(right: 10.horizontalSpace,),
//                         width: Get.width * 0.2,
//                         alignment: Alignment.center,
//                         height: 83.h,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10.r),
//                             image: DecorationImage(
//                                 image:FileImage(File(imagePath)),
//                                 //  AssetImage(
//                                 //     'assets/andras-vas-Bd7gNnWJBkU-unsplash.png'),
//                                 fit: BoxFit.cover)
//                                 ),
//                         child: Image.asset(
//                           'assets/Icon ionic-ios-close-circle.png',
//                           color: Colors.white,
//                           scale: 1.4,
//                         ),
//                       ),
//                     ),
//                     10.horizontalSpace,
//       ],
//     );

//   }
// }
