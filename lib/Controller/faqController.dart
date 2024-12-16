import 'dart:io';

import 'package:app_fliplaptop/Apiserrvices/Services.dart';
import 'package:app_fliplaptop/models/faqModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FAQController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    getAllFAQs();
    super.onInit();
  }
  RxBool isLoading = false.obs;

  var getFAQModel = FaqModel().obs;

  Future<List<FAQItem>?> getAllFAQs() async {
    try {
      isLoading.value = true;
      var result = await ApiServices().getFaqs();
      if(result.status=="true") {
        getFAQModel.value = result;
        isLoading.value = false;
      }
      else{
      }
        return getFAQModel.value.data;
    } on SocketException {
      isLoading.value = false;
      Get.snackbar('Error', "Internet Connection Not Available!",
          snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    } on Exception {
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
    return getFAQModel.value.data;
  }

}