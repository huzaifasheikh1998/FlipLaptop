import 'dart:developer';
import 'dart:io';

import 'package:app_fliplaptop/Apiserrvices/Services.dart';
import 'package:app_fliplaptop/models/filterModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/dashBoardModel.dart';

class FilterController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    // getAllFilters();
    super.onInit();
  }

  // @override
  // void onClose() {
  //   // TODO: implement onClose
  //   super.onClose();
  //   filteredData.value.clear();
  // }
  RxBool isLoading = false.obs;
  RxBool isApplyingFilters = false.obs;

  // var ListOfBrands = ['Dell', 'Hp', 'Acer', 'Apple', 'Lenovo'].obs;
  var ListOfBrands = [].obs;
  RxList<Datum> filteredData = <Datum>[].obs;
  var locationList = ['Downtown', 'Washington', 'Franklin', 'LA'].obs;
  var itemTypeList = [
    'Used',
    'New',
  ].obs;

  // var locationList = [].obs;

  // var sizeList = ['15-inch', '17-inch', '19-inch'].obs;
  var sizeList = [].obs;
  var lowerValue = 0.0.obs;
  var upperValue = 10000.0.obs;
  Map<String, dynamic> queryParameters = {};
  AllFiltersData completeFilterData = AllFiltersData();

  removeItemList1(i) {
    ListOfBrands.remove(ListOfBrands[i]);
    log("lentgh of brand" + ListOfBrands.length.toString());
    // update();
  }

  removeItemType(i) {
    itemTypeList.remove(itemTypeList[i]);
    // update();
  }

  removeItemList2(i) {
    locationList.remove(locationList[i]);
    // update();
  }

  void updateQueryParamter(Map<String, dynamic> map) {
    queryParameters = map;
    update();
  }

  removeItemList3(i) {
    sizeList.remove(sizeList[i]);
    // update();
  }

  Future<AllFiltersData?> getAllFilters() async {
    try {
      isLoading.value = true;
      update();
      var result = await ApiServices().getFilters();
      completeFilterData = result.data!;
      ListOfBrands.value = result.data!.brand!;
      sizeList.value = result.data!.displaySize!;
      isLoading.value = false;
      update();
      return completeFilterData;
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
      // Get.snackbar(
      //   'Error',
      //   "No Data Found",
      //   snackPosition: SnackPosition.BOTTOM,
      //   colorText: Colors.white,
      // );
    } catch (e) {
      isLoading.value = false;
      update();
      // Get.snackbar('Error', e.toString(),
      //     snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    }
    return completeFilterData;
  }

  Future<List<Datum>> brandFilter(String brandID) async {
    try {
      isLoading.value = true;
      // update();
      var result = await ApiServices().searchBrands(brandID);
      if (result.status.toString() == "true") {
        filteredData.value = result.data!;
        // isLoading.value = false;
      } else {
        filteredData.value = [];
        // isLoading.value = false;
      }
      // completeFilterData = result.data!;
      // ListOfBrands.value = result.data!.brand!;
      // sizeList.value = result.data!.displaySize!;
      isLoading.value = false;
      // update();
      return filteredData.value;
    } on SocketException {
      isLoading.value = false;
      // update();
      Get.snackbar(
        'Error',
        "Internet Connection Not Available!",
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
      );
    } catch (e) {
      isLoading.value = false;
      log("message" + e.toString());
      // update();
      // Get.snackbar('Error', e.toString(),
      //     snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    }
    return filteredData.value;
  }
}
