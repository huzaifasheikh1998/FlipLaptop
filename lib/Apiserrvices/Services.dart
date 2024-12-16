// ignore_for_file: body_might_complete_normally_nullable

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:app_fliplaptop/Apiserrvices/app_url.dart';
import 'package:app_fliplaptop/Apiserrvices/firebaseServices.dart';
import 'package:app_fliplaptop/Apiserrvices/loader.dart';
import 'package:app_fliplaptop/Apiserrvices/localStorage.dart';
import 'package:app_fliplaptop/Controller/UserController.dart';
import 'package:app_fliplaptop/Controller/chatController.dart';
import 'package:app_fliplaptop/Controller/filterController.dart';
import 'package:app_fliplaptop/Controller/productController.dart';
import 'package:app_fliplaptop/Controller/subscriptionController.dart';

// import 'package:app_fliplaptop/Screens/HomeScreen.dart';
import 'package:app_fliplaptop/Screens/LoginScreen.dart';
import 'package:app_fliplaptop/Screens/MyOrderScreen.dart';
import 'package:app_fliplaptop/Screens/MyStoreProfileScreen.dart';
import 'package:app_fliplaptop/Screens/OrderConfirmation.dart';
import 'package:app_fliplaptop/Screens/SelectPackageScreen.dart';
import 'package:app_fliplaptop/Screens/SelectPaymentMethod.dart';
import 'package:app_fliplaptop/Screens/ShippingAddress.dart';
import 'package:app_fliplaptop/Screens/StartNavigatorScreen.dart';
import 'package:app_fliplaptop/Screens/VerificationScreen.dart';
import 'package:app_fliplaptop/components/global.dart';
import 'package:app_fliplaptop/models/dashBoardModel.dart' as dash;
import 'package:app_fliplaptop/models/dashBoardModel.dart';
import 'package:app_fliplaptop/models/dashboard_filter.dart';
import 'package:app_fliplaptop/models/dealModel.dart';
import 'package:app_fliplaptop/models/faqModel.dart';
import 'package:app_fliplaptop/models/filterBrandModel.dart';
import 'package:app_fliplaptop/models/filterModel.dart';
import 'package:app_fliplaptop/models/followerListModel.dart';
import 'package:app_fliplaptop/models/getStoreRating.dart';
import 'package:app_fliplaptop/models/loginmodel.dart' as LoginModel;
import 'package:app_fliplaptop/models/my_profile_data_model/my_profile_data_model.dart';
import 'package:app_fliplaptop/models/my_store_profile_data_model/my_store_profile_data_model.dart';
import 'package:app_fliplaptop/models/orderModel.dart';
import 'package:app_fliplaptop/models/paymentCardModel.dart';
import 'package:app_fliplaptop/models/product_category_data_model/display_size.dart';
import 'package:app_fliplaptop/models/product_category_data_model/product_category_data_model.dart';
import 'package:app_fliplaptop/models/product_listing_data_model/product_listing_data_model.dart';
import 'package:app_fliplaptop/models/purchaseListModel.dart';
import 'package:app_fliplaptop/models/purchaseModel.dart';
import 'package:app_fliplaptop/models/reviewModel.dart';
import 'package:app_fliplaptop/models/searchFilterProductListModel.dart';
import 'package:app_fliplaptop/models/sellOrderModel.dart';
import 'package:app_fliplaptop/models/shippingAddressModel.dart';
import 'package:app_fliplaptop/models/storeReviewModel.dart';
import 'package:app_fliplaptop/models/subscriptionModel.dart';
import 'package:app_fliplaptop/models/wishListModel.dart';
import 'package:app_fliplaptop/models/yourFollowersModel.dart';
import 'package:app_fliplaptop/res/utils/utils.dart';
import "package:async/async.dart";
import 'package:dio/dio.dart' as DIO;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Controller/shippingController.dart';
import '../models/product_listing_data_model/deleteProduct.dart';

// String apiUrl = "https://fliplaptop.thesuitchstaging.com/api/v1/";
final userController = Get.put(UserController());

String email = "";
String authToken = "";

class ApiServices {
  static String storeId = "";
  static String profileName = "";
  static String profileEmail = "";
  static String profilePic = "";

  // Map<String, String> headerWithauthToken = {
  //   "Authorization": "Bearer $authToken",
  //   'Content-Type': 'application/json',
  // };

  getAuthTokenFrom() async {
    authToken = await LocalStorage.readJson(key: LocalStorageKeys.authToken);
  }

  Map<String, String> headerOnly = {'Content-Type': 'application/json'};

  headerWithBearerToken() async {
    return {
      'Authorization':
          'Bearer ${await LocalStorage.readJson(key: LocalStorageKeys.authToken)}'
    };
  }

  var onlyFormDataHeader = {'Content-Type': 'multipart/form-data'};
  var headerWithBearerTokenAndMultipart = {
    'Authorization': 'Bearer $authToken',
    'Content-Type': 'multipart/form-data'
  };

  newHeaderWithBearerTokenAndMultipart() async {
    return {
      'Authorization':
          'Bearer ${await LocalStorage.readJson(key: LocalStorageKeys.authToken)}',
    };
  }

  //   var headerWithBearerToken = {
  //   'Authorization':
  //       'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2ZsaXBsYXB0b3AudGhlc3VpdGNoc3RhZ2luZy5jb20vYXBpL3YxL2xvZ2luIiwiaWF0IjoxNjkxNjIwMzQ0LCJleHAiOjE2OTE2MjM5NDQsIm5iZiI6MTY5MTYyMDM0NCwianRpIjoiamhWRlhDbEhCMW94OVZXYSIsInN1YiI6Ijk4IiwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.-DfkaV8AfKUL1MrO529wKQsIOGYwfQBV-vml4qg-Z0Y'
  // };
  // Map<String, dynamic> headerWithBearerToken = {
  //   'bearer-token':
  //       '5f34d7e8411f6e63e323ce4c8a4fa5aab08c68128bf31628e23673cac125ecb3',
  //   'Content-Type': 'application/json'
  // };
  //   String headerWithBearerToken = {
  //   'bearer-token':
  //       "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2ZsaXBsYXB0b3AudGhlc3VpdGNoc3RhZ2luZy5jb20vYXBpL3YxL2xvZ2luIiwiaWF0IjoxNjkxNTM5MzIxLCJleHAiOjE2OTE1NDI5MjEsIm5iZiI6MTY5MTUzOTMyMSwianRpIjoiTUlKdUYxT252UnVFSHpuSyIsInN1YiI6Ijk1IiwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.9mnj8iw3qXsUUyjkoWPt6JfV_B1MZGc7PNg_yz6R1aU",
  //   'Content-Type': 'application/json'
  // }.toString();

  //  'Content-Type': 'application/json'

  setLocalVariable(
      String token, String pName, String pEmail, String pPic, String sId) {
    authToken = token;
    profileName = pName;
    profileEmail = pEmail;
    profilePic = pPic;
    storeId = sId;

    print("$profileName profile name");
    print("$profileEmail profile email");
  }

  callregister(context, data) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(child: Loader.spinkit);
      },
    );
    log(data.toString());

    final uri = Uri.parse(AppUrls.kSignUpUrl);
    String jsonBody = json.encode(data);
    // try {
    http.Response response = await http.post(
      uri,
      headers: headerOnly,
      body: jsonBody,
    );
    log("sttaus code" + response.statusCode.toString());
    log("url code" + AppUrls.kSignUpUrl.toString());

    var res_data = json.decode(response.body.toString());

    log(res_data.toString());

    if (res_data['status'] == true) {
      storeId = "";
      setLocalVariable(
          res_data["authorisation"]["token"].toString(),
          res_data["data"][0]["name"].toString(),
          res_data["data"][0]["email"].toString(),
          res_data["data"][0]["image"] ?? "",
          "");
      ApiServices.myStoreProfileDataList.clear();
      LocalStorage.deleteJson(key: LocalStorageKeys.cartList);
      LocalStorage.saveJson(
          key: LocalStorageKeys.stripeConnected, value: "false");
      Get.back();
      Get.to(() => VerificationScreen());
      Get.snackbar('Success', res_data['message'],
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: Colors.green);
      LocalStorage.saveJson(
          key: LocalStorageKeys.authToken,
          value: res_data["authorisation"]["token"].toString());
      LocalStorage.saveJson(
          key: LocalStorageKeys.stripeConnected, value: "false");

      userController.User(LoginModel.UserModel(
        id: res_data["data"][0]["id"],
        name: res_data["data"][0]["name"],
        email: res_data["data"][0]["email"],
      ));
      LocalStorage.saveJson(
          key: LocalStorageKeys.userID, value: res_data["data"][0]["id"]);
      userController.update();
      authToken = res_data["authorisation"]["token"];
      email = res_data["data"][0]["email"];
    } else {
      Get.back();
      Get.snackbar('Error', res_data['message'],
          snackPosition: SnackPosition.TOP, colorText: Colors.white);
    }
    // } catch (e) {
    //   Get.back();
    //   // Get.snackbar('Error', e.toString(),
    //   //     snackPosition: SnackPosition.TOP, colorText: Colors.white);
    // }
  }

  callVerifyOtp(context, data, singupVerification, email) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(child: Loader.spinkit);
      },
    );
    final uri = Uri.parse(AppUrls.kVerifyOtpUrl);
    String jsonBody = json.encode(data);
    try {
      http.Response response = await http.post(
        uri,
        headers: headerOnly,
        body: jsonBody,
      );
      print("=============> res data: ${response}");
      var res_data = json.decode(response.body.toString());
      if (kDebugMode) {
        print("Called API: $url");
        print("Status Code: ${response.statusCode}");
        print("Sent Body: ${data}");
        print("Response Body: ${response.body}");
        // print("HEADERS: $header");
      }

      if (res_data['status'] == true) {
        userController.user.value.id = res_data["data"][0]["id"];
        userController.user.value.name = res_data["data"][0]["name"];
        userController.user.value.email = res_data["data"][0]["email"];
        profileEmail = res_data["data"][0]["email"];
        profileName = res_data["data"][0]["name"];

        Get.back();
        if (forgotPwd == true) {
          Get.toNamed('/CreatePasswordScreen');
        } else {
          createStore = false;
          Get.toNamed('/StartAppScreen');
        }
        Get.snackbar('Success', res_data['message'],
            snackPosition: SnackPosition.TOP,
            colorText: Colors.white,
            backgroundColor: Colors.green);
      } else {
        Get.back();
        print("===============errorrrr: ${res_data['message']}");
        if (res_data['message'].toString().contains("OTP not compare")) {
          Get.snackbar('Error', "Invalid OTP",
              snackPosition: SnackPosition.TOP, colorText: Colors.white);
        } else {
          Get.snackbar('Error', res_data['message'],
              snackPosition: SnackPosition.TOP, colorText: Colors.white);
        }
      }
    } catch (e) {
      Get.back();
      print("===============catch error: ${e}");

      // Get.snackbar('Error', e.toString(),
      //     snackPosition: SnackPosition.TOP, colorText: Colors.white);
    }
  }

  callforgetPassword(context, data) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(child: Loader.spinkit);
      },
    );

    log(data.toString());
    final uri = Uri.parse(AppUrls.kForgetPass);
    // final headers = {'Content-Type': 'application/json'};
    String jsonBody = json.encode(data);
    try {
      http.Response response = await http.post(
        uri,
        headers: headerOnly,
        body: jsonBody,
      );
      var res_data = json.decode(response.body.toString());
      log(res_data.toString());
      if (res_data['status'] == true) {
        // Get.back();
        select == 'forgetpass'
            ? Get.to(() => VerificationScreen())
            : Get.back();
        Get.snackbar(
          'Success',
          "OTP sent to your registered email",
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: Colors.green,
        );
      } else {
        Get.back();
        Get.snackbar('Error', res_data['message'],
            snackPosition: SnackPosition.TOP, colorText: Colors.white);
      }
    } catch (e) {
      Get.back();

      // Get.snackbar('Error', e.toString(),
      //     snackPosition: SnackPosition.TOP, colorText: Colors.white);
    }
  }

  callLogin(context, data, remChk) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(child: Loader.spinkit);
      },
    );
    log(data.toString());
    final uri = Uri.parse(AppUrls.kSignInUrl);
    // final headers = {'Content-Type': 'application/json'};
    String jsonBody = json.encode(data);
    try {
      http.Response response = await http.post(
        uri,
        headers: headerOnly,
        body: jsonBody,
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      var res_data = json.decode(response.body.toString());
      if (res_data['status'].toString() == "otp not verified!") {
        Get.back();
        Get.snackbar('Error', "OTP was not verified, check your email!",
            snackPosition: SnackPosition.TOP, colorText: Colors.white);
        Get.to(() => VerificationScreen());
      } else if (res_data['status'] == true) {
        storeId = "";
        orderController.sellerOrderList.clear();
        orderController.purchaseOrderList.clear();
        orderController.newSellerOrderList.clear();
        orderController.newPurchaseOrderList.clear();
        orderController.inProgressSellerOrderList.clear();
        orderController.inProgressPurchaseOrderList.clear();
        orderController.completedSellerOrderList.clear();
        orderController.completedPurchaseOrderList.clear();
        ApiServices.myStoreProfileDataList.clear();
        LocalStorage.saveJson(
            key: LocalStorageKeys.authToken,
            value: res_data["authorisation"]["token"].toString());
        getAuthTokenFrom();
        Get.back();
        LocalStorage.saveJson(
            key: LocalStorageKeys.userID, value: res_data["data"][0]["id"]);
        // if (res_data["store"] != null) {
        //   userController.user.store = List<LoginModel.Store>.from(
        //       res_data["data"]["store"]
        //           .map((x) => LoginModel.Store.fromJson(x)));
        // }
        log("userrrrrrrrrrrrrrrrrrrrrrrrrrrr id " + res_data["data"][0]["id"]);
        userController.user.value.id = res_data["data"][0]["id"];
        userController.user.value.name = res_data["data"][0]["name"];
        userController.user.value.email = res_data["data"][0]["email"];
        userController.user.value.image = res_data["data"][0]["image"];
        profileEmail = res_data["data"][0]["email"];
        profileName = res_data["data"][0]["name"];

        // log("res data store " + List<LoginModel.Store>.from(
        //     res_data["data"]["store"]
        //         .map((x) => LoginModel.Store.fromJson(x))).toString());

        userController.update();
        var loginResponse = LoginModel.loginModelFromJson(response.body);
        // log("stripe vlaue"+loginResponse.data?.store?.first.stripeAccountID);
        LocalStorage.saveJson(
            key: LocalStorageKeys.stripeConnected, value: "false");

        if (loginResponse.data.first.store != null) {
          ApiServices.storeId = loginResponse.data.first.store!.id.toString();
          LocalStorage.saveJson(
              key: LocalStorageKeys.storeID,
              value: loginResponse.data.first.store!.id.toString());
          if (loginResponse.data.first.store?.stripeAccountId == null ||
              loginResponse.data.first.store?.stripeAccountId.toString() ==
                  "") {
            LocalStorage.saveJson(
                key: LocalStorageKeys.stripeConnected, value: "false");
          } else {
            LocalStorage.saveJson(
                key: LocalStorageKeys.stripeConnected, value: "true");
          }
        }
        // if(loginResponse.data?.store!=null) {
        //   if (loginResponse.data?.store == null) {
        //     LocalStorage.saveJson(
        //         key: LocalStorageKeys.stripeConnected, value: "false");
        //   } else {
        //     LocalStorage.saveJson(
        //         key: LocalStorageKeys.stripeConnected, value: "true");
        //   }
        // }

        if (loginResponse.data.first.store == null &&
                loginResponse.data.first.shipperAddress == null ||
            loginResponse.data.first.payment == null) {
          userController.User(LoginModel.UserModel(
            id: loginResponse.data.first.id,
            name: loginResponse.data.first.name,
            email: loginResponse.data.first.email,
          ));
          // getUserData() async {
          // await ;

          // chatController.update();
          // await ApiServices().getUsersData(chatController.listOfUserIDs);

          // .then(
          //   (value) => setState(() {}),
          // );
          // }
        } else {
          userController.User(
              LoginModel.loginModelFromJson(response.body).data.first);
        }

        Get.to(() => StartAppScreen());
        SharedPreferences sp = await SharedPreferences.getInstance();
        LocalStorage.deleteJson(key: LocalStorageKeys.cartList);

        // FirebaseServices().getUniqueMembers();

        if (remChk) {
          sp.remove("userEmail");
          sp.remove("userPassword");
          sp.setString("userEmail", data["email"]);
          sp.setString("userPassword", data["password"]);
        } else {
          // Comment
          sp.remove("userEmail");
          sp.remove("userPassword");
        }

        // <<<<<<<<<<<<<<<<<<   store locally >>>>>>>>>>>>>>>
        //  authToken = res_data["authorisation"]["token"];
        //  print(res_data["data"]["store"].toString() != "[]"?
        //  res_data["data"]["store"][0]["id"].toString() : "");
        //  print(res_data["data"]["image"]??"");
        // storeId = res_data["data"]["store"][0]["id"].toString();

        setLocalVariable(
            res_data["authorisation"]["token"].toString(),
            res_data["data"][0]["name"].toString(),
            res_data["data"][0]["email"].toString(),
            res_data["data"][0]["image"] ?? "",
            res_data["data"][0]["store"].toString() != "null"
                ? res_data["data"][0]["store"]["id"].toString()
                : "");

        // userController.User(LoginModel.fromJson(res_data));
        // authToken = UserController.user.authorisation!.token.toString();
        // step = UserController.user.data!.step.toString();
        // step == "1"
        //     ?

        //
        //         ? Get.to(() => CreateProfileScreen())
        //         :
        //         // bt.navBarChange(0);
        //         Get.to(() => MainScreen());
        // authToken = res_data['data']['token'];

        Get.snackbar('Success', 'User logged in successfully',
            snackPosition: SnackPosition.TOP,
            colorText: Colors.white,
            backgroundColor: Colors.green);
      } else {
        Get.back();
        Get.snackbar('Error', res_data['message'],
            snackPosition: SnackPosition.TOP, colorText: Colors.white);
      }
    } on SocketException {
      // isLoading.value = false;
      Get.back();
      Get.snackbar('Error', "Please Check Your Internet",
          snackPosition: SnackPosition.TOP, colorText: Colors.white);
    }
    // catch (e) {
    //   Get.back();
    //   Get.snackbar('Error', e.toString(),
    //       snackPosition: SnackPosition.TOP, colorText: Colors.white);
    // }
  }

  callLogout(context, data) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(child: Loader.spinkit);
      },
    );
    log(data.toString());
    final uri = Uri.parse(AppUrls.kLogOutUrl);
    // final headers = {
    //   'Content-Type': 'application/json',
    //   'Authorization': 'bearer ${authToken}',
    // };
    var header = await headerWithBearerToken();
    ApiServices.myStoreProfileDataList.clear();
    String jsonBody = json.encode(data);
    try {
      http.Response response = await http.post(
        uri,
        headers: header,
        body: jsonBody,
      );
      var res_data = json.decode(response.body.toString());
      log(res_data.toString());

      if (res_data['status'] == true) {
        storeId = "";

        Get.back();
        Get.offAll(() => LoginScreen());
        LocalStorage.deleteJson(key: LocalStorageKeys.cartList);
        LocalStorage.deleteJson(key: LocalStorageKeys.stripeConnected);
        LocalStorage.deleteJson(key: LocalStorageKeys.authToken);
        final GoogleSignIn _googleSignIn = GoogleSignIn();
        final FirebaseAuth _auth = FirebaseAuth.instance;
        await _auth.signOut();
        await _googleSignIn.signOut();
        // await GoogleSignIn.revokeAccess(); // added now
        // await auth().signOut();
        // log("cleared");
        Get.snackbar('Success', res_data['message'],
            snackPosition: SnackPosition.TOP,
            colorText: Colors.white,
            backgroundColor: Colors.green);
      } else {
        Get.back();
        Get.snackbar('Error', res_data['message'],
            snackPosition: SnackPosition.TOP, colorText: Colors.white);
      }
    } catch (e) {
      Get.back();

      // Get.snackbar('Error', e.toString(),
      //     snackPosition: SnackPosition.TOP, colorText: Colors.white);
    }
  }

