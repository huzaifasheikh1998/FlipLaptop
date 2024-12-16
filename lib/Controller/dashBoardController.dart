import 'dart:developer';
import 'dart:io';
import 'package:app_fliplaptop/Apiserrvices/Services.dart';
import 'package:app_fliplaptop/Apiserrvices/localStorage.dart';
import 'package:app_fliplaptop/models/dashBoardModel.dart';
import 'package:app_fliplaptop/models/dashboard_filter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DashBoardController extends GetxController {
  /// called when controller is initialized
  @override
  void onInit() {
    getStoreIDFromLocal();
    getDashboardData();
    update();

    // TODO: implement onInit
    super.onInit();
  }

  RefreshController refreshController = RefreshController(initialRefresh: true);

  /// for handling loading state
  RxBool isLoading = false.obs;

  /// complete data fetched from dashboard API saved in this model
  var completeData = DashBoardModel().obs;

  /// brand List fetched from dashboard API saved in this list
  RxList<Brand> brandList = <Brand>[].obs;

  /// store List, arrival, more product, top ranking fetched
  /// from dashboard API saved in the variables
  RxList<Store> storeList = <Store>[].obs;
  var newArrival = Product().obs;
  var moreProduct = Product().obs;
  RxList<Datum> moreProductList = <Datum>[].obs;
  var topRankingProduct = Product().obs;

  RxString storeID = "".obs;

  bool isCurrentDateBetween(DateTime startDate, DateTime endDate) {
    DateTime currentDate = DateTime.now();
    return currentDate.isAfter(startDate) && currentDate.isBefore(endDate);
  }

  getStoreIDFromLocal() async {
    storeID.value =
        await LocalStorage.readJson(key: LocalStorageKeys.storeID.toString());
    log("store ID from local" + storeID.value);
    // log("stripe status"+stripeStatus);
  }

  /// getting the dashBoard data on HomeScreen
  Future<DashBoardModel> getDashboardData() async {
    // getUserData();
    try {
      /// making the loading state true to show spinkit loader
      isLoading.value = true;

      /// hitting the get dashboard API made in APIServices
      var result = await ApiServices().getDashBoardData();
      // await ApiServices().getUsersData(
      //     chatController.listOfUserIDs);
      /// making the controller values equals to the API data
      completeData.value = await result;
      brandList.value = result.data!.brand!;
      storeList.value = result.data!.store!;
      newArrival.value = result.data!.newArrivalProduct!;
      moreProduct.value = result.data!.moreProduct!;
      moreProductList.value = result.data!.moreProduct!.data!;
      topRankingProduct.value = result.data!.topRankingProduct!;

      log("store ID from APi services" + ApiServices.storeId);
      moreProductList.value.removeWhere((element) =>
          element.storeId == userController.user.value.store?.id ||
          element.user!.id.toString() == ApiServices.storeId);
      moreProduct.value.data!.removeWhere(
          (element) => element.storeId == userController.user.value.store?.id);
      storeList.value.removeWhere((element) =>
          element.id == userController.user.value.store?.id ||
          element.id.toString() == ApiServices.storeId);
      for (var i = 0; i < newArrival.value.data!.length; i++) {
        log("removed ID" + newArrival.value.data![i].name!);
        if (newArrival.value.data?[i].storeId.toString() ==
            ApiServices.storeId) {
          newArrival.value.data?.removeAt(i);
        } else {}
        // moreProduct.value.data!.removeWhere(
        //         (element) => element.id.toString() == newArrival.value.data![i].id.toString());
        // log("index is "+index.toString());
      }
      // newArrival.value.data!.removeWhere((element) =>
      //     element.storeId == userController.user.store?.id ||
      //     element.storeId == ApiServices.storeId);
      for (var i = 0; i < newArrival.value.data!.length; i++) {
        // for (var i = 0; i<dashBoardController.newArrival.value.data!.length ; i++) {
        log("discounts " + newArrival.value.data![i].discount.toString());
        // }
        // log("removed ID" + newArrival.value.data![i].id!);
        moreProduct.value.data!.removeWhere((element) =>
            element.id.toString() == newArrival.value.data![i].id.toString());
        // log("index is "+index.toString());
      }

      // for (var i = 0; i < moreProduct.value.data!.length; i++) {
      //   if (moreProduct.value.data![i].discount != null) {
      //     var isDis = isCurrentDateBetween(
      //         DateTime.parse(
      //             moreProduct.value.data![i].discount!.startDatetime),
      //         DateTime.parse(moreProduct.value.data![i].discount!.endDatetime));
      //     log("is dis value" + isDis.toString());
      //     if (isDis == false) {
      //       moreProduct.value.data![i].discount = null;
      //     }
      //   }
      // }
      for (var i = 0; i < newArrival.value.data!.length; i++) {
        moreProduct.value.data!.removeWhere(
            (element) => element.id == newArrival.value.data![i].id);
        if (newArrival.value.data![i].discount != null) {
          var isDis = isCurrentDateBetween(
              DateTime.parse(
                  newArrival.value.data![i].discount!.startDatetime.toString()),
              DateTime.parse(
                  newArrival.value.data![i].discount!.endDatetime.toString()));
          log("is dis value" + isDis.toString());
          if (isDis == false) {
            newArrival.value.data![i].discount = null;
          }
        }
      }
      newArrival.refresh();
      // await removeNewArrivalFromMore();
      update();

      // storeList.value.removeWhere((element) => element.id==)

      /// making the loading state false to dismiss spinkit loader
      isLoading.value = false;

      /// returning the complete data list, which we get from API
      return completeData.value;
    } on SocketException {
      /// enters when internet connection is not available
      isLoading.value = false;
      Get.snackbar('Error', "Internet Connection Not Available!",
          snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    } on Exception {
      /// enters when any other exception happens in code
      isLoading.value = false;
      // Get.snackbar('Oops!', "No Data Found",
      //     snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    } catch (e) {
      ///enters when there is some other error message rather than exception
      isLoading.value = false;
      // Get.snackbar('Error', e.toString(),
      //     snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
      // isLoading.value = false;
    }

    /// returning the complete data list, which we get from API
    ///
    return completeData.value;
  }

  Future<DashBoardFilter?> getDashBoardFilter(String filterType) async {
    // getUserData();
    // try {
      /// making the loading state true to show spinkit loader
      isLoading.value = true;

      /// hitting the get dashboard API made in APIServices
      var result = await ApiServices().getDashBoardFilterData(filterType);
      // await ApiServices().getUsersData(
      //     chatController.listOfUserIDs);
      /// making the controller values equals to the API data
      completeData.value.data!.newArrivalProduct = (await result.data!.newArrivalProduct) as Product?;
      // brandList.value = result.data!.brand!;
      // storeList.value = result.data!.store!;
      newArrival.value = result.data!.newArrivalProduct! as Product;
      moreProduct.value = result.data!.moreProduct! as Product;
      moreProductList.value = result.data!.moreProduct!.data!;

      completeData.refresh();
      newArrival.refresh();
      moreProduct.refresh();
      moreProductList.refresh();
      // topRankingProduct.value = result.data!.topRankingProduct!;

      log("store ID from APi services" + ApiServices.storeId);
      moreProductList.value.removeWhere((element) =>
          element.storeId == userController.user.value.store?.id ||
          element.user!.id.toString() == ApiServices.storeId);
      moreProduct.value.data!.removeWhere(
          (element) => element.storeId == userController.user.value.store?.id);
      storeList.value.removeWhere((element) =>
          element.id == userController.user.value.store?.id ||
          element.id.toString() == ApiServices.storeId);
      for (var i = 0; i < newArrival.value.data!.length; i++) {
        log("removed ID" + newArrival.value.data![i].name!);
        if (newArrival.value.data?[i].storeId.toString() ==
            ApiServices.storeId) {
          newArrival.value.data?.removeAt(i);
        } else {}
        // moreProduct.value.data!.removeWhere(
        //         (element) => element.id.toString() == newArrival.value.data![i].id.toString());
        // log("index is "+index.toString());
      }
      // newArrival.value.data!.removeWhere((element) =>
      //     element.storeId == userController.user.store?.id ||
      //     element.storeId == ApiServices.storeId);
      for (var i = 0; i < newArrival.value.data!.length; i++) {
        // for (var i = 0; i<dashBoardController.newArrival.value.data!.length ; i++) {
        log("discounts " + newArrival.value.data![i].discount.toString());
        // }
        // log("removed ID" + newArrival.value.data![i].id!);
        moreProduct.value.data!.removeWhere((element) =>
            element.id.toString() == newArrival.value.data![i].id.toString());
        // log("index is "+index.toString());
      }

      // for (var i = 0; i < moreProduct.value.data!.length; i++) {
      //   if (moreProduct.value.data![i].discount != null) {
      //     var isDis = isCurrentDateBetween(
      //         DateTime.parse(
      //             moreProduct.value.data![i].discount!.startDatetime),
      //         DateTime.parse(moreProduct.value.data![i].discount!.endDatetime));
      //     log("is dis value" + isDis.toString());
      //     if (isDis == false) {
      //       moreProduct.value.data![i].discount = null;
      //     }
      //   }
      // }
      for (var i = 0; i < newArrival.value.data!.length; i++) {
        moreProduct.value.data!.removeWhere(
            (element) => element.id == newArrival.value.data![i].id);
        if (newArrival.value.data![i].discount != null) {
          var isDis = isCurrentDateBetween(
              DateTime.parse(
                  newArrival.value.data![i].discount!.startDatetime.toString()),
              DateTime.parse(
                  newArrival.value.data![i].discount!.endDatetime.toString()));
          log("is dis value" + isDis.toString());
          if (isDis == false) {
            newArrival.value.data![i].discount = null;
          }
        }
      }
      newArrival.refresh();
      // await removeNewArrivalFromMore();
      update();

      // storeList.value.removeWhere((element) => element.id==)

      /// making the loading state false to dismiss spinkit loader
      isLoading.value = false;

      /// returning the complete data list, which we get from API
      return result;
    // } on SocketException {
    //   /// enters when internet connection is not available
    //   isLoading.value = false;
    //   Get.snackbar('Error', "Internet Connection Not Available!",
    //       snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    // } on Exception {
    //   /// enters when any other exception happens in code
    //   isLoading.value = false;
    //   // Get.snackbar('Oops!', "No Data Found",
    //   //     snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    // } catch (e) {
    //   ///enters when there is some other error message rather than exception
    //   isLoading.value = false;
    //   // Get.snackbar('Error', e.toString(),
    //   //     snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    //   // isLoading.value = false;
    // }

    /// returning the complete data list, which we get from API
    ///
    return null;
  }
// removeNewArrivalFromMore(){
//   if(newArrival.value.data!.isNotEmpty) {
//     for (var i = 0; i > newArrival.value.data!.length; i++) {
//       if(moreProduct.value.data!.isNotEmpty) {
//         (moreProduct.value.data!.removeWhere((element) =>
//         element.id == newArrival.value.data![i].id));
//         moreProduct.refresh();
//       }
//       // moreProductList.value.removeWhere((element) =>
//       // element.id == newArrival.value.data![i].id)
//     }
//   }
// }
// List<Datum> splitProductListByCreatedAt(List<Datum> products) {
//   final today = DateTime.now();
//   final threeDaysAgo = today.subtract(Duration(days: 3));
//
//   final list1 = <Product>[];
//   final list2 = <Product>[];
//
//   for (final product in products) {
//     final createdAt = DateTime.parse(product.createdAt);
//
//     if (createdAt >= threeDaysAgo) {
//       list1.add(product);
//     } else {
//       list2.add(product);
//     }
//   }
//
//   return [list1, list2];
// }
}
