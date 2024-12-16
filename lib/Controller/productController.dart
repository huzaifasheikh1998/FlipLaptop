import 'dart:developer';
import 'dart:io';

import 'package:app_fliplaptop/Apiserrvices/Services.dart';
import 'package:app_fliplaptop/models/dashBoardModel.dart' as dash;
import 'package:app_fliplaptop/models/product_listing_data_model/deleteProduct.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/dashBoardModel.dart';
import '../models/my_store_profile_data_model/product.dart' as prod;
import '../models/product_listing_data_model/product_listing_data_model.dart'
    as PL;


class ProductController extends GetxController {
  RxList<PL.ProductListingDataModel> productListingDataList =
      <PL.ProductListingDataModel>[].obs;
  RxList<dash.ProductImage> myProductImageList = <dash.ProductImage>[].obs;

  var editDatumInstance = Datum().obs;
  var editProductInstance = prod.Product().obs;
  RxList<dash.ProductImage> deletedExistingImageList = <dash.ProductImage>[].obs;


  RxBool isVisibile = false.obs;
  RxBool isLoading = false.obs;

  // bool switchValue = false;

  void handleSwitchValueChanged(bool value) {
    // setState(() {
    isVisibile.value = value;
    // });
  }

  var counter = 0;

// Map<String,dynamic> addproductModel = {
//   // "store_id" : "",
//   // "name" : "",
//   // "price" : "",
//   // "qty" : ""
// };
  var addProductDiscountIns = ProductSingle().obs;
  Map<String, dynamic> addproductApiModel = {};

  void incrementCounter() {
    counter++;
    // This will reload the container when the counter variable is updated
    update();
  }

  Future<ProductSingle?> editProductDiscount(
    int productID,
    String discountName,
    String discountType,
    String startDateTime,
    String endDateTime,
    String perTarget,
    String price,
  ) async {
    try {
      isLoading.value = true;
      var result = await ApiServices().editProductDiscount(
          productID,
          discountName,
          discountType,
          startDateTime,
          endDateTime,
          perTarget,
          price);
      addProductDiscountIns.value = result!;
      if (result.status.toString() == "true") {
        log(addProductDiscountIns.value.data.toString());
        // getWishList();
        // Utils.showSnack("Product Added to Wishlist", context);
        // Get.snackbar(
        //   'Success',
        //   "Added to WishList",
        //   snackPosition: SnackPosition.TOP,
        //   colorText: Colors.white,
        //   backgroundColor: Colors.green,
        // );
      } else {
        Get.snackbar(
          'Error',
          result.message.toString(),
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
        );
      }
      // isLoading.value = false;
      // if (result!.cardNumber!.isNotEmpty) {
      //   // postDataModel.value=null;
      // if (result.data!.isNotEmpty) {
      //   wishList.value = result.data!;
      // }
      // getAllPaymentCards();
      // completeDataList.add(postDataModel.value);
      // completeDataList.refresh();
      // completeDataList.value = result!;
      isLoading.value = false;
      return addProductDiscountIns.value;
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
    return addProductDiscountIns.value;
  }
}

// class AddProductDataModel {
//  static String ff = "0";
// static Map<
//   srtff(String value){
//     ff = value;
//   }

// }