//<<<<<<<<<<<<<<<<<<<<Store Create>>>>>>>>>>>>>>>>>>>>>>>>>>>
  callStoreCreate(
      context,
      data,
      String name,
      String location,
      String description,
      String webLink,
      File imageFile,
      String taxPercentage) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(child: Loader.spinkit);
      },
    );

    log(data.toString());
    final uri = Uri.parse(AppUrls.kStoreCreate);
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var header = await headerWithBearerToken();

    try {
      var request = http.MultipartRequest('POST', uri);
      var multipartFile = new http.MultipartFile("image", stream, length,
          filename: basename(imageFile.path));
      request.files.add(multipartFile);
      request.fields['name'] = name;
      request.fields['location'] = location;
      request.fields['description'] = description;
      request.fields['website_link'] = webLink;
      request.fields['tax'] = taxPercentage;
      request.headers.addAll(header);
      var respond = await request.send();
      final http.Response response = await http.Response.fromStream(respond);
      print("Ressponse ${response.statusCode}");
      print("Respond ${respond.statusCode}");
      var res_data = json.decode(await response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Status 200");
        print(response.body);
        var res_data = json.decode(await response.body);
        log(res_data.toString());
        print(res_data);

        if (res_data['status'].toString() == "true") {
          log("${res_data["data"]["id"].toString()} store id");
          storeId = res_data["data"]["id"].toString();
          Get.back();
          Get.off(() => StartAppScreen());
          Get.snackbar('Success', res_data['message'],
              snackPosition: SnackPosition.TOP,
              colorText: Colors.white,
              backgroundColor: Colors.green);
          // log("user ID from Controller" +
          //     userController.user.store!.first.id.toString());
          // userController.user.store = [
          //   LoginModel.Store(
          //     id: res_data["data"]["id"],
          //     name: res_data["data"]["name"],
          //     location: res_data["data"]["location"],
          //     image: res_data["data"]["image"],
          //     description: res_data["data"]["description"],
          //     websiteLink: res_data["data"]["website_link"],
          //     follower: res_data["data"]["follower"],
          //     following: res_data["data"]["following"],
          //     productCount: res_data["data"]["productCount"],
          //     product: [],
          //   )
          // ];
          // res_data["data"] = userController.user.store
          // Get.offAll(() => LoginScreen());

          // Timer(Duration(seconds: 2), () {
          //   print("<<<<<<<<<<<<<<<<<<<<<<<<<back>>>>>>>>>>>>>>>>>>>>>>>>>");
          //   Navigator.pop(context);
          // });
          userController.user.value.store = LoginModel.Store(
            id: res_data["data"]["id"],
            name: res_data["data"]["name"],
            location: res_data["data"]["location"],
            image: res_data["data"]["image"],
            description: res_data["data"]["description"],
            websiteLink: res_data["data"]["website_link"],
            follower: res_data["data"]["follower"],
            following: res_data["data"]["following"],
            productCount: res_data["data"]["productCount"],
            product: [],
            tax: null,
            taxStatus: null,
            stripeAccountId: null,
          );
          userController.update();
        } else {
          Get.back();
          Get.snackbar('Error', res_data['message'],
              snackPosition: SnackPosition.TOP, colorText: Colors.white);
        }
      } else {
        // print("Upload Failed");
        Get.back();
        Get.snackbar('Error', res_data['message'],
            snackPosition: SnackPosition.TOP, colorText: Colors.white);
      }
    } catch (e) {
      Get.back();
      //
      // Get.snackbar('Error', e.toString(),
      //     snackPosition: SnackPosition.TOP, colorText: Colors.white);
    }
  }

  /// update the store --> POST
  ///
  /// want to get changed and put the image optional
  callStoreUpdate(
      context,
      data,
      String name,
      String location,
      String description,
      String webLink,
      File? imageFile,
      String taxPercentage) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(child: Loader.spinkit);
      },
    );
    log(data.toString());
    final uri = Uri.parse(AppUrls.kStoreUpdate + storeId);
    var header = await headerWithBearerToken();

    try {
      var request = http.MultipartRequest('POST', uri);
      if (imageFile != null) {
        var stream =
            new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
        var length = await imageFile.length();
        var multipartFile = new http.MultipartFile("image", stream, length,
            filename: basename(imageFile.path));
        request.files.add(multipartFile);
      }

      request.fields['name'] = name;
      request.fields['location'] = location;
      request.fields['description'] = description;
      request.fields['website_link'] = webLink;
      request.fields['tax'] = taxPercentage;
      request.headers.addAll(header);
      var respond = await request.send();
      final http.Response response = await http.Response.fromStream(respond);
      // print("Ressponse ${response.statusCode}");
      // print("Respond ${respond.statusCode}");
      var res_data = json.decode(await response.body);
      // if (kDebugMode) {
      // print("product image" + File(imageFile.path).path.toString());
      print("Called API: $url");
      // print("Status Code: ${response.statusCode}");
      print("Sent body: ${request.files}");
      // print("file Name" + multipartFile.filename.toString());
      // print("Response Body: ${response.body}");
      // print("HEADERS: $header");
      // }
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Status 200");
        print(response.body);
        var res_data = json.decode(await response.body);
        log(res_data.toString());
        print(res_data);
        if (res_data['status'].toString() == "true") {
          print("${res_data["data"]["id"].toString()} store id");
          storeId = res_data["data"]["id"].toString();
          var storeIns = LoginModel.Store.fromJson(res_data["data"]);
          userController.user.value.store = storeIns;
          userController.update();
          Get.offUntil(
            MaterialPageRoute(
                builder: (context) => MyStoreProfileScreen(
                      storeId: storeId,
                    )),
            (Route<dynamic> route) =>
                route.settings.name == "/MyStoreProfileScreen",
          );
          Get.back();
          Get.back();
          // Get.offAll(() => LoginScreen());
          Get.snackbar('Success', res_data['message'],
              snackPosition: SnackPosition.TOP,
              colorText: Colors.white,
              backgroundColor: Colors.green);
          Timer(Duration(seconds: 2), () {
            print("<<<<<<<<<<<<<<<<<<<<<<<<<back>>>>>>>>>>>>>>>>>>>>>>>>>");
            // Navigator.pop(context);
          });
        } else {
          Get.back();
          Get.snackbar('Error', res_data['message'],
              snackPosition: SnackPosition.TOP, colorText: Colors.white);
        }
      } else {
        // print("Upload Failed");
        Get.back();
        Get.snackbar('Error', res_data['message'],
            snackPosition: SnackPosition.TOP, colorText: Colors.white);
      }
    } catch (e) {
      Get.back();

      // Get.snackbar('Error', e.toString(),
      //     snackPosition: SnackPosition.TOP, colorText: Colors.white);
    }
  }

  /// updating the store tax amount
  // Future<DataWithStoreInstance>updateStoreTaxAndAmount(String taxPercentage, BuildContext context ) async {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return Center(child: Loader.spinkit);
  //     },
  //   );
  //   /// Url
  //   String url = AppUrls.addTaxAmount(storeId);
  //
  //   /// Header
  //       var header = await headerWithBearerToken();

  //
  //   /// body
  //   var data = {
  //     "tax_status":"percentage",
  //     "tax":taxPercentage
  //   };
  //
  //   // create a multipart request
  //   /// Request
  //   var response = await http.post(
  //     Uri.parse(url), headers: header,
  //     body: data
  //   );
  //
  //   // runs if we are in debug mode
  //   if (kDebugMode) {
  //     print("Called API: $url");
  //     print("Status Code: ${response.statusCode}");
  //     // print("Sent Body: ${request.fields}");
  //     print("Response Body: ${response.body}");
  //     print("HEADERS: $header");
  //   }
  //
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     var APIResponse = dataWithStoreInstanceFromJson(response.body);
  //     if(APIResponse.status.toString()=="true"){
  //       userController.user.store?[0] = APIResponse.data as LoginModel.Store;
  //       userController.update();
  //       Get.offUntil(
  //         MaterialPageRoute(
  //             builder: (context) => MyStoreProfileScreen(
  //               storeId: storeId,
  //             )),
  //             (Route<dynamic> route) =>
  //         route.settings.name == "/MyStoreProfileScreen",
  //       );
  //       Get.back();
  //       Get.back();
  //       Utils.showFloatingSuccessSnack(APIResponse.message??"");
  //     }
  //     else{
  //       Utils.showFloatingErrorSnack(APIResponse.message??"");
  //     }
  //     // APIResponse.status
  //   }
  //   if (response.statusCode == 422) {
  //     // eventually gives 422 when cardID/addressID is wrong
  //     Utils.showFloatingErrorSnack(
  //         jsonDecode(response.body)["message"].toString());
  //   }
  //   if (response.statusCode == 401) {
  //     Get.offAll(() => const LoginScreen());
  //     throw Exception('Not Authorized');
  //   }
  //   if (response.statusCode == 400) {
  //     Get.back();
  //     throw Exception('Not found');
  //   }
  //   if (response.statusCode == 500) {
  //     Get.back();
  //     throw Exception('Server Not Responding');
  //   }
  //   return dataWithStoreInstanceFromJson(response.body.toString());
  // }
  //<<<<<<<<<<<<<<<<<<<<Create Product>>>>>>>>>>>>>>>>>>>>>>>>>>>

  callProductCreate2(context, int popTimes) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(child: Loader.spinkit);
      },
    );
    final addProductController = Get.put(ProductController());
    // var imgList = addProductController.addproductApiModel["images[]"];
    // print(imgList.first);

    // log(data.toString());
    final uri = Uri.parse(AppUrls.kProductCreate);
    var header = await headerWithBearerToken();

    try {
      var request = http.MultipartRequest('POST', uri);
      for (var entry in addProductController.addproductApiModel.entries) {
        // Print the key and value
        if (entry.value is List) {
          if (entry.key == "images[]") {
            for (var item in entry.value) {
              print("Key Images[]: ${entry.key} Value: ${item}");
              File imgFile = File(item);
              var stream =
                  new http.ByteStream(DelegatingStream.typed(imgFile.openRead()
                      // imageFile.openRead()
                      ));
              var length = await imgFile.length();
              var multipartFile = new http.MultipartFile(
                  entry.key.toString(), stream, length,
                  filename: basename(imgFile.path));
              request.files.add(multipartFile);
            }
          } else {
            //for size[]
            for (var item in entry.value) {
              print("Key: ${entry.key} Value: ${item}");
              request.fields[entry.key.toString()] = item.toString();
            }
          }
        } else {
          print("Key: ${entry.key} Value: ${entry.value}");
          request.fields[entry.key.toString()] = entry.value.toString();
        }
        // print("Key: ${entry.key} Value: ${entry.value}");
      }
      request.headers.addAll(header);
      var respond = await request.send();
      final http.Response response = await http.Response.fromStream(respond);
      var res_data = json.decode(await response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        // await productListingApiFunc(storeId);
        print("status code${respond.statusCode}");
        print("sent bdoy${request.fields}");
        print(response.body);
        log(res_data.toString());
        if (res_data['status'] == "true") {
          // for (int i = 0; i < popTimes + 1; i++) {
          //   Get.back();
          // }
          Get.snackbar('Success', res_data['message'],
              snackPosition: SnackPosition.TOP,
              colorText: Colors.white,
              backgroundColor: Colors.green);
          Get.offUntil(
            MaterialPageRoute(
                builder: (context) => MyStoreProfileScreen(
                      storeId: storeId,
                    )),
            (Route<dynamic> route) =>
                route.settings.name == "/MyStoreProfileScreen",
          );
          Get.back();

          // await
          await ApiServices().viewStoreByID(storeId);

          Get.back();
          // Get.off(
          //   () => MyStoreProfileScreen(
          //     storeId: storeId,
          //   ),
          // );
          // Get.back();
          // Get.offAll(() =>MyStoreProfileScreen(storeId: addProductController.addproductApiModel["store_id"]));
        } else {
          Get.back();
          Get.snackbar('Error', res_data['message'],
              snackPosition: SnackPosition.TOP, colorText: Colors.white);
        }
      } else {
        // print("Upload Failed");
        Get.back();
        Get.snackbar('Error', res_data['message'],
            snackPosition: SnackPosition.TOP, colorText: Colors.white);
      }
    } catch (e) {
      Get.back();
      // Get.snackbar('Error', e.toString(),
      //     snackPosition: SnackPosition.TOP, colorText: Colors.white);
    }
  }

  //<<<<<<<<<<<<<<<<<<<<Edit Product>>>>>>>>>>>>>>>>>>>>>>>>>>>

  callChangePassword(context, data) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(child: Loader.spinkit);
      },
    );

    log(data.toString());
    final uri = Uri.parse(AppUrls.kResetPass);
    // final headers = {'Content-Type': 'application/json'};
    String jsonBody = json.encode(data);
    try {
      http.Response response = await http.post(
        uri,
        headers: headerOnly,
        body: jsonBody,
      );
      var res_data = json.decode(response.body.toString());
      log("Check Status:${res_data.toString()}");

      if (res_data['status'] == true) {
        // Get.back();
        Get.offAll(() => LoginScreen());
        Get.snackbar('Success', res_data['message'],
            snackPosition: SnackPosition.TOP,
            colorText: Colors.white,
            backgroundColor: Colors.green);
      } else {
        Get.back();
        Get.snackbar('Error', res_data['message'],
            snackPosition: SnackPosition.TOP, colorText: Colors.white);
      }
    } catch (e) {
      Get.back();

      // Get.snackbar('Error', e.toString(),
      //     snackPosition: SnackPosition.TOP, colorText: Colors.white);
    }
  }

  callResendOtp(context, data) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(child: Loader.spinkit);
      },
    );

    log(data.toString());
    final uri = Uri.parse(AppUrls.kResendOtp);
    // final headers = {'Content-Type': 'application/json'};
    String jsonBody = json.encode(data);
    try {
      http.Response response = await http.post(
        uri,
        headers: headerOnly,
        body: jsonBody,
      );

      var res_data = json.decode(response.body.toString());
      log(res_data.toString());

      if (res_data['status'] == true) {
        forgotPwd == true ? Get.back() : Get.back();
        // Get.offAll(() => LoginScreen());
        Get.snackbar('Success', res_data['message'],
            snackPosition: SnackPosition.TOP,
            colorText: Colors.white,
            backgroundColor: Colors.green);
      } else {
        Get.back();
        Get.snackbar('Error', res_data['message'],
            snackPosition: SnackPosition.TOP, colorText: Colors.white);
      }
    } catch (e) {
      Get.back();

      // Get.snackbar('Error', e.toString(),
      //     snackPosition: SnackPosition.TOP, colorText: Colors.white);
    }
  }

  callEditProfile(context, data, editFile) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: Loader.spinkit,
        );
      },
    );

    final uri = Uri.parse(AppUrls.kEditProfile);
    var request = http.MultipartRequest('POST', uri);
    var header = await headerWithBearerToken();

    try {
      request.fields["name"] = data["name"].toString();
      request.fields["address"] = data["address"].toString();
      request.fields["phone_number"] = (data["phone_number"]);
      request.fields["gender"] = data["gender"].toString();
      request.fields["zipCode"] = data["zipCode"].toString();
      request.fields["country"] = data["country"].toString();
      request.fields["state"] = (data["state"]);
      request.fields["city"] = data["city"].toString();

      if (editFile != null) {
        var multipartFile = await http.MultipartFile.fromPath(
          'image',
          editFile.path,
          filename: editFile.path.split('/').last,
          contentType: MediaType("image", "${editFile.path.split('.').last}"),
        );
        request.files.add(multipartFile);
      }

      // String jsonBody = json.encode(request.fields);
      request.headers.addAll(header);
      var response = await request.send();
      final res = await http.Response.fromStream(response);
      var res_data = json.decode(res.body.toString());
      log(res_data.toString());
      if (kDebugMode) {
        print("Called API: ${uri.toString()}");
        print("Status Code: ${res.statusCode}");
        print("Sent Body: ${request.fields}");
        log("Response Body: ${res.body}");
        print("HEADERS: $header");
      }

      // print("==============> "+request.fields.toString());

      if (res_data['status'] == "true") {
        // ProfileScreen
        Get.offUntil(
          MaterialPageRoute(builder: (context) => StartAppScreen()),
          (Route<dynamic> route) => route.settings.name == "/StartAppScreen",
        );
        // Get.back();
        // Get.back();
        Get.snackbar('Success', res_data['message'],
            snackPosition: SnackPosition.TOP,
            colorText: Colors.white,
            backgroundColor: Colors.green);
      } else {
        Get.back();
        Get.snackbar('Error', res_data['message'],
            snackPosition: SnackPosition.TOP, colorText: Colors.white);
      }
    } catch (e) {
      Get.back();
      // Get.snackbar('Error', e.toString(),
      //     snackPosition: SnackPosition.TOP, colorText: Colors.white);
    }
  }

  static List<MyProfileDataModel> myProfileDataList = [];

  myProfileApiFunc() async {
    try {
      var header = await headerWithBearerToken();

      final response =
          await http.get(Uri.parse(AppUrls.kProfile), headers: header);
      var data = jsonDecode(response.body.toString());
      // if (kDebugMode) {
      print("Called API: $url");
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      print("HEADERS: $headerWithBearerToken");
      // }
      log(data.toString());
      data = [data];

      if (data[0]["status"].toString() == "true") {
        myProfileDataList.clear();
        log("value of data" + data[0].toString());

        // for (Map i in data[0]) {
        //   log("value of i"+i.toString());
        myProfileDataList.add(MyProfileDataModel.fromJson(data[0]));
        // }
        return myProfileDataList;
      } else {
        Get.snackbar('Error', data[0]['message'],
            snackPosition: SnackPosition.TOP, colorText: Colors.white);
        return myProfileDataList;
      }
    } catch (e) {
      log(e.toString());
      // Get.snackbar('Error', e.toString(),
      //     snackPosition: SnackPosition.TOP, colorText: Colors.white);
    }
  }

