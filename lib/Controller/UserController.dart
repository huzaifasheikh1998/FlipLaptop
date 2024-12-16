import 'dart:io';

import 'package:app_fliplaptop/Apiserrvices/Services.dart';
import 'package:app_fliplaptop/models/followerListModel.dart';
import 'package:app_fliplaptop/models/yourFollowersModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Apiserrvices/localStorage.dart';
import '../models/loginmodel.dart';

class UserController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    updateAuthToken();
    getFollowedStores();
    geYourStoreFollowers();
    super.onInit();
  }

  Rx<UserModel> user = UserModel().obs;

  // static UserModel user = UserModel();
  // static MyProfile profile = MyProfile();
  // static GetBehaviour behaviour = GetBehaviour();
  // static GetSynopsesModel synopsis = GetSynopsesModel();
  // static GetAlarm alarm = GetAlarm();
  // void User(UserModel data) {
  // user = data;
  //   update();
  // }

  void User(UserModel data) {
    user.value = data;
    update();
  }

  void updateStore(Store data) {
    user.value.store = data;
    update();
  }

  // for loading state on followingStoriesScreen
  RxBool isLoading = false.obs;

  RxString selectedGender = "".obs;

  // to handle the follow and unfollow operations on storeProfile Screen
  RxBool isFollowed = false.obs;

  // contains the followed store instance
  RxList<StoreInstance> listOfFollowers = <StoreInstance>[].obs;
  RxList<Follower> listOfFollowedUsers = <Follower>[].obs;

  // this is the function made to follow the stores
  followStore(String storeID) async {
    try {
      isLoading.value = true;
      var result = await ApiServices().followStore(storeID);
      if (result["status"] == "true") {
        await getFollowedStores();
        isLoading.value = false;
        Get.snackbar('Success', result['message'],
            snackPosition: SnackPosition.TOP,
            colorText: Colors.white,
            backgroundColor: Colors.green);
      } else {
        isLoading.value = false;
      }
    } on SocketException {
      isLoading.value = false;
      Get.snackbar('Error', "Internet Connection Not Available!",
          snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    }
    isLoading.value = false;
    return null;
  }

  // takes storeID and checks that the store is followed or not
  // bool isStoreInFollowList(String StoreID){
  //   var tr = userController.listOfFollowers.indexWhere(
  //           (element) => element.id == StoreID);
  //   print("=====>value $tr");
  //   if (tr != -1) {
  //     userController.isFollowed.value = true;
  //     return userController.isFollowed.value;
  //   } else {
  //     userController.isFollowed.value = false;
  //     return userController.isFollowed.value;
  //
  //   }
  // }
  // this function is made to get the followed store list
  // and calling it on onInit
  Future<List<StoreInstance>> getFollowedStores() async {
    try {
      isLoading.value = true;
      var result = await ApiServices().getFollowedList();
      if (result.status.toString() == "true") {
        listOfFollowers.value = result.data;
        isLoading.value = false;
        return listOfFollowers;
        // Get.snackbar('Success', result['message'],
        //     snackPosition: SnackPosition.TOP,
        //     colorText: Colors.white,
        //     backgroundColor: Colors.green);
      } else {
        Get.snackbar('Error', result.message,
            snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
        isLoading.value = false;
      }
    } on SocketException {
      isLoading.value = false;
      Get.snackbar('Error', "Internet Connection Not Available!",
          snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    }
    isLoading.value = false;
    return listOfFollowers;
  }

  Future<List<Follower>> geYourStoreFollowers() async {
    try {
      isLoading.value = true;
      var result = await ApiServices().getYourFollowersList();
      if (result.status.toString() == "true") {
        listOfFollowedUsers.value = result.data!;
        isLoading.value = false;
        return listOfFollowedUsers;
        // Get.snackbar('Success', result['message'],
        //     snackPosition: SnackPosition.TOP,
        //     colorText: Colors.white,
        //     backgroundColor: Colors.green);
      } else {
        // Get.snackbar('Error', result.message.toString(),
        //     snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
        isLoading.value = false;
      }
    } on SocketException {
      isLoading.value = false;
      Get.snackbar('Error', "Internet Connection Not Available!",
          snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    }
    isLoading.value = false;
    return listOfFollowedUsers;
  }

  removeFromFollowers(String storeID) async {
    try {
      isLoading.value = true;
      var result = await ApiServices().removeFromFollowed(storeID);
      if (result["status"] == "true") {
        await getFollowedStores();
        isLoading.value = false;
        Get.snackbar('Success', "Store Unfollow Successful",
            snackPosition: SnackPosition.TOP,
            colorText: Colors.white,
            backgroundColor: Colors.green);
      } else {
        isLoading.value = false;
      }
    } on SocketException {
      isLoading.value = false;
      Get.snackbar('Error', "Internet Connection Not Available!",
          snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
    }
    return null;
  }

  RxString authTokenForSplash = "".obs;

  updateAuthToken() async {
    authTokenForSplash.value =
        await LocalStorage.readJson(key: LocalStorageKeys.authToken);
  }
}
