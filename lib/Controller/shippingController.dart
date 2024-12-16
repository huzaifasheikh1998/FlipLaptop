import 'package:app_fliplaptop/models/shippingAddressModel.dart';
import 'package:get/get.dart';

class ShippingController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  var completeShippingModel = ShippingAddress().obs;
  var defaultShippingModel = ShippingModel().obs;

  RxBool isLoading = false.obs;
  RxList<dynamic> completeShippingAddresses = <dynamic>[].obs;

  RxBool isDefaultSelected = false.obs;
  RxString isDefaultSelectedID = "".obs;

  // getShippingAddresses(BuildContext context) async {
  //   try {
  //     isLoading.value = true;
  //     var result = await ApiServices().listShippingAddresses(context);
  //     // isLoading.value = false;
  //     if (kDebugMode) {
  //       print("Result: ${result.response?.toJson()}");
  //     }
  //     if (result[0]["status"].toString() == "true") {
  //       completeShippingAddresses.clear();
  //       for (Map i in result["data"]) {
  //         completeShippingAddresses.add(ShippingModel.fromJson(i));
  //       }
  //       return completeShippingAddresses;
  //     } else if (result[0]["status"].toString() == "false") {
  //       Get.snackbar('Error', result[0]['message'],
  //           snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
  //     }
  //     isLoading.value = false;

  //     // ERList!.value = result.response!.data!;
  //     return result;
  //   } on SocketException {
  //     isLoading.value = false;
  //     Get.snackbar('Error', "Internet Connection Not Avaiable!",
  //         snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
  //   } on Exception {
  //     isLoading.value = false;
  //     Get.snackbar('Error', "No Data Found",
  //         snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
  //   } catch (e) {
  //     isLoading.value = false;
  //     Get.snackbar('Error', e.toString(),
  //         snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
  //   }
  // }
}