// <<<<<<<<<<<<<<<<my store profile >>>>>>>>>>>>>>>>

  static List<MyStoreProfileDataModel> myStoreProfileDataList = [];

  myStoreProfileApiFunc(String storeId) async {
    // try {
    var header = await headerWithBearerToken();

    final response = await http.get(Uri.parse(AppUrls.kStoreProfile + storeId),
        headers: header);
    var data = jsonDecode(response.body.toString());
    log(data.toString());
    data = [data];
    if (kDebugMode) {
      print("Called API: ${AppUrls.kStoreProfile + storeId}");
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      print("HEADERS: $headerWithBearerToken");
    }
    if (data[0]["status"].toString() == "true") {
      myStoreProfileDataList.clear();
      for (Map i in data) {
        myStoreProfileDataList.add(MyStoreProfileDataModel.fromJson(i));
        // storeId = MyStoreProfileDataModel.fromJson(i).data;
      }
      log("store" +
          myStoreProfileDataList.first.data!.stripeAccountId.toString());
      // var storeIns = myStoreProfileDataList.first.data;
      userController.user.value.store = myStoreProfileDataList.first.data!;
      userController.update();
      // log("Stripe ID"+userController.user.store!.first.name.toString());
      return myStoreProfileDataList;
    } else if (data[0]["status"].toString() == "false") {
      Get.snackbar('Error', data[0]['message'],
          snackPosition: SnackPosition.TOP, colorText: Colors.white);
    }
    // }
    // catch (e) {
    //   Get.snackbar('Error', e.toString(),
    //       snackPosition: SnackPosition.TOP, colorText: Colors.white);
    // }
  }

  // <<<<<<<<<<<<<<<<Product Listing >>>>>>>>>>>>>>>>

  // static List<ProductListingDataModel> productListingDataList = [];
  Future<ProductListingDataModel?> viewStoreByID(String storeId) async {
    // final productController = Get.put(ProductController());
    try {
      var header = await headerWithBearerToken();

      final response = await http
          .get(Uri.parse(AppUrls.kProductListing + storeId), headers: header);
      var data = jsonDecode(response.body.toString());
      log(data.toString());
      data = [data];
      if (data[0]["status"].toString() == "true") {
        // productController.productListingDataList.clear();

        for (Map i in data) {
          return ProductListingDataModel.fromJson(i);
          // var storeData = await getStoreData(storeId);
          // var storeIns =storeData;
          // userController.user.store?[0] = storeIns!;
          // userController.update();
        }

        log("Stripe ID" + userController.user.value.store!.stripeAccountId!);
        // return productController.productListingDataList;
      } else if (data[0]["status"].toString() == "false" &&
          data[0]["data"] != null) {
        Get.snackbar('Error', data[0]['message'],
            snackPosition: SnackPosition.TOP, colorText: Colors.white);
      }
    } on SocketException {
      Utils.showFloatingErrorSnack("Check you Internet Connection!");
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.TOP, colorText: Colors.white);
    }
  }

  Future<List<ProductListingDataModel>> productListingApiFunc(
      String storeId) async {
    final productController = Get.put(ProductController());
    try {
      var header = await headerWithBearerToken();

      final response = await http
          .get(Uri.parse(AppUrls.kProductListing + storeId), headers: header);
      var data = jsonDecode(response.body.toString());
      log(data.toString());
      data = [data];
      if (kDebugMode) {
        print("Called API: ${AppUrls.kProductListing + storeId}");
        print("Status Code: ${response.statusCode}");
        print("Response Body: ${response.body}");
        print("HEADERS: $header");
      }
      if (data[0]["status"].toString() == "true") {
        productController.productListingDataList.clear();

        for (Map i in data) {
          productController.productListingDataList
              .add(ProductListingDataModel.fromJson(i));
          // var storeData = await getStoreData(storeId);
          // var storeIns =storeData;
          // userController.user.store?[0] = storeIns!;
          // userController.update();
        }

        log("Stripe ID" + userController.user.value.store!.stripeAccountId!);
        return productController.productListingDataList;
      } else if (data[0]["status"].toString() == "false" &&
          data[0]["data"] == null) {
        // Get.snackbar('Error', data[0]['message'],
        //     snackPosition: SnackPosition.TOP, colorText: Colors.white);
        return productController.productListingDataList;
      }
    } on SocketException {
      Utils.showFloatingErrorSnack("Check you Internet Connection!");
      return productController.productListingDataList;
    } catch (e) {
      // Get.snackbar('Error', e.toString(),
      //     snackPosition: SnackPosition.TOP, colorText: Colors.white);
      return productController.productListingDataList;
    }
    return productController.productListingDataList;
  }

  Future<LoginModel.Store?> getStoreData(String storeID) async {
    /// Url
    String url = AppUrls.getStoreData(storeID);

    /// Header
    var header = await headerWithBearerToken();

    /// Request
    var response = await http.get(
      Uri.parse(url),
      headers: header,
    );

    if (kDebugMode) {
      print("Called API: $url");
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      print("HEADERS: $header");
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = jsonDecode(response.body.toString());
      log(data.toString());
      data = [data];
      if (data[0]["status"].toString() == "true") {
        var res = LoginModel.Store.fromJson(
            data[0]["data"][0].map((x) => LoginModel.Store.fromJson(x)));
        return res;
      } else if (data[0]["status"].toString() == "false") {
        Get.snackbar('Error', data[0]['message'],
            snackPosition: SnackPosition.TOP, colorText: Colors.white);
      }
      return jsonDecode(response.body.toString());
    }

    if (response.statusCode == 401) {
      // shippingController.isLoading.value = false;
      Get.offAll(() => const LoginScreen());
      throw Exception('Not Authorized');
    }
    if (response.statusCode == 400) {
      // shippingController.isLoading.value = false;
      Get.back();
      throw Exception('Not found');
    }
    if (response.statusCode == 500) {
      // shippingController.isLoading.value = false;
      Get.back();
      throw Exception('Server Not Responding');
    }
  }

  updateProduct(
    context,
    String? name,
    String? price,
    String? qty,
    List<DisplaySize> size,
    String? memory,
    String? conditionType,
    String? deliveryType,
    String? model,
    String? hardDrive,
    String? color,
    String? descriptions,
    // String? createdAt,
    String? productShippingCost,
    String? productVisibility,
    File? productImage,
    String productID,
    List<dash.ProductImage> deleteImageIds,
  ) async {
    final productController = Get.put(ProductController());

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: Loader.spinkit,
        );
      },
    );

    /// Url
    String url = AppUrls.kProductUpdate(productID);
    var request = http.MultipartRequest('POST', Uri.parse(url));
    for (var entry in productController.addproductApiModel.entries) {
      // Print the key and value
      if (entry.value is List) {
        // print(entry.key == "deleteImage[]");
        if (entry.key == "images[]") {
          for (var item in entry.value) {
            print("Key Images[]: ${entry.key} Value: ${item}");
            File imgFile = File(item);
            var stream =
                new http.ByteStream(DelegatingStream.typed(imgFile.openRead()
                    // imageFile.openRead()
                    ));
            var length = await imgFile.length();
            var multipartFile = new http.MultipartFile(
                entry.key.toString(), stream, length,
                filename: basename(imgFile.path));
            request.files.add(multipartFile);
          }
        } else {
          //for size[]
          for (var item in entry.value) {
            if (entry.key == "size[]") {
              // print("=========?"+item.toString());
              // // item = 12;
              // request.fields[entry.key] =12;
            }
            print("Key: ${entry.key} Value: ${item}");
            request.fields[entry.key.toString()] = item.toString();
          }
        }
      } else {
        // if (entry.key == "deleteImage[]") {
        // // for (String deleteImageId in deleteImageIds) {
        // //   request.fields['deleteImage[]'] = deleteImageId;
        // // }
        // log("Check Delete Image: ${entry.key.toString()}");
        // }

        print("Key: ${entry.key} Value: ${entry.value}");
        request.fields[entry.key.toString()] = entry.value.toString();
        request.fields.addAll({entry.key: entry.value.toString()});
        // print("========> requerst"+request.fields.a);
      }
      // print("Key: ${entry.key} Value: ${entry.value}");
    }

    for (int i = 0; i < deleteImageIds.length; i++) {
      print("i is having value $i");
      request.fields["deleteImage[$i][id]"] = deleteImageIds[i].id.toString();

      // File imgFile = File(deleteImageIds[i].name.toString());
      // var stream = new http.ByteStream(DelegatingStream.typed(imgFile.openRead()
      //     // imageFile.openRead()
      //     ));
      // var length = await imgFile.length();
      // var multipartFile = new http.MultipartFile(
      //     "deleteImage[$i][id]", stream, length,
      //     filename: basename(imgFile.path));
      // request.files.add(multipartFile);
    }
    var header = await headerWithBearerToken();

    request.headers.addAll(header);
    var respond = await request.send();
    final http.Response response = await http.Response.fromStream(respond);
    var res_data = json.decode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("status code${respond.statusCode}");
      productController.deletedExistingImageList.clear();
      print("=======================================>sent body" +
          request.fields.toString());
      print(response.body);
      log(res_data.toString());
      if (res_data['status'] == "true") {
        await viewStoreByID(storeId);
        // Get.back();
        Get.offUntil(
          MaterialPageRoute(
              builder: (context) => MyStoreProfileScreen(
                    storeId: storeId,
                  )),
          (Route<dynamic> route) => route.settings.name == "/StartAppScreen",
        );
        // Get.back();        // for (int i = 0; i < 0 + 1; i++) {
        //   Get.back();

        // Get.offUntil(
        //   MaterialPageRoute(
        //       builder: (context) => MyStoreProfileScreen(
        //             storeId: storeId,
        //           )),
        //   (Route<dynamic> route) =>
        //       route.settings.name == "/MyStoreProfileScreen",
        // );
        // Get.off(
        //       () => MyStoreProfileScreen(
        //     storeId: storeId,
        //   ),
        // );
        // Get.back();
        // Get.offAll(() =>MyStoreProfileScreen(storeId: addProductController.addproductApiModel["store_id"]));
        Get.snackbar('Success', "Product updated successfully",
            snackPosition: SnackPosition.TOP,
            colorText: Colors.white,
            backgroundColor: Colors.green);
      } else {
        Get.back();
        Get.snackbar('Error', res_data['message'],
            snackPosition: SnackPosition.TOP, colorText: Colors.white);
      }
    } else {
      // print("Upload Failed");
      Get.back();
      Get.snackbar('Error', res_data['message'],
          snackPosition: SnackPosition.TOP, colorText: Colors.white);
    }
  }

  /// delete the product
  Future<ProductSingle?> deleteProduct(
      BuildContext context, int productID, String storeID) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: Loader.spinkit,
        );
      },
    );

    /// Url
    String url = AppUrls.kProductDelete(productID);

    /// Headers
    var header = await headerWithBearerToken();

    /// Request
    var response = await http.delete(
      Uri.parse(url),
      headers: header,
    );

    if (kDebugMode) {
      print("Called API: $url");
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      print("HEADERS: $header");
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      await viewStoreByID(storeID);
      // Get.off(
      //   () => MyStoreProfileScreen(
      //     storeId: storeId,
      //   ),
      // );
      Get.offUntil(
        MaterialPageRoute(
            builder: (context) => MyStoreProfileScreen(
                  storeId: storeId,
                )),
        (Route<dynamic> route) =>
            route.settings.name == "/MyStoreProfileScreen",
      );
      Get.back();
      Get.snackbar('Success', "Product Deleted!",
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: Colors.green);
      return productSingleFromJson(response.body);
    }
    if (response.statusCode == 401) {
      Get.offAll(() => const LoginScreen());
      throw Exception('Not Authorized');
    }
    if (response.statusCode == 400) {
      Get.back();
      throw Exception('Not found');
    }
    if (response.statusCode == 500) {
      Get.back();
      throw Exception('Server Not Responding');
    }
  }

  // <<<<<<<<<<<<<<<<Product Listing >>>>>>>>>>>>>>>>

  static List<ProductCategoryDataModel> productCategoryDataList = [];

  productCategoryApiFunc() async {
    try {
      var header = await headerWithBearerToken();

      final response =
          await http.get(Uri.parse(AppUrls.kProductCategory), headers: header);
      var data = jsonDecode(response.body.toString());
      log(data.toString());
      data = [data];
      if (data[0]["status"].toString() == "true") {
        productCategoryDataList.clear();
        for (Map i in data) {
          productCategoryDataList.add(ProductCategoryDataModel.fromJson(i));
        }
        return productCategoryDataList;
      } else if (data[0]["status"].toString() == "false") {
        Get.snackbar('Error', data[0]['message'],
            snackPosition: SnackPosition.TOP, colorText: Colors.white);
      }
    } catch (e) {
      // Get.snackbar('Error', e.toString(),
      //     snackPosition: SnackPosition.TOP, colorText: Colors.white);
    }
  }

  /// edit the product discount
  Future<ProductSingle?> editProductDiscount(
    int productID,
    String discountName,
    String discountType,
    String startDateTime,
    String endDateTime,
    String perTarget,
    String price,
  ) async {
    // showDialog(
    //   context: context,
    //   barrierDismissible: false,
    //   builder: (BuildContext context) {
    //     return const Center(
    //       child: Loader.spinkit,
    //     );
    //   },
    // );

    /// Url
    String url = AppUrls.updateProductDiscount;

    /// Headers
    var header = await headerWithBearerToken();

    /// API body
    var data = {
      "product_id": productID.toString(),
      "name": discountName,
      "type": discountType,
      "start_datetime": startDateTime,
      "end_datetime": endDateTime,
      "percentage_target": perTarget,
      "price": price
    };

    /// Request
    var response = await http.post(
      Uri.parse(url),
      headers: header,
      body: data,
    );

    if (kDebugMode) {
      print("Called API: $url");
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      print("HEADERS: $header");
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      // await productListingApiFunc(storeID);
      // Get.off(
      //   () => MyStoreProfileScreen(
      //     storeId: storeId,
      //   ),
      // );
      // Get.back();
      // Get.offUntil(
      //   MaterialPageRoute(
      //       builder: (context) => MyStoreProfileScreen(
      //             storeId: storeId,
      //           )),
      //   (Route<dynamic> route) =>
      //       route.settings.name == "/MyStoreProfileScreen",
      // );
      // Get.back();

      // Get.snackbar('Success', "Product Deleted!",
      //     snackPosition: SnackPosition.TOP,
      //     colorText: Colors.white,
      //     backgroundColor: Colors.green);
      return productSingleFromJson(response.body);
    }
    if (response.statusCode == 401) {
      Get.offAll(() => const LoginScreen());
      throw Exception('Not Authorized');
    }
    if (response.statusCode == 400) {
      Get.back();
      throw Exception('Not found');
    }
    if (response.statusCode == 500) {
      Get.back();
      throw Exception('Server Not Responding');
    }
  }

