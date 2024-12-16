import 'dart:developer';
import 'dart:io';

import 'package:app_fliplaptop/Apiserrvices/Services.dart';
import 'package:app_fliplaptop/Screens/MyStoreProfileScreen.dart';
import 'package:app_fliplaptop/models/reviewModel.dart';
import 'package:app_fliplaptop/models/storeReviewModel.dart';
import 'package:app_fliplaptop/res/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ReviewController extends GetxController {
  RxList<String> reviewImageList = <String>[].obs;
  late File imageFile;
  RxBool isLoading = false.obs;
  RxList<ReviewDatum> reviewsList = <ReviewDatum>[].obs;
  RxList<StoreReview> storeReviewsList = <StoreReview>[].obs;
  Rx<TextEditingController> reviewDescription = TextEditingController().obs;

  // this is the variable which we will use to store the data, when we are
  // creating review
  Rx<ReviewDatum> reviewInstance = ReviewDatum().obs;
  // Rx<String> productIDInstance = "".obs;

  // image picker from gallery implemented
  getImageFromGallery() async {
    // List<ImageSo> list = [ImageSource.gallery,ImageSource.gallery];
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      if (!reviewImageList.contains(pickedFile.path)) {
        print("Doesnot caontain");
        reviewImageList.add(pickedFile.path);
        print(reviewImageList);
        // addProductController.incrementCounter();
        // setState(() {
        imageFile = File(pickedFile.path);
        update();
        // });
      }
    }
  }

  // creating review
  Future<ReviewDatum> createReview(
    BuildContext context,
    String productID,
    String description,
    String rating,
    List imageList,
  ) async {
    try {
      isLoading.value = true;
      var result = await ApiServices().createReview(
        productID,
        description,
        rating,
        imageList,
      );
      if (result.status.toString() == "true") {
        if (result.data != null) {
          reviewInstance.value = result.data!;
          Get.back();
          log("Review Added with id" + reviewInstance.value.id!);
          // reviewsList.add(reviewInstance.value);
          Utils.ReviewSubmitDialog(context);

          reviewImageList.clear();
          reviewDescription.value.clear();
        }
        isLoading.value = false;

      } else {
        Utils.showFloatingErrorSnack(result.message ?? "Something Went Wrong!");
        isLoading.value = false;
      }
      return reviewInstance.value;
    } on SocketException {
      isLoading.value = false;
      Utils.showFloatingErrorSnack("Check your Internet Connection");
    }
    // catch (e) {
    //   isLoading.value = false;
    //   Get.snackbar('Error', e.toString(),
    //       snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    // }
    return reviewInstance.value;
  }


  Future<List<ReviewDatum>> getMyReviews(
      ) async {
    try {
      isLoading.value = true;
      var result = await ApiServices().getMyReviews(
        // productID,
        // description,
        // rating,
        // imageList,
      );
      if (result.status.toString() == "true") {
        if (result.data != null) {
          reviewsList.clear();
          reviewsList.value = result.data!;
          // Get.back();
        }
        isLoading.value = false;

      } else {
        Utils.showFloatingErrorSnack(result.message ?? "Something Went Wrong!");
        isLoading.value = false;
      }
      return reviewsList;
    } on SocketException {
      isLoading.value = false;
      Utils.showFloatingErrorSnack("Check your Internet Connection");
    }
    // catch (e) {
    //   isLoading.value = false;
    //   Get.snackbar('Error', e.toString(),
    //       snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    // }
    return reviewsList;
  }



  Future<List<StoreReview>> getMyStoreReviews(
      ) async {
    try {
      isLoading.value = true;
      var result = await ApiServices().getMyStoreReviews(
      );
      if (result.status.toString() == "true") {
        if (result.data != []) {
          // reviewsList.clear();
          storeReviewsList.value = result.data;
          // Get.back();
        }
        isLoading.value = false;

      } else {
        Utils.showFloatingErrorSnack(result.message ?? "Something Went Wrong!");
        isLoading.value = false;
      }
      return storeReviewsList.value;
    } on SocketException {
      isLoading.value = false;
      Utils.showFloatingErrorSnack("Check your Internet Connection");
    }
    // catch (e) {
    //   isLoading.value = false;
    //   Get.snackbar('Error', e.toString(),
    //       snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    // }
    return storeReviewsList.value;
  }


  postReviewReply(String productID, String userID, String description, String parentId) async {
    try {
      isLoading.value = true;
      var result = await ApiServices().postReviewReply(productID, userID, description, parentId);
      if (result["status"].toString() == "true") {
        // await getMyStoreReviews();
        Get.offUntil(
          MaterialPageRoute(
              builder: (context) => MyStoreProfileScreen(
                storeId: ApiServices.storeId,
              )),
              (Route<dynamic> route) =>
          route.settings.name == "/MyStoreProfileScreen",
        );        Utils.showFloatingSuccessSnack("Review Reply has been submitted successfully");
        // if (result.data != []) {
        //   reviewsList.clear();
        //   storeReviewsList.value = result.data;
          // Get.back();
        // }
        isLoading.value = false;

      } else {
        Utils.showFloatingErrorSnack(result.message ?? "Something Went Wrong!");
        isLoading.value = false;
      }
      // return storeReviewsList.value;
    } on SocketException {
      isLoading.value = false;
      Utils.showFloatingErrorSnack("Check your Internet Connection");
    }
    // catch (e) {
    //   isLoading.value = false;
    //   Get.snackbar('Error', e.toString(),
    //       snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    // }
    // return storeReviewsList.value;
  }

}
