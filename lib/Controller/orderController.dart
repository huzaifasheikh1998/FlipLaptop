import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:app_fliplaptop/Apiserrvices/Services.dart';
import 'package:app_fliplaptop/Apiserrvices/localStorage.dart';
import 'package:app_fliplaptop/Screens/ListOfProduct.dart';
import 'package:app_fliplaptop/models/dashBoardModel.dart';
import 'package:app_fliplaptop/models/orderModel.dart';
import 'package:app_fliplaptop/models/purchaseListModel.dart';
import 'package:app_fliplaptop/models/purchaseModel.dart';
import 'package:app_fliplaptop/models/sellOrderModel.dart';
import 'package:app_fliplaptop/res/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'reviewController.dart';

class OrderController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    initial();
    super.onInit();
  }

  initial() async {
    await saveCartListFromStorage();
    await getSellerList(ApiServices.storeId);
    await getPurchaseList();
  }

  /// this is the default quantity of the product added in cartList
  var count = 1.obs;

  var tab = 0.obs;

  // for handling loading state
  RxBool isLoading = false.obs;



  // when we create order it returns data, that data is saved in this variable
  var postOrderData = OrderData().obs;

  // this is the list of the order data
  RxList<SellerData> sellerOrderList = <SellerData>[].obs;

  // these are the sublist made for seller order screens
  RxList<SellerData> newSellerOrderList = <SellerData>[].obs;
  RxList<SellerData> inProgressSellerOrderList = <SellerData>[].obs;
  RxList<SellerData> completedSellerOrderList = <SellerData>[].obs;

  // this is the main purchase order list
  RxList<PurchaseData> purchaseOrderList = <PurchaseData>[].obs;

  // these are the sublist made for purchase order screens
  RxList<PurchaseData> newPurchaseOrderList = <PurchaseData>[].obs;
  RxList<PurchaseData> inProgressPurchaseOrderList = <PurchaseData>[].obs;
  RxList<PurchaseData> completedPurchaseOrderList = <PurchaseData>[].obs;
  RxList<Datum> toBeReviewedPurchaseOrderList = <Datum>[].obs;
  RxInt toBeReviewedCount = 0.obs;

  add() {
    count.value++;
    update();
  }

  minus() {
    if (count != 1) count.value--;
    update();
  }

  /// this is the cartList, which contains all the products
  /// with their quantities
  RxList<CartItem> cartList = <CartItem>[].obs;

  // getting the cartList from local storage and then adding it in the cartList
  saveCartListFromStorage() async {
    var cart = await LocalStorage.readJson(key: LocalStorageKeys.cartList);
    if (cart != null) {
      List<dynamic> list = jsonDecode(cart);
      log(list.toString());
      list.forEach((element) {
        Map<String, dynamic> newMap = element["datum"];
        log("================? datum element" + newMap.toString());
        cartList.add(
          CartItem(
            datum: Datum.fromJson(newMap),
            quantity: element["quantity"],
          ),
        );
      });
      // cartList.value = list;
    }
    log("By default the list is " + cart.toString());
  }

  /// this is the data instance which is used to add the list
  /// of datum to add in the cart with default quantity 1
  var datumInstance = Datum().obs;
  RxDouble totalTax = 0.0.obs;
  RxDouble totalTaxAmount = 0.0.obs;

  /// this function is made to calculate the overall price of the items
  /// according to the quantity in the cartList made above
  totalSumOfCartProductsPrices(index) {
    //initial total price is 0
    totalPrice.value = 0.0;
    totalTax.value = 0.0;
    totalTaxAmount.value = 0.0;

    // running a for loop on cartList and calculate the price of
    // the products in list
    for (var i = 0; i < cartList.length; i++) {
      // shipping cost according to the quantity
      // int shippingCost = cartList[i].datum.shippingCost == ""
      //     ? 0
      //     : int.parse(cartList[i].datum.shippingCost!) *
      //         ((cartList[i].quantity.toInt()));

      // product quantity of the product present in the cart
      int productQuantity = ((cartList[i].quantity.toInt())) ?? 0;
      log("datum discount" + cartList[i].datum.discount.toString());
      log("deal price" + cartList[i].datum.dealItemPrice.toString());
      // total price of the product
      // int productPrice() {
      //   // (cartList[i].datum.discount.toString() != "null")
      //   //     ? int.parse(cartList[i].datum.discount!.price)
      //   //     :
      //   if(cartList[i].datum.dealItemPrice == "" && cartList[i].datum.discount.toString() == "null"){
      //     return cartList[i].datum.price!.toInt();
      //   }
      //   else if(cartList[i].datum.dealItemPrice == "" && cartList[i].datum.discount.toString() != "null"){
      //     return int.parse(cartList[i].datum.discount!.price);
      //   }
      //   else {
      //     return int.parse(cartList[i].datum.dealItemPrice ?? "");
      //   }

      double productPrice =
          // (cartList[i].datum.discount.toString() != "null")
          //     ? int.parse(cartList[i].datum.discount!.price)
          //     :
          (cartList[i].datum.dealItemPrice == ""
                  ?((cartList[i].datum.discount.toString() != "null")
                      ? double.parse(cartList[i].datum.discount!.price??"")
                      : double.parse(cartList[i].datum.price!.toString()))
                  : ((cartList[i].datum.discount.toString() != "null" && cartList[i].datum.dealItemPrice == "")
                      ? double.parse(cartList[i].datum.discount!.price.toString()??"") ?? 0
                      : double.parse(cartList[i].datum.dealItemPrice??""))) ??
              0;
      log("tax value" + cartList[i].datum.tax.toString());
      totalTax.value = totalTax.value +
          double.parse(
              (cartList[i].datum.tax == "" ? 0 : (cartList[i].datum.tax ?? 0))
                  .toString());

      log("productPRice is" + productPrice.toString());
      // log("tax valuew is" + productPrice.toString());
      // finally summing up all the things
      var individualTax =
          (productPrice * (double.parse(cartList[i].datum.tax.toString()) / 100))*cartList[i].quantity.toInt();
      var totalProductPrice = (productPrice * productQuantity) + individualTax
          // + (cartList[i].datum.tax==""?0:int.parse(cartList[i].datum.tax??""))
          ;
      // update the variables
      update();
      print("total Product price is ============>$totalProductPrice");
      print("total controller qty is ============>$productQuantity");
      totalTaxAmount.value += individualTax;
      print("total tax amount  is ============>${double.parse(totalTaxAmount.value.toStringAsFixed(4))}");
      totalPrice.value += (double.parse(totalProductPrice.toString()));
      print("====================>>>> $totalPrice");
      // totalPrice.value = totalPrice.value-totalTaxAmount.value;
    }
  }

  /// variables for the price calculations for the items in the cart
  RxDouble totalPrice = 0.0.obs;

  /// this is kept static would be discussed later on
  // RxDouble taxAmount = 2.5.obs;
  final reviewController = Get.put(ReviewController());

  separationSellerLists() {
    newSellerOrderList.clear();
    inProgressSellerOrderList.clear();
    completedSellerOrderList.clear();
    for (var i = 0; i < sellerOrderList.length; i++) {
      log("============>" +
          sellerOrderList[i].product!.first.orderProductStatus.toString());
      // if (sellerOrderList[i].orderStatus != "") {
      switch (
          sellerOrderList[i].product!.first.orderProductStatus.toString().toLowerCase()) {
        case "new":
          newSellerOrderList.add(sellerOrderList[i]);
          newSellerOrderList.refresh();
          break;

        case "inprogress":
          inProgressSellerOrderList.add((sellerOrderList[i]));
          inProgressSellerOrderList.refresh();
          break;

        case "completed":
          completedSellerOrderList.add((sellerOrderList[i]));
          completedSellerOrderList.refresh();
          break;
        default:
          print('Unknown type.');
        // }
      }
    }
  }

  separationPurchaseLists() {
    newPurchaseOrderList.clear();
    inProgressPurchaseOrderList.clear();
    completedPurchaseOrderList.clear();
    toBeReviewedPurchaseOrderList.clear();
    for (var i = 0; i < purchaseOrderList.length; i++) {
      log("============>" +
          purchaseOrderList[i].orderItem.first.orderItemStatus);
      // if (sellerOrderList[i].orderStatus != "") {
      switch (
          purchaseOrderList[i].orderItem.first.orderItemStatus.toLowerCase()) {
        case "new":
          newPurchaseOrderList.add(purchaseOrderList[i]);
          newPurchaseOrderList.refresh();
          break;

        case "inprogress":
          inProgressPurchaseOrderList.add((purchaseOrderList[i]));
          inProgressPurchaseOrderList.refresh();
          break;

        case "completed":
          completedPurchaseOrderList.add((purchaseOrderList[i]));
          completedPurchaseOrderList.refresh();
          break;
        default:
          print('Unknown type.');
        // }
      }
    }
    log("============>new" + newPurchaseOrderList.length.toString());
    log("============>progress" +
        inProgressPurchaseOrderList.length.toString());
    log("============>complete" + completedPurchaseOrderList.length.toString());
  }