////////~~~~~  Shipping Address APIs  ~~~~~~~////////////

// Adding Shipping Address

  postShippingAddress(
    BuildContext context,
    String countryName,
    String contactDetails,
    String phoneNumber,
    String address,
    String city,
    String zipCode,
  ) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: Loader.spinkit,
        );
      },
    );

    /// Url
    String url = AppUrls.createShipping;

    /// Header
    var header = await headerWithBearerToken();
    ;

    ///body
    var data = {
      "address_line1": address,
      "city": city,
      "postal_code": zipCode,
      "country": countryName,
      "mobile_number": phoneNumber,
    };

    /// Request
    var response = await http.post(Uri.parse(url), headers: header, body: data);

    if (kDebugMode) {
      print("Called API: $url");
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      print("HEADERS: $header");
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Get.back();
      Get.offUntil(
        MaterialPageRoute(builder: (context) => ShippingAddressScreen()),
        (Route<dynamic> route) =>
            route.settings.name == "/OrderConfirmationScreen",
      );

      // Get.offNamed("/ShippingAddressScreen");

      listShippingAddresses();

      Get.snackbar(
        'Success',
        "Shipping Address Added!",
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: Colors.green,
      );

      return json.decode(response.body);
    }
    if (response.statusCode == 401) {
      Get.offAll(() => const LoginScreen());
      throw Exception('Not Authorized');
    }
    if (response.statusCode == 400) {
      Get.back();
      throw Exception('Not found');
    }
    if (response.statusCode == 500) {
      Get.back();
      throw Exception('Server Not Responding');
    }
  }

  // Getting the list of shipping Addresses

  listShippingAddresses() async {
    final shippingController = Get.put(ShippingController());
    shippingController.isLoading.value = true;
    // showDialog(
    //   context: context,
    //   barrierDismissible: false,
    //   builder: (BuildContext context) {
    //     return const Center(
    //       child: Loader.spinkit,
    //     );
    //   },
    // );

    /// Url
    String url = AppUrls.listShipping;

    /// Header
    var header = await headerWithBearerToken();

    /// Request
    var response = await http.get(
      Uri.parse(url),
      headers: header,
    );

    if (kDebugMode) {
      print("Called API: $url");
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      print("HEADERS: $header");
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      shippingController.completeShippingModel.value =
          shippingAddressFromJson(response.body);
      // Get.back();
      // Get.back();
      var data = jsonDecode(response.body.toString());
      log(data.toString());
      data = [data];

      if (data[0]["status"].toString() == "true") {
        shippingController.completeShippingAddresses.clear();

        for (ShippingModel i
            in shippingController.completeShippingModel.value.data!) {
          if (i.setAsDefault == "yes") {
            print("=========================================== loop in model");
            print(i);
            shippingController.defaultShippingModel.value = i;
          }
        }
        for (Map i in data) {
          print("==========================");
          print(i["data"]);
          shippingController.completeShippingAddresses.value = i["data"];
          // shippingController.completeShippingAddresses
          //     .add(ShippingModel.fromJson(i));
        }
        shippingController.isLoading.value = false;

        return shippingController.completeShippingAddresses;
      } else if (data[0]["status"].toString() == "false") {
        Get.snackbar('Error', data[0]['message'],
            snackPosition: SnackPosition.TOP, colorText: Colors.white);
      }
      return jsonDecode(response.body.toString());
    }

    if (response.statusCode == 401) {
      shippingController.isLoading.value = false;
      Get.offAll(() => const LoginScreen());
      throw Exception('Not Authorized');
    }
    if (response.statusCode == 400) {
      shippingController.isLoading.value = false;
      Get.back();
      throw Exception('Not found');
    }
    if (response.statusCode == 500) {
      shippingController.isLoading.value = false;
      Get.back();
      throw Exception('Server Not Responding');
    }
  }

  /// Editing the Shipping Address

  editShippingAddress(
    BuildContext context,
    String? shippingID,
    String? addressLine,
    String? city,
    String? postalCode,
    String? country,
    String? mobileNumber,
    String? setAsDefault,
  ) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: Loader.spinkit,
        );
      },
    );

    /// Url
    String url = AppUrls.kUpdateShipping(
      shippingID,
      addressLine,
      city,
      postalCode,
      country,
      mobileNumber,
      setAsDefault,
    );

    /// Header
    var header = await headerWithBearerToken();

    /// Request
    var response = await http.put(
      Uri.parse(url),
      headers: header,
    );

    if (kDebugMode) {
      print("Called API: $url");
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      print("HEADERS: $header");
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Get.back();
      // Get.back();
      // Get.back();
      listShippingAddresses();
      Get.offUntil(
        MaterialPageRoute(builder: (context) => ShippingAddressScreen()),
        (Route<dynamic> route) =>
            route.settings.name == "/OrderConfirmationScreen",
      );
      Get.snackbar(
        'Success',
        "Address Updated Successfully",
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: Colors.green,
      );
      return jsonDecode(response.body.toString());
    }

    if (response.statusCode == 401) {
      // shippingController.isLoading.value = false;
      Get.offAll(() => const LoginScreen());
      throw Exception('Not Authorized');
    }
    if (response.statusCode == 400) {
      // shippingController.isLoading.value = false;

      Get.back();
      throw Exception('Not found');
    }
    if (response.statusCode == 500) {
      // shippingController.isLoading.value = false;
      Get.back();
      throw Exception('Server Not Responding');
    }
  }

