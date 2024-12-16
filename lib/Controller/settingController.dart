import 'dart:io';

import 'package:app_fliplaptop/Apiserrvices/Services.dart';
import 'package:app_fliplaptop/Screens/LoginScreen.dart';
import 'package:app_fliplaptop/res/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  RxBool isStripeConnected = false.obs;
  RxBool isLoading = false.obs;

  deleteAccount() async {
    try {
      isLoading.value = true;
      var result = await ApiServices().deleteAccount();
      if (result["status"].toString() == "true") {
        Get.offAll(() => LoginScreen());
        Utils.showFloatingSuccessSnack(result["message"]);
      } else {
        Utils.showFloatingErrorSnack(result["message"]);
        Get.back();
      }
      isLoading.value = false;
    } on SocketException {
      isLoading.value = false;
      Get.snackbar('Error', "Internet Connection Not Avaiable!",
          snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    } on Exception {
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
  }
}
