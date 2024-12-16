import 'dart:io';

import 'package:app_fliplaptop/Apiserrvices/Services.dart';
import 'package:app_fliplaptop/models/subscriptionModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubscriptionController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    getSubscriptions();
    super.onInit();
  }

  RxBool isLoading = false.obs;
  // RxBool isSelected = false.obs;
  RxString isSelectedID = "".obs;
  RxList<SubscriptionItem> subscriptionList = <SubscriptionItem>[].obs;

  Future<List<SubscriptionItem>?> getSubscriptions() async {
    try {
      isLoading.value = true;
      var result = await ApiServices().getSubscriptions();
      // isLoading.value = false;
      if (result.status.toString()=="true") {
        // completeDataList.clear();
        subscriptionList.value = result.data!;
        isLoading.value = false;
        return subscriptionList;
      } else {
        Get.snackbar('Error', result.message!,
            snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
        subscriptionList.clear();
        isLoading.value = false;
        return subscriptionList;
      }
    } on SocketException {
      isLoading.value = false;
      Get.snackbar('Error', "Internet Connection Not Avaiable!",
          snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    } on Exception {
      isLoading.value = false;
      Get.snackbar('Error', "No Data Found",
          snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    }
    return subscriptionList;
  }

}