// deleting shipping address
  deleteShippingAddress(String shippingID, BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: Loader.spinkit,
        );
      },
    );

    /// Url
    String url = AppUrls.deleteShippingAddress(shippingID);

    /// Header
    var header = await headerWithBearerToken();

    /// Request
    var response = await http.delete(
      Uri.parse(url),
      headers: header,
    );

    if (kDebugMode) {
      print("Called API: $url");
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      print("HEADERS: $header");
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Get.back();
      Get.back();
      Get.back();
      Get.offNamed("/ShippingAddressScreen");

      listShippingAddresses();
      // Get.back();
      // Get.back();
      // Get.back();
      Get.snackbar(
        'Success',
        "Shipping Address Deleted!",
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: Colors.green,
      );
      return jsonDecode(response.body.toString());
    }

    if (response.statusCode == 401) {
      // shippingController.isLoading.value = false;
      Get.offAll(() => const LoginScreen());
      throw Exception('Not Authorized');
    }
    if (response.statusCode == 400) {
      // shippingController.isLoading.value = false;

      Get.back();
      throw Exception('Not found');
    }
    if (response.statusCode == 500) {
      // shippingController.isLoading.value = false;
      Get.back();
      throw Exception('Server Not Responding');
    }
  }

  setAsDefaultShippingAddress(BuildContext context, String shippingID) async {
    final shippingController = Get.put(ShippingController());

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: Loader.spinkit,
        );
      },
    );

    /// Url
    String url = AppUrls.setDefaultShipping(shippingID);

    /// Header
    var header = await headerWithBearerToken();

    /// Request
    var response = await http.put(
      Uri.parse(url),
      headers: header,
    );

    if (kDebugMode) {
      print("Called API: $url");
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      print("HEADERS: $header");
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Get.back();
      // Get.back();
      shippingController.defaultShippingModel.value =
          ShippingModel.fromJson(jsonDecode(response.body));
      // Get.back();
      // Get.offNamed("/ShippingAddressScreen");
      listShippingAddresses();
      Get.off(() => OrderConfirmation());
      // Get.back();
      // Get.back();
      // Get.back();
      Get.snackbar(
        'Success',
        "Default Address Updated!",
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: Colors.green,
      );
      return jsonDecode(response.body.toString());
    }

    if (response.statusCode == 401) {
      // shippingController.isLoading.value = false;
      Get.offAll(() => const LoginScreen());
      throw Exception('Not Authorized');
    }
    if (response.statusCode == 400) {
      // shippingController.isLoading.value = false;

      Get.back();
      throw Exception('Not found');
    }
    if (response.statusCode == 500) {
      // shippingController.isLoading.value = false;
      Get.back();
      throw Exception('Server Not Responding');
    }
  }

  ////~~~~~~~~~~~~~~~~~~Payment Cards CRUD~~~~~~~~~~~~~~~~~~~////
  /// get all the payment cards
  Future<List<CardModel>?> getPaymentCards() async {
    /// Url
    String url = AppUrls.listPaymentCards;

    /// Header
    var header = await headerWithBearerToken();

    /// Request
    var response = await http.get(
      Uri.parse(url),
      headers: header,
    );

    if (kDebugMode) {
      print("Called API: $url");
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      print("HEADERS: $header");
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Get.back();
      // Get.back();
      var data = jsonDecode(response.body.toString());
      log(data.toString());
      data = [data];
      if (data[0]["status"].toString() == "true") {
        return paymentCardModelFromJson(response.body).data;
      } else if (data[0]["status"].toString() == "false") {
        Get.snackbar('Error', data[0]['message'],
            snackPosition: SnackPosition.TOP, colorText: Colors.white);
      }
      return jsonDecode(response.body.toString());
    }
    if (response.statusCode == 401) {
      Get.offAll(() => const LoginScreen());
      throw Exception('Not Authorized');
    }
    if (response.statusCode == 400) {
      Get.back();
      throw Exception('Not found');
    }
    if (response.statusCode == 500) {
      Get.back();
      throw Exception('Server Not Responding');
    }
  }

  /// Adding Payment Card
  Future<CardModel?> postPaymentCard(CardModel postData) async {
    /// Url
    String url = AppUrls.addPaymentCard;

    /// Header

    ///split expiry String
    var splittedExp = postData.expDate!.split("/");

    ///Body
    var data = {
      // body is updated after change of APIs. 06/Sept/2023 2:54 AM
      "name": postData.name,
      "card_number": postData.cardNumber,
      "cvc_cvv": postData.cvcCvv,
      // "cvc_check": "true",
      // "brand": "master card",
      // "stripe_create_id": "card_1NTmM72eZvKYlo2CRk8YhSzH",
      // "country": "US",
      "exp_month": splittedExp[0],
      "exp_year": splittedExp[1],
      // "fingerprint": "Xt5EWLLDS7FJjR1c",
      // "funding": "credit",
      // "last4": postData.cardNumber!.substring(postData.cardNumber!.length - 5),
      "set_as_default": "no"
    };
    var header = await headerWithBearerToken();

    /// Request
    var response = await http.post(
      Uri.parse(url),
      headers: header,
      body: data,
    );

    if (kDebugMode) {
      print("Called API: $url");
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      print("Response Body: ${splittedExp[0]}");
      print("Response Body: ${splittedExp[1]}");
      print("HEADERS: $header");
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Get.back();
      // Get.back();
      var data = jsonDecode(response.body.toString());
      log(data.toString());
      data = [data];
      if (data[0]["status"].toString() == "true") {
        return CardModel.fromJson(jsonDecode(response.body.toString()));
      } else if (data[0]["status"].toString() == "false") {
        print("==============> Entered in false status");
      }
      return jsonDecode(response.body.toString());
    }
    if (response.statusCode == 401) {
      Get.offAll(() => const LoginScreen());
      throw Exception('Not Authorized');
    }
    if (response.statusCode == 400) {
      Get.back();
      throw Exception('Not found');
    }
    if (response.statusCode == 500) {
      var data = jsonDecode(response.body.toString());
      data = [data];
      // log(data[0]["message"].toString());
      // if (data[0]["status"].toString() == "false") {
      Get.snackbar('Error', data[0]['message'],
          snackPosition: SnackPosition.TOP, colorText: Colors.white);
      // }
      // Get.back();
    }
  }

  /// Editing Payment Card
  Future<CardModel?> editPaymentCard(CardModel postData) async {
    ///splitting expiry
    var splittedExp = postData.expDate!.split("/");

    /// Url
    String url = AppUrls.editPaymentCard(
      postData.id,
      postData.name,
      postData.cardNumber,
      postData.cvcCvv,
      splittedExp[0],
      splittedExp[1],
      postData.setAsDefault,
    );

    /// Header
    var header = await headerWithBearerToken();

    // ///Body
    // var data = {
    //   // body is updated after change of APIs. 06/Sept/2023 2:54 AM
    //   "name": postData.name,
    //   "card_number": postData.cardNumber,
    //   "cvc_cvv": postData.cvcCvv,
    //   // "cvc_check": "true",
    //   // "brand": "master card",
    //   // "stripe_create_id": "card_1NTmM72eZvKYlo2CRk8YhSzH",
    //   // "country": "US",
    //   "exp_month": postData.expDate!.substring(0, 2),
    //   "exp_year": postData.expDate!.substring(4, 7),
    //   // "fingerprint": "Xt5EWLLDS7FJjR1c",
    //   // "funding": "credit",
    //   // "last4": postData.cardNumber!.substring(postData.cardNumber!.length - 5),
    //   "set_as_default": "no"
    // };

    /// Request
    var response = await http.put(
      Uri.parse(url),
      headers: header,
      // body: data,
    );

    if (kDebugMode) {
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      print("HEADERS: $header");
      print("Called API: $url");
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Get.back();
      // Get.back();
      var data = jsonDecode(response.body.toString());
      log(data.toString());
      data = [data];
      if (data[0]["status"].toString() == "true") {
        return CardModel.fromJson(jsonDecode(response.body.toString()));
      } else if (data[0]["status"].toString() == "false") {
        print("==============> Entered in false status");
        Get.snackbar('Error', data[0]['message'],
            snackPosition: SnackPosition.TOP, colorText: Colors.white);
      }
      return jsonDecode(response.body.toString());
    }
    if (response.statusCode == 401) {
      Get.offAll(() => const LoginScreen());
      throw Exception('Not Authorized');
    }
    if (response.statusCode == 400) {
      Get.back();
      throw Exception('Not found');
    }
    if (response.statusCode == 500) {
      // Get.back();
      throw Exception('Server Not Responding');
    }
  }

  /// Deleting Payment Card
  Future<CardModel?> deletePaymentCard(String cardID) async {
    /// Url
    String url = AppUrls.deletePaymentCard(cardID);

    /// Header
    var header = await headerWithBearerToken();

    /// Request
    var response = await http.delete(
      Uri.parse(url),
      headers: header,
    );

    if (kDebugMode) {
      print("Called API: $url");
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      print("HEADERS: $header");
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Get.back();
      // Get.back();
      var data = jsonDecode(response.body.toString());
      log(data.toString());
      data = [data];
      if (data[0]["status"].toString() == "true") {
        return CardModel.fromJson(jsonDecode(response.body.toString()));
      } else if (data[0]["status"].toString() == "false") {
        Get.snackbar('Error', data[0]['message'],
            snackPosition: SnackPosition.TOP, colorText: Colors.white);
      }
      return jsonDecode(response.body.toString());
    }
    if (response.statusCode == 401) {
      Get.offAll(() => const LoginScreen());
      throw Exception('Not Authorized');
    }
    if (response.statusCode == 400) {
      Get.back();
      throw Exception('Not found');
    }
    if (response.statusCode == 500) {
      Get.back();
      throw Exception('Server Not Responding');
    }
  }

  ///setting payment card as default
  Future<CardModel?> cardSetAsDefault(String cardID) async {
    /// Url
    String url = AppUrls.cardSetAsDefault(cardID);

    /// Header
    var header = await headerWithBearerToken();

    /// Request
    var response = await http.put(
      Uri.parse(url),
      headers: header,
    );

    if (kDebugMode) {
      print("Called API: $url");
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      print("HEADERS: $header");
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Get.back();
      // Get.back();
      var data = jsonDecode(response.body.toString());
      log(data.toString());
      data = [data];
      if (data[0]["status"].toString() == "true") {
        return CardModel.fromJson(jsonDecode(response.body.toString()));
      } else if (data[0]["status"].toString() == "false") {
        Get.snackbar('Error', data[0]['message'],
            snackPosition: SnackPosition.TOP, colorText: Colors.white);
      }
      return jsonDecode(response.body.toString());
    }
    if (response.statusCode == 401) {
      Get.offAll(() => const LoginScreen());
      throw Exception('Not Authorized');
    }
    if (response.statusCode == 400) {
      Get.back();
      throw Exception('Not found');
    }
    if (response.statusCode == 500) {
      Get.back();
      throw Exception('Server Not Responding');
    }
  }

////~~~~~~~~~~~~~~~~~~DashBoard APIs~~~~~~~~~~~~~~~~~~~////
  Future<DashBoardModel> getDashBoardData() async {
    ChatController chatController = Get.put(ChatController());

    /// Url
    String url = AppUrls.dashBoard;

    /// Header

    String authToken =
        await LocalStorage.readJson(key: LocalStorageKeys.authToken);
    var header = {'Authorization': 'Bearer $authToken'};

    /// Request
    var response = await http.get(
      Uri.parse(url),
      headers: header,
    );

    if (kDebugMode) {
      print("Called API: $url");
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      print("HEADERS: $header");
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Get.back();
      // Get.back();
      var data = jsonDecode(response.body.toString());
      log(data.toString());
      data = [data];
      if (data[0]["status"].toString() == "true") {
        FirebaseServices().getUniqueMembers();
        getUsersData(chatController.listOfUserIDs.value);

        return dashBoardModelFromJson(response.body);
      } else if (data[0]["status"].toString() == "false") {
        Get.snackbar('Error', data[0]['message'],
            snackPosition: SnackPosition.TOP, colorText: Colors.white);
      }
      return jsonDecode(response.body.toString());
    }
    if (response.statusCode == 401) {
      Get.offAll(() => const LoginScreen());
      throw Exception('Not Authorized');
    }
    if (response.statusCode == 400) {
      Get.back();
      throw Exception('Not found');
    }
    if (response.statusCode == 500) {
      // Get.back();
      throw Exception('Server Not Responding');
    }
    return jsonDecode(response.body.toString());
  }

  Future<DashBoardFilter> getDashBoardFilterData(String filterType) async {
    ChatController chatController = Get.put(ChatController());

    /// Url
    String url = AppUrls.getProductsWithFilter(filterType);

    /// Header

    String authToken =
        await LocalStorage.readJson(key: LocalStorageKeys.authToken);
    var header = {'Authorization': 'Bearer $authToken'};

    /// Request
    var response = await http.get(
      Uri.parse(url),
      headers: header,
    );

    if (kDebugMode) {
      print("Called API: ${url.toString()}");
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      print("HEADERS: $header");
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Get.back();
      // Get.back();
      var data = jsonDecode(response.body.toString());
      log(data.toString());
      data = [data];
      if (data[0]["status"].toString() == "true") {
        FirebaseServices().getUniqueMembers();
        getUsersData(chatController.listOfUserIDs.value);

        return dashBoardFilterFromJson(response.body);
      } else if (data[0]["status"].toString() == "false") {
        Get.snackbar('Error', data[0]['message'],
            snackPosition: SnackPosition.TOP, colorText: Colors.white);
      }
      return jsonDecode(response.body.toString());
    }
    if (response.statusCode == 401) {
      Get.offAll(() => const LoginScreen());
      throw Exception('Not Authorized');
    }
    if (response.statusCode == 400) {
      Get.back();
      throw Exception('Not found');
    }
    if (response.statusCode == 500) {
      // Get.back();
      throw Exception('Server Not Responding');
    }
    return jsonDecode(response.body.toString());
  }

