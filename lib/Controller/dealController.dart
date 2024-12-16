import 'dart:io';

import 'package:app_fliplaptop/Apiserrvices/Services.dart';
import 'package:app_fliplaptop/Screens/MyStoreProfileScreen.dart';
import 'package:app_fliplaptop/models/dealModel.dart';
import 'package:app_fliplaptop/res/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DealController extends GetxController {
  @override
  void onInit() {
    // getting the deal indexes
    getDealIndexes();
    super.onInit();
  }

  RxList<DealIndex> listOfDealIndex = <DealIndex>[].obs;
  Rx<DealData> dealDataInstance = DealData().obs;
  RxBool isLoading = false.obs;

  // RxBool isSelected = false.obs;
  RxString onTapIndexID = "".obs;
  RxString SelectedDealImageUrl = "".obs;

  updateOnTapIndexID(String indexID) {
    onTapIndexID.value = indexID;
    update();
  }

  Future<List<DealIndex>?> getDealIndexes() async {
    try {
      isLoading.value = true;
      update();
      var result = await ApiServices().getDealIndex();
      listOfDealIndex.value = result.data!;
      onTapIndexID.value = listOfDealIndex[0].id;
      isLoading.value = false;
      // update();
      return listOfDealIndex;
    } on SocketException {
      isLoading.value = false;
      update();
      Get.snackbar(
        'Error',
        "Internet Connection Not Available!",
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
      );
    } on Exception {
      isLoading.value = false;
      update();
      Get.snackbar(
        'Error',
        "No Data Found",
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
      );
    } catch (e) {
      isLoading.value = false;
      update();
      // Get.snackbar('Error', e.toString(),
      //     snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    }
    return listOfDealIndex;
  }

  Future<DealData> addDeal(
    String storeID,
    String dealID,
    String title,
    String description,
    String salePercentage,
    String startDateTime,
    String endDateTime,
  ) async {
    try {
      isLoading.value = true;
      update();
      var result = await ApiServices().createDeal(storeID, dealID, title,
          description, salePercentage, startDateTime, endDateTime);
      if (result.status == false) {
        Get.offUntil(
          MaterialPageRoute(
              builder: (context) => MyStoreProfileScreen(
                storeId: storeID,
              )),
              (Route<dynamic> route) =>
          route.settings.name == "/MyStoreProfileScreen",
        );
      } else {
        dealDataInstance.value = result.data!;
        Utils.showFloatingSuccessSnack("Deal Created Successfully");
        Get.offUntil(
          MaterialPageRoute(
              builder: (context) => MyStoreProfileScreen(
                storeId: storeID,
              )),
              (Route<dynamic> route) =>
          route.settings.name == "/MyStoreProfileScreen",
        );
      }
      // onTapIndexID.value = listOfDealIndex[0].id;
      isLoading.value = false;
      // update();
      return dealDataInstance.value;
    } on SocketException {
      isLoading.value = false;
      update();
      Get.snackbar(
        'Error',
        "Internet Connection Not Available!",
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
      );
    } on Exception {
      isLoading.value = false;
      update();
      Get.snackbar(
        'Error',
        "No Data Found",
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
      );
    } catch (e) {
      isLoading.value = false;
      update();
      // Get.snackbar('Error', e.toString(),
      //     snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    }
    return dealDataInstance.value;
  }
}
