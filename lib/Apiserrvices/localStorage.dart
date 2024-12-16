// import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static saveJson({required key, required String value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var res = prefs.setString("$key", value);
    return res;
  }

  static readJson({required key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var res = prefs.getString("$key");
    return res;
  }

  static deleteJson({required key}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var res = prefs.remove("$key");
    return res;
  }
}

class LocalStorageKeys {
  static String cartList = 'cartList';
  static String fcmToken = 'fcmToken';
  static String deviceType = 'deviceType';
  static String userEmail = 'userEmail';
  static String userID = 'userID';
  static String userPassword = 'userPassword';
  static String authToken = 'authToken';
  static String stripeConnected = 'stripeConnected';
  static String storeID = 'storeID';
}