////~~~~~~~~~~~~~~~~~~Filter APIs~~~~~~~~~~~~~~~~~~~////
  Future<FilterModel> getFilters() async {
    /// Url
    String url = AppUrls.listOfFilters;

    /// Header
    var header = await headerWithBearerToken();

    /// Request
    var response = await http.get(
      Uri.parse(url),
      headers: header,
    );

    if (kDebugMode) {
      print("Called API: $url");
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      print("HEADERS: $header");
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Get.back();
      // Get.back();
      var data = jsonDecode(response.body.toString());
      log(data.toString());
      data = [data];
      if (data[0]["status"].toString() == "true") {
        return filterModelFromJson(response.body);
      } else if (data[0]["status"].toString() == "false") {
        Get.snackbar('Error', data[0]['message'],
            snackPosition: SnackPosition.TOP, colorText: Colors.white);
      }
      return filterModelFromJson(response.body.toString());
    }
    if (response.statusCode == 401) {
      Get.offAll(() => const LoginScreen());
      throw Exception('Not Authorized');
    }
    if (response.statusCode == 400) {
      Get.back();
      throw Exception('Not found');
    }
    if (response.statusCode == 500) {
      Get.back();
      throw Exception('Server Not Responding');
    }
    return filterModelFromJson(response.body.toString());
  }

  searchFilter() async {
    final filterController = Get.put(FilterController());
    filterController.isApplyingFilters.value = true;

    // create a multipart request
    var header = await newHeaderWithBearerTokenAndMultipart();

    var request =
        http.MultipartRequest('POST', Uri.parse(AppUrls.searchFilterApi));

    request.headers.addAll(header);

    Map<String, String> data = {};
    for (var i = 0; i < filterController.ListOfBrands.length; i++) {
    data["brand_name[$i]"] = filterController.ListOfBrands[i].name;
    }

    /// adding display size
    for (var i = 0; i < filterController.sizeList.length; i++) {
     data["display_size[$i]"] = filterController.sizeList[i].name;
    }

    /// adding item type\
    if(filterController.itemTypeList.length!=2){
      // for (var i = 0; i < filterController.itemTypeList.length; i++) {
        data["condition_type"] = filterController.itemTypeList.first.toString();
      // }
    }

    request.fields.addAll(data);

    // adding all the fields in the request
    // request.fields['user_card_id'] = cardID;
    // request.fields['user_address_id'] = addressID;
    // request.fields['total_amount'] = totalAmount;
    // request.fields['payment_type'] = paymentType;
    //
    // // taking the cart list as input and adding orderItem fields
    // for (var i = 0; i < orderList.length; i++) {
    //   request.fields["orderitems[$i][qty]"] = orderList[i].quantity.toString();
    //   request.fields["orderitems[$i][product_id]"] =
    //       orderList[i].datum.id.toString();
    // }
    // adding headers
    //sending request
    var respond = await request.send();
    // getting response
    final http.Response response = await http.Response.fromStream(respond);
    filterController.filteredData.value =
        searchFilterProductListModelFromJson(response.body).data ?? [];

    if (kDebugMode) {
      print("Called API: ${AppUrls.searchFilterApi}");
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      print("Send body" + request.fields.toString());
      // print(

      // "filtered list if of Length: ${filterController.filteredData.length.}");
      print("HEADERS: ${request.headers}");
    }

    log("response" + response.statusCode.toString());
    filterController.isApplyingFilters.value = false;
  }

  Future<List<dash.User>?> getUsersData(List userIDs) async {
    final ChatController chatController = Get.put(ChatController());
    chatController.isLoading.value = true;
    final dio = DIO.Dio();
    final Map<String, dynamic> queryParameters = {
      // "min_price": filterController.lowerValue.value,
      // "max_price": filterController.upperValue.value
    };

    // FirebaseServices().getUniqueMembers().then((value) => log("firebaseeeeeeeee"+value.toString()));
    String token = await LocalStorage.readJson(key: LocalStorageKeys.authToken);

    /// Header
    var header = {"Authorization": "Bearer $token"};

    for (var i = 0; i < userIDs.length; i++) {
      queryParameters["UserID[$i]"] = userIDs[i];
    }
    try {
      final DIO.Options dioHeader = DIO.Options(headers: header);
      final DIO.Response response = await dio.get(AppUrls.searchUsers,
          queryParameters: queryParameters, options: dioHeader);
      if (kDebugMode) {
        print("Called API: ${AppUrls.searchUsers}");
        print("Status Code: ${response.statusCode}");
        print("Response Body: ${response.data["data"]}");
        print("Sent Body: ${queryParameters}");
        // print(
        // "filtered list if of Length: ${filterController.filteredData
        //     .length}");
        print("HEADERS: $header");
      }
      ;
      if (response.statusCode == 200 || response.statusCode == 201) {
        var totalResponse = List<dash.User>.from(
            response.data["data"].map((x) => dash.User.fromJson(x)));
        log("total response" + totalResponse.toString());
        chatController.listOfUsers.value = totalResponse;
        chatController.update();
        log("res" + chatController.listOfUsers.toString());
        chatController.isLoading.value = false;
        return chatController.listOfUsers;
      }
      if (response.statusCode == 422) {
        // Utils.showFloatingErrorSnack(response.data["message"]);
        chatController.isLoading.value = false;
      }
      if (response.statusCode == 500) {
        Utils.showFloatingErrorSnack("Internal Server Error");
        chatController.isLoading.value = false;
      }
      log("response" + response.statusCode.toString());
      chatController.isLoading.value = false;
      return chatController.listOfUsers;
    } on DIO.DioException catch (e) {
      chatController.isLoading.value = false;
      log("the catch is " + e.toString());
      // return chatController.listOfUsers;
    }
  }

  Future<FilterBrandModel> searchBrands(String brandID) async {
    /// Url
    String url = AppUrls.brandFilter(brandID);

    /// Header
    var header = await headerWithBearerToken();

    /// Request
    var response = await http.get(
      Uri.parse(url),
      headers: header,
    );

    if (kDebugMode) {
      print("Called API: $url");
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      print("HEADERS: $header");
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Get.back();
      // Get.back();
      var data = jsonDecode(response.body.toString());
      log(data.toString());
      data = [data];
      if (data[0]["status"].toString() == "true") {
        return filterBrandModelFromJson(response.body);
      } else if (data[0]["status"].toString() == "false") {
        Get.snackbar('Error', data[0]['message'],
            snackPosition: SnackPosition.TOP, colorText: Colors.white);
      }
      return filterBrandModelFromJson(response.body.toString());
    }
    if (response.statusCode == 401) {
      Get.offAll(() => const LoginScreen());
      throw Exception('Not Authorized');
    }
    if (response.statusCode == 400) {
      // Get.back();
      throw Exception('No Products Found');
    }
    if (response.statusCode == 500) {
      Get.back();
      throw Exception('Server Not Responding');
    }
    return filterBrandModelFromJson(response.body.toString());
  }

////~~~~~~~~~~~~~~~~~~WishList APIs~~~~~~~~~~~~~~~~~~~////

  /// adding an item to wishList by product ID
  Future<WishListModel> postWishList(String productID) async {
    /// Url
    String url = AppUrls.postWishList;

    /// Header
    var header = await headerWithBearerToken();

    /// body
    var data = {"product_id": productID, "type": "product"};

    /// Request
    var response = await http.post(Uri.parse(url), headers: header, body: data);

    if (kDebugMode) {
      print("Called API: $url");
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      print("HEADERS: $header");
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      return wishListModelFromJson(response.body.toString());
    }
    if (response.statusCode == 422) {
      Get.snackbar('Oops!', "Already Added to wishList",
          snackPosition: SnackPosition.TOP, colorText: Colors.white);
      // return wishListModelFromJson(response.body.toString());
    }
    if (response.statusCode == 401) {
      Get.offAll(() => const LoginScreen());
      throw Exception('Not Authorized');
    }
    if (response.statusCode == 400) {
      Get.back();
      throw Exception('Not found');
    }
    if (response.statusCode == 500) {
      Get.back();
      throw Exception('Server Not Responding');
    }
    return wishListModelFromJson(response.body.toString());
  }

  /// getting the complete wishList of the user
  Future<WishListModel> getWishList() async {
    /// Url
    String url = AppUrls.getWishList;

    /// Header
    var header = await headerWithBearerToken();

    /// Request
    var response = await http.get(
      Uri.parse(url), headers: header,
      // body: data
    );

    if (kDebugMode) {
      print("Called API: $url");
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      print("HEADERS: $header");
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      return wishListModelFromJson(response.body.toString());
    }
    if (response.statusCode == 422) {
      Utils.showFloatingErrorSnack("Something went wrong");
      // return wishListModelFromJson(response.body.toString());
    }
    if (response.statusCode == 401) {
      Get.offAll(() => const LoginScreen());
      throw Exception('Not Authorized');
    }
    if (response.statusCode == 400) {
      Get.back();
      throw Exception('Not found');
    }
    if (response.statusCode == 500) {
      // Get.back();
      throw Exception('Server Not Responding');
    }
    return wishListModelFromJson(response.body.toString());
  }

  /// deleting the wishList by product ID
  Future<WishListModel> removeWishList(String productID) async {
    /// Url
    String url = AppUrls.removeWishList;

    /// Header
    var header = await headerWithBearerToken();

    /// body
    var data = {"product_id": productID, "type": "product"};

    /// Request
    var response = await http.post(Uri.parse(url), headers: header, body: data);

    if (kDebugMode) {
      print("Called API: $url");
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      print("HEADERS: $header");
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      return wishListModelFromJson(response.body.toString());
    }
    if (response.statusCode == 422) {
      Utils.showFloatingErrorSnack("Already removed from wishList");
      // return wishListModelFromJson(response.body.toString());
    }
    if (response.statusCode == 401) {
      Get.offAll(() => const LoginScreen());
      throw Exception('Not Authorized');
    }
    if (response.statusCode == 400) {
      Get.back();
      throw Exception('Not found');
    }
    if (response.statusCode == 500) {
      Get.back();
      throw Exception('Server Not Responding');
    }
    return wishListModelFromJson(response.body.toString());
  }

////~~~~~~~~~~~~~~~~~~Notification APIs~~~~~~~~~~~~~~~~~~~////
  changeNotificationStatus(bool notificationStatus, context) async {
    /// Url
    String url = AppUrls.changeNotificationStatus;

    /// Header
    var header = await headerWithBearerToken();

    /// body
    var data = {"status": notificationStatus ? 1.toString() : 0.toString()};

    /// Request
    var response = await http.post(Uri.parse(url), headers: header, body: data);

    if (kDebugMode) {
      print("Called API: $url");
      print("Status Code: ${response.statusCode}");
      print("Sent body: ${data}");
      print("Response Body: ${response.body}");
      print("HEADERS: $header");
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      Utils.showSnack("Notification Status updated Successfully", context);
      return jsonDecode(response.body.toString());
    }
    if (response.statusCode == 422) {
      Utils.showFloatingErrorSnack("Already Added to wishList");
      // return wishListModelFromJson(response.body.toString());
    }
    if (response.statusCode == 401) {
      Get.offAll(() => const LoginScreen());
      throw Exception('Not Authorized');
    }
    if (response.statusCode == 400) {
      Get.back();
      throw Exception('Not found');
    }
    if (response.statusCode == 500) {
      // Get.back();
      throw Exception('Server Not Responding');
    }
    return jsonDecode(response.body.toString());
  }

////~~~~~~~~~~~~~~~~~~Follow APIs~~~~~~~~~~~~~~~~~~~////

  followStore(String storeID) async {
    /// Url
    String url = AppUrls.postWishList;

    /// Header
    var header = await headerWithBearerToken();

    /// body
    var data = {
      "store_id": storeID,
      "type": "store",
    };

    /// Request
    var response = await http.post(Uri.parse(url), headers: header, body: data);

    if (kDebugMode) {
      print("Called API: $url");
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      print("HEADERS: $header");
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body.toString());
    }
    if (response.statusCode == 422) {
      Utils.showFloatingErrorSnack("Already Followed");
      // return wishListModelFromJson(response.body.toString());
    }
    if (response.statusCode == 401) {
      Get.offAll(() => const LoginScreen());
      throw Exception('Not Authorized');
    }
    if (response.statusCode == 400) {
      Get.back();
      throw Exception('Not found');
    }
    if (response.statusCode == 500) {
      Get.back();
      throw Exception('Server Not Responding');
    }
    return jsonDecode(response.body.toString());
  }

  Future<FollowerListModel> getFollowedList() async {
    /// Url
    String url = AppUrls.getProfileFollowers;

    String alterAuth =
        await LocalStorage.readJson(key: LocalStorageKeys.authToken);

    /// Header
    var header = {'Authorization': 'Bearer $alterAuth'};

    /// Request
    var response = await http.get(
      Uri.parse(url),
      headers: header,
    );

    if (kDebugMode) {
      print("Called API: $url");
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      print("HEADERS: $header");
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      return followerListModelFromJson(response.body.toString());
    }
    if (response.statusCode == 422) {
      Utils.showFloatingErrorSnack("Already have List");
    }
    if (response.statusCode == 401) {
      Get.offAll(() => const LoginScreen());
      throw Exception('Not Authorized');
    }
    if (response.statusCode == 400) {
      Get.back();
      throw Exception('Not found');
    }
    if (response.statusCode == 500) {
      Get.back();
      throw Exception('Server Not Responding');
    }
    return followerListModelFromJson(response.body.toString());
  }

  Future<GetYourFollowers> getYourFollowersList() async {
    /// Url
    String url = AppUrls.getYourFollowers;

    String alterAuth =
        await LocalStorage.readJson(key: LocalStorageKeys.authToken);

    /// Header
    var header = {'Authorization': 'Bearer $alterAuth'};

    /// Request
    var response = await http.get(
      Uri.parse(url),
      headers: header,
    );

    if (kDebugMode) {
      print("Called API: $url");
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      print("HEADERS: $header");
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      return getYourFollowersFromJson(response.body.toString());
    }
    if (response.statusCode == 422) {
      // Utils.showFloatingErrorSnack("Already have List");
    }
    if (response.statusCode == 401) {
      Get.offAll(() => const LoginScreen());
      throw Exception('Not Authorized');
    }
    if (response.statusCode == 400) {
      Get.back();
      throw Exception('Not found');
    }
    if (response.statusCode == 500) {
      Get.back();
      throw Exception('Server Not Responding');
    }
    return getYourFollowersFromJson(response.body.toString());
  }

  // this API needs to be corrected Throwing error of 404
  removeFromFollowed(String StoreID) async {
    /// Url
    String url = AppUrls.removeFromFollowers;

    /// Header
    var header = await headerWithBearerToken();

    /// body
    var data = {"type": "store", "store_id": StoreID};

    /// Request
    var response = await http.post(Uri.parse(url), headers: header, body: data);

    if (kDebugMode) {
      print("Called API: $url");
      print("Status Code: ${response.statusCode}");
      print("Sent Body: ${data}");
      print("Response Body: ${response.body}");
      print("HEADERS: $header");
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body.toString());
    }
    if (response.statusCode == 422) {
      Utils.showFloatingErrorSnack("Already have List");
    }
    if (response.statusCode == 401) {
      Get.offAll(() => const LoginScreen());
      throw Exception('Not Authorized');
    }
    if (response.statusCode == 400) {
      Get.back();
      throw Exception('Not found');
    }
    if (response.statusCode == 500) {
      Get.back();
      throw Exception('Server Not Responding');
    }
    return jsonDecode(response.body.toString());
  }

////~~~~~~~~~~~~~~~~~~Stripe APIs~~~~~~~~~~~~~~~~~~~////
//   var abc = storeId;
  Future<String> stripeConnect() async {
    /// Url
    String url = AppUrls.stripeConnect(storeId);

    /// Header
    var header = await headerWithBearerToken();

    /// Request
    var response = await http.get(
      Uri.parse(url), headers: header,
      // body: data
    );

    if (kDebugMode) {
      print("Called API: $url");
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      print("Response Body: ${jsonDecode(response.body)["data"]}");
      print("HEADERS: $header");
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (jsonDecode(response.body)["status"].toString() == "true") {
        return jsonDecode(response.body)["data"];
      } else {
        Utils.showFloatingErrorSnack(jsonDecode(response.body)["message"]);
      }
    }
    if (response.statusCode == 422) {
      Utils.showFloatingErrorSnack("Already Followed");
      // return wishListModelFromJson(response.body.toString());
    }
    if (response.statusCode == 401) {
      Get.offAll(() => const LoginScreen());
      throw Exception('Not Authorized');
    }
    if (response.statusCode == 400) {
      Get.back();
      throw Exception('Not found');
    }
    if (response.statusCode == 500) {
      Get.back();
      throw Exception('Server Not Responding');
    }
    return jsonDecode(response.body.toString());
  }

