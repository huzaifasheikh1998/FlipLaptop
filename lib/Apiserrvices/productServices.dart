// import 'package:app_fliplaptop/Apiserrvices/app_url.dart';
// import 'package:http/http.dart' as http;
// import '../models/product_listing_data_model/deleteProduct.dart';

// class ProductServices{

//   Future<DeleteProduct> deleteProduct(int productID) async {

//         /// Url
//     String url = AppUrls.kProductUpdate(productID);

//     // /// Get Token
//     // String accessToken =
//     //     LocalStorage.readString(key: LocalStorageKeys.accessToken);

//     /// Headers
//     var header = await headerWithBearerToken;

//     /// Request
//     var response = await http.delete(Uri.parse(url), headers: header, body: {

//     });

//     if (kDebugMode) {
//       print("Called API: $url");
//       print("Status Code: ${response.statusCode}");
//       print("Response Body: ${response.body}");
//       print("HEADERS: $header");
//     }

//     if (response.statusCode == 200) {
//       if (kDebugMode) {
//         print("response on 200: ${response.body}");
//       }
//       return jsonDecode(response.body);
//     }
//     if (response.statusCode == 401) {
//       Get.offAll(() => const LoginScreen());
//       throw Exception('Not Authorized');
//     }
//     if (response.statusCode == 400) {
//       throw Exception('Not found');
//     }
//     if (response.statusCode == 500) {
//       throw Exception('Server Not Responding');
//     } else {
//       throw Exception('Something Went Wrong');
//     }
//   }

// }