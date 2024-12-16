// import 'package:collection/collection.dart';
//
// class Data {
//   String? id;
//   String? name;
//   String? email;
//   String? address;
//   String? phoneNumber;
//   String? image;
//   String? gender;
//   String? otp;
//   String? emailVerifiedAt;
//   String? deviceType;
//   String? socialDevice;
//   bool? notificationStatus;
//   String? deviceToken;
//
//   // List<MyStore>? myStore;
//   // MyOrder? myOrder;
//   // List<ListProduct>? listProduct;
//   // List<dynamic>? shippingAddress;
//   // List<dynamic>? paymentCard;
//   // "id": "87",
//   // "image": "",
//   // "name": "Harry Battler",
//   // "email": "harrybaasdsattler119@yopmail.com",
//   // "phone_number": "",
//   // "gender": "",
//   // "otp": "09734",
//   // "email_verified_at": "",
//   // // "address": "",
//   // "device_type": "android",
//   // "social_device": "flip",
//   // "notification_status": true,
//   // "device_token"
//   //
//   //     :
//
//   // "
//   //
//   // safarwrq
//   //
//   // "
//
//   Data({
//     this.id,
//     this.name,
//     this.email,
//     this.address,
//     this.phoneNumber,
//     this.image,
//     this.gender,
//     this.otp,
//     this.deviceToken,
//     this.deviceType,
//     this.emailVerifiedAt,
//     this.notificationStatus,
//     this.socialDevice
//     // this.myStore,
//     // this.myOrder,
//     // this.listProduct,
//     // this.shippingAddress,
//     // this.paymentCard,
//   });
//
//   factory Data.fromJson(Map<String, dynamic> json) =>
//       Data(
//           id: json['id'] as String?,
//           name: json['name'] as String?,
//           email: json['email'] as String?,
//           address: json['address'] as String?,
//           phoneNumber: json['phone_number'] as String?,
//           image: json['image'] as String?,
//           gender: json['gender'] as String?,
//           otp: json['otp'] as String?,
//           emailVerifiedAt: json['email_verified_at'] as String?,
//           deviceType: json['device_type'] as String?,
//           socialDevice: json['social_device'] as String?,
//           notificationStatus: json['notification_status'],
//           deviceToken: json["device_token"] as String?
//
//
//         // myStore: (json['my_store'] as List<dynamic>?)
//         //     ?.map((e) => MyStore.fromJson(e as Map<String, dynamic>))
//         //     .toList(),
//         // myOrder: json['my_order'] == null
//         //     ? null
//         //     : MyOrder.fromJson(json['my_order'] as Map<String, dynamic>),
//         // listProduct: (json['list_product'] as List<dynamic>?)
//         //     ?.map((e) => ListProduct.fromJson(e as Map<String, dynamic>))
//         //     .toList(),
//         // shippingAddress: json['shipping_address'] as List<dynamic>?,
//         // paymentCard: json['payment_card'] as List<dynamic>?,
//       );
//
//   Map<String, dynamic> toJson() =>
//       {
//         'id': id,
//         'name': name,
//         'email': email,
//         'address': address,
//         'phone_number': phoneNumber,
//         'image': image,
//         'gender': gender,
//         'otp': otp,
//         'email_verified_at': emailVerifiedAt,
//         'device_type': deviceType,
//         'social_device': socialDevice,
//         'notification_status': notificationStatus,
//         'deviceToken': deviceToken,
//         // 'my_store': myStore?.map((e) => e.toJson()).toList(),
//         // 'my_order': myOrder?.toJson(),
//         // 'list_product': listProduct?.map((e) => e.toJson()).toList(),
//         // 'shipping_address': shippingAddress,
//         // 'payment_card': paymentCard,
//       };
//
//   @override
//   bool operator ==(Object other) {
//     if (identical(other, this)) return true;
//     if (other is! Data) return false;
//     final mapEquals = const DeepCollectionEquality().equals;
//     return mapEquals(other.toJson(), toJson());
//   }
//
//   @override
//   int get hashCode =>
//       id.hashCode ^
//       name.hashCode ^
//       email.hashCode ^
//       address.hashCode ^
//       phoneNumber.hashCode ^
//       image.hashCode ^
//       gender.hashCode ^
//       otp.hashCode ^
//       emailVerifiedAt.hashCode ^
//   deviceType.hashCode ^
//   socialDevice.hashCode ^
//   notificationStatus.hashCode ^
//   deviceToken.hashCode ;
// // myStore.hashCode ^
// // myOrder.hashCode ^
// // listProduct.hashCode ^
// // shippingAddress.hashCode ^
// // paymentCard.hashCode;
// }