////~~~~~~~~~~~~~~~~~~Order APIs~~~~~~~~~~~~~~~~~~~////

  // API for creating an order
  Future<OrderModel> createOrder(
    String cardID,
    String addressID,
    String totalAmount,
    String paymentType,
    List<CartItem> orderList,
  ) async {
    /// Url
    String url = AppUrls.createOrder;

    /// Header
    var header = await headerWithBearerTokenAndMultipart;

    // create a multipart request
    var request = http.MultipartRequest('POST', Uri.parse(url));

    // adding all the fields in the request
    request.fields['user_card_id'] = cardID;
    request.fields['user_address_id'] = addressID;
    request.fields['total_amount'] = totalAmount;
    request.fields['payment_type'] = paymentType;

    // taking the cart list as input and adding orderItem fields
    for (var i = 0; i < orderList.length; i++) {
      request.fields["orderitems[$i][qty]"] = orderList[i].quantity.toString();
      request.fields["orderitems[$i][product_id]"] =
          orderList[i].datum.id.toString();
    }

    // adding headers
    request.headers.addAll(header);
    //sending request
    var respond = await request.send();
    // getting response
    final http.Response response = await http.Response.fromStream(respond);

    // runs if we are in debug mode
    if (kDebugMode) {
      print("Called API: $url");
      print("Status Code: ${response.statusCode}");
      print("Sent Body: ${request.fields}");
      print("Response Body: ${response.body}");
      print("HEADERS: $header");
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      return orderModelFromJson(response.body);
    }
    if (response.statusCode == 422) {
      // eventually gives 422 when cardID/addressID is wrong
      Utils.showFloatingErrorSnack(
          jsonDecode(response.body)["message"].toString());
    }
    if (response.statusCode == 401) {
      Get.offAll(() => const LoginScreen());
      throw Exception('Not Authorized');
    }
    if (response.statusCode == 400) {
      Get.back();
      throw Exception('Not found');
    }
    if (response.statusCode == 500) {
      Get.back();
      Utils.showFloatingErrorSnack(
          jsonDecode(response.body)["message"].toString());
      throw Exception('Server Not Responding');
    }
    return orderModelFromJson(response.body.toString());
  }

  Future<SellOrderModel> getSellList(
    String storeID,
  ) async {
    /// Url
    String url = AppUrls.getSellOrders(storeID);

    /// Header
    var header = await headerWithBearerToken();

    // create a multipart request
    /// Request
    var response = await http.get(
      Uri.parse(url), headers: header,
      // body: data
    );

    // runs if we are in debug mode
    if (kDebugMode) {
      print("Called API: $url");
      print("Status Code: ${response.statusCode}");
      // print("Sent Body: ${request.fields}");
      log("Response Body: ${response.body}");
      print("HEADERS: $header");
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      return sellOrderModelFromJson(response.body);
    }
    if (response.statusCode == 422) {
      orderController.sellerOrderList.clear();
      orderController.newSellerOrderList.clear();
      orderController.inProgressSellerOrderList.clear();
      orderController.completedSellerOrderList.clear();

      // eventually gives 422 when cardID/addressID is wrong
      // Utils.showFloatingErrorSnack(
      //     jsonDecode(response.body)["message"].toString())
    }
    if (response.statusCode == 401) {
      Get.offAll(() => const LoginScreen());
      throw Exception('Not Authorized');
    }
    if (response.statusCode == 400) {
      Get.back();
      throw Exception('Not found');
    }
    if (response.statusCode == 500) {
      Get.back();
      throw Exception('Server Not Responding');
    }
    return sellOrderModelFromJson(response.body.toString());
  }

  Future<PurchaseListModel> getPurchaseList() async {
    /// Url
    String url = AppUrls.getPurchaseOrders;

    /// Header
    var header = await headerWithBearerToken();

    // create a multipart request
    /// Request
    var response = await http.get(
      Uri.parse(url), headers: header,
      // body: data
    );

    // runs if we are in debug mode
    if (kDebugMode) {
      print("Called API: $url");
      print("Status Code: ${response.statusCode}");
      // print("Sent Body: ${request.fields}");
      // log("Response Body: ${response.body}");
      print("HEADERS: $header");
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      return purchaseListModelFromJson(response.body);
    }
    if (response.statusCode == 422) {
      // eventually gives 422 when cardID/addressID is wrong
      Utils.showFloatingErrorSnack(
          jsonDecode(response.body)["message"].toString());
    }
    if (response.statusCode == 401) {
      Get.offAll(() => const LoginScreen());
      throw Exception('Not Authorized');
    }
    if (response.statusCode == 400) {
      Get.back();
      throw Exception('Not found');
    }
    if (response.statusCode == 500) {
      Get.back();
      throw Exception('Server Not Responding');
    }
    return purchaseListModelFromJson(response.body.toString());
  }

  changeOrderStatus(
      String orderID, String statusToBeChanged, BuildContext context) async {
    /// Url
    String url = AppUrls.changeOrderStatus;

    /// Header
    var header = await headerWithBearerToken();

    /// body
    var data = {"order_product_id": orderID, "status": statusToBeChanged};

    // create a multipart request
    /// Request
    var response = await http.post(Uri.parse(url), headers: header, body: data
        // body: data
        );

    // runs if we are in debug mode
    if (kDebugMode) {
      print("Called API: $url");
      print("Status Code: ${response.statusCode}");
      print("Sent Body: ${data}");
      print("Response Body: ${response.body}");
      print("HEADERS: $header");
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      var res_data = json.decode(response.body.toString());
      // await getSellList(storeId);

      if (res_data["status"].toString() == "true") {
        if (statusToBeChanged == "inprogress") {
          log("changing to in progress");
          var indexOfElement = orderController.newSellerOrderList.value
              .indexWhere(
                  (element) => element.product![0].orderProductId == orderID);
          var element =
              orderController.newSellerOrderList.value[indexOfElement];
          orderController.newSellerOrderList.value[indexOfElement].product![0]
              .orderProductStatus = "inprogress";

          orderController.newSellerOrderList.value.removeWhere(
              (element) => element.product![0].orderProductId == orderID);

          orderController.inProgressSellerOrderList.value.add(element);
          orderController.update();
        } else if (statusToBeChanged == "completed") {
          var indexOfElement = orderController.inProgressSellerOrderList.value
              .indexWhere(
                  (element) => element.product![0].orderProductId == orderID);
          var element =
              orderController.inProgressSellerOrderList.value[indexOfElement];
          orderController.inProgressSellerOrderList.value[indexOfElement]
              .product![0].orderProductStatus = "completed";
          log("changing to completed");
          orderController.inProgressSellerOrderList.value.removeWhere(
              (element) => element.product![0].orderProductId == orderID);

          orderController.completedSellerOrderList.value.add(element);
          orderController.update();
        }
        // await getSellList(storeId);
        Utils.showSnack(
            "Product Status changed to $statusToBeChanged", context);
      } else {
        Utils.showFloatingErrorSnack(res_data["message"]);
      }

      // return jsonDecode(response.body);
    }
    if (response.statusCode == 422) {
      // eventually gives 422 when cardID/addressID is wrong
      if (jsonDecode(response.body)["status"].toString() == "false") {
        Utils.showFloatingErrorSnack(
            jsonDecode(response.body)["message"].toString());
      }
    }
    if (response.statusCode == 401) {
      Get.offAll(() => const LoginScreen());
      throw Exception('Not Authorized');
    }
    if (response.statusCode == 400) {
      Get.back();
      throw Exception('Not found');
    }
    if (response.statusCode == 500) {
      Get.back();
      throw Exception('Server Not Responding');
    }
    return createDealModelFromJson(response.body.toString());
  }

  ////~~~~~~~~~~~~~~~~~~Deal APIs~~~~~~~~~~~~~~~~~~~////

  Future<DealModel> getDealIndex() async {
    /// Url
    String url = AppUrls.getDealIndex;

    /// Header
    var header = await headerWithBearerToken();

    // create a multipart request
    /// Request
    var response = await http.get(
      Uri.parse(url), headers: header,
      // body: data
    );

    // runs if we are in debug mode
    if (kDebugMode) {
      print("Called API: $url");
      print("Status Code: ${response.statusCode}");
      // print("Sent Body: ${request.fields}");
      print("Response Body: ${response.body}");
      print("HEADERS: $header");
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      return dealModelFromJson(response.body);
    }
    if (response.statusCode == 422) {
      // eventually gives 422 when cardID/addressID is wrong
      Utils.showFloatingErrorSnack(
          jsonDecode(response.body)["message"].toString());
    }
    if (response.statusCode == 401) {
      Get.offAll(() => const LoginScreen());
      throw Exception('Not Authorized');
    }
    if (response.statusCode == 400) {
      Get.back();
      throw Exception('Not found');
    }
    if (response.statusCode == 500) {
      Get.back();
      throw Exception('Server Not Responding');
    }
    return dealModelFromJson(response.body.toString());
  }

  // for creating deal we do
  Future<CreateDealModel> createDeal(
    String storeID,
    String dealID,
    String title,
    String description,
    String salePercentage,
    String startDateTime,
    String endDateTime,
  ) async {
    /// Url
    String url = AppUrls.createDeal;

    /// Header
    var header = await headerWithBearerToken();

    /// body
    var data = {
      "store_id": storeId,
      "deal_id": dealID,
      "title": title,
      "description": description,
      "sale_parcentage": salePercentage,
      "start_datetime": startDateTime,
      "end_datetime": endDateTime,
      "timezone": await FlutterTimezone.getLocalTimezone(),
    };

    // create a multipart request
    /// Request
    var response = await http.post(Uri.parse(url), headers: header, body: data
        // body: data
        );

    // runs if we are in debug mode
    if (kDebugMode) {
      print("Called API: $url");
      print("Status Code: ${response.statusCode}");
      print("Sent Body: ${data}");
      print("Response Body: ${response.body}");
      print("HEADERS: $header");
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      return createDealModelFromJson(response.body);
    }
    if (response.statusCode == 422) {
      // eventually gives 422 when cardID/addressID is wrong
      if (jsonDecode(response.body)["status"].toString() == "false") {
        if (jsonDecode(response.body)["message"].toString() ==
                ("Your subscription has expired.") ||
            jsonDecode(response.body)["message"]
                .toString()
                .contains("first you buy subscription plan for this deals")) {
          Get.to(() => SelectPackageScreen());
          Utils.showFloatingAlertSnack(
              jsonDecode(response.body)["message"].toString());
        } else if (jsonDecode(response.body)["message"]
            .toString()
            .contains("Your Already Created This Deal")) {
          Get.offUntil(
            MaterialPageRoute(
                builder: (context) => MyStoreProfileScreen(
                      storeId: storeID,
                    )),
            (Route<dynamic> route) =>
                route.settings.name == "/MyStoreProfileScreen",
          );
          Get.back();
          Utils.showFloatingSuccessSnack("Deal Created Successfully");
          // Get.to(() => SelectPackageScreen());
        } else {
          Utils.showFloatingErrorSnack(
              jsonDecode(response.body)["message"].toString());
          Get.offUntil(
            MaterialPageRoute(
                builder: (context) => MyStoreProfileScreen(
                      storeId: storeID,
                    )),
            (Route<dynamic> route) =>
                route.settings.name == "/MyStoreProfileScreen",
          );
        }
      }
    }
    if (response.statusCode == 401) {
      Get.offAll(() => const LoginScreen());
      throw Exception('Not Authorized');
    }
    if (response.statusCode == 400) {
      Get.back();
      throw Exception('Not found');
    }
    if (response.statusCode == 500) {
      Get.back();
      throw Exception('Server Not Responding');
    }
    return createDealModelFromJson(response.body.toString());
  }

////~~~~~~~~~~~~~~~~~~Subscription APIs~~~~~~~~~~~~~~~~~~~////
  Future<SubscriptionModel> getSubscriptions() async {
    /// Url
    String url = AppUrls.getSubscriptions;

    /// Header
    var header = await headerWithBearerToken();

    // create a multipart request
    /// Request
    var response = await http.get(
      Uri.parse(url), headers: header,
      // body: data
    );

    // runs if we are in debug mode
    if (kDebugMode) {
      print("Called API: $url");
      print("Status Code: ${response.statusCode}");
      // print("Sent Body: ${request.fields}");
      print("Response Body: ${response.body}");
      print("HEADERS: $header");
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      return subscriptionModelFromJson(response.body);
    }
    if (response.statusCode == 422) {
      // eventually gives 422 when cardID/addressID is wrong
      Utils.showFloatingErrorSnack(
          jsonDecode(response.body)["message"].toString());
      if (jsonDecode(response.body)["message"]
          .toString()
          .contains("invalid to create this Deal")) {
        Get.toNamed('/SelectPackageScreen');
      }
      ;
    }
    if (response.statusCode == 401) {
      Get.offAll(() => const LoginScreen());
      throw Exception('Not Authorized');
    }
    if (response.statusCode == 400) {
      Get.back();
      throw Exception('Not found');
    }
    if (response.statusCode == 500) {
      Get.back();
      throw Exception('Server Not Responding');
    }
    return subscriptionModelFromJson(response.body.toString());
  }

  buySubscription(String subscriptionID) async {
    final SubscriptionController subscriptionController =
        Get.put(SubscriptionController());
    subscriptionController.isLoading.value = true;

    /// Url
    String url = AppUrls.buySubscriptions;

    /// Header
    var header = await headerWithBearerToken();

    /// body
    var data = {
      "subscription_plan_id": subscriptionID,
    };

    // create a multipart request
    /// Request
    var response = await http.post(Uri.parse(url), headers: header, body: data
        // body: data
        );
    // runs if we are in debug mode
    if (kDebugMode) {
      print("Called API: $url");
      print("Status Code: ${response.statusCode}");
      print("Sent Body: ${data}");
      print("Response Body: ${response.body}");
      print("HEADERS: $header");
    }

    if (response.statusCode == 200 ||
        response.statusCode ==
            201) if (jsonDecode(response.body)["message"]
        .toString()
        .contains("Subscription Plan Added")) {
      Utils.showFloatingSuccessSnack(
          jsonDecode(response.body)["message"].toString());
      // Get.to(() => AddTextScreen());
      Get.close(1);
    } else {
      Utils.showFloatingErrorSnack(
          jsonDecode(response.body)["message"].toString());
    }
    subscriptionController.isLoading.value = false;

    // return jsonDecode(response.body)["message"].toString().contains("Subscription Plan Added");

    if (response.statusCode == 422) {
      subscriptionController.isLoading.value = false;

      // eventually gives 422 when cardID/addressID is wrong
      if (jsonDecode(response.body)["status"].toString() == "false") {
        if (jsonDecode(response.body)["message"]
            .toString()
            .contains("Payment Card Not Found")) {
          Get.to(() => SelectPaymentMethod(
                isFromSubscriptions: true,
                fromProfile: false,
              ));
        } else {
          Get.offUntil(
            MaterialPageRoute(
                builder: (context) => MyStoreProfileScreen(
                      storeId: storeId,
                    )),
            (Route<dynamic> route) =>
                route.settings.name == "/MyStoreProfileScreen",
          );
        }
      }
      Utils.showFloatingAlertSnack(
          jsonDecode(response.body)["message"].toString());
    }
    if (response.statusCode == 401) {
      Get.offAll(() => const LoginScreen());
      throw Exception('Not Authorized');
      subscriptionController.isLoading.value = false;
    }
    if (response.statusCode == 400) {
      Get.back();
      throw Exception('Not found');
      subscriptionController.isLoading.value = false;
    }
    if (response.statusCode == 500) {
      Get.back();
      throw Exception('Server Not Responding');
      subscriptionController.isLoading.value = false;
    }
    // return createDealModelFromJson(response.body.toString());
  }

