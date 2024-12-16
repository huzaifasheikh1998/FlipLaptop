import 'dart:io';

import 'package:app_fliplaptop/Apiserrvices/Services.dart';
import 'package:app_fliplaptop/Screens/LoginScreen.dart';
import 'package:app_fliplaptop/models/wishListModel.dart';
import 'package:app_fliplaptop/res/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishListController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    getWishList();
    // getWishListStatus("126");
    super.onInit();
  }

  RxBool isWishList = false.obs;
  RxBool isLoading = false.obs;
  var wishListInstance = WishListModel().obs;
  var wishListCompleteData = WishListModel().obs;
  RxList<WishListItem> wishList = <WishListItem>[].obs;

  // bool? getWishListStatus(String productID) {
  //   bool result;
  //   for (var i in wishListCompleteData.value.data!) {
  //     result = true;
  //     if (i.id.toString() == productID) {
  //       return true;
  //     } else {
  //       result = false;
  //       return false;
  //     }
  //   }
  //   // return result;
  // }

  Future<WishListModel?> postWishListItem(String productID, context) async {
    try {
      isLoading.value = true;
      var result = await ApiServices().postWishList(productID);
      wishListInstance.value = result;
      if (result.status.toString() == "true") {
        getWishList();
        Utils.showSnack("Product Added to wishlist", context);
      } else {
        Get.snackbar(
          'Error',
          result.message.toString(),
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
        );
      }
      if (result.data!.isNotEmpty) {
        wishList.value = result.data!;
      }
      isLoading.value = false;
      return wishListInstance.value;
    } on SocketException {
      isLoading.value = false;
      Get.snackbar('Error', "Internet Connection Not Available!",
          snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    }
    return wishListInstance.value;
  }

  Future<WishListModel?> getWishList() async {
    try {
      isLoading.value = true;
      var result = await ApiServices().getWishList();
      if (result.status.toString() == "true") {
        wishListCompleteData.value = result;
      } else {
        if (result.message!.contains("Unauthenticated access")) {
          Get.offAll(() => LoginScreen());
        }
        Get.snackbar(
          'Error',
          result.message.toString(),
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
        );
      }
      isLoading.value = false;
      return wishListCompleteData.value;
    } on SocketException {
      isLoading.value = false;
      Get.snackbar('Error', "Internet Connection Not Available!",
          snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    }
    return wishListCompleteData.value;
  }

  Future<WishListModel?> removeWishList(String productID) async {
    try {
      isLoading.value = true;
      var result = await ApiServices().removeWishList(productID);
      if (result.status.toString() == "true") {
        ///removing the wishlist item from the list

        wishListCompleteData.value.data!
            .removeWhere((element) => element.id.toString() == productID);
        Get.snackbar(
          'Success',
          "Product removed from wishlist",
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: Colors.green,
        );
      } else {
        Get.snackbar(
          'Error',
          result.message.toString(),
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
        );
      }
      isLoading.value = false;
      return wishListCompleteData.value;
    } on SocketException {
      isLoading.value = false;
      Get.snackbar('Error', "Internet Connection Not Available!",
          snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    }
    return wishListCompleteData.value;
  }
}