// RxDouble taxOrderPrice = 0.0.obs;

  // for creating order
  Future<OrderData?> createOrder(
      String cardID,
      String addressID,
      String totalAmount,
      String paymentType,
      List<CartItem> orderList,
      BuildContext context) async {
    try {
      isLoading.value = true;
      // saving the create order response in the "result" variable.
      var result = await ApiServices()
          .createOrder(cardID, addressID, totalAmount, paymentType, orderList);

      // if the status of API is true
      if (result.status.toString() == "true") {
        // make the postOrderData variable value equal to the data present in
        // the result
        Utils.OrderConfirmationPopup(context);
        count.value =1;
        cartList.clear();

        LocalStorage.deleteJson(key: LocalStorageKeys.cartList);
        // cartList.refresh();
        postOrderData.value = result.data!;
      } else {
        Utils.showFloatingErrorSnack(result.message!);
      }
      isLoading.value = false;
      return postOrderData.value;
    } on SocketException {
      isLoading.value = false;
      Utils.showFloatingErrorSnack("Internet Connection Not Available!");
    } catch (e) {
      isLoading.value = false;
      // Get.snackbar('Error', e.toString(),
      //     snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    }
    return postOrderData.value;
  }

  Future<List<SellerData>> getSellerList(
    String storeID,
  ) async {
    // try {
      isLoading.value = true;
      // saving the create order response in the "result" variable.
      var result = await ApiServices().getSellList(storeID);
      // sellerOrderList.value = result.data!;

      // if the status of API is true
      if (result.status.toString() == "true") {
        // make the sellerList variable value equal to the data present in
        // the result
        // sellerOrderList.clear();
        sellerOrderList.value = result.data!;
        // sellerOrderList.refresh();
        log("seller Order list is of length ${sellerOrderList.length}");
        if (sellerOrderList.isNotEmpty) {
          separationSellerLists();
        }
        isLoading.value = false;
      } else {
        isLoading.value = false;
        // Utils.showFloatingErrorSnack(result.message!);
      }
      isLoading.value = false;
      return sellerOrderList;
    // } on SocketException {
    //   isLoading.value = false;
    //   Utils.showFloatingErrorSnack("Internet Connection Not Available!");
    // } catch (e) {
    //   isLoading.value = false;
    //   // Get.snackbar('Error', e.toString(),
    //   //     snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    // }
    return sellerOrderList;
  }

  Future<List<PurchaseData>> getPurchaseList() async {
    // try {
      isLoading.value = true;
      purchaseOrderList.clear();
      newPurchaseOrderList.clear();
      inProgressPurchaseOrderList.clear();
      completedPurchaseOrderList.clear();
      // saving the create order response in the "result" variable.
      var result = await ApiServices().getPurchaseList();
      // sellerOrderList.value = result.data!;

      // if the status of API is true
      if (result.status.toString() == "true") {
        // make the sellerList variable value equal to the data present in
        // the result
        purchaseOrderList.value = result.data ?? [];
        log("purchase Order list is of length ${purchaseOrderList.length}");
        if (purchaseOrderList.isNotEmpty) {
          separationPurchaseLists();
        }
        isLoading.value = false;
      } else {
        Utils.showFloatingErrorSnack(result.message!);
      }
      isLoading.value = false;
      return purchaseOrderList;
    // } on SocketException {
    //   isLoading.value = false;
    //   Utils.showFloatingErrorSnack("Internet Connection Not Available!");
    // } catch (e) {
    //   isLoading.value = false;
    //   // Get.snackbar('Error', e.toString(),
    //   //     snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    // }
    // return purchaseOrderList;
  }

  changeOrderStatus(
      String orderID, String statusToBeChanged, BuildContext context) async {
    try {
      isLoading.value = true;
      await ApiServices()
          .changeOrderStatus(orderID, statusToBeChanged, context);
      // await getSellerList(ApiServices.storeId);
      // await ApiServices().getSellList(ApiServices.storeId);

      // await ApiServices().getSellList(ApiServices.storeId);

      // await ApiServices().getSellList(ApiServices.storeId);
      isLoading.value = false;
    } on SocketException {
      isLoading.value = false;
      Utils.showFloatingErrorSnack("Internet Connection Not Available!");
    } catch (e) {
      isLoading.value = false;
    }
  }
}
