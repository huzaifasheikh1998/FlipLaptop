import 'dart:convert';
import 'dart:io';

import 'package:app_fliplaptop/Apiserrvices/Services.dart';
import 'package:app_fliplaptop/Screens/OrderConfirmation.dart';
import 'package:app_fliplaptop/models/paymentCardModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentCardController extends GetxController {
  /// called when controller is initialized
  @override
  void onInit() {
    getAllPaymentCards();
    // TODO: implement onInit
    super.onInit();
  }

  /// contains all the cards which would be in the account
  RxList<CardModel> completeDataList = <CardModel>[].obs;

  /// to handle the laoding state of the screen
  RxBool isLoading = false.obs;

  /// for performing UD and make as default operations
  RxBool isSelected = false.obs;
  RxString isSelectedCardNumber = "".obs;
  RxString isSelectedCardName = "".obs;

  RxString stripeUrl = "".obs;

  /// this is the id which we get from API in id field
  RxString cardModelID = "".obs;

  /// when tapped on radio button this variable value changes, would be used to hit API.
  var confirmCardModel = CardModel().obs;

  /// when posted the data this is added to the completeDataList
  var postDataModel = CardModel().obs;

  /// default card model
  var defaultCardModel = CardModel().obs;


  /// when editted the data this is added to the completeDataList
  var editCardModel = CardModel().obs;
  var editDataCardModel = CardModel().obs;

  /// getting all the Payments
  Future<List<CardModel>?> getAllPaymentCards() async {
    try {
      isLoading.value = true;
      var result = await ApiServices().getPaymentCards();
      // isLoading.value = false;
      if (result!.isNotEmpty) {
        completeDataList.clear();
        completeDataList.value = result;
        confirmCardModel.value.cardNumber = completeDataList[0].cardNumber;
        /// finding the index of the element which is having set as default == yes
        var indexOfDefault = completeDataList
            .indexWhere((element) => element.setAsDefault.toString() == "yes");
        /// it will be -1 if not found in the list else the value would be updated
        if (indexOfDefault != -1) {
          cardModelID.value = completeDataList[indexOfDefault].id!;
              defaultCardModel.value = completeDataList[indexOfDefault];
        }
        completeDataList.refresh();
        isLoading.value = false;
        return completeDataList;
      } else {
        completeDataList.clear();
        isLoading.value = false;
        return completeDataList;
      }
    } on SocketException {
      isLoading.value = false;
      Get.snackbar('Error', "Internet Connection Not Avaiable!",
          snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    } on Exception {
      isLoading.value = false;
      // Get.snackbar('Error', "No Data Found",
      //     snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    } catch (e) {
      isLoading.value = false;
      // Get.snackbar('Error', e.toString(),
      //     snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    }
    return completeDataList;
  }

  /// posting of Payment Card
  Future<CardModel?> postPaymentCard(CardModel postData) async {
    try {
      isLoading.value = true;
      var result = await ApiServices().postPaymentCard(postData);
      // isLoading.value = false;
      // if (result!.cardNumber!.isNotEmpty) {
      //   // postDataModel.value=null;
      if (result != null) {
        postDataModel.value = result;
        // completeDataList.add(result);
        await getAllPaymentCards();
        // completeDataList.add(postDataModel.value);
        completeDataList.refresh();
        // completeDataList.value = result!;
        isLoading.value = false;
        return postDataModel.value;
      } else {
        isLoading.value = false;
      }
      // }
    } on SocketException {
      isLoading.value = false;
      Get.snackbar('Error', "Internet Connection Not Available!",
          snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    }
    // catch (e) {
    //   isLoading.value = false;
    //   Get.snackbar('Error', e.toString(),
    //       snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    // }
    return postDataModel.value;
  }

  /// editing the Payment Card
  Future<CardModel?> editPaymentCard(CardModel postData) async {
    try {
      isLoading.value = true;
      var result = await ApiServices().editPaymentCard(postData);
      // isLoading.value = false;
      // if (result!.cardNumber!.isNotEmpty) {
      //   // postDataModel.value=null;
      if (result != null) {
        editDataCardModel.value = result;
        await getAllPaymentCards();
        // completeDataList.add(postDataModel.value);
        completeDataList.refresh();
        // completeDataList.value = result!;
        isLoading.value = false;
        return editDataCardModel.value;
      } else {
        isLoading.value = false;
      }
      // }
    } on SocketException {
      isLoading.value = false;
      Get.snackbar('Error', "Internet Connection Not Available!",
          snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    }
    catch (e) {
      isLoading.value = false;
      // Get.snackbar('Error', e.toString(),
      //     snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    }
    return editDataCardModel.value;
  }

  /// deleting the payment Card
  Future<CardModel?> deletePaymentCard(String cardID) async {
    try {
      isLoading.value = true;
      await ApiServices().deletePaymentCard(cardID);
      await getAllPaymentCards();
      Get.snackbar(
        'Success',
        "Payment method deleted",
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: Colors.green,
      );
      isSelected.value = false;
      completeDataList.refresh();
      isLoading.value = false;
      return postDataModel.value;
      // }
    } on SocketException {
      isLoading.value = false;
      Get.snackbar('Error', "Internet Connection Not Available!",
          snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    } on Exception {
      isLoading.value = false;
      // Get.snackbar('Error', "No Data Found",
      //     snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    } catch (e) {
      isLoading.value = false;
      // Get.snackbar('Error', e.toString(),
      //     snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    }
    return postDataModel.value;
  }

  /// setting payment card as default
  Future<CardModel?> cardSetAsDefault(String cardID, bool fromSubscription, bool fromProfile) async {
    try {
      isLoading.value = true;
      var result = await ApiServices().cardSetAsDefault(cardID);
      defaultCardModel.value =  result!;
      await getAllPaymentCards();
      Get.snackbar(
        'Success',
        "Card Set to Default",
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: Colors.green,
      );
      fromSubscription?Get.close(1):
      fromProfile?Get.close(1):Get.off(() => OrderConfirmation());

      isSelected.value = false;
      completeDataList.refresh();
      isLoading.value = false;
      return defaultCardModel.value;
      // }
    } on SocketException {
      isLoading.value = false;
      Get.snackbar('Error', "Internet Connection Not Available!",
          snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    } on Exception {
      isLoading.value = false;
      // Get.snackbar('Error', "No Data Found",
      //     snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    } catch (e) {
      isLoading.value = false;
      // Get.snackbar('Error', e.toString(),
      //     snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    }
    return defaultCardModel.value;
  }

  /// for connecting stripe
  Future<String> stripeConnect() async {
    try {
      isLoading.value = true;
      var data = await ApiServices().stripeConnect();
      print(data);
      jsonDecode(data);
       // jsonDecode(data)["data"]= stripeUrl;
       print("=========> Stripe Url is");
      // getAllPaymentCards();
      Get.snackbar(
        'Success',
        "Deleted Payment",
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: Colors.green,
      );
      // isSelected.value = false;
      // completeDataList.refresh();
      isLoading.value = false;
      return stripeUrl.value;
      // }
    } on SocketException {
      isLoading.value = false;
      Get.snackbar('Error', "Internet Connection Not Available!",
          snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    } on Exception {
      isLoading.value = false;
      // Get.snackbar('Error', "No Data Found",
      //     snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    } catch (e) {
      isLoading.value = false;
      // Get.snackbar('Error', e.toString(),
      //     snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    }
    return stripeUrl.value;
  }

}