////~~~~~~~~~~~~~~~~~~Review APIs~~~~~~~~~~~~~~~~~~~////
  Future<PostReviewModel> createReview(
    String productID,
    String description,
    String rating,
    List imageList,
  ) async {
    /// Url
    String url = AppUrls.createReview;

    /// Header
    var header = await headerWithBearerTokenAndMultipart;

    // create a multipart request
    var request = http.MultipartRequest('POST', Uri.parse(url));

    // adding all the fields in the request
    request.fields['product_id'] = productID;
    request.fields['rating'] = rating;
    request.fields['description'] = description;

    log("image list is iof length" + imageList.length.toString());
    // taking the image list as input and adding images fields
    for (var i = 0; i < imageList.length; i++) {
      var stream = new http.ByteStream(
          DelegatingStream.typed(File(imageList[i]).openRead()));
      var length = await File(imageList[i]).length();
      var multipartFile = new http.MultipartFile("images[$i]", stream, length,
          filename: basename(File(imageList[i]).path));
      request.files.add(multipartFile);
    }

    // adding headers
    request.headers.addAll(header);
    //sending request
    var respond = await request.send();
    // getting response
    final http.Response response = await http.Response.fromStream(respond);

    // runs if we are in debug mode
    if (kDebugMode) {
      print("Called API: $url");
      print("Status Code: ${response.statusCode}");
      print("Sent Body: ${request.fields}");
      print("Sent Body: ${request.files}");
      print("Response Body: ${response.body}");
      print("HEADERS: $header");
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      await getMyReviews();
      return postReviewModelFromJson(response.body);
    }
    if (response.statusCode == 422) {
      // eventually gives 422 when review is wrong
      Utils.showFloatingErrorSnack(
          jsonDecode(response.body)["message"].toString());
      ;
    }
    if (response.statusCode == 401) {
      Get.offAll(() => const LoginScreen());
      throw Exception('Not Authorized');
    }
    if (response.statusCode == 400) {
      Get.back();
      throw Exception('Not found');
    }
    if (response.statusCode == 500) {
      Get.back();
      throw Exception('Server Not Responding');
    }
    return postReviewModelFromJson(response.body.toString());
  }

  Future<ReviewModel> getMyReviews() async {
    /// Url
    String url = AppUrls.getMyReviews;

    /// Header
    var header = await headerWithBearerToken();

    /// Request
    var response = await http.get(
      Uri.parse(url), headers: header,
      // body: data
    );

    if (kDebugMode) {
      print("Called API: $url");
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      print("HEADERS: $header");
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      return reviewModelFromJson(response.body);
    }
    if (response.statusCode == 422) {
      // eventually gives 422 when review is wrong
      Utils.showFloatingErrorSnack(
          jsonDecode(response.body)["message"].toString());
      ;
    }
    if (response.statusCode == 401) {
      Get.offAll(() => const LoginScreen());
      throw Exception('Not Authorized');
    }
    if (response.statusCode == 400) {
      Get.back();
      throw Exception('Not found');
    }
    if (response.statusCode == 500) {
      Get.back();
      throw Exception('Server Not Responding');
    }
    return reviewModelFromJson(response.body.toString());
  }

  Future<StoreReviewModel> getMyStoreReviews() async {
    /// Url
    String url = AppUrls.getMyStoreReviews;

    /// Header
    var header = await headerWithBearerToken();

    /// Request
    var response = await http.get(
      Uri.parse(url), headers: header,
      // body: data
    );

    if (kDebugMode) {
      print("Called API: $url");
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      print("HEADERS: $header");
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      return storeReviewModelFromJson(response.body);
    }
    if (response.statusCode == 422) {
      // eventually gives 422 when review is wrong
      Utils.showFloatingErrorSnack(
          jsonDecode(response.body)["message"].toString());
      ;
    }
    if (response.statusCode == 401) {
      Get.offAll(() => const LoginScreen());
      throw Exception('Not Authorized');
    }
    if (response.statusCode == 400) {
      Get.back();
      throw Exception('Not found');
    }
    if (response.statusCode == 500) {
      Get.back();
      throw Exception('Server Not Responding');
    }
    return storeReviewModelFromJson(response.body.toString());
  }

  postReviewReply(String productID, String userID, String description,
      String parentId) async {
    /// Url
    String url = AppUrls.postReplyReview;

    /// Header
    var header = await headerWithBearerToken();

    /// body
    var data = {
      "product_id": productID,
      "user_id": userID,
      "description": description,
      "parent_id": parentId
    };

    /// Request
    var response = await http.post(Uri.parse(url), headers: header, body: data);

    if (kDebugMode) {
      print("Called API: $url");
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      print("HEADERS: $header");
    }
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    }
    if (response.statusCode == 422) {
      // eventually gives 422 when review is wrong
      Utils.showFloatingErrorSnack(
          jsonDecode(response.body)["message"].toString());
      ;
    }
    if (response.statusCode == 401) {
      Get.offAll(() => const LoginScreen());
      throw Exception('Not Authorized');
    }
    if (response.statusCode == 400) {
      // Get.back();
      throw Exception('Not found');
    }
    if (response.statusCode == 500) {
      // Get.back();
      throw Exception('Server Not Responding');
    }
    return jsonDecode(response.body.toString());
  }

  Future<List<Datum>> getToBeReviewed() async {
    /// Url
    String url = AppUrls.toBeReviewed;

    /// Header
    var header = await headerWithBearerToken();

    // /// body
    // var data = {
    //   "product_id": productID,
    //   "user_id": userID,
    //   "description": description,
    //   "parent_id": parentId
    // };

    /// Request
    var response = await http.get(
      Uri.parse(url), headers: header,
      // body: data,
    );

    if (kDebugMode) {
      print("Called API: $url");
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      print("HEADERS: $header");
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Future.delayed(Duration.zero,(){

      //   orderController.toBeReviewedPurchaseOrderList.value = List<Datum>.from(
      //       (jsonDecode(response.body)["data"]).map((x) => Datum.fromJson(x)));
      // });
      return List<Datum>.from(
          (jsonDecode(response.body)["data"]).map((x) => Datum.fromJson(x)));
    }
    if (response.statusCode == 422) {
      // eventually gives 422 when review is wrong
      Utils.showFloatingErrorSnack(
          jsonDecode(response.body)["message"].toString());
      ;
    }
    if (response.statusCode == 401) {
      Get.offAll(() => const LoginScreen());
      throw Exception('Not Authorized');
    }
    if (response.statusCode == 400) {
      // Get.back();
      throw Exception('Not found');
    }
    if (response.statusCode == 500) {
      // Get.back();
      throw Exception('Server Not Responding');
    }
    return jsonDecode(response.body.toString());
  }

  Future<GetStoreRating> getStoreRating(String storeID) async {
    /// Url
    String url = AppUrls.getStoreRating(storeID);

    /// Header
    var header = await headerWithBearerToken();

    /// Request
    var response = await http.get(
      Uri.parse(url), headers: header,
      // body: data
    );

    if (kDebugMode) {
      print("Called API: $url");
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      print("HEADERS: $header");
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      return getStoreRatingFromJson(response.body);
    }
    if (response.statusCode == 422) {
      // eventually gives 422 when review is wrong
      Utils.showFloatingErrorSnack(
          jsonDecode(response.body)["message"].toString());
      ;
    }
    if (response.statusCode == 401) {
      Get.offAll(() => const LoginScreen());
      throw Exception('Not Authorized');
    }
    if (response.statusCode == 400) {
      Get.back();
      throw Exception('Not found');
    }
    if (response.statusCode == 500) {
      Get.back();
      throw Exception('Server Not Responding');
    }
    return getStoreRatingFromJson(response.body.toString());
  }

  /// FAQ APIs
  Future<FaqModel> getFaqs() async {
    /// Url
    String url = AppUrls.getFAQs;

    /// Header
    var header = await headerWithBearerToken();

    /// Request
    var response = await http.get(
      Uri.parse(url), headers: header,
      // body: data
    );

    if (kDebugMode) {
      print("Called API: $url");
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      print("HEADERS: $header");
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      return faqModelFromJson(response.body);
    }
    if (response.statusCode == 422) {
      // eventually gives 422 when review is wrong
      Utils.showFloatingErrorSnack(
          jsonDecode(response.body)["message"].toString());
      ;
    }
    if (response.statusCode == 401) {
      Get.offAll(() => const LoginScreen());
      throw Exception('Not Authorized');
    }
    if (response.statusCode == 400) {
      // Get.back();
      throw Exception('Not found');
    }
    if (response.statusCode == 500) {
      // Get.back();
      throw Exception('Server Not Responding');
    }
    return faqModelFromJson(response.body.toString());
  }

  /// Social Login
  Future signInWithGoogle(BuildContext context, String deviceToken) async {
    // Trigger the authentication flow
    // try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      return null;
    }
    googleUser.authentication;
    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // googleSignInClient = GoogleSignIn.getClient(this, googleSignInOptions)
    // googleSignInClient.revokeAccess()
    log("google user email is " + googleUser.email);
    await googleLogin(
      context,
      googleUser.email,
      deviceToken,
      googleUser.displayName ?? "",
    );

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    credential;
    // idToken = credential.idToken.toString();
    // accessToken = credential.accessToken.toString();
    // Once signed in, return the UserCredential

    return await FirebaseAuth.instance.signInWithCredential(credential);
    // }
    // catch (e) {
    //   print(e);
    // }
  }

  googleLogin(BuildContext context, String email, String deviceToken,
      String userName) async {
    // log(data.toString());
    final uri = Uri.parse(AppUrls.socialLogin);
    // final headers = {'Content-Type': 'application/json'};
    // String jsonBody = json.encode(data);
    // try {
    var data = {
      "email": email,
      "phone_number": "",
      "name": userName,
      "social_device": "google",
      "device_type": Platform.isAndroid ? "android" : "iphone",
      "device_token": deviceToken
    };
    http.Response response = await http.post(
      uri,
      // headers: onlyFormDataHeader,
      body: data,
    );
    log(response.statusCode.toString());
    log(response.body.toString());
    var res_data = json.decode(response.body.toString());

    if (res_data['status'] == true) {
      storeId = "";
      orderController.sellerOrderList.clear();
      orderController.purchaseOrderList.clear();
      orderController.newSellerOrderList.clear();
      orderController.newPurchaseOrderList.clear();
      orderController.inProgressSellerOrderList.clear();
      orderController.inProgressPurchaseOrderList.clear();
      orderController.completedSellerOrderList.clear();
      orderController.completedPurchaseOrderList.clear();
      ApiServices.myStoreProfileDataList.clear();
      LocalStorage.saveJson(
          key: LocalStorageKeys.authToken,
          value: res_data["authorisation"]["token"].toString());
      getAuthTokenFrom();
      Get.back();
      // if (res_data["store"] != null) {
      //   userController.user.store = List<LoginModel.Store>.from(
      //       res_data["data"]["store"]
      //           .map((x) => LoginModel.Store.fromJson(x)));
      // }
      userController.user.value.id = res_data["id"];
      userController.user.value.name = res_data["name"];
      userController.user.value.email = res_data["email"];
      // log("res data store " + List<LoginModel.Store>.from(
      //     res_data["data"]["store"]
      //         .map((x) => LoginModel.Store.fromJson(x))).toString());

      userController.update();
      var loginResponse = LoginModel.loginModelFromJson(response.body);
      // log("stripe vlaue"+loginResponse.data?.store?.first.stripeAccountID);
      LocalStorage.saveJson(
          key: LocalStorageKeys.stripeConnected, value: "false");

      if (loginResponse.data!.first.store == null &&
              loginResponse.data!.first.shipperAddress == null ||
          loginResponse.data!.first.payment == null) {
        userController.User(LoginModel.UserModel(
          id: loginResponse.data!.first.id,
          name: loginResponse.data!.first.name,
          email: loginResponse.data!.first.email,
        ));
      } else {
        userController.User(
            LoginModel.loginModelFromJson(response.body).data!.first);
      }

      Get.to(() => StartAppScreen());
      // SharedPreferences sp = await SharedPreferences.getInstance();
      LocalStorage.deleteJson(key: LocalStorageKeys.cartList);

      // FirebaseServices().getUniqueMembers();

      // if (remChk) {
      //   sp.remove("userEmail");
      //   sp.remove("userPassword");
      //   sp.setString("userEmail", data["email"]);
      //   sp.setString("userPassword", data["password"]);
      // } else {
      //   // Comment
      //   sp.remove("userEmail");
      //   sp.remove("userPassword");
      // }

      // <<<<<<<<<<<<<<<<<<   store locally >>>>>>>>>>>>>>>
      //  authToken = res_data["authorisation"]["token"];
      //  print(res_data["data"]["store"].toString() != "[]"?
      //  res_data["data"]["store"][0]["id"].toString() : "");
      //  print(res_data["data"]["image"]??"");
      // storeId = res_data["data"]["store"][0]["id"].toString();

      setLocalVariable(
          res_data["authorisation"]["token"].toString(),
          res_data["data"][0]["name"].toString(),
          res_data["data"][0]["email"].toString(),
          res_data["data"][0]["image"] ?? "",
          res_data["data"][0]["store"].toString() != "null"
              ? res_data["data"][0]["store"]["id"].toString()
              : "");

      // userController.User(LoginModel.fromJson(res_data));
      // authToken = UserController.user.authorisation!.token.toString();
      // step = UserController.user.data!.step.toString();
      // step == "1"
      //     ?

      //
      //         ? Get.to(() => CreateProfileScreen())
      //         :
      //         // bt.navBarChange(0);
      //         Get.to(() => MainScreen());
      // authToken = res_data['data']['token'];

      Get.snackbar('Success', 'User logged in successfully',
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white,
          backgroundColor: Colors.green);
    } else {
      Get.back();
      Get.snackbar('Error', res_data['message'],
          snackPosition: SnackPosition.TOP, colorText: Colors.white);
    }
  }

  deleteAccount() async {
    /// Url
    String url = AppUrls.deleteAccount;

    /// Header
    var header = await headerWithBearerToken();

    /// Request
    var response = await http.get(
      Uri.parse(url), headers: header,
      // body: data
    );

    if (kDebugMode) {
      print("Called API: $url");
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
      print("HEADERS: $header");
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      var resp = jsonDecode(response.body);

      return jsonDecode(response.body);
    }
    if (response.statusCode == 422) {
      // eventually gives 422 when review is wrong
      Utils.showFloatingErrorSnack(
          jsonDecode(response.body)["message"].toString());
      ;
    }
    if (response.statusCode == 401) {
      Get.offAll(() => const LoginScreen());
      throw Exception('Not Authorized');
    }
    if (response.statusCode == 400) {
      // Get.back();
      throw Exception('Not found');
    }
    if (response.statusCode == 500) {
      // Get.back();
      throw Exception('Server Not Responding');
    }
    return faqModelFromJson(response.body.toString());
  }

// on SocketException {
//   // isLoading.value = false;
//   Get.back();
//   Get.snackbar('Error', "Please Check Your Internet",
//       snackPosition: SnackPosition.TOP, colorText: Colors.white);
// }
// catch (e) {
//   Get.back();
//   Get.snackbar('Error', e.toString(),
//       snackPosition: SnackPosition.TOP, colorText: Colors.white);
// }
// }
}
